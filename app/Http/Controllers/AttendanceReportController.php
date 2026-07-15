<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Student;
use App\Models\StudentAttendance;
use App\Models\StudentDiscipline;
use App\Models\Clas;
use Carbon\Carbon;

class AttendanceReportController extends Controller
{
    /**
     * Tampilkan Laporan Kehadiran Siswa
     */
    public function index(Request $request)
    {
        // 1. Tentukan batas semester berjalan (Contoh: Ganjil = Jul-Des, Genap = Jan-Jun)
        $month = Carbon::now()->month;
        $year = Carbon::now()->year;
        
        if ($month >= 7 && $month <= 12) {
            $startDate = Carbon::create($year, 7, 1)->startOfDay();
            $endDate = Carbon::create($year, 12, 31)->endOfDay();
        } else {
            $startDate = Carbon::create($year, 1, 1)->startOfDay();
            $endDate = Carbon::create($year, 6, 30)->endOfDay();
        }

        // 2. Query Siswa beserta relasi Kelas & Wali Kelas
        // Kita juga query student_attendances dan student_disciplines dalam rentang semester ini.
        $students = Student::with(['clas.waliKelas'])
            ->withCount([
                'attendances as alpa_count' => function ($query) use ($startDate, $endDate) {
                    $query->whereIn('status', ['ALPA', 'A', 'alpa'])
                          ->whereBetween('waktu_presensi', [$startDate, $endDate]);
                },
                'attendances as izin_count' => function ($query) use ($startDate, $endDate) {
                    $query->whereIn('status', ['IZIN', 'I', 'izin'])
                          ->whereBetween('waktu_presensi', [$startDate, $endDate]);
                },
                'attendances as sakit_count' => function ($query) use ($startDate, $endDate) {
                    $query->whereIn('status', ['SAKIT', 'S', 'sakit'])
                          ->whereBetween('waktu_presensi', [$startDate, $endDate]);
                },
                'disciplines as terlambat_count' => function ($query) use ($startDate, $endDate) {
                    $query->whereRaw("UPPER(kategori_kasus) = 'ABSENSI'")
                          ->where('kasus_detail', 'TERLAMBAT DATANG')
                          ->whereBetween('tanggal_tindakan', [$startDate, $endDate]);
                }
            ])
            ->get();

        // 3. Ambil riwayat kedisiplinan (Tindakan Wali Kelas) terkait Absensi
        $disciplines = StudentDiscipline::where('kategori_kasus', 'Absensi')
            ->orderBy('tanggal_tindakan', 'desc')
            ->get()
            ->groupBy('id_siswa');

        $laporanData = [];
        $totalKritis = 0;

        foreach ($students as $siswa) {
            // Hanya masukkan siswa yang punya record absen (minimal 1 A/I/S/T) untuk memperingan tabel
            if ($siswa->alpa_count == 0 && $siswa->izin_count == 0 && $siswa->sakit_count == 0 && $siswa->terlambat_count == 0) {
                continue; 
            }

            $siswaDisciplines = $disciplines->get($siswa->id_siswa, collect());
            
            // Status Penanganan Logic
            // Merah (Belum Ditindak): Alfa >= 5 dan tidak ada tindakan
            // Kuning (Proses): Ada tindakan tapi belum selesai (Asumsi: semua tindakan dianggap proses/selesai)
            // Hijau (Selesai): Untuk simplifikasi, jika sudah ditindak = Hijau/Kuning.
            $statusPenanganan = 'AMAN';
            if ($siswa->alpa_count >= 5 && $siswaDisciplines->isEmpty()) {
                $statusPenanganan = 'BELUM_DITINDAK';
                $totalKritis++;
            } elseif ($siswa->alpa_count > 0 && $siswaDisciplines->isNotEmpty()) {
                $statusPenanganan = 'SUDAH_DITINDAK';
            } elseif ($siswa->alpa_count > 0 && $siswa->alpa_count < 5) {
                $statusPenanganan = 'PERLU_DIPANTAU'; // Belum >= 3 tapi sudah ada alpa
            }

            // Nomor HP Walas
            $waliHp = $siswa->clas && $siswa->clas->waliKelas ? $siswa->clas->waliKelas->no_hp : null;
            if ($waliHp && strpos($waliHp, '0') === 0) {
                $waliHp = '62' . substr($waliHp, 1);
            }

            $laporanData[] = [
                'id_siswa' => $siswa->id_siswa,
                'nis' => $siswa->nis,
                'nama_siswa' => $siswa->nama_siswa,
                'kelas' => $siswa->clas ? $siswa->clas->nama_kelas : '-',
                'wali_kelas' => $siswa->clas && $siswa->clas->waliKelas ? $siswa->clas->waliKelas->nama_guru : 'Belum Ada Walas',
                'no_hp_wali' => $waliHp,
                'alpa' => $siswa->alpa_count,
                'izin' => $siswa->izin_count,
                'sakit' => $siswa->sakit_count,
                'terlambat' => $siswa->terlambat_count,
                'status_penanganan' => $statusPenanganan,
                'riwayat_tindakan' => $siswaDisciplines->map(function ($d) {
                    return [
                        'id' => $d->id,
                        'tanggal' => $d->tanggal_tindakan,
                        'tipe' => $d->tipe_tindakan,
                        'keterangan' => $d->keterangan,
                        'tindakan_lanjut' => $d->tindakan_lanjut,
                        'foto' => $d->foto_bukti,
                    ];
                })->values()
            ];
        }

        // Urutkan berdasarkan Alfa terbanyak
        usort($laporanData, function ($a, $b) {
            return $b['alpa'] <=> $a['alpa'];
        });

        // Top 3 Kritis
        $top3 = array_slice($laporanData, 0, 3);

        return Inertia::render('Admin/AttendanceReport', [
            'laporanData' => $laporanData,
            'summary' => [
                'totalKritis' => $totalKritis,
                'top3' => $top3
            ]
        ]);
    }
}
