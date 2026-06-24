<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('students', function (Blueprint $table) {
            $table->id('id_siswa');
            $table->string('nis', 20)->unique();
            $table->string('nisn', 20)->nullable()->unique();
            $table->string('nama_siswa');
            $table->unsignedBigInteger('id_kelas');
            $table->timestamps();

            $table->foreign('id_kelas')->references('id_kelas')->on('classes')->onDelete('restrict');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('students');
    }
};
