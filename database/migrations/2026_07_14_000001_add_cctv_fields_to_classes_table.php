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
        Schema::table('classes', function (Blueprint $table) {
            $table->string('cctv_type')->default('NONE'); // NONE, STREAM, IFRAME
            $table->text('cctv_url')->nullable();
            $table->string('cctv_verification_code')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('classes', function (Blueprint $table) {
            $table->dropColumn(['cctv_type', 'cctv_url', 'cctv_verification_code']);
        });
    }
};
