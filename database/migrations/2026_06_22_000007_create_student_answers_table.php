<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('student_answers', function (Blueprint $table) {
            $table->id('id_answer');
            $table->unsignedBigInteger('id_exam');
            $table->unsignedBigInteger('id_siswa');
            $table->unsignedBigInteger('id_question');
            $table->enum('jawaban_siswa', ['A', 'B', 'C', 'D', 'E'])->nullable();
            $table->boolean('is_correct')->default(false);
            
            $table->foreign('id_exam')->references('id_exam')->on('live_exams')->onDelete('cascade');
            $table->foreign('id_siswa')->references('id_siswa')->on('students')->onDelete('cascade');
            $table->foreign('id_question')->references('id_question')->on('questions')->onDelete('cascade');
            
            $table->unique(['id_exam', 'id_siswa', 'id_question']); // Satu jawaban per soal per siswa per ujian
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('student_answers');
    }
};
