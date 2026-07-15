<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Auth;

use App\Models\Student;
use App\Models\Timetable;

class SiswaController extends Controller
{
    public function dashboard()
    {
        $user = Auth::user();
        $today = now()->toDateString();
        
        // Ambil data siswa
        $siswa = Student::with('clas')->find($user->id_siswa);

        $jadwalRaw = [];
        if ($siswa && $siswa->id_kelas) {
            $jadwalRaw = \App\Models\KbmSession::with(['clas', 'subject', 'guruAktual'])
                ->where('id_kelas', $siswa->id_kelas)
                ->where('tanggal', $today)
                ->orderBy('jam_ke')
                ->get();
        }

        // Get day of week name
        $dayOfWeek = now()->dayOfWeek;
        $days = ['MINGGU', 'SENIN', 'SELASA', 'RABU', 'KAMIS', 'JUMAT', 'SABTU'];
        $hariEnum = $days[$dayOfWeek];
        
        $shift = $siswa->clas->shift_operasional ?? 'PAGI';

        // Retrieve JpSchedules for today and this shift
        $schedules = \App\Models\JpSchedule::where('hari', $hariEnum)
            ->where('shift', $shift)
            ->orderBy('waktu_mulai')
            ->get();

        $formattedJadwal = $schedules->map(function ($jp) use ($jadwalRaw, $user) {
            $session = collect($jadwalRaw)->firstWhere('jam_ke', $jp->jam_ke);
            
            $jamMulai = substr($jp->waktu_mulai, 0, 5);
            $jamSelesai = substr($jp->waktu_selesai, 0, 5);

            // Cek apakah JP ini adalah jam pelajaran aktif saat ini
            $nowTime = now()->toTimeString();
            $isTimeActive = ($nowTime >= $jp->waktu_mulai && $nowTime <= $jp->waktu_selesai);
            $isTimePassed = ($nowTime > $jp->waktu_selesai);

            if (!$jp->is_kbm) {
                // Jam Istirahat
                return [
                    'id' => 'break-' . $jp->id,
                    'mapel' => '☕ ISTIRAHAT',
                    'guru' => 'Istirahat Sejenak',
                    'jamKe' => 0,
                    'jamMulai' => $jamMulai,
                    'jamSelesai' => $jamSelesai,
                    'status' => 'BREAK',
                    'isTimeActive' => $isTimeActive,
                    'isTimePassed' => $isTimePassed,
                    'presensiSiswa' => null,
                    'ruang' => '-',
                ];
            }

            if ($session) {
                $attendance = \App\Models\StudentAttendance::where('id_kbm_session', $session->id)
                    ->where('id_siswa', $user->id_siswa)
                    ->first();

                return [
                    'id' => $session->id,
                    'mapel' => $session->subject->nama_mapel ?? 'Unknown',
                    'guru' => $session->guruAktual->nama_guru ?? 'Unknown',
                    'jamKe' => $session->jam_ke,
                    'jamMulai' => $jamMulai,
                    'jamSelesai' => $jamSelesai,
                    'status' => $session->status_sesi,
                    'isTimeActive' => $isTimeActive,
                    'isTimePassed' => $isTimePassed,
                    'presensiSiswa' => $attendance ? $attendance->status : null,
                    'ruang' => 'Ruang Kelas',
                ];
            }

            // Jika kosong/tidak ada kelas di jam ke tersebut
            return [
                'id' => 'empty-' . $jp->id,
                'mapel' => 'Tidak Ada Kelas',
                'guru' => '-',
                'jamKe' => $jp->jam_ke,
                'jamMulai' => $jamMulai,
                'jamSelesai' => $jamSelesai,
                'status' => 'KOSONG',
                'isTimeActive' => $isTimeActive,
                'isTimePassed' => $isTimePassed,
                'presensiSiswa' => null,
                'ruang' => '-',
            ];
        })->values();

        // Cek apakah ada Ujian Live aktif untuk sesi kelas hari ini
        $activeLiveExam = null;
        $activeSession = collect($jadwalRaw)->firstWhere('status_sesi', 'AKTIF');
        if (!$activeSession && $siswa && $siswa->id_kelas) {
            // Fallback: Cari sesi aktif kelas ini tanpa membatasi tanggal hari ini (berguna saat simulasi/mock time)
            $activeSession = \App\Models\KbmSession::where('id_kelas', $siswa->id_kelas)
                ->where('status_sesi', 'AKTIF')
                ->first();
        }
        if ($activeSession) {
            $activeLiveExam = \App\Models\LiveExam::with('questionBank')
                ->where('id_kbm_session', $activeSession->id)
                ->where('status', 'ACTIVE')
                ->first();
        }

        return Inertia::render('Siswa/Dashboard', [
            'siswa' => $siswa,
            'kelas' => $siswa->clas->nama_kelas ?? 'Unknown',
            'jadwal' => $formattedJadwal,
            'activeLiveExam' => $activeLiveExam ? [
                'id_exam' => $activeLiveExam->id_exam,
                'judul' => $activeLiveExam->questionBank->judul ?? 'Asesmen Live',
                'tujuan' => $activeLiveExam->tujuan,
                'durasi' => $activeLiveExam->durasi,
            ] : null,
        ]);
    }

    public function scanQr()
    {
        $user = Auth::user();
        $siswa = Student::find($user->id_siswa);
        
        $activeSession = null;
        if ($siswa && $siswa->id_kelas) {
            $activeSession = \App\Models\KbmSession::with('subject')
                ->where('id_kelas', $siswa->id_kelas)
                ->where('status_sesi', 'SCANNING')
                ->first();
        }

        return Inertia::render('Siswa/ScanQR', [
            'activeSession' => $activeSession ? [
                'id_kbm_session' => $activeSession->id,
                'mapel' => $activeSession->subject->nama_mapel ?? 'Mata Pelajaran',
            ] : null,
        ]);
    }

    public function processScan(Request $request)
    {
        $request->validate([
            'payload' => 'required|string'
        ]);

        try {
            $data = json_decode($request->payload, true);
            if (!isset($data['id_kbm_session']) || !isset($data['timestamp'])) {
                return response()->json(['message' => 'QR Code tidak valid!'], 400);
            }

            // Validasi Kedaluwarsa (15 detik, di-bypass jika local environment atau mode simulasi aktif)
            $diffSeconds = (time() * 1000 - $data['timestamp']) / 1000;
            $isMockTime = app()->environment(['local', 'development']) && \Illuminate\Support\Facades\Cache::has('time_offset');
            if (!app()->environment(['local', 'development']) && !$isMockTime && ($diffSeconds > 15 || $diffSeconds < -15)) {
                return response()->json(['message' => 'QR Code sudah KEDALUWARSA! Silakan scan QR terbaru di layar proyektor.'], 400);
            }

            $session = \App\Models\KbmSession::find($data['id_kbm_session']);
            if (!$session) {
                return response()->json(['message' => 'Sesi KBM tidak ditemukan!'], 404);
            }

            // Validasi Kelas Siswa
            $user = Auth::user();
            $siswa = Student::find($user->id_siswa);
            if ($siswa->id_kelas !== $session->id_kelas) {
                return response()->json(['message' => 'DITOLAK! Anda men-scan jadwal dari kelas lain.'], 403);
            }
            // Validasi Status Sesi
            if ($session->status_sesi !== 'SCANNING') {
                return response()->json(['message' => 'Sesi KBM ini belum dimulai oleh Guru atau sudah selesai.'], 400);
            }

            // Cari semua sesi dalam blok yang sama
            $blockSessions = \App\Models\KbmSession::where('tanggal', $session->tanggal)
                ->where('id_kelas', $session->id_kelas)
                ->where('id_mapel', $session->id_mapel)
                ->where('id_guru_terjadwal', $session->id_guru_terjadwal)
                ->get();

            foreach ($blockSessions as $bSession) {
                if ($bSession->status_sesi === 'SCANNING' || $bSession->status_sesi === 'PENDING') {
                    $bSession->status_sesi = 'AKTIF';
                    $bSession->status_guru = 'HADIR';
                    $bSession->waktu_scan_masuk = now();
                    $bSession->save();
                }

                // Inisialisasi absensi semua siswa di kelas ini sebagai default HADIR (SYSTEM)
                $studentsInClass = \App\Models\Student::where('id_kelas', $bSession->id_kelas)->get();
                foreach ($studentsInClass as $s) {
                    \App\Models\StudentAttendance::updateOrCreate(
                        [
                            'id_kbm_session' => $bSession->id,
                            'id_siswa' => $s->id_siswa,
                        ],
                        [
                            'status' => 'HADIR',
                            'metode' => $s->id_siswa === $siswa->id_siswa ? 'SCAN_QR' : 'SYSTEM',
                            'waktu_presensi' => $s->id_siswa === $siswa->id_siswa ? now() : null,
                        ]
                    );
                }
            }
            return response()->json([
                'message' => 'Berhasil! Kelas ' . ($session->subject->nama_mapel ?? '') . ' resmi dimulai.',
            ]);

        } catch (\Exception $e) {
            return response()->json(['message' => 'Terjadi kesalahan sistem.'], 500);
        }
    }

    public function ujianLive()
    {
        return Inertia::render('Siswa/UjianLive');
    }

    public function getLiveExam()
    {
        $user = Auth::user();
        $siswa = Student::find($user->id_siswa);
        $today = now()->toDateString();

        // Cari sesi KBM siswa hari ini yang sedang AKTIF
        $activeSession = \App\Models\KbmSession::where('id_kelas', $siswa->id_kelas)
            ->where('status_sesi', 'AKTIF')
            ->orderBy('tanggal', 'desc')
            ->first();

        if (!$activeSession) {
            return response()->json(['exam' => null, 'message' => 'Tidak ada sesi kelas yang aktif.']);
        }

        // Cari Ujian yang dilaunching ke sesi ini
        $exam = \App\Models\LiveExam::with(['questionBank.questions' => function($q) {
            // Sembunyikan jawaban_benar saat dikirim ke frontend siswa!
            $q->select(
                'id_question', 'id_bank', 'pertanyaan',
                'gambar_pertanyaan',
                'opsi_a', 'opsi_b', 'opsi_c', 'opsi_d', 'opsi_e',
                'gambar_opsi_a', 'gambar_opsi_b', 'gambar_opsi_c', 'gambar_opsi_d', 'gambar_opsi_e'
            );
        }])
        ->where('id_kbm_session', $activeSession->id)
        ->where('status', 'ACTIVE')
        ->first();

        if (!$exam) {
            return response()->json(['exam' => null, 'message' => 'Tidak ada asesmen aktif saat ini.']);
        }

        // ======= LOGIKA ACAK + LIMIT SOAL PER SISWA =======
        $allQuestions = $exam->questionBank->questions->values()->toArray();

        if ($exam->acak_soal) {
            // Gunakan seed deterministik: kombinasi id_exam + id_siswa sehingga per siswa unik
            // tapi tetap konsisten jika siswa refresh
            $seed = crc32($exam->id_exam . '_' . $siswa->id_siswa);
            // Buat array indeks acak menggunakan seed
            $indices = range(0, count($allQuestions) - 1);
            srand($seed);
            shuffle($indices);
            srand(); // Reset seed

            $shuffled = [];
            foreach ($indices as $i) {
                $shuffled[] = $allQuestions[$i];
            }
            $allQuestions = $shuffled;
        }

        // Batasi jumlah soal jika limit_soal di-set
        if ($exam->limit_soal && $exam->limit_soal < count($allQuestions)) {
            $allQuestions = array_slice($allQuestions, 0, $exam->limit_soal);
        }

        // ======= HITUNG SISA WAKTU =======
        $secondsElapsed  = $exam->started_at ? now()->diffInSeconds($exam->started_at) : 0;
        $secondsRemaining = max(0, ($exam->durasi * 60) - $secondsElapsed);

        // Ambil jawaban siswa yang sudah tersimpan (jika mereka me-refresh halaman)
        $answered = \App\Models\StudentAnswer::where('id_exam', $exam->id_exam)
            ->where('id_siswa', $siswa->id_siswa)
            ->get();

        // Bangun response exam dengan questions yang sudah diacak/dibatasi
        $examData = $exam->toArray();
        $examData['question_bank']['questions'] = $allQuestions;

        return response()->json([
            'exam'              => $examData,
            'answered'          => $answered->pluck('jawaban_siswa', 'id_question'),
            'seconds_remaining' => $secondsRemaining,
        ]);
    }

    public function submitAnswer(Request $request)
    {
        $request->validate([
            'id_exam' => 'required|exists:live_exams,id_exam',
            'id_question' => 'required|exists:questions,id_question',
            'jawaban_siswa' => 'required|in:A,B,C,D,E'
        ]);

        $user = Auth::user();
        $exam = \App\Models\LiveExam::find($request->id_exam);

        if ($exam->status !== 'ACTIVE') {
            return response()->json(['message' => 'Ujian sudah ditutup oleh Guru!'], 400);
        }

        $question = \App\Models\Question::find($request->id_question);
        $isCorrect = ($question->jawaban_benar === $request->jawaban_siswa);

        \App\Models\StudentAnswer::updateOrCreate(
            [
                'id_exam' => $request->id_exam,
                'id_siswa' => $user->id_siswa,
                'id_question' => $request->id_question,
            ],
            [
                'jawaban_siswa' => $request->jawaban_siswa,
                'is_correct' => $isCorrect
            ]
        );

        return response()->json(['message' => 'Jawaban tersimpan']);
    }

    public function nilai()
    {
        $user = Auth::user();
        $siswa = Student::with('clas')->find($user->id_siswa);

        $nilaiList = [];

        if ($siswa && $siswa->id_kelas) {
            $classSubjects = \App\Models\ClassSubject::with(['subject', 'guruMutlak'])
                ->where('id_kelas', $siswa->id_kelas)
                ->get();

            $gradingService = new \App\Services\GradingService();

            foreach ($classSubjects as $cs) {
                // Tentukan guru untuk mapel ini
                $idGuru = $cs->id_guru_mutlak;
                $guru = $cs->guruMutlak;

                if (!$idGuru) {
                    $timetableEntry = \App\Models\Timetable::with('teacher')
                        ->where('id_class_subject', $cs->id_class_subject)
                        ->whereNotNull('id_guru')
                        ->first();
                    if ($timetableEntry) {
                        $idGuru = $timetableEntry->id_guru;
                        $guru = $timetableEntry->teacher;
                    }
                }

                // Hitung nilai akhir semester via GradingService
                $endGrades = $gradingService->calculateEndSemesterGrades($siswa->id_kelas, $cs->id_mapel);
                $studentEndGrade = collect($endGrades['students'])->firstWhere('id_siswa', $siswa->id_siswa);

                // Hitung nilai tengah semester via GradingService
                $midGrades = $gradingService->calculateMidSemesterGrades($siswa->id_kelas, $cs->id_mapel);
                $studentMidGrade = collect($midGrades['students'])->firstWhere('id_siswa', $siswa->id_siswa);

                // TP progress breakdown
                $tpProgressList = $gradingService->calculateStudentTpProgress($siswa->id_siswa, $cs->id_mapel);

                // Generate deskripsi capaian dinamis (fallback)
                $desc = '';
                $sortedTps = collect($tpProgressList)->sortByDesc('nilai');
                if ($sortedTps->count() > 0) {
                    $highest = $sortedTps->first();
                    $lowest = $sortedTps->last();
                    if ($highest['nilai'] !== null && $lowest['nilai'] !== null) {
                        $desc = "Menunjukkan penguasaan yang sangat baik dalam " . $highest['deskripsi_tp'] . ". Namun, perlu pendampingan lebih lanjut pada " . $lowest['deskripsi_tp'] . ".";
                    }
                }

                $nilaiList[] = [
                    'id' => $cs->id_class_subject,
                    'nama' => $cs->subject->nama_mapel ?? 'Unknown',
                    'guru' => $guru->nama_guru ?? 'Unknown',
                    'kkm' => $cs->subject->kkm ?? 75,
                    'mid' => [
                        'absensi' => $studentMidGrade ? $studentMidGrade['absensi'] : 100,
                        'formatif' => $studentMidGrade ? $studentMidGrade['formatif'] : null,
                        'sts' => $studentMidGrade ? $studentMidGrade['sts'] : null,
                        'nilai_rapor' => $studentMidGrade ? $studentMidGrade['nilai_rapor'] : null,
                    ],
                    'end' => [
                        'formatif' => $studentEndGrade ? $studentEndGrade['formatif'] : null,
                        'sts' => $studentEndGrade ? $studentEndGrade['sts'] : null,
                        'sas' => $studentEndGrade ? $studentEndGrade['sas'] : null,
                        'nilai_rapor' => $studentEndGrade ? $studentEndGrade['nilai_rapor'] : null,
                    ],
                    'deskripsi' => $desc ?: 'Belum ada deskripsi capaian.',
                    'details' => $tpProgressList,
                    'expanded' => false
                ];
            }
        }

        return Inertia::render('Siswa/Nilai', [
            'nilaiList' => $nilaiList,
        ]);
    }

    public function kuesioner()
    {
        $user = Auth::user();
        $siswa = Student::with('clas')->find($user->id_siswa);

        // Cari kuesioner yang sedang AKTIF
        $activeQuestionnaire = \App\Models\Questionnaire::with('questions')
            ->where('is_active', true)
            ->first();

        $targets = [];

        if ($activeQuestionnaire) {
            if ($activeQuestionnaire->tipe === 'WALI_KELAS') {
                if ($siswa->clas && $siswa->clas->id_guru_wali) {
                    $wali = \App\Models\Teacher::find($siswa->clas->id_guru_wali);
                    if ($wali) {
                        $targets[] = $wali;
                    }
                }
            } else if ($activeQuestionnaire->tipe === 'GURU_MAPEL') {
                // Ambil daftar guru yang mengajar di kelas siswa ini dari jp_schedules
                $guruIds = \App\Models\JpSchedule::where('id_kelas', $siswa->id_kelas)
                    ->pluck('id_guru')
                    ->unique()
                    ->filter();

                $targets = \App\Models\Teacher::whereIn('id_guru', $guruIds)->get();
            }
            
            // Ambil id_guru yang sudah dinilai oleh siswa ini untuk kuesioner yang sedang aktif
            $answeredGuruIds = \App\Models\QuestionnaireResponse::where('id_questionnaire', $activeQuestionnaire->id_questionnaire)
                ->where('id_siswa', $siswa->id_siswa)
                ->pluck('id_guru_target')
                ->unique()
                ->toArray();
                
            // Saring target, tandai mana yang sudah dikerjakan
            $targets = collect($targets)->map(function($guru) use ($answeredGuruIds) {
                $guru->sudah_dinilai = in_array($guru->id_guru, $answeredGuruIds);
                return $guru;
            });
        }

        return Inertia::render('Siswa/Kuesioner', [
            'questionnaire' => $activeQuestionnaire,
            'targets' => $targets
        ]);
    }

    public function submitKuesioner(Request $request)
    {
        $request->validate([
            'id_questionnaire' => 'required|exists:questionnaires,id_questionnaire',
            'id_guru_target' => 'required|exists:teachers,id_guru',
            'responses' => 'required|array', // key: id_q_question, value: rating_score
            'komentar' => 'nullable|string'
        ]);

        $user = Auth::user();

        // Cek apakah kuesioner masih aktif
        $q = \App\Models\Questionnaire::find($request->id_questionnaire);
        if (!$q->is_active) {
            return redirect()->back()->with('error', 'Kuesioner ini sudah ditutup.');
        }

        foreach ($request->responses as $id_q_question => $rating) {
            \App\Models\QuestionnaireResponse::updateOrCreate(
                [
                    'id_questionnaire' => $request->id_questionnaire,
                    'id_siswa' => $user->id_siswa,
                    'id_guru_target' => $request->id_guru_target,
                    'id_q_question' => $id_q_question,
                ],
                [
                    'rating_score' => $rating,
                    'komentar' => $request->komentar // simpan komentar di semua response untuk guru ini (atau salah satu saja juga boleh)
                ]
            );
        }

        return redirect()->back()->with('success', 'Terima kasih atas penilaian Anda!');
    }

    public function jadwal()
    {
        $user = Auth::user();
        $siswa = Student::with('clas')->find($user->id_siswa);

        $timetable = [];
        $jpSchedules = [];

        if ($siswa && $siswa->id_kelas) {
            $timetable = Timetable::with(['classSubject.subject', 'teacher'])
                ->whereHas('classSubject', function ($query) use ($siswa) {
                    $query->where('id_kelas', $siswa->id_kelas);
                })
                ->get();

            $shift = $siswa->clas->shift_operasional ?? 'PAGI';

            $jpSchedules = \App\Models\JpSchedule::where('shift', $shift)
                ->orderByRaw("FIELD(hari, 'SENIN', 'SELASA', 'RABU', 'KAMIS', 'JUMAT', 'SABTU')")
                ->orderBy('waktu_mulai')
                ->get()
                ->groupBy('hari');
        }

        return Inertia::render('Siswa/Jadwal', [
            'timetable' => $timetable,
            'jpSchedules' => $jpSchedules,
            'kelas' => $siswa->clas->nama_kelas ?? 'Unknown',
            'shift' => $siswa->clas->shift_operasional ?? 'PAGI',
        ]);
    }
}
