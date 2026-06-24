<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('classes', function (Blueprint $table) {
            // Kolom untuk ID Wali Kelas
            $table->unsignedBigInteger('id_guru_wali')->nullable()->after('jurusan');
            $table->foreign('id_guru_wali')->references('id_guru')->on('teachers')->onDelete('set null');
        });
    }

    public function down(): void
    {
        Schema::table('classes', function (Blueprint $table) {
            $table->dropForeign(['id_guru_wali']);
            $table->dropColumn('id_guru_wali');
        });
    }
};
