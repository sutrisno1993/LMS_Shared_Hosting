<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Auth;
use App\Models\LiveExam;
use App\Models\QuestionBank;
use App\Models\KbmSession;
use App\Models\StudentAnswer;
use App\Models\StudentGrade;
use App\Models\LearningObjective;
use App\Models\LearningTopic;

class LiveExamController extends Controller
{
    // Meluncurkan Ujian ke Kelas
    public function launch(Request $request)
    {
        $request->validate([
            'id_bank'          => 'required|exists:question_banks,id_bank',
            'id_kbm_session'   => 'required|exists:kbm_sessions,id',
            'durasi'           => 'required|integer|min:1|max:240',
            'limit_soal'       => 'nullable|integer|min:1',
            'acak_soal'        => 'boolean',
            'tujuan'           => 'required|in:DIAGNOSTIK,SUMATIF',
            'id_tp'            => 'nullable|exists:learning_objectives,id_tp',
            'nama_topik_baru'  => 'nullable|string|max:255', // Teks bebas topik baru
            'id_topic'         => 'nullable|exists:learning_topics,id_topic',
        ]);

        // Cek apakah ada ujian yang sudah jalan di sesi ini
        $existing = LiveExam::where('id_kbm_session', $request->id_kbm_session)
            ->where('status', 'ACTIVE')
            ->first();

        if ($existing) {
            return redirect()->back()->with('error', 'Sudah ada asesmen yang sedang aktif di kelas ini!');
        }

        // Jika tujuan SUMATIF dan guru mengetik nama topik baru, buat topik tersebut
        $idTopic = $request->id_topic;
        if ($request->tujuan === 'SUMATIF' && $request->filled('nama_topik_baru') && $request->id_tp) {
            $newTopic = LearningTopic::create([
                'id_tp'      => $request->id_tp,
                'nama_topik' => trim($request->nama_topik_baru),
            ]);
            $idTopic = $newTopic->id_topic;
        }

        $exam = LiveExam::create([
            'id_kbm_session' => $request->id_kbm_session,
            'id_bank'        => $request->id_bank,
            'status'         => 'ACTIVE',
            'durasi'         => $request->durasi,
            'limit_soal'     => $request->limit_soal ?: null,
            'acak_soal'      => $request->boolean('acak_soal', true),
            'tujuan'         => $request->tujuan,
            'id_tp'          => $request->tujuan === 'SUMATIF' ? $request->id_tp : null,
            'id_topic'       => $request->tujuan === 'SUMATIF' ? $idTopic : null,
            'started_at'     => now(),
        ]);

        return redirect()->route('guru.live-exam.monitor', $exam->id_exam);
    }

    // Halaman Monitor (Dashboard Realtime Guru)
    public function monitor($id)
    {
        $exam = LiveExam::with(['questionBank.questions', 'kbmSession.clas.students', 'learningObjective', 'learningTopic'])
            ->findOrFail($id);

        // Ambil rekap jawaban siswa
        $answers = StudentAnswer::where('id_exam', $id)->get();
        $totalQuestions = $exam->limit_soal
            ? min($exam->limit_soal, $exam->questionBank->questions->count())
            : $exam->questionBank->questions->count();

        // Hitung progres tiap siswa
        $studentsProgress = $exam->kbmSession->clas->students->map(function($siswa) use ($answers, $totalQuestions) {
            $siswaAnswers  = $answers->where('id_siswa', $siswa->id_siswa);
            $answeredCount = $siswaAnswers->count();
            $correctCount  = $siswaAnswers->where('is_correct', true)->count();
            $score         = $totalQuestions > 0 ? round(($correctCount / $totalQuestions) * 100) : 0;

            return [
                'id_siswa'    => $siswa->id_siswa,
                'nama'        => $siswa->nama_siswa,
                'answered'    => $answeredCount,
                'total'       => $totalQuestions,
                'score'       => $score,
                'is_finished' => $answeredCount >= $totalQuestions,
            ];
        });

        // Hitung sisa waktu untuk info guru
        $secondsElapsed  = $exam->started_at ? now()->diffInSeconds($exam->started_at) : 0;
        $secondsRemaining = max(0, ($exam->durasi * 60) - $secondsElapsed);

        return Inertia::render('Guru/LiveExam/Monitor', [
            'exam'             => $exam,
            'studentsProgress' => $studentsProgress,
            'secondsRemaining' => $secondsRemaining,
            'totalQuestions'   => $totalQuestions,
        ]);
    }

    // Menutup Ujian dan Auto-Grading
    public function close(Request $request, $id)
    {
        $exam = LiveExam::with(['questionBank.questions', 'kbmSession'])->findOrFail($id);
        $exam->status = 'FINISHED';
        $exam->save();

        // Jika tujuan SUMATIF dan ada relasi TP, suntik nilai ke tabel Asesmen & Skor baru
        if ($exam->tujuan === 'SUMATIF' && $exam->id_tp) {
            $answers       = StudentAnswer::where('id_exam', $id)->get();
            $totalQuestions = $exam->limit_soal
                ? min($exam->limit_soal, $exam->questionBank->questions->count())
                : $exam->questionBank->questions->count();

            $groupedByStudent = $answers->groupBy('id_siswa');
            $idBab = \Illuminate\Support\Facades\DB::table('bab_tp')
                ->where('id_tp', $exam->id_tp)
                ->value('id_bab');

            if ($idBab) {
                // Buat/update Assessment
                $assessment = \App\Models\Assessment::updateOrCreate(
                    [
                        'id_bab' => $idBab,
                        'id_kelas' => $exam->kbmSession->id_kelas,
                        'id_mapel' => $exam->kbmSession->id_mapel,
                        'nama_asesmen' => 'Ujian Live: ' . ($exam->questionBank->judul ?? 'Asesmen'),
                        'kategori' => 'FORMATIF',
                    ],
                    [
                        'id_guru' => $exam->kbmSession->id_guru_aktual,
                        'bentuk_asesmen' => 'Quiz',
                        'tanggal' => now()->toDateString(),
                        'status' => 'SELESAI',
                        'semester' => 'GANJIL',
                    ]
                );

                // Hubungkan TP ke asesmen
                $assessment->learningObjectives()->syncWithoutDetaching([$exam->id_tp]);

                foreach ($groupedByStudent as $idSiswa => $siswaAnswers) {
                    $correctCount = $siswaAnswers->where('is_correct', true)->count();
                    $score = $totalQuestions > 0 ? round(($correctCount / $totalQuestions) * 100) : 0;

                    // Simpan nilai asesmen baru
                    \App\Models\StudentAssessmentScore::updateOrCreate(
                        [
                            'id_assessment' => $assessment->id_assessment,
                            'id_siswa' => $idSiswa,
                        ],
                        ['nilai' => $score]
                    );

                    // Simpan nilai warisan (legacy) untuk backward compatibility jika ada fitur lama yang menggunakannya
                    StudentGrade::updateOrCreate(
                        [
                            'id_siswa' => $idSiswa,
                            'id_tp'    => $exam->id_tp,
                            'id_topic' => $exam->id_topic,
                        ],
                        ['nilai' => $score]
                    );
                }
            }
        }     
        
        $msg = $exam->id_topic
                ? "Ujian selesai! Nilai otomatis masuk ke Topik \"{$exam->learningTopic?->nama_topik}\"."
                : 'Ujian selesai! Nilai otomatis masuk ke Bab terkait.';

        return redirect()->route('guru.live-exam.laporan-diagnostik', $id);
    }

    // Ambil daftar TP + Topik untuk dropdown modal pra-ujian
    public function tpList(Request $request)
    {
        $user = Auth::user();
        $session = \App\Models\KbmSession::findOrFail($request->id_kbm_session);

        // Ambil bank soal yang relevan untuk mapel ini
        $questionBanks = \App\Models\QuestionBank::withCount('questions')
            ->where('id_guru', $user->id_guru)
            ->where('id_mapel', $session->id_mapel)
            ->get();

        $tps = LearningObjective::with('topics')
            ->where('id_guru', $user->id_guru)
            ->where('id_mapel', $session->id_mapel)
            ->whereHas('classes', function($q) use ($session) {
                $q->where('classes.id_kelas', $session->id_kelas);
            })
            ->orderBy('kode_tp')
            ->get()
            ->map(fn($tp) => [
                'id_tp'       => $tp->id_tp,
                'kode_tp'     => $tp->kode_tp,
                'deskripsi_tp'=> $tp->deskripsi_tp,
                'topics'      => $tp->topics->map(fn($t) => [
                    'id_topic'   => $t->id_topic,
                    'nama_topik' => $t->nama_topik,
                ])->values(),
            ]);

        return response()->json(['tps' => $tps]);
    }

    // Laporan Hasil Asesmen Diagnostik
    public function laporanDiagnostik($id)
    {
        $exam = LiveExam::with([
            'questionBank.questions',
            'kbmSession.clas.students',
            'kbmSession.subject',
            'kbmSession.clas',
        ])->findOrFail($id);

        $answers        = StudentAnswer::where('id_exam', $id)->get();
        $allQuestions   = $exam->questionBank->questions;
        $totalQuestions = $exam->limit_soal
            ? min($exam->limit_soal, $allQuestions->count())
            : $allQuestions->count();

        $students = $exam->kbmSession->clas->students;

        // Nilai per siswa
        $studentsResult = $students->map(function($siswa) use ($answers, $totalQuestions) {
            $siswaAnswers  = $answers->where('id_siswa', $siswa->id_siswa);
            $answeredCount = $siswaAnswers->count();
            $correctCount  = $siswaAnswers->where('is_correct', true)->count();
            $score = ($totalQuestions > 0 && $answeredCount > 0)
                ? round(($correctCount / $totalQuestions) * 100)
                : 0;
            return [
                'id_siswa' => $siswa->id_siswa,
                'nama'     => $siswa->nama_siswa,
                'answered' => $answeredCount,
                'score'    => $score,
            ];
        })->sortByDesc('score')->values();

        // Analisis per butir soal
        $questionAnalysis = $allQuestions->take($totalQuestions)->map(function($q) use ($answers) {
            $qAnswers      = $answers->where('id_question', $q->id_question);
            $totalAnswered = $qAnswers->count();
            $correctCount  = $qAnswers->where('is_correct', true)->count();
            $correctPct    = $totalAnswered > 0 ? round(($correctCount / $totalAnswered) * 100) : 0;
            return [
                'id_question'   => $q->id_question,
                'pertanyaan'    => $q->pertanyaan,
                'correctCount'  => $correctCount,
                'totalAnswered' => $totalAnswered,
                'correctPct'    => $correctPct,
            ];
        })->values();

        return Inertia::render('Guru/LiveExam/LaporanDiagnostik', [
            'exam'             => $exam,
            'studentsResult'   => $studentsResult,
            'questionAnalysis' => $questionAnalysis,
            'totalQuestions'   => $totalQuestions,
        ]);
    }
}
