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
        Schema::table('kbm_sessions', function (Blueprint $table) {
            $table->string('foto_selfie')->nullable()->after('materi_log');
            $table->string('latitude')->nullable()->after('foto_selfie');
            $table->string('longitude')->nullable()->after('latitude');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('kbm_sessions', function (Blueprint $table) {
            $table->dropColumn(['foto_selfie', 'latitude', 'longitude']);
        });
    }
};
