<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Auth;
use App\Models\QuestionBank;
use App\Models\Question;
use App\Models\TeacherSubject;

class BankSoalController extends Controller
{
    public function index()
    {
        $user = Auth::user();
        
        $banks = QuestionBank::with('subject')
            ->where('id_guru', $user->id_guru)
            ->withCount('questions')
            ->latest()
            ->get();

        return Inertia::render('Guru/BankSoal/Index', [
            'banks' => $banks
        ]);
    }

    public function create()
    {
        $user = Auth::user();
        
        $mapelList = TeacherSubject::with('subject')
            ->where('id_guru', $user->id_guru)
            ->get()
            ->pluck('subject')
            ->unique('id_mapel')
            ->values();

        return Inertia::render('Guru/BankSoal/Form', [
            'mapelList' => $mapelList,
            'bank' => null,
            'questions' => []
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_mapel' => 'required|exists:subjects,id_mapel',
            'judul' => 'required|string|max:255',
            'deskripsi' => 'nullable|string',
            'questions' => 'required|array|min:1',
            'questions.*.pertanyaan' => 'required|string',
            'questions.*.opsi_a' => 'required|string',
            'questions.*.opsi_b' => 'required|string',
            'questions.*.opsi_c' => 'required|string',
            'questions.*.opsi_d' => 'required|string',
            'questions.*.opsi_e' => 'required|string',
            'questions.*.jawaban_benar' => 'required|in:A,B,C,D,E',
        ]);

        $user = Auth::user();

        // Buat Bank Soal
        $bank = QuestionBank::create([
            'id_guru' => $user->id_guru,
            'id_mapel' => $request->id_mapel,
            'judul' => $request->judul,
            'deskripsi' => $request->deskripsi,
        ]);

        // Buat Butir Soal
        foreach ($request->questions as $q) {
            Question::create([
                'id_bank' => $bank->id_bank,
                'pertanyaan' => $q['pertanyaan'],
                'opsi_a' => $q['opsi_a'],
                'opsi_b' => $q['opsi_b'],
                'opsi_c' => $q['opsi_c'],
                'opsi_d' => $q['opsi_d'],
                'opsi_e' => $q['opsi_e'],
                'jawaban_benar' => $q['jawaban_benar'],
                'pembahasan' => $q['pembahasan'] ?? null,
            ]);
        }

        return redirect()->route('guru.bank-soal.index')->with('message', 'Bank Soal berhasil disimpan!');
    }
    
    public function show($id)
    {
        $user = Auth::user();
        $bank = QuestionBank::with(['questions', 'subject'])
            ->where('id_guru', $user->id_guru)
            ->findOrFail($id);
            
        return Inertia::render('Guru/BankSoal/Show', [
            'bank' => $bank
        ]);
    }

    public function edit($id)
    {
        $user = Auth::user();
        
        $bank = QuestionBank::where('id_guru', $user->id_guru)->findOrFail($id);
        $questions = Question::where('id_bank', $id)->get();
        
        $mapelList = TeacherSubject::with('subject')
            ->where('id_guru', $user->id_guru)
            ->get()
            ->pluck('subject')
            ->unique('id_mapel')
            ->values();

        return Inertia::render('Guru/BankSoal/Form', [
            'mapelList' => $mapelList,
            'bank' => $bank,
            'questions' => $questions
        ]);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'id_mapel' => 'required|exists:subjects,id_mapel',
            'judul' => 'required|string|max:255',
            'deskripsi' => 'nullable|string',
            'questions' => 'required|array|min:1',
            'questions.*.pertanyaan' => 'required|string',
            'questions.*.opsi_a' => 'required|string',
            'questions.*.opsi_b' => 'required|string',
            'questions.*.opsi_c' => 'required|string',
            'questions.*.opsi_d' => 'required|string',
            'questions.*.opsi_e' => 'required|string',
            'questions.*.jawaban_benar' => 'required|in:A,B,C,D,E',
        ]);

        $user = Auth::user();
        $bank = QuestionBank::where('id_guru', $user->id_guru)->findOrFail($id);

        // Update Bank Soal
        $bank->update([
            'id_mapel' => $request->id_mapel,
            'judul' => $request->judul,
            'deskripsi' => $request->deskripsi,
        ]);

        // Recreate Butir Soal
        Question::where('id_bank', $id)->delete();

        foreach ($request->questions as $q) {
            Question::create([
                'id_bank' => $bank->id_bank,
                'pertanyaan' => $q['pertanyaan'],
                'opsi_a' => $q['opsi_a'],
                'opsi_b' => $q['opsi_b'],
                'opsi_c' => $q['opsi_c'],
                'opsi_d' => $q['opsi_d'],
                'opsi_e' => $q['opsi_e'],
                'jawaban_benar' => $q['jawaban_benar'],
                'pembahasan' => $q['pembahasan'] ?? null,
            ]);
        }

        return redirect()->route('guru.bank-soal.index')->with('message', 'Bank Soal berhasil diperbarui!');
    }
}
