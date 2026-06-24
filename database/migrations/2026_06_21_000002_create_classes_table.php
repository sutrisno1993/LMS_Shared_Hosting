<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('classes', function (Blueprint $table) {
            $table->id('id_kelas');
            $table->string('nama_kelas')->unique(); // Unique key untuk pencarian/sinkronisasi
            $table->enum('shift_operasional', ['PAGI', 'SIANG']);
            $table->string('tingkat')->nullable();
            $table->string('jurusan')->nullable();
            
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('classes');
    }
};
