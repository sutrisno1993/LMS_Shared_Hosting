<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('timetable', function (Blueprint $table) {
            $table->id('id_timetable');
            
            $table->unsignedBigInteger('id_class_subject');
            $table->foreign('id_class_subject')->references('id_class_subject')->on('class_subjects')->onDelete('cascade');
            
            $table->string('hari');
            $table->integer('jam_ke');
            
            // Guru yang mengajar slot ini (bisa digantikan fallback)
            $table->unsignedBigInteger('id_guru')->nullable();
            $table->foreign('id_guru')->references('id_guru')->on('teachers')->onDelete('set null');
            
            $table->boolean('is_fallback')->default(false);
            
            $table->unsignedBigInteger('original_guru_id')->nullable();
            $table->foreign('original_guru_id')->references('id_guru')->on('teachers')->onDelete('set null');
            
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('timetable');
    }
};
