<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function loginAdmin(Request $request)
    {
        $credentials = $request->validate([
            'email' => ['required', 'email'],
            'password' => ['required'],
        ]);

        if (Auth::attempt($credentials)) {
            $request->session()->regenerate();
            $user = Auth::user();
            
            if ($user->role === 'ADMIN') {
                return redirect()->route('admin.dashboard');
            }
            
            Auth::logout();
            return back()->withErrors(['email' => 'Anda bukan admin.']);
        }

        return back()->withErrors([
            'email' => 'Email atau password salah.',
        ])->onlyInput('email');
    }

    public function loginTeacher(Request $request)
    {
        $request->validate([
            'no_wa' => ['required'],
            'password' => ['required'],
            'intent' => ['required', 'in:guru,walikelas'],
        ]);

        $teacher = \App\Models\Teacher::where('no_wa', $request->no_wa)->first();
        if (!$teacher) {
            return back()->withErrors(['no_wa' => 'Nomor WhatsApp tidak ditemukan.'])->onlyInput('no_wa');
        }

        if ($request->intent === 'walikelas') {
            $isWaliKelas = \App\Models\Clas::where('id_guru_wali', $teacher->id_guru)->exists();
            if (!$isWaliKelas) {
                return back()->withErrors(['no_wa' => 'Anda tidak terdaftar sebagai Wali Kelas.']);
            }
        }

        $user = \App\Models\User::where('id_guru', $teacher->id_guru)->first();
        if (!$user) {
            return back()->withErrors(['no_wa' => 'Akun belum ditautkan ke sistem.']);
        }

        if (\Illuminate\Support\Facades\Hash::check($request->password, $user->password)) {
            Auth::login($user);
            $request->session()->regenerate();
            
            session(['login_intent' => $request->intent]);

            if ($request->intent === 'walikelas') {
                return redirect()->route('walikelas.dashboard');
            }
            return redirect()->route('guru.dashboard');
        }

        return back()->withErrors(['password' => 'Password salah.']);
    }

    public function loginStudent(Request $request)
    {
        $request->validate([
            'nisn' => ['required'],
            'password' => ['required'],
        ]);

        $student = \App\Models\Student::where('nisn', $request->nisn)
            ->orWhere('nis', $request->nisn)
            ->first();
            
        if (!$student) {
            return back()->withErrors(['nisn' => 'NISN atau NIS tidak ditemukan.'])->onlyInput('nisn');
        }

        $user = \App\Models\User::where('id_siswa', $student->id_siswa)->first();
        if (!$user) {
            return back()->withErrors(['nisn' => 'Akun belum ditautkan ke sistem.']);
        }

        if (\Illuminate\Support\Facades\Hash::check($request->password, $user->password)) {
            Auth::login($user);
            $request->session()->regenerate();
            return redirect()->route('siswa.dashboard');
        }

        return back()->withErrors(['password' => 'Password salah.']);
    }

    /**
     * Log the user out of the application.
     */
    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect()->route('login');
    }
}
