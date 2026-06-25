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
        Schema::create('teacher_attendances', function (Blueprint $table) {
            $table->id('id_attendance');
            $table->unsignedBigInteger('id_guru');
            $table->date('tanggal');
            $table->enum('shift', ['PAGI', 'SIANG']);
            $table->string('status')->nullable(); // HADIR, SAKIT, IZIN, or manual string
            $table->time('waktu_datang')->nullable();
            $table->timestamps();

            $table->foreign('id_guru')->references('id_guru')->on('teachers')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('teacher_attendances');
    }
};
