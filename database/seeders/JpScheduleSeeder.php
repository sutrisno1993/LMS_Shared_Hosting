<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class JpScheduleSeeder extends Seeder
{
    public function run(): void
    {
        // Bersihkan data lama terlebih dahulu agar tidak duplikat
        DB::table('jp_schedules')->truncate();

        $shifts = ['PAGI', 'SIANG'];
        $hari_list = ['SENIN', 'SELASA', 'RABU', 'KAMIS', 'JUMAT', 'SABTU'];

        $schedules = [];

        foreach ($shifts as $shift) {
            foreach ($hari_list as $hari) {
                
                // --- LOGIKA SHIFT PAGI ---
                if ($shift === 'PAGI') {
                    if (in_array($hari, ['SENIN', 'SELASA', 'RABU', 'KAMIS'])) {
                        // Pola Senin - Kamis Pagi
                        $schedules = array_merge($schedules, $this->generatePagiSeninKamis($hari, $shift));
                    } elseif ($hari === 'JUMAT') {
                        // Pola Jumat Pagi
                        $schedules = array_merge($schedules, $this->generatePagiJumat($hari, $shift));
                    } elseif ($hari === 'SABTU') {
                        // Pola Sabtu Pagi
                        $schedules = array_merge($schedules, $this->generatePagiSabtu($hari, $shift));
                    }
                } 
                // --- LOGIKA SHIFT SIANG ---
                else {
                    if ($hari === 'JUMAT') {
                        // Pola Jumat Siang (Mulai 13:30, JP 45m, Break 15:45-16:15)
                        $schedules = array_merge($schedules, $this->generateSiangJumat($hari, $shift));
                    } else {
                        // Pola Senin-Kamis & Sabtu Siang
                        $schedules = array_merge($schedules, $this->generateSiangReguler($hari, $shift));
                    }
                }
            }
        }

        DB::table('jp_schedules')->insert($schedules);
    }

    private function generatePagiSeninKamis($hari, $shift)
    {
        $data = [];
        $time = Carbon::createFromTime(6, 30, 0);

        // JP 1
        $end = (clone $time)->addMinutes(60);
        $data[] = $this->makeJp($hari, $shift, 1, true, $time, $end, 'KBM/Upacara');
        $time = $end;

        // JP 2-4
        for ($i = 2; $i <= 4; $i++) {
            $end = (clone $time)->addMinutes(40);
            $data[] = $this->makeJp($hari, $shift, $i, true, $time, $end);
            $time = $end;
        }

        // Istirahat
        $end = (clone $time)->addMinutes(30);
        $data[] = $this->makeJp($hari, $shift, 0, false, $time, $end, 'Istirahat');
        $time = $end;

        // JP 5-7
        for ($i = 5; $i <= 7; $i++) {
            $end = (clone $time)->addMinutes(35);
            $data[] = $this->makeJp($hari, $shift, $i, true, $time, $end);
            $time = $end;
        }
        return $data;
    }

    private function generatePagiJumat($hari, $shift)
    {
        $data = [];
        $time = Carbon::createFromTime(7, 0, 0);

        // JP 1-4
        for ($i = 1; $i <= 4; $i++) {
            $end = (clone $time)->addMinutes(40);
            $data[] = $this->makeJp($hari, $shift, $i, true, $time, $end);
            $time = $end;
        }

        // Istirahat
        $end = (clone $time)->addMinutes(20);
        $data[] = $this->makeJp($hari, $shift, 0, false, $time, $end, 'Istirahat');
        $time = $end;

        // JP 5-6
        for ($i = 5; $i <= 6; $i++) {
            $end = (clone $time)->addMinutes(40);
            $data[] = $this->makeJp($hari, $shift, $i, true, $time, $end);
            $time = $end;
        }
        return $data;
    }

    private function generatePagiSabtu($hari, $shift)
    {
        $data = [];
        $time = Carbon::createFromTime(7, 0, 0);

        // JP 1-4
        for ($i = 1; $i <= 4; $i++) {
            $end = (clone $time)->addMinutes(45);
            $data[] = $this->makeJp($hari, $shift, $i, true, $time, $end);
            $time = $end;
        }

        // Istirahat
        $end = (clone $time)->addMinutes(30);
        $data[] = $this->makeJp($hari, $shift, 0, false, $time, $end, 'Istirahat');
        $time = $end;

        // JP 5-7
        for ($i = 5; $i <= 7; $i++) {
            $end = (clone $time)->addMinutes(45);
            $data[] = $this->makeJp($hari, $shift, $i, true, $time, $end);
            $time = $end;
        }
        return $data;
    }

    private function generateSiangReguler($hari, $shift)
    {
        $data = [];
        $time = Carbon::createFromTime(12, 45, 0);

        // JP 1-4
        for ($i = 1; $i <= 4; $i++) {
            $end = (clone $time)->addMinutes(45);
            $data[] = $this->makeJp($hari, $shift, $i, true, $time, $end);
            $time = $end;
        }

        // Istirahat
        $end = (clone $time)->addMinutes(30);
        $data[] = $this->makeJp($hari, $shift, 0, false, $time, $end, 'Istirahat');
        $time = $end;

        // JP 5-7
        for ($i = 5; $i <= 7; $i++) {
            $end = (clone $time)->addMinutes(45);
            $data[] = $this->makeJp($hari, $shift, $i, true, $time, $end);
            $time = $end;
        }
        return $data;
    }

    private function generateSiangJumat($hari, $shift)
    {
        $data = [];
        $time = Carbon::createFromTime(13, 30, 0); // Mulai 13:30

        // JP 1-3
        for ($i = 1; $i <= 3; $i++) {
            $end = (clone $time)->addMinutes(45);
            $data[] = $this->makeJp($hari, $shift, $i, true, $time, $end);
            $time = $end;
        }

        // Istirahat
        $end = (clone $time)->addMinutes(30);
        $data[] = $this->makeJp($hari, $shift, 0, false, $time, $end, 'Istirahat');
        $time = $end;

        // JP 4-6
        for ($i = 4; $i <= 6; $i++) {
            $end = (clone $time)->addMinutes(45);
            $data[] = $this->makeJp($hari, $shift, $i, true, $time, $end);
            $time = $end;
        }
        return $data;
    }

    private function makeJp($hari, $shift, $jam_ke, $is_kbm, $start, $end, $keterangan = 'KBM Aktif')
    {
        return [
            'hari' => $hari,
            'shift' => $shift,
            'jam_ke' => $jam_ke,
            'is_kbm' => $is_kbm,
            'waktu_mulai' => $start->format('H:i:s'),
            'waktu_selesai' => $end->format('H:i:s'),
            'keterangan' => $keterangan,
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }
}
