<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 1. Rencana Penilaian (Planner Bab)
        Schema::create('rencana_penilaians', function (Blueprint $table) {
            $table->id('id_rencana');
            $table->unsignedBigInteger('id_bab');
            $table->integer('jumlah_formatif')->default(0);
            $table->integer('jumlah_sumatif')->default(0);
            $table->timestamps();

            $table->foreign('id_bab')->references('id_bab')->on('babs')->onDelete('cascade');
        });

        // 2. Asesmen (Assessment)
        Schema::create('assessments', function (Blueprint $table) {
            $table->id('id_assessment');
            $table->unsignedBigInteger('id_rencana')->nullable(); // Terhubung ke planner jika generate otomatis
            $table->unsignedBigInteger('id_bab');
            $table->unsignedBigInteger('id_kelas');
            $table->unsignedBigInteger('id_mapel');
            $table->unsignedBigInteger('id_guru');
            
            $table->string('nama_asesmen');
            $table->enum('kategori', ['FORMATIF', 'SUMATIF']);
            $table->string('bentuk_asesmen'); // E.g., Tugas, Quiz, STS, SAS, dll
            $table->date('tanggal')->nullable();
            $table->text('deskripsi')->nullable();
            $table->enum('status', ['DRAFT', 'AKTIF', 'SELESAI'])->default('DRAFT');
            $table->enum('semester', ['GANJIL', 'GENAP'])->default('GANJIL');
            $table->timestamps();
            
            $table->foreign('id_rencana')->references('id_rencana')->on('rencana_penilaians')->onDelete('set null');
            $table->foreign('id_bab')->references('id_bab')->on('babs')->onDelete('cascade');
            $table->foreign('id_kelas')->references('id_kelas')->on('classes')->onDelete('cascade');
            $table->foreign('id_mapel')->references('id_mapel')->on('subjects')->onDelete('cascade');
            $table->foreign('id_guru')->references('id_guru')->on('teachers')->onDelete('cascade');
        });

        // 3. Pivot Asesmen ↔ TP (Many-to-Many)
        Schema::create('assessment_tp', function (Blueprint $table) {
            $table->unsignedBigInteger('id_assessment');
            $table->unsignedBigInteger('id_tp');
            $table->primary(['id_assessment', 'id_tp']);

            $table->foreign('id_assessment')->references('id_assessment')->on('assessments')->onDelete('cascade');
            $table->foreign('id_tp')->references('id_tp')->on('learning_objectives')->onDelete('cascade');
        });

        // 4. Nilai Asesmen Siswa (Student Assessment Scores)
        Schema::create('student_assessment_scores', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('id_assessment');
            $table->unsignedBigInteger('id_siswa');
            $table->decimal('nilai', 5, 2)->nullable();
            $table->text('catatan')->nullable();
            $table->timestamps();
            
            $table->foreign('id_assessment')->references('id_assessment')->on('assessments')->onDelete('cascade');
            $table->foreign('id_siswa')->references('id_siswa')->on('students')->onDelete('cascade');
            $table->unique(['id_assessment', 'id_siswa']);
        });

        // 5. Konfigurasi Pembobotan Sekolah/Nilai Akhir
        Schema::create('school_grading_configs', function (Blueprint $table) {
            $table->id();
            $table->enum('tipe_rapor', ['TENGAH_SEMESTER', 'AKHIR_SEMESTER']); // Konfigurasi per jenis rapor
            $table->integer('bobot_absensi')->default(0);    // Default 10% untuk Tengah Semester, 0% untuk Akhir Semester
            $table->integer('bobot_formatif')->default(60);   // Default 60%
            $table->integer('bobot_sts')->default(15);        // Default 30% untuk Tengah Semester, 15% untuk Akhir Semester
            $table->integer('bobot_sas')->default(25);        // Default 0% untuk Tengah Semester, 25% untuk Akhir Semester
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });

        // Seed default configurations
        DB::table('school_grading_configs')->insert([
            [
                'tipe_rapor' => 'TENGAH_SEMESTER',
                'bobot_absensi' => 10,
                'bobot_formatif' => 60,
                'bobot_sts' => 30,
                'bobot_sas' => 0,
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'tipe_rapor' => 'AKHIR_SEMESTER',
                'bobot_absensi' => 0,
                'bobot_formatif' => 60,
                'bobot_sts' => 15,
                'bobot_sas' => 25,
                'is_active' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('school_grading_configs');
        Schema::dropIfExists('student_assessment_scores');
        Schema::dropIfExists('assessment_tp');
        Schema::dropIfExists('assessments');
        Schema::dropIfExists('rencana_penilaians');
    }
};
