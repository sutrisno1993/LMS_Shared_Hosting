<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\GradeConfig;

class AdminConfigController extends Controller
{
    public function gradeConfigIndex()
    {
        // Ambil konfigurasi global (ID=1). Jika belum ada, buat baru dengan default 50:50.
        $config = GradeConfig::firstOrCreate(
            ['id' => 1],
            ['bobot_formatif' => 50, 'bobot_sumatif' => 50]
        );

        return Inertia::render('Admin/GradeConfig', [
            'gradeConfig' => $config
        ]);
    }

    public function gradeConfigUpdate(Request $request)
    {
        $request->validate([
            'bobot_formatif' => 'required|integer|min:0|max:100',
            'bobot_sumatif' => 'required|integer|min:0|max:100',
        ]);

        if (($request->bobot_formatif + $request->bobot_sumatif) !== 100) {
            return redirect()->back()->with('error', 'Total bobot harus tepat 100%');
        }

        GradeConfig::updateOrCreate(
            ['id' => 1],
            [
                'bobot_formatif' => $request->bobot_formatif,
                'bobot_sumatif' => $request->bobot_sumatif,
            ]
        );

        return redirect()->back()->with('success', 'Konfigurasi Bobot Nilai berhasil disimpan.');
    }
    
    // Placeholder untuk Timeline dan Rapor agar tidak 404
    public function timeline()
    {
        return Inertia::render('Admin/Placeholder', [
            'title' => 'Timeline & Kalender Akademik',
            'description' => 'Fitur penjadwalan timeline (lock nilai, UTS/UAS) sedang dalam tahap pengembangan.'
        ]);
    }
    
    public function rapor()
    {
        return Inertia::render('Admin/Placeholder', [
            'title' => 'Ekspor Rapor',
            'description' => 'Fitur ekspor Rapor PTS/PAS PDF massal sedang dalam tahap pengembangan.'
        ]);
    }
}
