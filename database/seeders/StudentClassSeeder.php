<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\Models\Clas;
use App\Models\Student;
use App\Models\User;
use Faker\Factory as Faker;

class StudentClassSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create('id_ID');
        $classes = Clas::all();
        
        $nisCounter = 20260001;

        foreach ($classes as $class) {
            for ($i = 0; $i < 5; $i++) {
                $nisn = $faker->unique()->numerify('00########');
                $nis = (string) $nisCounter++;
                
                // Create Student
                $student = Student::create([
                    'nis' => $nis,
                    'nisn' => $nisn,
                    'nama_siswa' => $faker->name(),
                    'id_kelas' => $class->id_kelas,
                ]);

                // Create User for Student (Password default is their NISN)
                User::create([
                    'name' => $student->nama_siswa,
                    'email' => $nisn . '@student.smk11maret.sch.id', // unique fake email
                    'password' => Hash::make($nisn), // Password sesuai kesepakatan (NISN)
                    'role' => 'STUDENT',
                    'id_siswa' => $student->id_siswa,
                    'id_guru' => null,
                ]);
            }
        }
    }
}
