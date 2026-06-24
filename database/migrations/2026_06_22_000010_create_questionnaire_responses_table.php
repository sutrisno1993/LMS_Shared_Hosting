<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('questionnaire_responses', function (Blueprint $table) {
            $table->id('id_response');
            $table->unsignedBigInteger('id_questionnaire');
            $table->unsignedBigInteger('id_siswa');
            $table->unsignedBigInteger('id_guru_target'); // Guru yang dinilai
            $table->unsignedBigInteger('id_q_question'); // Pertanyaan spesifik
            $table->integer('rating_score')->default(0); // 1-5 bintang
            $table->text('komentar')->nullable(); // Anonim untuk guru, terekam untuk admin
            
            $table->foreign('id_questionnaire')->references('id_questionnaire')->on('questionnaires')->onDelete('cascade');
            $table->foreign('id_siswa')->references('id_siswa')->on('students')->onDelete('cascade');
            $table->foreign('id_guru_target')->references('id_guru')->on('teachers')->onDelete('cascade');
            $table->foreign('id_q_question')->references('id_q_question')->on('questionnaire_questions')->onDelete('cascade');
            
            // Satu siswa hanya boleh menjawab satu pertanyaan untuk satu guru target pada satu kuesioner tertentu sekali saja
            $table->unique(['id_questionnaire', 'id_siswa', 'id_guru_target', 'id_q_question'], 'unique_response');
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('questionnaire_responses');
    }
};
