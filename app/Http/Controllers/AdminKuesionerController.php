<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Questionnaire;
use App\Models\QuestionnaireQuestion;
use App\Models\QuestionnaireResponse;

class AdminKuesionerController extends Controller
{
    public function index()
    {
        $questionnaires = Questionnaire::withCount('questions')->latest()->get();
        return Inertia::render('Admin/Kuesioner/Index', [
            'questionnaires' => $questionnaires
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'judul' => 'required|string|max:255',
            'deskripsi' => 'nullable|string',
            'tipe' => 'required|in:GURU_MAPEL,WALI_KELAS',
            'questions' => 'required|array|min:1',
            'questions.*' => 'required|string'
        ]);

        $q = Questionnaire::create([
            'judul' => $request->judul,
            'deskripsi' => $request->deskripsi,
            'tipe' => $request->tipe,
            'is_active' => false // Default non-aktif, harus di-toggle manual
        ]);

        foreach ($request->questions as $text) {
            QuestionnaireQuestion::create([
                'id_questionnaire' => $q->id_questionnaire,
                'pertanyaan' => $text
            ]);
        }

        return redirect()->back()->with('success', 'Kuesioner berhasil dibuat!');
    }

    public function toggleActive($id)
    {
        $q = Questionnaire::findOrFail($id);
        
        // Opsional: Matikan kuesioner lain yang tipenya sama agar tidak bentrok
        if (!$q->is_active) {
            Questionnaire::where('tipe', $q->tipe)->update(['is_active' => false]);
        }
        
        $q->is_active = !$q->is_active;
        $q->save();

        return redirect()->back()->with('success', 'Status kuesioner berhasil diubah.');
    }

    public function destroy($id)
    {
        Questionnaire::findOrFail($id)->delete();
        return redirect()->back()->with('success', 'Kuesioner berhasil dihapus.');
    }

    public function report($id)
    {
        $q = Questionnaire::with('questions')->findOrFail($id);
        
        // Ambil responses dan grouping berdasarkan Guru Target
        $responses = QuestionnaireResponse::with(['student.clas', 'targetTeacher', 'question'])
            ->where('id_questionnaire', $id)
            ->get();
            
        // Rekapitulasi per Guru
        $rekapGuru = $responses->groupBy('id_guru_target')->map(function ($guruResponses) {
            $avgRating = $guruResponses->avg('rating_score');
            $teacher = $guruResponses->first()->targetTeacher;
            
            // Komentar
            $comments = $guruResponses->filter(function($res) {
                return !empty($res->komentar);
            })->map(function($res) {
                return [
                    'nama_siswa' => $res->student->nama_siswa, // Admin bisa melihat nama siswa
                    'kelas' => $res->student->clas->nama_kelas ?? '-',
                    'komentar' => $res->komentar,
                    'rating' => $res->rating_score
                ];
            })->values();

            return [
                'id_guru' => $teacher->id_guru ?? null,
                'nama_guru' => $teacher->nama_guru ?? 'Tidak Diketahui',
                'avg_rating' => round($avgRating, 2),
                'total_respon' => $guruResponses->unique('id_siswa')->count(),
                'komentar' => $comments
            ];
        })->values()->sortByDesc('avg_rating')->values();

        return Inertia::render('Admin/Kuesioner/Report', [
            'questionnaire' => $q,
            'rekapGuru' => $rekapGuru
        ]);
    }
}
