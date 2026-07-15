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
        // 1. Create atps table
        Schema::create('atps', function (Blueprint $table) {
            $table->id('id_atp');
            $table->unsignedBigInteger('id_element');
            $table->string('kode_atp');
            $table->text('deskripsi_atp');
            $table->integer('urutan')->default(1);
            $table->timestamps();

            $table->foreign('id_element')->references('id_element')->on('learning_elements')->onDelete('cascade');
        });

        // 2. Modify learning_objectives to link to atps
        Schema::table('learning_objectives', function (Blueprint $table) {
            $table->unsignedBigInteger('id_atp')->nullable()->after('id_element');
            $table->foreign('id_atp')->references('id_atp')->on('atps')->onDelete('cascade');
            
            // Make id_element, id_guru, id_mapel nullable to allow migration
            $table->unsignedBigInteger('id_element')->nullable()->change();
            $table->unsignedBigInteger('id_guru')->nullable()->change();
            $table->unsignedBigInteger('id_mapel')->nullable()->change();
        });

        // 3. Create babs table
        Schema::create('babs', function (Blueprint $table) {
            $table->id('id_bab');
            $table->unsignedBigInteger('id_mapel');
            $table->string('nama_bab');
            $table->text('deskripsi')->nullable();
            $table->integer('urutan')->default(1);
            $table->enum('semester', ['GANJIL', 'GENAP'])->default('GANJIL');
            $table->timestamps();

            $table->foreign('id_mapel')->references('id_mapel')->on('subjects')->onDelete('cascade');
        });

        // 4. Create bab_tp pivot table
        Schema::create('bab_tp', function (Blueprint $table) {
            $table->unsignedBigInteger('id_bab');
            $table->unsignedBigInteger('id_tp');
            $table->primary(['id_bab', 'id_tp']);

            $table->foreign('id_bab')->references('id_bab')->on('babs')->onDelete('cascade');
            $table->foreign('id_tp')->references('id_tp')->on('learning_objectives')->onDelete('cascade');
        });

        // 5. Create sub_materis table
        Schema::create('sub_materis', function (Blueprint $table) {
            $table->id('id_sub_materi');
            $table->unsignedBigInteger('id_bab');
            $table->string('judul');
            $table->enum('tipe', ['ARTIKEL', 'PDF', 'VIDEO', 'PPT', 'LINK', 'YOUTUBE', 'HTML'])->default('ARTIKEL');
            $table->longText('konten')->nullable();
            $table->string('file_path')->nullable();
            $table->integer('urutan')->default(1);
            $table->timestamps();

            $table->foreign('id_bab')->references('id_bab')->on('babs')->onDelete('cascade');
        });

        // 6. Create aktivitas_pembelajarans table
        Schema::create('aktivitas_pembelajarans', function (Blueprint $table) {
            $table->id('id_aktivitas');
            $table->unsignedBigInteger('id_sub_materi');
            $table->string('nama_aktivitas');
            $table->enum('tipe_aktivitas', ['MEMBACA', 'MENONTON', 'DISKUSI', 'UPLOAD_TUGAS', 'PRAKTIK', 'QUIZ'])->default('MEMBACA');
            $table->text('deskripsi')->nullable();
            $table->boolean('status_wajib')->default(true);
            $table->timestamps();

            $table->foreign('id_sub_materi')->references('id_sub_materi')->on('sub_materis')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('aktivitas_pembelajarans');
        Schema::dropIfExists('sub_materis');
        Schema::dropIfExists('bab_tp');
        Schema::dropIfExists('babs');

        Schema::table('learning_objectives', function (Blueprint $table) {
            $table->dropForeign(['id_atp']);
            $table->dropColumn('id_atp');
        });

        Schema::dropIfExists('atps');
    }
};
