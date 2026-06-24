<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('live_exams', function (Blueprint $table) {
            $table->id('id_exam');
            $table->unsignedBigInteger('id_kbm_session');
            $table->unsignedBigInteger('id_bank');
            $table->enum('status', ['DRAFT', 'ACTIVE', 'FINISHED'])->default('DRAFT');
            
            $table->foreign('id_kbm_session')->references('id')->on('kbm_sessions')->onDelete('cascade');
            $table->foreign('id_bank')->references('id_bank')->on('question_banks')->onDelete('cascade');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('live_exams');
    }
};
