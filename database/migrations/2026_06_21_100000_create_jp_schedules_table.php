<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('jp_schedules', function (Blueprint $table) {
            $table->id();
            $table->enum('shift', ['PAGI', 'SIANG']);
            $table->enum('hari', ['SENIN', 'SELASA', 'RABU', 'KAMIS', 'JUMAT', 'SABTU']);
            $table->integer('jam_ke')->nullable();
            $table->time('waktu_mulai');
            $table->time('waktu_selesai');
            // false jika slot ini bukan KBM (mis: Upacara, Istirahat, Penurunan Bendera)
            $table->boolean('is_kbm')->default(true);
            $table->string('keterangan')->nullable();
            $table->timestamps();

            $table->unique(['shift', 'hari', 'waktu_mulai']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('jp_schedules');
    }
};
