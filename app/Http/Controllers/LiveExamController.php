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

class LiveExamController extends Controller
{
    // Meluncurkan Ujian ke Kelas
    public function launch(Request $request)
    {
        $request->validate([
            'id_bank' => 'required|exists:question_banks,id_bank',
            'id_kbm_session' => 'required|exists:kbm_sessions,id',
        ]);

        $user = Auth::user();

        // Cek apakah ada ujian yang sudah jalan di sesi ini
        $existing = LiveExam::where('id_kbm_session', $request->id_kbm_session)
            ->where('status', 'ACTIVE')
            ->first();

        if ($existing) {
            return redirect()->back()->with('error', 'Sudah ada asesmen yang sedang aktif di kelas ini!');
        }

        $exam = LiveExam::create([
            'id_kbm_session' => $request->id_kbm_session,
            'id_bank' => $request->id_bank,
            'status' => 'ACTIVE'
        ]);

        return redirect()->route('guru.live-exam.monitor', $exam->id_exam);
    }

    // Halaman Monitor (Dashboard Realtime Guru)
    public function monitor($id)
    {
        $user = Auth::user();
        
        $exam = LiveExam::with(['questionBank.questions', 'kbmSession.clas.students'])
            ->findOrFail($id);

        // Ambil rekap jawaban siswa
        $answers = StudentAnswer::where('id_exam', $id)->get();
        $totalQuestions = $exam->questionBank->questions->count();

        // Hitung progres tiap siswa
        $studentsProgress = $exam->kbmSession->clas->students->map(function($siswa) use ($answers, $totalQuestions) {
            $siswaAnswers = $answers->where('id_siswa', $siswa->id_siswa);
            $answeredCount = $siswaAnswers->count();
            $correctCount = $siswaAnswers->where('is_correct', true)->count();
            
            $score = $totalQuestions > 0 ? round(($correctCount / $totalQuestions) * 100) : 0;
            
            return [
                'id_siswa' => $siswa->id_siswa,
                'nama' => $siswa->nama_siswa,
                'answered' => $answeredCount,
                'total' => $totalQuestions,
                'score' => $score,
                'is_finished' => $answeredCount === $totalQuestions
            ];
        });

        return Inertia::render('Guru/LiveExam/Monitor', [
            'exam' => $exam,
            'studentsProgress' => $studentsProgress
        ]);
    }

    // Menutup Ujian dan Auto-Grading
    public function close(Request $request, $id)
    {
        $user = Auth::user();
        $exam = LiveExam::with(['questionBank.questions', 'kbmSession'])->findOrFail($id);
        
        $exam->status = 'FINISHED';
        $exam->save();

        // Proses Auto-Grading (Opsional: Simpan ke Dafnil)
        // Jika form mengirim id_tp (Tujuan Pembelajaran), kita bisa langsung suntik ke StudentGrade
        if ($request->filled('id_tp')) {
            $answers = StudentAnswer::where('id_exam', $id)->get();
            $totalQuestions = $exam->questionBank->questions->count();
            
            $groupedByStudent = $answers->groupBy('id_siswa');
            
            foreach ($groupedByStudent as $idSiswa => $siswaAnswers) {
                $correctCount = $siswaAnswers->where('is_correct', true)->count();
                $score = $totalQuestions > 0 ? round(($correctCount / $totalQuestions) * 100) : 0;
                
                StudentGrade::updateOrCreate(
                    [
                        'id_siswa' => $idSiswa,
                        'id_tp' => $request->id_tp
                    ],
                    [
                        'nilai' => $score
                    ]
                );
            }
            return redirect()->route('guru.dashboard')->with('message', 'Ujian selesai dan nilai otomatis masuk ke Dafnil!');
        }

        return redirect()->route('guru.dashboard')->with('message', 'Ujian berhasil ditutup!');
    }
}
