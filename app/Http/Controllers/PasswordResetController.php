<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\PasswordResetRequest;
use App\Models\User;
use App\Models\Student;
use App\Models\Teacher;
use App\Models\Clas;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class PasswordResetController extends Controller
{
    /**
     * Kirim pengajuan reset password (Guest)
     */
    public function requestReset(Request $request)
    {
        $request->validate([
            'role' => 'required|in:STUDENT,TEACHER',
            'identifier' => 'required|string',
            'new_password' => 'required|string|min:6|confirmed',
        ], [
            'role.required' => 'Peran (Siswa/Guru) wajib dipilih.',
            'identifier.required' => 'NISN/NIS atau nomor WhatsApp wajib diisi.',
            'new_password.required' => 'Password baru wajib diisi.',
            'new_password.min' => 'Password minimal terdiri dari 6 karakter.',
            'new_password.confirmed' => 'Konfirmasi password tidak cocok.',
        ]);

        if ($request->role === 'STUDENT') {
            // Cari data siswa berdasarkan NISN atau NIS
            $student = Student::where('nisn', $request->identifier)
                ->orWhere('nis', $request->identifier)
                ->first();

            if (!$student) {
                return back()->withErrors(['identifier' => 'Siswa dengan NISN/NIS tersebut tidak ditemukan.']);
            }

            // Cari user account
            $user = User::where('id_siswa', $student->id_siswa)->first();
            if (!$user) {
                return back()->withErrors([
                    'identifier' => 'Akun login Anda belum terbuat. Silakan login terlebih dahulu menggunakan password default "password123" untuk mengaktifkan akun Anda.'
                ]);
            }

            // Cek apakah sudah ada pengajuan pending
            $existing = PasswordResetRequest::where('user_id', $user->id)
                ->where('status', 'PENDING')
                ->first();

            if ($existing) {
                return back()->withErrors(['identifier' => 'Anda sudah mengajukan reset password sebelumnya. Silakan tunggu persetujuan Wali Kelas Anda.']);
            }

            PasswordResetRequest::create([
                'user_id' => $user->id,
                'role' => 'STUDENT',
                'new_password' => Hash::make($request->new_password),
                'status' => 'PENDING',
            ]);

            return back()->with('success', 'Pengajuan reset password berhasil dikirim! Silakan hubungi Wali Kelas Anda untuk meminta persetujuan.');

        } else {
            // Cari guru berdasarkan Nomor WhatsApp
            $teacher = Teacher::where('no_wa', $request->identifier)->first();

            if (!$teacher) {
                return back()->withErrors(['identifier' => 'Guru dengan Nomor WhatsApp tersebut tidak ditemukan.']);
            }

            // Cari user account
            $user = User::where('id_guru', $teacher->id_guru)->first();
            if (!$user) {
                return back()->withErrors([
                    'identifier' => 'Akun login Anda belum terbuat. Silakan login terlebih dahulu menggunakan password default "password123" untuk mengaktifkan akun Anda.'
                ]);
            }

            // Cek apakah sudah ada pengajuan pending
            $existing = PasswordResetRequest::where('user_id', $user->id)
                ->where('status', 'PENDING')
                ->first();

            if ($existing) {
                return back()->withErrors(['identifier' => 'Anda sudah mengajukan reset password sebelumnya. Silakan tunggu persetujuan Admin Kurikulum.']);
            }

            PasswordResetRequest::create([
                'user_id' => $user->id,
                'role' => 'TEACHER',
                'new_password' => Hash::make($request->new_password),
                'status' => 'PENDING',
            ]);

            return back()->with('success', 'Pengajuan reset password berhasil dikirim! Silakan hubungi Admin Kurikulum untuk meminta persetujuan.');
        }
    }

    /**
     * Tampilkan daftar pengajuan reset password siswa untuk Wali Kelas
     */
    public function listStudentRequests(Request $request)
    {
        $user = Auth::user();
        if ($user->role !== 'TEACHER') {
            abort(403, 'Akses ditolak.');
        }

        // Dapatkan kelas perwalian guru ini
        $class = Clas::where('id_guru_wali', $user->id_guru)->first();
        if (!$class) {
            return Inertia::render('WaliKelas/ResetRequests', [
                'requests' => [],
                'message' => 'Anda tidak terdaftar sebagai Wali Kelas aktif.'
            ]);
        }

        // Ambil daftar ID user siswa di kelas ini
        $studentIds = Student::where('id_kelas', $class->id_kelas)->pluck('id_siswa');
        $studentUserIds = User::whereIn('id_siswa', $studentIds)->pluck('id');

        $requests = PasswordResetRequest::with(['user.student'])
            ->whereIn('user_id', $studentUserIds)
            ->where('role', 'STUDENT')
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function ($req) {
                return [
                    'id' => $req->id,
                    'nama_siswa' => $req->user->student->nama_siswa ?? $req->user->name,
                    'nis' => $req->user->student->nis ?? '-',
                    'nisn' => $req->user->student->nisn ?? '-',
                    'status' => $req->status,
                    'tanggal' => $req->created_at->format('d M Y H:i'),
                ];
            });

        return Inertia::render('WaliKelas/ResetRequests', [
            'requests' => $requests,
            'nama_kelas' => $class->nama_kelas,
        ]);
    }

    /**
     * Setujui pengajuan reset password siswa oleh Wali Kelas
     */
    public function approveStudentRequest($id)
    {
        $user = Auth::user();
        if ($user->role !== 'TEACHER') {
            return redirect()->back()->with('error', 'Akses ditolak.');
        }

        $class = Clas::where('id_guru_wali', $user->id_guru)->first();
        if (!$class) {
            return redirect()->back()->with('error', 'Anda bukan wali kelas.');
        }

        $req = PasswordResetRequest::findOrFail($id);

        // Pastikan murid yang diajukan adalah benar murid dari kelas wali kelas ini
        $student = User::findOrFail($req->user_id)->student;
        if (!$student || $student->id_kelas !== $class->id_kelas) {
            return redirect()->back()->with('error', 'Siswa ini bukan anggota kelas perwalian Anda.');
        }

        if ($req->status !== 'PENDING') {
            return redirect()->back()->with('error', 'Pengajuan ini sudah diproses sebelumnya.');
        }

        // Update password user siswa
        User::where('id', $req->user_id)->update([
            'password' => $req->new_password
        ]);

        // Tandai request sebagai APPROVED
        $req->update([
            'status' => 'APPROVED',
            'approved_by' => $user->id
        ]);

        return redirect()->back()->with('success', 'Reset password siswa berhasil disetujui!');
    }

    /**
     * Tolak pengajuan reset password siswa oleh Wali Kelas
     */
    public function rejectStudentRequest($id)
    {
        $user = Auth::user();
        if ($user->role !== 'TEACHER') {
            return redirect()->back()->with('error', 'Akses ditolak.');
        }

        $class = Clas::where('id_guru_wali', $user->id_guru)->first();
        if (!$class) {
            return redirect()->back()->with('error', 'Anda bukan wali kelas.');
        }

        $req = PasswordResetRequest::findOrFail($id);
        $student = User::findOrFail($req->user_id)->student;
        if (!$student || $student->id_kelas !== $class->id_kelas) {
            return redirect()->back()->with('error', 'Siswa ini bukan anggota kelas perwalian Anda.');
        }

        if ($req->status !== 'PENDING') {
            return redirect()->back()->with('error', 'Pengajuan ini sudah diproses sebelumnya.');
        }

        $req->update([
            'status' => 'REJECTED',
            'approved_by' => $user->id
        ]);

        return redirect()->back()->with('success', 'Pengajuan reset password siswa ditolak.');
    }

    /**
     * Tampilkan daftar pengajuan reset password guru untuk Admin
     */
    public function listTeacherRequests(Request $request)
    {
        $user = Auth::user();
        if ($user->role !== 'ADMIN') {
            abort(403, 'Akses ditolak.');
        }

        $requests = PasswordResetRequest::with(['user.teacher'])
            ->where('role', 'TEACHER')
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function ($req) {
                return [
                    'id' => $req->id,
                    'nama_guru' => $req->user->teacher->nama_guru ?? $req->user->name,
                    'no_wa' => $req->user->teacher->no_wa ?? '-',
                    'status' => $req->status,
                    'tanggal' => $req->created_at->format('d M Y H:i'),
                ];
            });

        return Inertia::render('Admin/ResetRequests', [
            'requests' => $requests
        ]);
    }

    /**
     * Setujui pengajuan reset password guru oleh Admin
     */
    public function approveTeacherRequest($id)
    {
        $user = Auth::user();
        if ($user->role !== 'ADMIN') {
            return redirect()->back()->with('error', 'Akses ditolak.');
        }

        $req = PasswordResetRequest::findOrFail($id);

        if ($req->status !== 'PENDING') {
            return redirect()->back()->with('error', 'Pengajuan ini sudah diproses sebelumnya.');
        }

        // Update password user guru
        User::where('id', $req->user_id)->update([
            'password' => $req->new_password
        ]);

        // Tandai request sebagai APPROVED
        $req->update([
            'status' => 'APPROVED',
            'approved_by' => $user->id
        ]);

        return redirect()->back()->with('success', 'Reset password guru berhasil disetujui!');
    }

    /**
     * Tolak pengajuan reset password guru oleh Admin
     */
    public function rejectTeacherRequest($id)
    {
        $user = Auth::user();
        if ($user->role !== 'ADMIN') {
            return redirect()->back()->with('error', 'Akses ditolak.');
        }

        $req = PasswordResetRequest::findOrFail($id);

        if ($req->status !== 'PENDING') {
            return redirect()->back()->with('error', 'Pengajuan ini sudah diproses sebelumnya.');
        }

        $req->update([
            'status' => 'REJECTED',
            'approved_by' => $user->id
        ]);

        return redirect()->back()->with('success', 'Pengajuan reset password guru ditolak.');
    }
}
