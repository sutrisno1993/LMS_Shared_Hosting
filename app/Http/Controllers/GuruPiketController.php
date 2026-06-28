<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Auth;
use App\Models\Teacher;
use App\Models\TeacherAttendance;
use App\Models\KbmSession;
use App\Models\Student;
use App\Models\StudentDiscipline;

class GuruPiketController extends Controller
{
    /**
     * Halaman Utama Tugas Piket
     */
    public function index()
    {
        $user = Auth::user();
        $teacherInfo = Teacher::find($user->id_guru);
        
        $dayOfWeek = now()->dayOfWeek;
        $days = ['MINGGU', 'SENIN', 'SELASA', 'RABU', 'KAMIS', 'JUMAT', 'SABTU'];
        $hariEnum = $days[$dayOfWeek];
        $todayStr = now()->toDateString();
        
        $piketPagi = is_array($teacherInfo->piket_pagi) ? $teacherInfo->piket_pagi : [];
        $piketSiang = is_array($teacherInfo->piket_siang) ? $teacherInfo->piket_siang : [];
        
        $isPiketPagi = in_array($hariEnum, $piketPagi);
        $isPiketSiang = in_array($hariEnum, $piketSiang);

        // Cek apakah guru ini piket hari ini
        if (!$teacherInfo || (!$isPiketPagi && !$isPiketSiang)) {
            return redirect()->route('guru.dashboard')->with('error', 'Anda tidak dijadwalkan piket hari ini.');
        }

        // Tentukan shift piket aktif (bisa pagi atau siang)
        $shiftPiket = $isPiketPagi ? 'PAGI' : 'SIANG';

        // Ambil semua sesi KBM terjadwal hari ini (berdasarkan shift)
        $sessions = KbmSession::with(['teacherTerjadwal', 'clas'])
            ->where('tanggal', $todayStr)
            ->whereHas('clas', function($q) use ($shiftPiket) {
                $q->where('shift_operasional', $shiftPiket);
            })
            ->get();

        // Cari jam pertama tiap guru
        $firstSessionPerTeacher = [];
        foreach ($sessions as $session) {
            $id = $session->id_guru_terjadwal;
            if (!$id) continue;
            
            if (!isset($firstSessionPerTeacher[$id])) {
                $firstSessionPerTeacher[$id] = $session->jam_ke;
            } else {
                if ($session->jam_ke < $firstSessionPerTeacher[$id]) {
                    $firstSessionPerTeacher[$id] = $session->jam_ke;
                }
            }
        }

        // Ambil data attendance hari ini untuk guru-guru tersebut
        $guruIds = array_keys($firstSessionPerTeacher);
        $attendances = TeacherAttendance::where('tanggal', $todayStr)
            ->whereIn('id_guru', $guruIds)
            ->get()
            ->keyBy('id_guru');

        $teachersRaw = Teacher::whereIn('id_guru', $guruIds)->orderBy('nama_guru')->get();
        
        $teachersList = $teachersRaw->map(function ($t) use ($firstSessionPerTeacher, $attendances) {
            $att = $attendances->get($t->id_guru);
            return [
                'id_guru' => $t->id_guru,
                'nama_guru' => $t->nama_guru,
                'jam_ke' => $firstSessionPerTeacher[$t->id_guru],
                'status' => $att ? $att->status : null,
                'keterangan_jam' => $att ? $att->keterangan_jam : null,
            ];
        })->sortBy('jam_ke')->values();

        // Data untuk Tab Siswa Terlambat
        $allStudents = Student::with('clas')->orderBy('nama_siswa')->get()->map(function($s) {
            return [
                'id' => $s->id_siswa,
                'nama' => $s->nama_siswa,
                'nis' => $s->nis,
                'kelas' => $s->clas->nama_kelas ?? 'Unknown',
            ];
        });

        $lateStudentsToday = StudentDiscipline::with('student.clas')
            ->where('tanggal_tindakan', $todayStr)
            ->where('kategori_kasus', 'ABSENSI')
            ->orderBy('created_at', 'desc')
            ->get()->map(function($d) {
                return [
                    'id' => $d->id,
                    'nama' => $d->student->nama_siswa ?? 'Unknown',
                    'kelas' => $d->student->clas->nama_kelas ?? 'Unknown',
                    'kasus_detail' => $d->kasus_detail,
                    'keterangan' => $d->keterangan,
                    'tipe_tindakan' => $d->tipe_tindakan,
                    'waktu' => $d->created_at->format('H:i'),
                ];
            });

        return Inertia::render('Guru/TugasPiket', [
            'shift' => $shiftPiket,
            'hariIni' => $todayStr,
            'teachers' => $teachersList,
            'students' => $allStudents,
            'lateStudentsToday' => $lateStudentsToday,
        ]);
    }

    /**
     * Simpan Absensi Guru (Oleh Piket)
     */
    public function simpanAbsensiGuru(Request $request)
    {
        $request->validate([
            'id_guru' => 'required|exists:teachers,id_guru',
            'status' => 'required|in:HADIR,SAKIT,IZIN,LAINNYA',
            'keterangan_jam' => 'nullable|string',
        ]);

        $todayStr = now()->toDateString();
        $user = Auth::user();
        $teacherInfo = Teacher::find($user->id_guru);
        $dayOfWeek = now()->dayOfWeek;
        $days = ['MINGGU', 'SENIN', 'SELASA', 'RABU', 'KAMIS', 'JUMAT', 'SABTU'];
        $hariEnum = $days[$dayOfWeek];
        
        $piketPagi = is_array($teacherInfo->piket_pagi) ? $teacherInfo->piket_pagi : [];
        $isPiketPagi = in_array($hariEnum, $piketPagi);
        
        $shiftPiket = $isPiketPagi ? 'PAGI' : 'SIANG';

        TeacherAttendance::updateOrCreate(
            [
                'tanggal' => $todayStr,
                'id_guru' => $request->id_guru,
            ],
            [
                'shift' => $shiftPiket,
                'waktu_datang' => $request->status === 'HADIR' ? now()->toTimeString() : null,
                'status' => $request->status,
                'keterangan_jam' => $request->keterangan_jam, // misal "Jam ke-2" atau manual text
            ]
        );

        return redirect()->back()->with('success', 'Absensi guru berhasil disimpan.');
    }

    /**
     * Simpan Data Siswa Terlambat (Oleh Piket)
     */
    public function catatSiswaTelat(Request $request)
    {
        $request->validate([
            'id_siswa' => 'required|exists:students,id_siswa',
            'alasan' => 'nullable|string',
            'tindakan' => 'required|string',
        ]);

        $todayStr = now()->toDateString();

        StudentDiscipline::create([
            'id_siswa' => $request->id_siswa,
            'kategori_kasus' => 'ABSENSI',
            'kasus_detail' => 'TERLAMBAT DATANG',
            'tipe_tindakan' => $request->tindakan,
            'tanggal_tindakan' => $todayStr,
            'keterangan' => $request->alasan,
        ]);

        return redirect()->back()->with('success', 'Data keterlambatan siswa berhasil dicatat.');
    }
}
