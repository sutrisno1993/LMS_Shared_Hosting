<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('live_exams', function (Blueprint $table) {
            $table->integer('durasi')->default(30)->after('status');         // Menit
            $table->integer('limit_soal')->nullable()->after('durasi');      // null = semua soal
            $table->boolean('acak_soal')->default(true)->after('limit_soal');
            $table->enum('tujuan', ['DIAGNOSTIK', 'SUMATIF'])->default('DIAGNOSTIK')->after('acak_soal');
            $table->unsignedBigInteger('id_tp')->nullable()->after('tujuan');
            $table->unsignedBigInteger('id_topic')->nullable()->after('id_tp');
            $table->timestamp('started_at')->nullable()->after('id_topic');   // Waktu ujian diluncurkan

            $table->foreign('id_tp')->references('id_tp')->on('learning_objectives')->onDelete('set null');
            $table->foreign('id_topic')->references('id_topic')->on('learning_topics')->onDelete('set null');
        });
    }

    public function down(): void
    {
        Schema::table('live_exams', function (Blueprint $table) {
            $table->dropForeign(['id_tp']);
            $table->dropForeign(['id_topic']);
            $table->dropColumn(['durasi', 'limit_soal', 'acak_soal', 'tujuan', 'id_tp', 'id_topic', 'started_at']);
        });
    }
};
