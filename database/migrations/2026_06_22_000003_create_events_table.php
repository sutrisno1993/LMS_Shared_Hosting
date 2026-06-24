<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('events', function (Blueprint $table) {
            $table->id();
            $table->string('nama_event');
            $table->date('tanggal');
            
            // Null berarti berlaku untuk SEMUA shift
            $table->enum('target_shift', ['PAGI', 'SIANG'])->nullable();
            
            // Menyimpan daftar Jam Ke- dalam bentuk JSON array, misal: [1, 2, 3]
            // Null berarti berlaku untuk FULL 1 hari
            $table->json('jam_ke')->nullable();
            
            // Menyimpan daftar ID Kelas dalam bentuk JSON array, misal: [10, 11, 15]
            // Null berarti berlaku untuk SELURUH KELAS di sekolah
            $table->json('target_kelas')->nullable();
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('events');
    }
};
