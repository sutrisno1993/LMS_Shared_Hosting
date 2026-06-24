<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->enum('role', ['ADMIN', 'TEACHER', 'STUDENT'])->default('STUDENT')->after('password');
            $table->unsignedBigInteger('id_guru')->nullable()->after('role');
            $table->unsignedBigInteger('id_siswa')->nullable()->after('id_guru');

            $table->foreign('id_guru')->references('id_guru')->on('teachers')->onDelete('set null');
            $table->foreign('id_siswa')->references('id_siswa')->on('students')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropForeign(['id_guru']);
            $table->dropForeign(['id_siswa']);
            $table->dropColumn(['role', 'id_guru', 'id_siswa']);
        });
    }
};
