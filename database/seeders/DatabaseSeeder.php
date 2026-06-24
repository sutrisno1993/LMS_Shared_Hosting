<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Data Guru & Kelas sudah ada di database dari proses import SITAB sebelumnya.
        // id_guru 24 = REZA PATRIOTA PUTRA
        // id_guru 2 = ARIF RAHMAN HAKIM (atau sejenisnya)
        // id_kelas 22 = XII TKJ 1

        // 1. Buat Dummy Siswa (karena data siswa belum ada)
        DB::table('students')->insertOrIgnore([
            ['id_siswa' => 1, 'nis' => '2024001', 'nisn' => '0011223344', 'nama_siswa' => 'Ahmad Rifai', 'id_kelas' => 22, 'created_at' => now(), 'updated_at' => now()],
            ['id_siswa' => 2, 'nis' => '2024002', 'nisn' => '0011223355', 'nama_siswa' => 'Budi Santoso', 'id_kelas' => 22, 'created_at' => now(), 'updated_at' => now()],
        ]);

        // 2. Buat Akun Users
        $password = Hash::make('password123');

        User::updateOrCreate(['email' => 'admin@smk11maret.sch.id'], [
            'name' => 'Admin Kurikulum',
            'password' => $password,
            'role' => 'ADMIN',
            'id_guru' => null,
            'id_siswa' => null,
        ]);

        User::updateOrCreate(['email' => 'reza.patriota@smk11maret.sch.id'], [
            'name' => 'Reza Patriota Putra, S.Kom',
            'password' => $password,
            'role' => 'TEACHER',
            'id_guru' => 24, // Sesuaikan dengan id_guru Reza di DB
            'id_siswa' => null,
        ]);

        User::updateOrCreate(['email' => 'sari.widyastuti@smk11maret.sch.id'], [
            'name' => 'Guru Lainnya / Wali Kelas',
            'password' => $password,
            'role' => 'TEACHER', 
            'id_guru' => 2, // Asumsi id_guru 2 ada
            'id_siswa' => null,
        ]);

        User::updateOrCreate(['email' => '2024001@smk11maret.sch.id'], [
            'name' => 'Ahmad Rifai',
            'password' => $password,
            'role' => 'STUDENT',
            'id_guru' => null,
            'id_siswa' => 1,
        ]);
    }
}
