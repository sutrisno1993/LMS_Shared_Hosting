<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Carbon\Carbon;

class DevTimeController extends Controller
{
    public function update(Request $request)
    {
        if (!app()->environment(['local', 'development'])) {
            abort(403, 'Unauthorized action in production.');
        }

        $target = Carbon::parse($request->target_time);
        $realTime = time();
        
        // Calculate offset in seconds (target_time - real_time)
        $offset = $target->timestamp - $realTime;

        if ($offset < 0) {
            throw \Illuminate\Validation\ValidationException::withMessages([
                'target_time' => 'Waktu simulasi hanya boleh diatur ke masa depan (ke depan).',
            ]);
        }

        Cache::forever('time_offset', $offset);
        
        // Clear schedules cache so it regenerates for the new simulated day
        for ($i = 0; $i < 7; $i++) {
            Cache::forget('jp_schedules_today_' . $i);
        }

        return back()->with('success', 'Waktu simulasi berhasil diatur ke ' . $request->target_time);
    }

    public function reset()
    {
        if (!app()->environment(['local', 'development'])) {
            abort(403, 'Unauthorized action in production.');
        }

        Cache::forget('time_offset');
        
        // Clear schedules cache
        for ($i = 0; $i < 7; $i++) {
            Cache::forget('jp_schedules_today_' . $i);
        }

        return back()->with('success', 'Simulasi waktu direset ke waktu sistem riil.');
    }
}
