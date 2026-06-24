<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Artisan;
use Carbon\Carbon;

class EnsureDailyKbmGenerated
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Hanya cek jika request bukan untuk API atau aset statis, dan jika user sudah login
        if ($request->is('admin/*') || $request->is('guru/*') || $request->is('walikelas/*') || $request->is('siswa/*')) {
            $today = Carbon::today()->toDateString();
            $cacheKey = 'kbm_generated_' . $today;

            if (!Cache::has($cacheKey)) {
                // Generate KBM untuk hari ini
                // Gunakan date parameter sesuai dengan waktu mock yang aktif
                Artisan::call('kbm:generate-today', [
                    '--date' => $today
                ]);

                // Simpan flag di cache sampai akhir hari (berdasarkan waktu mock/asli)
                $endOfDay = Carbon::today()->endOfDay();
                Cache::put($cacheKey, true, $endOfDay);
            }
        }

        return $next($request);
    }
}
