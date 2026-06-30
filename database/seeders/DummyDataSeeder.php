<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class DummyDataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // 1. Buat Dummy Siswa (karena data siswa belum ada)
        DB::table('students')->insertOrIgnore([
            ['id_siswa' => 1, 'nis' => '2024001', 'nisn' => '0011223344', 'nama_siswa' => 'Ahmad Rifai', 'id_kelas' => 22, 'created_at' => now(), 'updated_at' => now()],
            ['id_siswa' => 2, 'nis' => '2024002', 'nisn' => '0011223355', 'nama_siswa' => 'Budi Santoso', 'id_kelas' => 22, 'created_at' => now(), 'updated_at' => now()],
        ]);

        // 2. Buat Akun Users Dummy (Guru & Siswa)
        $password = Hash::make('password123');

        // Buat User untuk semua Guru di tabel teachers
        $teachers = DB::table('teachers')->get();
        foreach ($teachers as $t) {
            $cleanName = strtolower(preg_replace('/[^a-zA-Z]/', '', explode(',', $t->nama_guru)[0]));
            $email = $cleanName . '@teacher.smk11maret.sch.id';

            User::updateOrCreate(
                ['email' => $email],
                [
                    'name' => $t->nama_guru,
                    'password' => $password,
                    'role' => 'TEACHER',
                    'id_guru' => $t->id_guru,
                    'id_siswa' => null,
                ]
            );
        }

        User::updateOrCreate(['email' => '2024001@smk11maret.sch.id'], [
            'name' => 'Ahmad Rifai',
            'password' => $password,
            'role' => 'STUDENT',
            'id_guru' => null,
            'id_siswa' => 1,
        ]);
        
        // Memanggil Seeder Dummy Lainnya (jika diperlukan untuk Testing/Local)
        // $this->call(TestAttendanceSeeder::class);
        // $this->call(TestGradeSeeder::class);
        // $this->call(Class4GradeSeeder::class);
        // $this->call(StudentClassSeeder::class);
    }
}
