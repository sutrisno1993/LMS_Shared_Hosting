<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('report_cards', function (Blueprint $table) {
            $table->id('id_rapor');
            $table->unsignedBigInteger('id_siswa');
            $table->unsignedBigInteger('id_class_subject');
            $table->integer('nilai_sas')->default(0); // Sumatif Akhir Semester
            $table->integer('nilai_akhir')->default(0); // Rata-rata TP (70%) + SAS (30%)
            $table->text('deskripsi_capaian')->nullable(); // Narasi rapor
            $table->timestamps();

            $table->foreign('id_siswa')->references('id_siswa')->on('students')->onDelete('cascade');
            $table->foreign('id_class_subject')->references('id_class_subject')->on('class_subjects')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('report_cards');
    }
};
