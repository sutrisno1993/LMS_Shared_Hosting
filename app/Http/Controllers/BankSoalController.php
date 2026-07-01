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

    private function saveBase64Image($base64Str)
    {
        if (empty($base64Str)) {
            return null;
        }

        // If it's already a saved storage path, return it as is
        if (str_starts_with($base64Str, '/storage/')) {
            return $base64Str;
        }

        if (preg_match('/^data:image\/(\w+);base64,/', $base64Str, $type)) {
            $data = substr($base64Str, strpos($base64Str, ',') + 1);
            $data = base64_decode($data);
            
            $ext = strtolower($type[1]); // png, jpg, jpeg, gif, webp
            if (!in_array($ext, ['jpg', 'jpeg', 'png', 'gif', 'webp'])) {
                $ext = 'png';
            }
            
            $filename = 'img_' . uniqid() . '_' . time() . '.' . $ext;
            \Illuminate\Support\Facades\Storage::disk('public')->put('questions/' . $filename, $data);
            
            return '/storage/questions/' . $filename;
        }

        return null;
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_mapel' => 'required|exists:subjects,id_mapel',
            'judul' => 'required|string|max:255',
            'deskripsi' => 'nullable|string',
            'questions' => 'required|array|min:1',
            'questions.*.pertanyaan' => 'required|string',
            'questions.*.gambar_pertanyaan' => 'nullable|string',
            'questions.*.opsi_a' => 'required|string',
            'questions.*.gambar_opsi_a' => 'nullable|string',
            'questions.*.opsi_b' => 'required|string',
            'questions.*.gambar_opsi_b' => 'nullable|string',
            'questions.*.opsi_c' => 'required|string',
            'questions.*.gambar_opsi_c' => 'nullable|string',
            'questions.*.opsi_d' => 'required|string',
            'questions.*.gambar_opsi_d' => 'nullable|string',
            'questions.*.opsi_e' => 'required|string',
            'questions.*.gambar_opsi_e' => 'nullable|string',
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
                'gambar_pertanyaan' => $this->saveBase64Image($q['gambar_pertanyaan'] ?? null),
                'opsi_a' => $q['opsi_a'],
                'gambar_opsi_a' => $this->saveBase64Image($q['gambar_opsi_a'] ?? null),
                'opsi_b' => $q['opsi_b'],
                'gambar_opsi_b' => $this->saveBase64Image($q['gambar_opsi_b'] ?? null),
                'opsi_c' => $q['opsi_c'],
                'gambar_opsi_c' => $this->saveBase64Image($q['gambar_opsi_c'] ?? null),
                'opsi_d' => $q['opsi_d'],
                'gambar_opsi_d' => $this->saveBase64Image($q['gambar_opsi_d'] ?? null),
                'opsi_e' => $q['opsi_e'],
                'gambar_opsi_e' => $this->saveBase64Image($q['gambar_opsi_e'] ?? null),
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
            'questions.*.gambar_pertanyaan' => 'nullable|string',
            'questions.*.opsi_a' => 'required|string',
            'questions.*.gambar_opsi_a' => 'nullable|string',
            'questions.*.opsi_b' => 'required|string',
            'questions.*.gambar_opsi_b' => 'nullable|string',
            'questions.*.opsi_c' => 'required|string',
            'questions.*.gambar_opsi_c' => 'nullable|string',
            'questions.*.opsi_d' => 'required|string',
            'questions.*.gambar_opsi_d' => 'nullable|string',
            'questions.*.opsi_e' => 'required|string',
            'questions.*.gambar_opsi_e' => 'nullable|string',
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
                'gambar_pertanyaan' => $this->saveBase64Image($q['gambar_pertanyaan'] ?? null),
                'opsi_a' => $q['opsi_a'],
                'gambar_opsi_a' => $this->saveBase64Image($q['gambar_opsi_a'] ?? null),
                'opsi_b' => $q['opsi_b'],
                'gambar_opsi_b' => $this->saveBase64Image($q['gambar_opsi_b'] ?? null),
                'opsi_c' => $q['opsi_c'],
                'gambar_opsi_c' => $this->saveBase64Image($q['gambar_opsi_c'] ?? null),
                'opsi_d' => $q['opsi_d'],
                'gambar_opsi_d' => $this->saveBase64Image($q['gambar_opsi_d'] ?? null),
                'opsi_e' => $q['opsi_e'],
                'gambar_opsi_e' => $this->saveBase64Image($q['gambar_opsi_e'] ?? null),
                'jawaban_benar' => $q['jawaban_benar'],
                'pembahasan' => $q['pembahasan'] ?? null,
            ]);
        }

        return redirect()->route('guru.bank-soal.index')->with('message', 'Bank Soal berhasil diperbarui!');
    }
}
