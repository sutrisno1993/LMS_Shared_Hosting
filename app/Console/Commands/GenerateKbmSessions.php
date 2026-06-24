<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Timetable;
use App\Models\KbmSession;
use App\Models\Event;
use Carbon\Carbon;

class GenerateKbmSessions extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'kbm:generate-today {--date= : Format YYYY-MM-DD, default hari ini}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Generate log sesi KBM harian berdasarkan jadwal timetable mingguan';

    /**
     * Map angka hari dari Carbon (0=Minggu, 1=Senin) ke enum string kita
     */
    private $dayMap = [
        1 => 'SENIN',
        2 => 'SELASA',
        3 => 'RABU',
        4 => 'KAMIS',
        5 => 'JUMAT',
        6 => 'SABTU',
        0 => 'MINGGU',
    ];

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $dateStr = $this->option('date');
        $date = $dateStr ? Carbon::parse($dateStr) : Carbon::today();
        
        $hariEnum = $this->dayMap[$date->dayOfWeek];

        if ($hariEnum === 'MINGGU') {
            $this->info("Hari Minggu tidak ada jadwal KBM yang di-generate.");
            return 0;
        }

        $this->info("Memulai generate sesi KBM untuk hari: {$hariEnum} ({$date->toDateString()})");

        // Ambil semua jadwal untuk hari ini, gabung dengan relasi untuk cek shift dan kelas
        $timetables = Timetable::with(['classSubject.clas'])
            ->where('hari', $hariEnum)->get();

        // Ambil semua jpSchedule untuk hari ini
        $jpSchedules = \App\Models\JpSchedule::where('hari', $hariEnum)->get()->keyBy('jam_ke');

        if ($timetables->isEmpty()) {
            $this->warn("Tidak ada jadwal timetable ditemukan untuk hari {$hariEnum}.");
            return 0;
        }

        // Ambil events (Dispensasi) untuk hari ini
        $events = Event::where('tanggal', $date->toDateString())->get();

        // Cek Kalender Akademik untuk hari ini (Libur/Ujian)
        $academicEvent = \App\Models\AcademicCalendar::where('start_date', '<=', $date->toDateString())
            ->where('end_date', '>=', $date->toDateString())
            ->whereIn('type', ['LIBUR', 'UJIAN'])
            ->first();

        $count = 0;
        foreach ($timetables as $t) {
            $statusSesi = 'PENDING';
            $statusGuru = 'PENDING';

            // Jika ada event kalender akademik yang membatalkan KBM
            if ($academicEvent) {
                $statusSesi = 'EVENT';
                $statusGuru = 'LIBUR';
            }

            // Jika tidak libur total, cek irisan dengan events dispensasi spesifik
            if ($statusSesi === 'PENDING') {
                foreach ($events as $event) {
                $intersectShift = true;
                $intersectKelas = true;
                $intersectJam = true;

                // Cek Shift
                $jpSchedule = $jpSchedules->get($t->jam_ke);
                if ($event->target_shift && $jpSchedule && $event->target_shift !== $jpSchedule->shift) {
                    $intersectShift = false;
                }

                // Cek Kelas
                if ($event->target_kelas && is_array($event->target_kelas) && count($event->target_kelas) > 0) {
                    $idKelas = $t->classSubject && $t->classSubject->clas ? $t->classSubject->clas->id_kelas : null;
                    if (!in_array($idKelas, $event->target_kelas)) {
                        $intersectKelas = false;
                    }
                }

                // Cek Jam Ke
                if ($event->jam_ke && is_array($event->jam_ke) && count($event->jam_ke) > 0) {
                    if (!in_array($t->jam_ke, $event->jam_ke)) {
                        $intersectJam = false;
                    }
                }

                if ($intersectShift && $intersectKelas && $intersectJam) {
                    $statusSesi = 'EVENT';
                    $statusGuru = 'DISPENSASI';
                    break; // Sudah kena event, tidak perlu cek event lain
                }
            }
            }

            $idKelas = $t->classSubject && $t->classSubject->clas ? $t->classSubject->clas->id_kelas : null;
            $idMapel = $t->classSubject && $t->classSubject->subject ? $t->classSubject->subject->id_mapel : null;

            $session = KbmSession::firstOrCreate(
                [
                    'tanggal' => $date->toDateString(),
                    'id_kelas' => $idKelas,
                    'jam_ke' => $t->jam_ke,
                ],
                [
                    'id_timetable' => $t->id_timetable,
                    'id_mapel' => $idMapel,
                    'id_guru_terjadwal' => $t->id_guru,
                    'id_guru_aktual' => $t->id_guru,
                    'status_sesi' => $statusSesi,
                    'status_guru' => $statusGuru,
                ]
            );

            // Jika session baru dibuat atau di-update dari PENDING ke EVENT oleh run ulang
            if ($session->wasRecentlyCreated) {
                $count++;
            } elseif ($session->status_sesi === 'PENDING' && $statusSesi === 'EVENT') {
                $session->update([
                    'status_sesi' => 'EVENT',
                    'status_guru' => 'DISPENSASI'
                ]);
            }
        }

        $this->info("Berhasil men-generate/update {$count} sesi KBM untuk hari ini.");
        return 0;
    }
}
