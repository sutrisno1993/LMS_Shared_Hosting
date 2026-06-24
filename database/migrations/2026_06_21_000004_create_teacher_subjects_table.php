<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('teacher_subjects', function (Blueprint $table) {
            $table->id('id_teacher_subject');
            
            $table->unsignedBigInteger('id_guru');
            $table->foreign('id_guru')->references('id_guru')->on('teachers')->onDelete('cascade');
            
            $table->unsignedBigInteger('id_mapel');
            $table->foreign('id_mapel')->references('id_mapel')->on('subjects')->onDelete('cascade');
            
            $table->unique(['id_guru', 'id_mapel']);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('teacher_subjects');
    }
};
