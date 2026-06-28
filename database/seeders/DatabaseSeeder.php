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
        // 1. Selalu jalankan seeder inti (Production & Local butuh ini)
        $this->call(AdminKurikulumSeeder::class);
        // Tambahkan seeder esensial lainnya di sini (misal: SettingsSeeder, RolesSeeder, dll jika ada)

        // 2. Cek apakah ini mode lokal/testing?
        if (app()->environment(['local', 'testing', 'development'])) {
            // Hanya jalankan seeder bohong-bohongan di lokal!
            $this->call(DummyDataSeeder::class);
        }
    }
}
