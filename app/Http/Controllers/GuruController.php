<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Auth;

use App\Models\Timetable;

use App\Models\LearningObjective;
use App\Models\TeacherSubject;
use App\Models\LearningElement;
use App\Models\LearningTopic;
use App\Models\Atp;
use App\Models\Bab;
use App\Models\SubMateri;
use App\Models\AktivitasPembelajaran;
use App\Models\RencanaPenilaian;
use App\Models\Assessment;
use App\Models\StudentAssessmentScore;
use App\Models\SchoolGradingConfig;
use App\Services\GradingService;

class GuruController extends Controller
{
    public function dashboard()
    {
        $user = Auth::user();
        $today = now()->toDateString();
        
        // Get day of week name
        $dayOfWeek = now()->dayOfWeek;
        $days = ['MINGGU', 'SENIN', 'SELASA', 'RABU', 'KAMIS', 'JUMAT', 'SABTU'];
        $hariEnum = $days[$dayOfWeek];

        // Ambil sesi KBM harian untuk guru yang login (terjadwal atau aktual)
        $kbmSessionsRaw = \App\Models\KbmSession::with(['clas', 'subject'])
            ->where('tanggal', $today)
            ->where(function ($query) use ($user) {
                $query->where('id_guru_terjadwal', $user->id_guru)
                      ->orWhere('id_guru_aktual', $user->id_guru);
            })
            ->orderBy('jam_ke')
            ->get();

        // Format data sesuai dengan yang dibutuhkan frontend
        $formattedJadwal = $kbmSessionsRaw->map(function ($session) use ($hariEnum) {
            $shift = $session->clas->shift_operasional ?? 'PAGI';
            
            // Cari JpSchedule untuk menentukan apakah jam pelajaran ini aktif sekarang
            $jp = \App\Models\JpSchedule::where('hari', $hariEnum)
                ->where('shift', $shift)
                ->where('jam_ke', $session->jam_ke)
                ->first();

            $nowTime = now()->toTimeString();
            $isTimeActive = false;
            if ($jp) {
                $isTimeActive = ($nowTime >= $jp->waktu_mulai && $nowTime <= $jp->waktu_selesai);
            }

            // Tambahkan waktu mulai & selesai ke response agar UI bisa menampilkannya
            $jamMulai = $jp ? substr($jp->waktu_mulai, 0, 5) : '-';
            $jamSelesai = $jp ? substr($jp->waktu_selesai, 0, 5) : '-';

            return [
                'id' => $session->id,
                'kelas' => $session->clas->nama_kelas ?? 'Unknown',
                'mapel' => $session->subject->nama_mapel ?? 'Unknown',
                'jam' => 'Jam ke-' . $session->jam_ke,
                'jam_ke' => $session->jam_ke,
                'jamMulai' => $jamMulai,
                'jamSelesai' => $jamSelesai,
                'status_sesi' => $session->status_sesi,
                'status_guru' => $session->status_guru,
                'is_active' => $isTimeActive,
                'shift' => $shift,
                // Sesi terlewat: masih PENDING tapi sudah > 20 menit sejak bel berbunyi
                'is_terlewat' => (
                    $session->status_sesi === 'PENDING' &&
                    $jp !== null &&
                    now()->toTimeString() > date('H:i:s', strtotime($jp->waktu_mulai . ' +20 minutes'))
                ),
                'payload' => $session->status_sesi === 'SCANNING' ? json_encode([
                    'id_kbm_session' => $session->id,
                ]) : null,
            ];
        });

        // Ambil mata pelajaran yang diampu guru secara dinamis
        $mapelDiampu = \App\Models\ClassSubject::with(['clas', 'subject'])
            ->where(function($query) use ($user) {
                $query->where('id_guru_mutlak', $user->id_guru)
                      ->orWhereIn('id_class_subject', \App\Models\Timetable::where('id_guru', $user->id_guru)->pluck('id_class_subject'));
            })
            ->get()
            ->groupBy('id_mapel')
            ->map(function($group) {
                $first = $group->first();
                $kelasNames = $group->map(fn($cs) => $cs->clas->nama_kelas ?? 'Unknown')->unique()->implode(' & ');
                $totalJp = $group->sum('durasi_jp');
                return [
                    'nama' => $first->subject->nama_mapel ?? 'Unknown',
                    'kelas' => $kelasNames,
                    'jp' => $totalJp,
                ];
            })
            ->values();

        // Cek apakah guru ini piket hari ini
        $isPiketToday = false;
        $teacherInfo = \App\Models\Teacher::find($user->id_guru);
        if ($teacherInfo) {
            $piketPagi = is_array($teacherInfo->piket_pagi) ? $teacherInfo->piket_pagi : [];
            $piketSiang = is_array($teacherInfo->piket_siang) ? $teacherInfo->piket_siang : [];
            if (in_array($hariEnum, $piketPagi) || in_array($hariEnum, $piketSiang)) {
                $isPiketToday = true;
            }
        }

        return Inertia::render('Guru/Dashboard', [
            'jadwal' => $formattedJadwal,
            'mapelDiampu' => $mapelDiampu,
            'isPiketToday' => $isPiketToday,
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
        $questionBanks = \App\Models\QuestionBank::withCount('questions')
            ->where('id_guru', $user->id_guru)
            ->where('id_mapel', $session->id_mapel)
            ->get();

        // Ambil data siswa di kelas ini beserta status absensinya
        $students = \App\Models\Student::where('id_kelas', $session->id_kelas)
            ->orderBy('nama_siswa')
            ->get()
            ->map(function ($s) use ($id) {
                $attendance = \App\Models\StudentAttendance::where('id_kbm_session', $id)
                    ->where('id_siswa', $s->id_siswa)
                    ->first();
                
                return [
                    'id' => $s->id_siswa,
                    'nama' => $s->nama_siswa,
                    'nis' => $s->nis,
                    'status' => $attendance ? $attendance->status : 'HADIR',
                    'metode' => $attendance ? $attendance->metode : null,
                    'waktu' => $attendance && $attendance->waktu_presensi ? $attendance->waktu_presensi->format('H:i') : null,
                ];
            });

        return Inertia::render('Guru/SesiKBM', [
            'sessionId' => $id,
            'session' => $session,
            'questionBanks' => $questionBanks,
            'students' => $students
        ]);
    }

    public function pemetaanMateri()
    {
        $user = Auth::user();
        
        // Ambil daftar kelas & mapel yang diajar guru ini (mutlak & terjadwal di timetable)
        $kelasMapelList = \App\Models\ClassSubject::with(['clas', 'subject'])
            ->where(function($query) use ($user) {
                $query->where('id_guru_mutlak', $user->id_guru)
                      ->orWhereIn('id_class_subject', \App\Models\Timetable::where('id_guru', $user->id_guru)->pluck('id_class_subject'));
            })
            ->get()
            ->map(function($cs) {
                return [
                    'id_kelas' => $cs->id_kelas,
                    'nama_kelas' => $cs->clas->nama_kelas ?? 'Unknown',
                    'tingkat' => $cs->clas->tingkat ?? 'Unknown',
                    'id_mapel' => $cs->id_mapel,
                    'nama_mapel' => $cs->subject->nama_mapel ?? 'Unknown',
                    'kkm' => $cs->subject->kkm ?? 75,
                ];
            })
            ->unique(function($item) {
                return $item['id_kelas'] . '-' . $item['id_mapel'];
            })
            ->values();

        $mapelIds = $kelasMapelList->pluck('id_mapel')->unique();
        $kelasIds = $kelasMapelList->pluck('id_kelas')->unique();

        // Ambil daftar Elemen beserta ATPs, TPs, dan Babs
        $elementsList = LearningElement::with(['subject', 'atps.learningObjectives.classes', 'atps.learningObjectives.babs'])
            ->where('id_guru', $user->id_guru)
            ->whereIn('id_mapel', $mapelIds)
            ->get();

        // Ambil Bab List untuk mapel-mapel yang diampu
        $babsList = Bab::with(['subject', 'learningObjectives.classes', 'subMateris.aktivitasPembelajarans', 'rencanaPenilaians'])
            ->whereIn('id_mapel', $mapelIds)
            ->orderBy('urutan')
            ->get();

        // Ambil Asesmen (Assessments) untuk kelas & mapel yang diampu
        $assessmentsList = Assessment::with(['learningObjectives', 'rencanaPenilaian'])
            ->whereIn('id_mapel', $mapelIds)
            ->whereIn('id_kelas', $kelasIds)
            ->where('id_guru', $user->id_guru)
            ->get();

        // Konfigurasi pembobotan aktif
        $gradingConfigs = SchoolGradingConfig::where('is_active', true)->get();

        return Inertia::render('Guru/PemetaanMateri', [
            'kelasMapelList' => $kelasMapelList,
            'elementsList' => $elementsList,
            'babsList' => $babsList,
            'assessmentsList' => $assessmentsList,
            'gradingConfigs' => $gradingConfigs,
        ]);
    }

    public function copyMapping(Request $request)
    {
        $request->validate([
            'id_mapel' => 'required',
            'source_kelas_id' => 'required',
            'target_kelas_id' => 'required',
        ]);

        $user = Auth::user();
        $idGuru = $user->id_guru;
        $idMapel = $request->id_mapel;
        $sourceKelasId = $request->source_kelas_id;
        $targetKelasId = $request->target_kelas_id;

        $sourceClass = \App\Models\Clas::find($sourceKelasId);
        $targetClass = \App\Models\Clas::find($targetKelasId);

        if (!$sourceClass || !$targetClass || $sourceClass->tingkat !== $targetClass->tingkat) {
            return redirect()->back()->withErrors(['message' => 'Penyalinan pemetaan hanya diperbolehkan untuk kelas pada tingkat (grade) yang sama.']);
        }

        // 1. Dapatkan semua id_tp dari mapel & guru ini yang terhubung ke source_kelas_id
        $tpIds = \Illuminate\Support\Facades\DB::table('learning_objectives')
            ->join('learning_objective_class', 'learning_objectives.id_tp', '=', 'learning_objective_class.id_tp')
            ->where('learning_objectives.id_mapel', $idMapel)
            ->where('learning_objectives.id_guru', $idGuru)
            ->where('learning_objective_class.id_kelas', $sourceKelasId)
            ->pluck('learning_objectives.id_tp');

        if ($tpIds->isEmpty()) {
            return redirect()->back()->withErrors(['message' => 'Tidak ada pemetaan materi (TP) di kelas sumber.']);
        }

        // 2. Hubungkan target_kelas_id ke TPs ini
        foreach ($tpIds as $idTp) {
            \Illuminate\Support\Facades\DB::table('learning_objective_class')->insertOrIgnore([
                'id_tp' => $idTp,
                'id_kelas' => $targetKelasId,
            ]);
        }

        return redirect()->back()->with('message', 'Pemetaan materi berhasil disalin.');
    }

    public function simpanPemetaanMateri(Request $request)
    {
        $request->validate([
            'id_element' => 'nullable|exists:learning_elements,id_element',
            'id_mapel' => 'required|exists:subjects,id_mapel',
            'nama_elemen' => 'required|string|max:255',
            'deskripsi_cp' => 'required|string',
        ]);

        $user = Auth::user();

        $element = LearningElement::updateOrCreate(
            ['id_element' => $request->id_element, 'id_guru' => $user->id_guru],
            [
                'id_guru' => $user->id_guru,
                'id_mapel' => $request->id_mapel,
                'nama_elemen' => $request->nama_elemen,
                'deskripsi_cp' => $request->deskripsi_cp,
            ]
        );

        return redirect()->back()->with('message', 'Capaian Pembelajaran (CP) berhasil disimpan.');
    }

    public function hapusElement($id_element)
    {
        $user = Auth::user();
        $element = LearningElement::where('id_guru', $user->id_guru)->findOrFail($id_element);
        $element->delete();

        return redirect()->back()->with('message', 'Capaian Pembelajaran (CP) berhasil dihapus.');
    }

    public function simpanAtp(Request $request)
    {
        $request->validate([
            'id_atp' => 'nullable|exists:atps,id_atp',
            'id_element' => 'required|exists:learning_elements,id_element',
            'kode_atp' => 'required|string|max:50',
            'deskripsi_atp' => 'required|string',
            'urutan' => 'nullable|integer',
            'tps' => 'nullable|array',
        ]);

        $atp = Atp::updateOrCreate(
            ['id_atp' => $request->id_atp],
            [
                'id_element' => $request->id_element,
                'kode_atp' => $request->kode_atp,
                'deskripsi_atp' => $request->deskripsi_atp,
                'urutan' => $request->urutan ?? 1,
            ]
        );

        // Jika ada TP dikirim sekalian
        if ($request->has('tps')) {
            $savedTpIds = [];
            foreach ($request->tps as $tpData) {
                $tp = LearningObjective::updateOrCreate(
                    ['id_tp' => $tpData['id_tp'] ?? null],
                    [
                        'id_atp' => $atp->id_atp,
                        'kode_tp' => $tpData['kode_tp'],
                        'deskripsi_tp' => $tpData['deskripsi_tp'],
                        'semester' => $tpData['semester'] ?? 'GANJIL',
                    ]
                );
                $savedTpIds[] = $tp->id_tp;
                if (isset($tpData['target_kelas'])) {
                    $tp->classes()->sync($tpData['target_kelas']);
                }
            }
            // Hapus TP di bawah ATP ini yang tidak dikirimkan lagi
            if ($request->id_atp) {
                LearningObjective::where('id_atp', $atp->id_atp)
                    ->whereNotIn('id_tp', $savedTpIds)
                    ->delete();
            }
        }

        return redirect()->back()->with('message', 'Alur Tujuan Pembelajaran (ATP) berhasil disimpan.');
    }

    public function hapusAtp($id_atp)
    {
        $atp = Atp::findOrFail($id_atp);
        $atp->delete();
        return redirect()->back()->with('message', 'Alur Tujuan Pembelajaran (ATP) berhasil dihapus.');
    }

    public function simpanBab(Request $request)
    {
        $request->validate([
            'id_bab' => 'nullable|exists:babs,id_bab',
            'id_mapel' => 'required|exists:subjects,id_mapel',
            'nama_bab' => 'required|string|max:255',
            'deskripsi' => 'nullable|string',
            'urutan' => 'nullable|integer',
            'semester' => 'required|in:GANJIL,GENAP',
            'tp_ids' => 'nullable|array',
        ]);

        $bab = Bab::updateOrCreate(
            ['id_bab' => $request->id_bab],
            [
                'id_mapel' => $request->id_mapel,
                'nama_bab' => $request->nama_bab,
                'deskripsi' => $request->deskripsi,
                'urutan' => $request->urutan ?? 1,
                'semester' => $request->semester,
            ]
        );

        if ($request->has('tp_ids')) {
            $bab->learningObjectives()->sync($request->tp_ids);
        }

        return redirect()->back()->with('message', 'Bab/Modul berhasil disimpan.');
    }

    public function hapusBab($id_bab)
    {
        $bab = Bab::findOrFail($id_bab);
        $bab->delete();
        return redirect()->back()->with('message', 'Bab/Modul berhasil dihapus.');
    }

    public function linkTpToBab(Request $request)
    {
        $request->validate([
            'id_bab' => 'required|exists:babs,id_bab',
            'tp_ids' => 'required|array',
        ]);

        $bab = Bab::findOrFail($request->id_bab);
        $bab->learningObjectives()->sync($request->tp_ids);

        return redirect()->back()->with('message', 'Tujuan Pembelajaran berhasil dipetakan ke Bab.');
    }

    public function simpanSubMateri(Request $request)
    {
        $request->validate([
            'id_sub_materi' => 'nullable|exists:sub_materis,id_sub_materi',
            'id_bab' => 'required|exists:babs,id_bab',
            'judul' => 'required|string|max:255',
            'tipe' => 'required|in:ARTIKEL,PDF,VIDEO,PPT,LINK,YOUTUBE,HTML',
            'konten' => 'nullable|string',
            'file' => 'nullable|file|max:20480', // Max 20MB
            'urutan' => 'nullable|integer',
        ]);

        $data = $request->only(['id_bab', 'judul', 'tipe', 'konten', 'urutan']);
        $data['urutan'] = $data['urutan'] ?? 1;

        if ($request->hasFile('file')) {
            $file = $request->file('file');
            $fileName = time() . '_' . $file->getClientOriginalName();
            $dirPath = public_path('uploads/materi');
            if (!file_exists($dirPath)) {
                mkdir($dirPath, 0755, true);
            }
            $file->move($dirPath, $fileName);
            $data['file_path'] = '/uploads/materi/' . $fileName;
        }

        SubMateri::updateOrCreate(['id_sub_materi' => $request->id_sub_materi], $data);

        return redirect()->back()->with('message', 'Sub Materi berhasil disimpan.');
    }

    public function hapusSubMateri($id_sub_materi)
    {
        $sub = SubMateri::findOrFail($id_sub_materi);
        $sub->delete();
        return redirect()->back()->with('message', 'Sub Materi berhasil dihapus.');
    }

    public function simpanAktivitas(Request $request)
    {
        $request->validate([
            'id_aktivitas' => 'nullable|exists:aktivitas_pembelajarans,id_aktivitas',
            'id_sub_materi' => 'required|exists:sub_materis,id_sub_materi',
            'nama_aktivitas' => 'required|string|max:255',
            'tipe_aktivitas' => 'required|in:MEMBACA,MENONTON,DISKUSI,UPLOAD_TUGAS,PRAKTIK,QUIZ',
            'deskripsi' => 'nullable|string',
            'status_wajib' => 'required|boolean',
        ]);

        AktivitasPembelajaran::updateOrCreate(
            ['id_aktivitas' => $request->id_aktivitas],
            $request->all()
        );

        return redirect()->back()->with('message', 'Aktivitas Pembelajaran berhasil disimpan.');
    }

    public function hapusAktivitas($id_aktivitas)
    {
        $akt = AktivitasPembelajaran::findOrFail($id_aktivitas);
        $akt->delete();
        return redirect()->back()->with('message', 'Aktivitas Pembelajaran berhasil dihapus.');
    }

    public function simpanRencanaPenilaian(Request $request)
    {
        $request->validate([
            'id_bab' => 'required|exists:babs,id_bab',
            'jumlah_formatif' => 'required|integer|min:0',
            'jumlah_sumatif' => 'required|integer|min:0',
        ]);

        RencanaPenilaian::updateOrCreate(
            ['id_bab' => $request->id_bab],
            $request->only(['id_bab', 'jumlah_formatif', 'jumlah_sumatif'])
        );

        return redirect()->back()->with('message', 'Rencana Penilaian berhasil disimpan.');
    }

    public function generateDraftAsesmen(Request $request)
    {
        $request->validate([
            'id_bab' => 'required|exists:babs,id_bab',
            'id_kelas' => 'required|exists:classes,id_kelas',
            'id_mapel' => 'required|exists:subjects,id_mapel',
        ]);

        $user = Auth::user();
        $idBab = $request->id_bab;
        $idKelas = $request->id_kelas;
        $idMapel = $request->id_mapel;

        $bab = Bab::findOrFail($idBab);
        $planner = RencanaPenilaian::where('id_bab', $idBab)->first();
        if (!$planner) {
            return redirect()->back()->with('error', 'Rencana Penilaian belum ditentukan.');
        }

        // Ambil semua asesmen yang sudah ada
        $existingAssessments = Assessment::where([
            'id_bab' => $idBab,
            'id_kelas' => $idKelas,
            'id_mapel' => $idMapel
        ])->get();

        // Pisahkan asesmen yang sudah memiliki nilai vs belum memiliki nilai
        $gradedAssessments = $existingAssessments->filter(function ($assessment) {
            return StudentAssessmentScore::where('id_assessment', $assessment->id_assessment)
                ->whereNotNull('nilai')
                ->exists();
        });

        $ungradedAssessments = $existingAssessments->reject(function ($assessment) {
            return StudentAssessmentScore::where('id_assessment', $assessment->id_assessment)
                ->whereNotNull('nilai')
                ->exists();
        });

        // Jumlah target formatif & sumatif
        $targetFormatif = max(0, $planner->jumlah_formatif);
        $targetSumatif = max(0, $planner->jumlah_sumatif);

        // --- SESUAIKAN FORMATIF ---
        $currentFormatifAssessments = $existingAssessments->where('kategori', 'FORMATIF')->values();
        $currentFormatifCount = $currentFormatifAssessments->count();

        if ($currentFormatifCount < $targetFormatif) {
            // Tambahkan draf baru
            $toAdd = $targetFormatif - $currentFormatifCount;
            for ($i = 0; $i < $toAdd; $i++) {
                $num = $currentFormatifCount + $i + 1;
                Assessment::create([
                    'id_rencana' => $planner->id_rencana,
                    'id_bab' => $idBab,
                    'id_kelas' => $idKelas,
                    'id_mapel' => $idMapel,
                    'id_guru' => $user->id_guru,
                    'nama_asesmen' => 'Formatif ' . $num . ' (Bab ' . $bab->urutan . ')',
                    'kategori' => 'FORMATIF',
                    'bentuk_asesmen' => 'Tugas',
                    'status' => 'DRAFT',
                    'semester' => $bab->semester,
                ]);
            }
        } elseif ($currentFormatifCount > $targetFormatif) {
            // Hapus draf kosong yang berlebih
            $toRemove = $currentFormatifCount - $targetFormatif;
            $ungradedFormatif = $ungradedAssessments->where('kategori', 'FORMATIF')->values();
            for ($i = 0; $i < min($toRemove, $ungradedFormatif->count()); $i++) {
                $ungradedFormatif[$i]->delete();
            }
        }

        // --- SESUAIKAN SUMATIF ---
        $currentSumatifAssessments = $existingAssessments->where('kategori', 'SUMATIF')->values();
        $currentSumatifCount = $currentSumatifAssessments->count();

        if ($currentSumatifCount < $targetSumatif) {
            // Tambahkan draf baru
            $toAdd = $targetSumatif - $currentSumatifCount;
            for ($i = 0; $i < $toAdd; $i++) {
                $num = $currentSumatifCount + $i + 1;
                Assessment::create([
                    'id_rencana' => $planner->id_rencana,
                    'id_bab' => $idBab,
                    'id_kelas' => $idKelas,
                    'id_mapel' => $idMapel,
                    'id_guru' => $user->id_guru,
                    'nama_asesmen' => 'Sumatif ' . $num . ' (Bab ' . $bab->urutan . ')',
                    'kategori' => 'SUMATIF',
                    'bentuk_asesmen' => 'Sumatif Lingkup Materi',
                    'status' => 'DRAFT',
                    'semester' => $bab->semester,
                ]);
            }
        } elseif ($currentSumatifCount > $targetSumatif) {
            // Hapus draf kosong yang berlebih
            $toRemove = $currentSumatifCount - $targetSumatif;
            $ungradedSumatif = $ungradedAssessments->where('kategori', 'SUMATIF')->values();
            for ($i = 0; $i < min($toRemove, $ungradedSumatif->count()); $i++) {
                $ungradedSumatif[$i]->delete();
            }
        }

        return redirect()->back()->with('message', 'Draf asesmen berhasil dibuat dan disesuaikan.');
    }

    public function simpanAsesmen(Request $request)
    {
        $request->validate([
            'id_assessment' => 'nullable|exists:assessments,id_assessment',
            'id_bab' => 'required|exists:babs,id_bab',
            'id_kelas' => 'required|exists:classes,id_kelas',
            'id_mapel' => 'required|exists:subjects,id_mapel',
            'nama_asesmen' => 'required|string|max:255',
            'kategori' => 'required|in:FORMATIF,SUMATIF',
            'bentuk_asesmen' => 'required|string',
            'tanggal' => 'nullable|date',
            'deskripsi' => 'nullable|string',
            'status' => 'required|in:DRAFT,AKTIF,SELESAI',
            'tp_ids' => 'required|array',
        ]);

        $user = Auth::user();
        $bab = Bab::findOrFail($request->id_bab);

        $assessment = Assessment::updateOrCreate(
            ['id_assessment' => $request->id_assessment],
            [
                'id_bab' => $request->id_bab,
                'id_kelas' => $request->id_kelas,
                'id_mapel' => $request->id_mapel,
                'id_guru' => $user->id_guru,
                'nama_asesmen' => $request->nama_asesmen,
                'kategori' => $request->kategori,
                'bentuk_asesmen' => $request->bentuk_asesmen,
                'tanggal' => $request->tanggal,
                'deskripsi' => $request->deskripsi,
                'status' => $request->status,
                'semester' => $bab->semester,
            ]
        );

        $assessment->learningObjectives()->sync($request->tp_ids);

        return redirect()->back()->with('message', 'Asesmen berhasil disimpan.');
    }

    public function hapusAsesmen($id_assessment)
    {
        $assessment = Assessment::findOrFail($id_assessment);
        
        $hasScores = StudentAssessmentScore::where('id_assessment', $id_assessment)->whereNotNull('nilai')->exists();
        if ($hasScores) {
            return redirect()->back()->with('error', 'Gagal: Asesmen sudah memiliki nilai siswa.');
        }

        $assessment->delete();
        return redirect()->back()->with('message', 'Asesmen berhasil dihapus.');
    }

    public function simpanNilaiAsesmen(Request $request)
    {
        $request->validate([
            'id_assessment' => 'required|exists:assessments,id_assessment',
            'students' => 'required|array',
            'students.*.id_siswa' => 'required|exists:students,id_siswa',
            'students.*.nilai' => 'nullable|numeric|min:0|max:100',
            'students.*.catatan' => 'nullable|string',
        ]);

        $idAssessment = $request->id_assessment;
        $assessment = Assessment::findOrFail($idAssessment);

        foreach ($request->students as $studentData) {
            if ($studentData['nilai'] === null || $studentData['nilai'] === '') {
                StudentAssessmentScore::where('id_assessment', $idAssessment)
                    ->where('id_siswa', $studentData['id_siswa'])
                    ->delete();
            } else {
                StudentAssessmentScore::updateOrCreate(
                    [
                        'id_assessment' => $idAssessment,
                        'id_siswa' => $studentData['id_siswa'],
                    ],
                    [
                        'nilai' => $studentData['nilai'],
                        'catatan' => $studentData['catatan'] ?? null,
                    ]
                );
            }
        }

        if ($assessment->status !== 'SELESAI') {
            $assessment->status = 'SELESAI';
            $assessment->save();
        }

        return redirect()->back()->with('message', 'Semua nilai asesmen berhasil disimpan.');
    }

    public function hapusPemetaanMateri($id_tp)
    {
        $user = Auth::user();
        $tp = LearningObjective::where('id_guru', $user->id_guru)->findOrFail($id_tp);
        $tp->delete();

        return redirect()->back()->with('message', 'Tujuan Pembelajaran berhasil dihapus.');
    }

    public function nilaiSumatif(Request $request)
    {
        return redirect()->route('nilai-akhir');
    }

    public function simpanNilaiSumatif(Request $request)
    {
        return redirect()->route('nilai-akhir');
    }

    public function nilaiAkhir(Request $request)
    {
        $user = Auth::user();

        // 1. Ambil daftar kelas & mapel yang diajar
        $kelasMapelList = \App\Models\ClassSubject::with(['clas', 'subject'])
            ->where(function($query) use ($user) {
                $query->where('id_guru_mutlak', $user->id_guru)
                      ->orWhereIn('id_class_subject', \App\Models\Timetable::where('id_guru', $user->id_guru)->pluck('id_class_subject'));
            })
            ->get();

        $kelasList = $kelasMapelList->pluck('clas')->filter()->unique('id_kelas')->values();
        $mapelList = $kelasMapelList->pluck('subject')->filter()->unique('id_mapel')->values();

        $selectedKelas = $request->input('id_kelas', $kelasList->first()->id_kelas ?? null);
        $selectedMapel = $request->input('id_mapel', $mapelList->first()->id_mapel ?? null);

        $midSemesterData = null;
        $endSemesterData = null;
        $kkm = 75;

        $assessments = [];
        $babs = [];
        $tps = [];

        if ($selectedKelas && $selectedMapel) {
            $subject = \App\Models\Subject::find($selectedMapel);
            if ($subject) {
                $kkm = $subject->kkm;
            }

            $gradingService = new GradingService();
            $midSemesterData = $gradingService->calculateMidSemesterGrades($selectedKelas, $selectedMapel);
            $endSemesterData = $gradingService->calculateEndSemesterGrades($selectedKelas, $selectedMapel);
            
            $assessments = Assessment::with(['learningObjectives', 'scores'])
                ->where('id_kelas', $selectedKelas)
                ->where('id_mapel', $selectedMapel)
                ->get();

            $babs = Bab::with('rencanaPenilaians')->where('id_mapel', $selectedMapel)->orderBy('urutan')->get();
            
            $tps = LearningObjective::whereHas('atp', function ($q) use ($selectedMapel) {
                $q->where('id_mapel', $selectedMapel);
            })->get();
        }

        return Inertia::render('Guru/NilaiAkhir', [
            'kelasList' => $kelasList,
            'mapelList' => $mapelList,
            'selectedKelas' => $selectedKelas,
            'selectedMapel' => $selectedMapel,
            'midSemesterData' => $midSemesterData,
            'endSemesterData' => $endSemesterData,
            'kkm' => $kkm,
            'assessments' => $assessments,
            'babs' => $babs,
            'tps' => $tps,
        ]);
    }

    public function simpanNilaiAkhir(Request $request)
    {
        $request->validate([
            'id_kelas' => 'required|exists:classes,id_kelas',
            'id_mapel' => 'required|exists:subjects,id_mapel',
            'tipe' => 'required|in:STS,SAS',
            'students' => 'required|array',
            'students.*.id_siswa' => 'required|exists:students,id_siswa',
            'students.*.nilai' => 'nullable|numeric|min:0|max:100',
        ]);

        $user = Auth::user();
        $idKelas = $request->id_kelas;
        $idMapel = $request->id_mapel;
        $tipe = $request->tipe;

        // Cari atau buat Bab pertama (sebagai fallback jika bab belum ada)
        // Karena Asesmen membutuhkan id_bab
        $bab = Bab::where('id_mapel', $idMapel)->orderBy('urutan')->first();
        if (!$bab) {
            $bab = Bab::create([
                'id_mapel' => $idMapel,
                'nama_bab' => 'Pendahuluan / Asesmen Utama',
                'urutan' => 1,
                'semester' => 'GANJIL',
            ]);
        }

        // Cari atau buat Asesmen STS/SAS
        $assessment = Assessment::where([
            'id_kelas' => $idKelas,
            'id_mapel' => $idMapel,
            'kategori' => 'SUMATIF',
            'bentuk_asesmen' => $tipe,
        ])->first();

        if (!$assessment) {
            $assessment = Assessment::create([
                'id_bab' => $bab->id_bab,
                'id_kelas' => $idKelas,
                'id_mapel' => $idMapel,
                'id_guru' => $user->id_guru,
                'nama_asesmen' => 'Sumatif ' . ($tipe === 'STS' ? 'Tengah' : 'Akhir') . ' Semester (' . $tipe . ')',
                'kategori' => 'SUMATIF',
                'bentuk_asesmen' => $tipe,
                'tanggal' => now()->toDateString(),
                'status' => 'SELESAI',
                'semester' => $bab->semester,
            ]);
        } else {
            $assessment->status = 'SELESAI';
            $assessment->save();
        }

        foreach ($request->students as $studentData) {
            if ($studentData['nilai'] === null || $studentData['nilai'] === '') {
                StudentAssessmentScore::where('id_assessment', $assessment->id_assessment)
                    ->where('id_siswa', $studentData['id_siswa'])
                    ->delete();
            } else {
                StudentAssessmentScore::updateOrCreate(
                    [
                        'id_assessment' => $assessment->id_assessment,
                        'id_siswa' => $studentData['id_siswa'],
                    ],
                    [
                        'nilai' => $studentData['nilai'],
                    ]
                );
            }
        }

        return redirect()->back()->with('message', 'Nilai ' . $tipe . ' berhasil disimpan.');
    }

    public function raporPreview()
    {
        return Inertia::render('Guru/RaporPreview');
    }

    public function mulaiKbm($id_sesi)
    {
        $session = \App\Models\KbmSession::findOrFail($id_sesi);
        
        $blockSessions = \App\Models\KbmSession::where('tanggal', $session->tanggal)
            ->where('id_kelas', $session->id_kelas)
            ->where('id_mapel', $session->id_mapel)
            ->where('id_guru_terjadwal', $session->id_guru_terjadwal)
            ->get();

        foreach ($blockSessions as $bSession) {
            if ($bSession->status_sesi === 'PENDING') {
                $bSession->status_sesi = 'SCANNING';
                $bSession->status_guru = 'PENDING';
                $bSession->waktu_scan_masuk = null;
                $bSession->save();
            }
        }

        return redirect()->route('guru.sesi-kbm', $id_sesi)->with('message', 'Sesi KBM berhasil dimulai.');
    }

    public function uploadSelfieKbm(Request $request, $id_sesi)
    {
        $request->validate([
            'foto' => 'required|string',
            'latitude' => 'nullable|string',
            'longitude' => 'nullable|string',
        ]);

        $session = \App\Models\KbmSession::findOrFail($id_sesi);

        // Decode base64 image
        $image = $request->input('foto');
        $image = str_replace('data:image/jpeg;base64,', '', $image);
        $image = str_replace(' ', '+', $image);
        $imageName = 'selfie_' . $id_sesi . '_' . time() . '.jpg';

        $dirPath = public_path('uploads/selfie');
        if (!file_exists($dirPath)) {
            mkdir($dirPath, 0755, true);
        }

        file_put_contents($dirPath . '/' . $imageName, base64_decode($image));
        $filePath = '/uploads/selfie/' . $imageName;

        // Cari semua sesi dalam blok yang sama
        $blockSessions = \App\Models\KbmSession::where('tanggal', $session->tanggal)
            ->where('id_kelas', $session->id_kelas)
            ->where('id_mapel', $session->id_mapel)
            ->where('id_guru_terjadwal', $session->id_guru_terjadwal)
            ->get();

        foreach ($blockSessions as $bSession) {
            $bSession->status_sesi = 'AKTIF';
            $bSession->status_guru = 'HADIR';
            $bSession->waktu_scan_masuk = now();
            $bSession->foto_selfie = $filePath;
            $bSession->latitude = $request->input('latitude');
            $bSession->longitude = $request->input('longitude');
            $bSession->save();

            // Inisialisasi absensi semua siswa di kelas ini sebagai default HADIR
            $studentsInClass = \App\Models\Student::where('id_kelas', $bSession->id_kelas)->get();
            foreach ($studentsInClass as $s) {
                \App\Models\StudentAttendance::updateOrCreate(
                    [
                        'id_kbm_session' => $bSession->id,
                        'id_siswa' => $s->id_siswa,
                    ],
                    [
                        'status' => 'HADIR',
                        'metode' => 'SYSTEM',
                        'waktu_presensi' => null,
                    ]
                );
            }
        }

        return redirect()->route('guru.sesi-kbm', $id_sesi)->with('message', 'Sesi KBM aktif, selfie berhasil diunggah.');
    }

    public function selesaiKbm($id_sesi)
    {
        $session = \App\Models\KbmSession::findOrFail($id_sesi);
        
        $blockSessions = \App\Models\KbmSession::where('tanggal', $session->tanggal)
            ->where('id_kelas', $session->id_kelas)
            ->where('id_mapel', $session->id_mapel)
            ->where('id_guru_terjadwal', $session->id_guru_terjadwal)
            ->get();

        foreach ($blockSessions as $bSession) {
            $bSession->status_sesi = 'SELESAI';
            $bSession->waktu_scan_keluar = now();
            $bSession->save();
        }

        return redirect()->route('guru.dashboard')->with('message', 'Sesi KBM selesai.');
    }

    public function simpanPresensi(Request $request, $id_sesi)
    {
        $request->validate([
            'students' => 'required|array',
            'materi_log' => 'nullable|string|max:255',
        ]);

        $session = \App\Models\KbmSession::findOrFail($id_sesi);
        
        $blockSessions = \App\Models\KbmSession::where('tanggal', $session->tanggal)
            ->where('id_kelas', $session->id_kelas)
            ->where('id_mapel', $session->id_mapel)
            ->where('id_guru_terjadwal', $session->id_guru_terjadwal)
            ->get();

        foreach ($blockSessions as $bSession) {
            // Simpan materi log ke session
            if ($request->has('materi_log')) {
                $bSession->materi_log = $request->materi_log;
                $bSession->save();
            }

            // Simpan/update presensi siswa untuk masing-masing sesi di blok tersebut
            foreach ($request->students as $studentData) {
                \App\Models\StudentAttendance::updateOrCreate(
                    [
                        'id_kbm_session' => $bSession->id,
                        'id_siswa' => $studentData['id'],
                    ],
                    [
                        'status' => $studentData['status'],
                        'metode' => 'MANUAL_GURU',
                        'waktu_presensi' => $studentData['status'] === 'HADIR' ? now() : null,
                    ]
                );
            }
        }

        return redirect()->back()->with('message', 'Presensi dan Jurnal berhasil disimpan.');
    }

    public function riwayatJurnal()
    {
        $user = Auth::user();
        
        // Ambil semua sesi yang diampu guru ini dan sudah SELESAI
        $sessions = \App\Models\KbmSession::with(['clas', 'subject', 'attendances'])
            ->where(function($q) use ($user) {
                $q->where('id_guru_terjadwal', $user->id_guru)
                  ->orWhere('id_guru_aktual', $user->id_guru);
            })
            ->where('status_sesi', 'SELESAI')
            ->orderBy('tanggal', 'desc')
            ->orderBy('jam_ke', 'desc')
            ->get()
            ->map(function ($session) {
                $totalSiswa = \App\Models\Student::where('id_kelas', $session->id_kelas)->count();
                $hadir = $session->attendances->where('status', 'HADIR')->count();
                $sakit = $session->attendances->where('status', 'SAKIT')->count();
                $izin = $session->attendances->where('status', 'IZIN')->count();
                $alpa = $session->attendances->where('status', 'ALPA')->count();

                return [
                    'id' => $session->id,
                    'tanggal' => $session->tanggal->format('Y-m-d'),
                    'kelas' => $session->clas->nama_kelas ?? 'Unknown',
                    'mapel' => $session->subject->nama_mapel ?? 'Unknown',
                    'jam_ke' => $session->jam_ke,
                    'materi_log' => $session->materi_log ?? '-',
                    'stats' => [
                        'total' => $totalSiswa,
                        'hadir' => $hadir,
                        'sakit' => $sakit,
                        'izin' => $izin,
                        'alpa' => $alpa,
                    ]
                ];
            });

        return Inertia::render('Guru/RiwayatJurnal', [
            'sessions' => $sessions,
        ]);
    }

    public function jadwal()
    {
        $user = Auth::user();
        
        $timetable = Timetable::with(['classSubject.clas', 'classSubject.subject'])
            ->where('id_guru', $user->id_guru)
            ->get();

        $jpSchedules = \App\Models\JpSchedule::orderBy('shift')
            ->orderByRaw("FIELD(hari, 'SENIN', 'SELASA', 'RABU', 'KAMIS', 'JUMAT', 'SABTU')")
            ->orderBy('waktu_mulai')
            ->get()
            ->groupBy(['shift', 'hari']);

        return Inertia::render('Guru/Jadwal', [
            'timetable' => $timetable,
            'jpSchedules' => $jpSchedules
        ]);
    }
}
