<?php
define('LARAVEL_START', microtime(true));

// Load Composer Autoloader
require __DIR__.'/../vendor/autoload.php';

// Bootstrap Laravel Kernel
$app = require_once __DIR__.'/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\KbmSession;
use App\Models\JpSchedule;
use App\Models\Clas;
use Carbon\Carbon;

try {
    echo "<pre>";
    echo "=========================================================\n";
    echo "           DIAGNOSIS REAL-TIME DATA CCTV & KBM           \n";
    echo "=========================================================\n\n";

    $today = Carbon::today()->toDateString();
    echo "Tanggal Hari Ini (Server): " . $today . "\n";
    echo "Jam Server Saat Ini: " . Carbon::now()->toDateTimeString() . "\n";
    $dayIndex = Carbon::now()->dayOfWeek;
    $days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    $hariEnum = strtoupper($days[$dayIndex]);
    echo "Hari Enum (Server): " . $hariEnum . "\n\n";

    // 1. Hitung Sesi KBM hari ini
    $sessionsCount = KbmSession::where('tanggal', $today)->count();
    echo "[1] Total Sesi KBM Terdaftar Hari Ini: " . $sessionsCount . " sesi\n";

    $sessionsByJam = KbmSession::where('tanggal', $today)
        ->selectRaw('jam_ke, count(*) as count')
        ->groupBy('jam_ke')
        ->get();

    echo "    Distribusi Sesi KBM per Jam Pelajaran:\n";
    if ($sessionsByJam->isEmpty()) {
        echo "    -> [!] TIDAK ADA SESI KBM HARI INI DI DATABASE [!]\n";
    } else {
        foreach ($sessionsByJam as $s) {
            echo "       - Jam ke-{$s->jam_ke}: {$s->count} sesi\n";
        }
    }
    echo "\n";

    // 2. Cek Jadwal JP hari ini
    $schedules = JpSchedule::where('hari', $hariEnum)->get();
    echo "[2] Total Jadwal JP Hari {$hariEnum}: " . $schedules->count() . " jadwal\n";
    if ($schedules->isEmpty()) {
        echo "    -> [!] DATA JP_SCHEDULE KOSONG UNTUK HARI {$hariEnum} [!]\n";
    } else {
        foreach ($schedules as $s) {
            echo "       - {$s->shift} | Jam ke-{$s->jam_ke} | {$s->waktu_mulai} - {$s->waktu_selesai} | KBM: " . ($s->is_kbm ? 'Ya' : 'Tidak') . "\n";
        }
    }
    echo "\n";

    // 3. Deteksi Jam Pelajaran yang Aktif Sekarang
    $now = Carbon::now();
    $currentMinutes = $now->hour * 60 + $now->minute;
    echo "[3] Waktu Saat Ini (dalam Menit): " . $currentMinutes . " menit\n";

    $activeSchedules = [];
    foreach ($schedules as $s) {
        if (!$s->waktu_mulai || !$s->waktu_selesai) continue;
        list($hStart, $mStart) = explode(':', $s->waktu_mulai);
        list($hEnd, $mEnd) = explode(':', $s->waktu_selesai);
        $startMins = (int)$hStart * 60 + (int)$mStart;
        $endMins = (int)$hEnd * 60 + (int)$mEnd;
        if ($currentMinutes >= $startMins && $currentMinutes < $endMins) {
            $activeSchedules[] = $s;
        }
    }

    echo "    Jadwal JP yang Aktif Detik Ini:\n";
    if (empty($activeSchedules)) {
        echo "    -> [!] DI LUAR JAM SEKOLAH / TIDAK ADA JADWAL AKTIF [!]\n";
    } else {
        foreach ($activeSchedules as $s) {
            echo "       - {$s->shift} | Jam ke-{$s->jam_ke} | {$s->waktu_mulai} - {$s->waktu_selesai}\n";
        }
    }
    echo "\n";

    // 4. Test Pencocokan Kelas & Sesi KBM Aktif
    echo "[4] Test Pencocokan Sesi KBM:\n";
    if (empty($activeSchedules)) {
        echo "    -> Tidak dapat melakukan pengetesan karena tidak ada jadwal aktif saat ini.\n";
    } else {
        $activeJp = $activeSchedules[0];
        echo "    Mencoba mencocokkan Kelas shift '{$activeJp->shift}' untuk Jam ke-{$activeJp->jam_ke}...\n";
        
        $classes = Clas::where('shift_operasional', $activeJp->shift)->orderBy('nama_kelas')->get();
        echo "    Total kelas terdeteksi pada shift {$activeJp->shift}: " . $classes->count() . " kelas\n";
        
        foreach ($classes as $c) {
            // Cek dengan query DB langsung
            $session = KbmSession::where('tanggal', $today)
                ->where('id_kelas', $c->id_kelas)
                ->where('jam_ke', $activeJp->jam_ke)
                ->first();
                
            if ($session) {
                echo "       - Kelas {$c->nama_kelas} (ID: {$c->id_kelas}) -> ADA SESI (Status Guru: {$session->status_guru}, Sesi: {$session->status_sesi})\n";
            } else {
                echo "       - Kelas {$c->nama_kelas} (ID: {$c->id_kelas}) -> [!] TIDAK ADA SESI DI DATABASE [!]\n";
            }
        }
    }

    echo "\n=========================================================\n";
    echo "Saran:\n";
    echo "1. Jika bagian [1] Jam ke-3 bernilai 0 sesi, berarti Anda belum meng-generate sesi KBM hari ini.\n";
    echo "2. Jika bagian [3] 'DI LUAR JAM' padahal saat ini jam sekolah, cek timezone server hosting Anda.\n";
    echo "=========================================================\n";
    echo "</pre>";

} catch (\Throwable $e) {
    echo "<pre>";
    echo "PHP Error Caught:\n";
    echo $e->getMessage() . "\n";
    echo "In file: " . $e->getFile() . " on line " . $e->getLine() . "\n";
    echo $e->getTraceAsString();
    echo "</pre>";
}
