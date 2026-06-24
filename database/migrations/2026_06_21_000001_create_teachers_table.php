<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('teachers', function (Blueprint $table) {
            $table->id('id_guru'); // Primary Key (BIGINT UNSIGNED)
            $table->string('nama_guru');
            $table->integer('kode_guru')->unique(); // Unique key untuk pencarian/sinkronisasi
            $table->json('hari_tersedia'); // Hari mengajar umum (cast ke array)
            $table->boolean('shift_pagi')->default(true);
            $table->boolean('shift_siang')->default(true);
            $table->json('hari_tersedia_pagi')->nullable();
            $table->json('hari_tersedia_siang')->nullable();
            $table->integer('min_jp')->default(2);
            $table->integer('max_jp')->default(60);
            $table->json('allowed_jp_pagi')->nullable();
            $table->json('allowed_jp_siang')->nullable();
            $table->string('no_wa')->nullable(); // Nomor WhatsApp untuk kirim jadwal
            
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('teachers');
    }
};
