<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Config;

class TenantDatabaseMiddleware
{
    /**
     * Handle an incoming request.
     */
    public function handle(Request $request, Closure $next)
    {
        $host = $request->getHost(); // Contoh: "bekasi.lms11maret.xyz" atau "jakarta.lms11maret.xyz"
        $parts = explode('.', $host);
        
        // Ambil subdomain pertama
        $subdomain = strtolower($parts[0] ?? '');

        if (app()->environment(['local', 'development'])) {
            // Di lingkungan lokal/development, default ke database Bekasi (lms_bekasi)
            // kecuali jika subdomain secara eksplisit diakses sebagai 'jakarta' atau 'jkt'
            if ($subdomain === 'jakarta' || $subdomain === 'jkt') {
                $dbName = env('DB_DATABASE', 'lms_db');
            } else {
                $dbName = 'lms_bekasi';
            }
        } else {
            // Di lingkungan production, baca subdomain secara ketat
            if ($subdomain === 'bekasi' || $subdomain === 'bks') {
                $dbName = 'lms_bekasi';
            } else {
                // Default menggunakan database utama yang terdefinisi di .env (lms_db)
                $dbName = env('DB_DATABASE', 'lms_db');
            }
        }

        // Set konfigurasi database MySQL secara runtime
        Config::set('database.connections.mysql.database', $dbName);

        // Bersihkan cache koneksi dan sambungkan kembali
        DB::purge('mysql');
        DB::reconnect('mysql');

        return $next($request);
    }
}
