<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Auth;

use App\Models\Timetable;

use App\Models\LearningObjective;
use App\Models\TeacherSubject;

class GuruController extends Controller
{
    public function dashboard()
    {
        $user = Auth::user();
        $today = now()->toDateString();
        
        // Ambil sesi KBM hari ini untuk guru yang login (terjadwal atau aktual)
        $kbmSessionsRaw = \App\Models\KbmSession::with(['clas', 'subject'])
            ->where('tanggal', $today)
            ->where(function ($query) use ($user) {
                $query->where('id_guru_terjadwal', $user->id_guru)
                      ->orWhere('id_guru_aktual', $user->id_guru);
            })
            ->orderBy('jam_ke')
            ->get();

        // Format data sesuai dengan yang dibutuhkan frontend
        $formattedJadwal = $kbmSessionsRaw->map(function ($session) {
            return [
                'id' => $session->id,
                'kelas' => $session->clas->nama_kelas ?? 'Unknown',
                'mapel' => $session->subject->nama_mapel ?? 'Unknown',
                'jam' => 'Jam ke-' . $session->jam_ke,
                'status_sesi' => $session->status_sesi,
                'status_guru' => $session->status_guru,
                'is_active' => $session->status_sesi === 'PENDING' || $session->status_sesi === 'AKTIF',
                'payload' => $session->status_sesi === 'PENDING' ? json_encode([
                    'id_kbm_session' => $session->id,
                    // Timestamp ditambahkan oleh frontend tiap 10 detik
                ]) : null,
            ];
        });

        return Inertia::render('Guru/Dashboard', [
            'jadwal' => $formattedJadwal,
        ]);
    }

    public function kbmStatus($id)
    {
        $session = \App\Models\KbmSession::find($id);
        if (!$session) {
            return response()->json(['status' => 'ERROR'], 404);
        }
        return response()->json(['status_sesi' => $session->status_sesi]);
    }

    public function sesiKbm($id)
    {
        $user = Auth::user();
        
        $session = \App\Models\KbmSession::with(['clas', 'subject'])->findOrFail($id);
        
        // Ambil bank soal yang relevan untuk mapel ini
        $questionBanks = \App\Models\QuestionBank::where('id_guru', $user->id_guru)
            ->where('id_mapel', $session->id_mapel)
            ->get();

        return Inertia::render('Guru/SesiKBM', [
            'sessionId' => $id,
            'sessionDb' => $session,
            'questionBanks' => $questionBanks
        ]);
    }

    public function pemetaanMateri()
    {
        $user = Auth::user();
        
        // Ambil daftar mapel yang diajar guru ini
        $mapelList = TeacherSubject::with('subject')
            ->where('id_guru', $user->id_guru)
            ->get()
            ->pluck('subject')
            ->unique('id_mapel')
            ->values();

        // Ambil data Tujuan Pembelajaran (TP) yang sudah dibuat oleh guru ini
        $tpList = LearningObjective::with('subject')
            ->where('id_guru', $user->id_guru)
            ->orderBy('id_mapel')
            ->orderBy('kode_tp')
            ->get();

        return Inertia::render('Guru/PemetaanMateri', [
            'mapelList' => $mapelList,
            'tpList' => $tpList,
        ]);
    }

    public function simpanPemetaanMateri(Request $request)
    {
        $request->validate([
            'id_mapel' => 'required|exists:subjects,id_mapel',
            'kode_tp' => 'required|string|max:50',
            'deskripsi_tp' => 'required|string',
            'semester' => 'required|in:GANJIL,GENAP',
        ]);

        $user = Auth::user();

        LearningObjective::create([
            'id_guru' => $user->id_guru,
            'id_mapel' => $request->id_mapel,
            'kode_tp' => $request->kode_tp,
            'deskripsi_tp' => $request->deskripsi_tp,
            'semester' => $request->semester,
        ]);

        return redirect()->back()->with('message', 'Tujuan Pembelajaran berhasil ditambahkan.');
    }

    public function nilaiSumatif(Request $request)
    {
        $user = Auth::user();

        // 1. Ambil daftar kelas yang diajar guru
        $kelasMapelList = TeacherSubject::with(['class', 'subject'])
            ->where('id_guru', $user->id_guru)
            ->get();

        // Unique classes and subjects for dropdowns
        $kelasList = $kelasMapelList->pluck('class')->unique('id_kelas')->values();
        $mapelList = $kelasMapelList->pluck('subject')->unique('id_mapel')->values();

        // Default selection
        $selectedKelas = $request->input('id_kelas', $kelasList->first()->id_kelas ?? null);
        $selectedMapel = $request->input('id_mapel', $mapelList->first()->id_mapel ?? null);

        // 2. Ambil Tujuan Pembelajaran (TP) untuk Mapel dan Guru terkait
        $tpList = [];
        $students = [];

        if ($selectedMapel) {
            $tpList = LearningObjective::where('id_guru', $user->id_guru)
                ->where('id_mapel', $selectedMapel)
                ->orderBy('kode_tp')
                ->get();
        }

        // 3. Ambil daftar Siswa berdasarkan kelas yang dipilih beserta Nilai-nya
        if ($selectedKelas && count($tpList) > 0) {
            $tpIds = $tpList->pluck('id_tp');

            $studentsRaw = \App\Models\Student::where('id_kelas', $selectedKelas)
                ->orderBy('nama_siswa')
                ->get();

            // Ambil semua nilai siswa di kelas ini untuk TP yang relevan
            $grades = \App\Models\StudentGrade::whereIn('id_siswa', $studentsRaw->pluck('id_siswa'))
                ->whereIn('id_tp', $tpIds)
                ->get()
                ->groupBy('id_siswa');

            foreach ($studentsRaw as $siswa) {
                $nilaiMapping = [];
                foreach ($tpList as $tp) {
                    // Cari nilai untuk TP ini
                    $grade = $grades->get($siswa->id_siswa)?->firstWhere('id_tp', $tp->id_tp);
                    $nilaiMapping[$tp->id_tp] = $grade ? $grade->nilai : null;
                }

                $students[] = [
                    'id' => $siswa->id_siswa,
                    'nama' => $siswa->nama_siswa,
                    'nis' => $siswa->nis,
                    'nilai' => $nilaiMapping,
                    'catatan' => '', // Nanti diambil dari tabel jika ada
                ];
            }
        }

        return Inertia::render('Guru/NilaiSumatif', [
            'kelasList' => $kelasList,
            'mapelList' => $mapelList,
            'selectedKelas' => $selectedKelas,
            'selectedMapel' => $selectedMapel,
            'tpList' => $tpList,
            'students' => $students,
        ]);
    }

    public function simpanNilaiSumatif(Request $request)
    {
        $request->validate([
            'students' => 'required|array',
        ]);

        $studentsData = $request->input('students');

        foreach ($studentsData as $siswa) {
            $idSiswa = $siswa['id'];
            $nilaiData = $siswa['nilai'] ?? []; // Array dengan key id_tp dan value nilainya

            foreach ($nilaiData as $idTp => $nilai) {
                // Jangan update/insert jika nilai kosong/null
                if ($nilai === null || $nilai === '') {
                    continue;
                }

                \App\Models\StudentGrade::updateOrCreate(
                    [
                        'id_siswa' => $idSiswa,
                        'id_tp' => $idTp,
                    ],
                    [
                        'nilai' => $nilai,
                    ]
                );
            }
        }

        return redirect()->back()->with('message', 'Semua nilai berhasil disimpan!');
    }

    public function nilaiAkhir()
    {
        return Inertia::render('Guru/NilaiAkhir');
    }

    public function raporPreview()
    {
        return Inertia::render('Guru/RaporPreview');
    }
}
