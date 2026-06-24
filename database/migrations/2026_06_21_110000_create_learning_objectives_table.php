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
        Schema::create('learning_objectives', function (Blueprint $table) {
            $table->id('id_tp');
            $table->unsignedBigInteger('id_guru');
            $table->unsignedBigInteger('id_mapel');
            $table->string('kode_tp');
            $table->text('deskripsi_tp');
            $table->enum('semester', ['GANJIL', 'GENAP'])->default('GANJIL');
            $table->timestamps();

            $table->foreign('id_guru')->references('id_guru')->on('teachers')->onDelete('cascade');
            $table->foreign('id_mapel')->references('id_mapel')->on('subjects')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('learning_objectives');
    }
};
