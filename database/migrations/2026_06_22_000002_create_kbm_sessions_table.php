<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('kbm_sessions', function (Blueprint $table) {
            $table->id();
            $table->date('tanggal');
            
            // Relasi ke jadwal template mingguan (bisa null jika jadwal di-reset/dihapus)
            $table->unsignedBigInteger('id_timetable')->nullable();
            $table->foreign('id_timetable')->references('id_timetable')->on('timetable')->onDelete('set null');

            // Snapshot data historis agar tidak hilang jika timetable di-reset Kurikulum
            $table->unsignedBigInteger('id_kelas')->nullable();
            $table->unsignedBigInteger('id_mapel')->nullable();
            $table->integer('jam_ke')->nullable();
            $table->unsignedBigInteger('id_guru_terjadwal')->nullable();
            
            // Relasi ke guru yang *aktual* mengajar (bisa jadi guru pengganti/inval)
            $table->unsignedBigInteger('id_guru_aktual')->nullable();
            $table->foreign('id_guru_aktual')->references('id_guru')->on('teachers')->onDelete('set null');
            
            // Status sesi (PENDING = belum waktunya/belum discan, AKTIF = sedang berjalan, SELESAI = sudah kelar, KOSONG = ga ada guru/libur, EVENT = dispensasi KBM)
            $table->enum('status_sesi', ['PENDING', 'AKTIF', 'SELESAI', 'KOSONG', 'EVENT'])->default('PENDING');
            
            // Status spesifik kedisiplinan guru di sesi ini
            $table->enum('status_guru', ['PENDING', 'HADIR', 'TERLAMBAT', 'ALPA', 'DISPENSASI'])->default('PENDING');
            
            $table->timestamp('waktu_scan_masuk')->nullable();
            $table->timestamp('waktu_scan_keluar')->nullable();
            
            // Log singkat jika guru mengisi jurnal materi
            $table->string('materi_log')->nullable();
            
            $table->timestamps();

            // Hindari duplikasi pembuatan sesi untuk hari yang sama, kelas yang sama, di jam yang sama
            $table->unique(['tanggal', 'id_kelas', 'jam_ke']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('kbm_sessions');
    }
};
