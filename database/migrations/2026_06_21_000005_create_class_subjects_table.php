<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('class_subjects', function (Blueprint $table) {
            $table->id('id_class_subject');
            
            $table->unsignedBigInteger('id_kelas');
            $table->foreign('id_kelas')->references('id_kelas')->on('classes')->onDelete('cascade');
            
            $table->unsignedBigInteger('id_mapel');
            $table->foreign('id_mapel')->references('id_mapel')->on('subjects')->onDelete('cascade');
            
            $table->integer('durasi_jp');
            
            // Guru Mutlak (nullable, jika diset)
            $table->unsignedBigInteger('id_guru_mutlak')->nullable();
            $table->foreign('id_guru_mutlak')->references('id_guru')->on('teachers')->onDelete('set null');
            
            $table->unique(['id_kelas', 'id_mapel']);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('class_subjects');
    }
};
