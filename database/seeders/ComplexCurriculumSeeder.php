<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Atp;
use App\Models\Bab;
use App\Models\SubMateri;
use App\Models\AktivitasPembelajaran;
use App\Models\RencanaPenilaian;
use App\Models\Assessment;
use App\Models\StudentAssessmentScore;

class ComplexCurriculumSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $idGuru = 7;      // DEDE HIDAYATULLAH
        $idMapel = 30;    // Matematika
        $idKelas = 3;     // X OTKP 2
        $students = [11, 12, 13, 14, 15]; // Siswa X OTKP 2

        // Set KKM Matematika ke 75
        DB::table('subjects')->where('id_mapel', $idMapel)->update(['kkm' => 75]);

        // 1. Bersihkan data lama agar seeder bersifat idempotent
        DB::table('student_attendances')->whereIn('id_kbm_session', function($query) use ($idKelas, $idMapel) {
            $query->select('id_kbm_session')
                  ->from('kbm_sessions')
                  ->where('id_kelas', $idKelas)
                  ->where('id_mapel', $idMapel);
        })->delete();

        DB::table('kbm_sessions')->where('id_kelas', $idKelas)->where('id_mapel', $idMapel)->delete();

        // Cari atau buat ClassSubject
        $classSubject = DB::table('class_subjects')->where('id_kelas', $idKelas)->where('id_mapel', $idMapel)->first();
        if (!$classSubject) {
            $idClassSubject = DB::table('class_subjects')->insertGetId([
                'id_kelas' => $idKelas,
                'id_mapel' => $idMapel,
                'id_guru_mutlak' => $idGuru,
                'created_at' => now(),
                'updated_at' => now()
            ]);
        } else {
            $idClassSubject = $classSubject->id_class_subject;
            DB::table('class_subjects')->where('id_class_subject', $idClassSubject)->update(['id_guru_mutlak' => $idGuru]);
        }

        // Cari atau buat Timetable entry
        $timetable = DB::table('timetable')->where('id_class_subject', $idClassSubject)->first();
        if (!$timetable) {
            DB::table('timetable')->insert([
                'id_class_subject' => $idClassSubject,
                'hari' => 'SENIN',
                'jam_ke' => 1,
                'id_guru' => $idGuru,
                'is_fallback' => false
            ]);
        }

        // 2. Buat 10 Sesi KBM Selesai untuk kalkulasi Absensi
        $attendancePatterns = [
            11 => [1,1,1,1,1,1,1,1,1,1], // 100%
            12 => [1,1,1,1,1,1,1,1,0,1], // 90%
            13 => [1,1,0,1,1,1,1,1,0,1], // 80%
            14 => [1,1,1,1,1,1,1,1,1,1], // 100%
            15 => [1,0,1,0,1,1,1,1,0,1], // 70%
        ];

        for ($i = 1; $i <= 10; $i++) {
            $date = now()->subDays(11 - $i)->toDateString();
            
            // Bersihkan sesi yang berkonflik pada kelas, tanggal, dan jam_ke ini
            DB::table('student_attendances')->whereIn('id_kbm_session', function($q) use ($idKelas, $date) {
                $q->select('id_kbm_session')
                  ->from('kbm_sessions')
                  ->where('id_kelas', $idKelas)
                  ->where('tanggal', $date)
                  ->where('jam_ke', 1);
            })->delete();
            DB::table('kbm_sessions')->where('id_kelas', $idKelas)->where('tanggal', $date)->where('jam_ke', 1)->delete();

            $sessionId = DB::table('kbm_sessions')->insertGetId([
                'id_kelas' => $idKelas,
                'id_mapel' => $idMapel,
                'id_guru_terjadwal' => $idGuru,
                'id_guru_aktual' => $idGuru,
                'tanggal' => $date,
                'jam_ke' => 1,
                'status_sesi' => 'SELESAI',
                'status_guru' => 'HADIR',
                'materi_log' => 'Pertemuan ke-' . $i . ' pembahasan materi matematika kurikulum merdeka.',
                'created_at' => now()->subDays(11 - $i),
                'updated_at' => now()->subDays(11 - $i)
            ]);

            foreach ($students as $idSiswa) {
                $statusHadir = ($attendancePatterns[$idSiswa][$i - 1] === 1) ? 'HADIR' : 'ALPA';
                DB::table('student_attendances')->insert([
                    'id_kbm_session' => $sessionId,
                    'id_siswa' => $idSiswa,
                    'status' => $statusHadir,
                    'metode' => 'SCAN_QR',
                    'waktu_presensi' => now()->subDays(11 - $i)->toDateTimeString()
                ]);
            }
        }

        // 3. Buat Elemen / CP (Capaian Pembelajaran)
        $element1Id = DB::table('learning_elements')->insertGetId([
            'id_mapel' => $idMapel,
            'id_guru' => $idGuru,
            'nama_elemen' => 'Bilangan (Eksponen & Logaritma)',
            'deskripsi_cp' => 'Di akhir fase E, peserta didik dapat menggeneralisasi sifat-sifat operasi bilangan berpangkat (eksponen) dan logaritma, serta menggunakan barisan dan deret.',
            'created_at' => now(),
            'updated_at' => now()
        ]);

        $element2Id = DB::table('learning_elements')->insertGetId([
            'id_mapel' => $idMapel,
            'id_guru' => $idGuru,
            'nama_elemen' => 'Aljabar dan Fungsi',
            'deskripsi_cp' => 'Di akhir fase E, peserta didik dapat menyelesaikan masalah yang berkaitan dengan sistem persamaan linear tiga variabel dan sistem pertidaksamaan linear dua variabel.',
            'created_at' => now(),
            'updated_at' => now()
        ]);

        // 4. Buat ATP (Alur Tujuan Pembelajaran)
        $atp1 = Atp::create([
            'id_element' => $element1Id,
            'kode_atp' => 'ATP-01.01',
            'deskripsi_atp' => 'Menerapkan konsep eksponen dan logaritma untuk menyelesaikan masalah keuangan dan pertumbuhan.',
            'urutan' => 1
        ]);

        $atp2 = Atp::create([
            'id_element' => $element2Id,
            'kode_atp' => 'ATP-02.01',
            'deskripsi_atp' => 'Membuat dan menyelesaikan model matematika dari SPLTV dan pertidaksamaan grafis.',
            'urutan' => 2
        ]);

        // 5. Buat TP (Tujuan Pembelajaran)
        $tp11 = DB::table('learning_objectives')->insertGetId([
            'id_atp' => $atp1->id_atp,
            'id_guru' => $idGuru,
            'id_mapel' => $idMapel,
            'kode_tp' => 'TP-1.1.1',
            'deskripsi_tp' => 'Menggeneralisasi sifat-sifat operasi bilangan berpangkat (eksponen)',
            'semester' => 'GANJIL',
            'created_at' => now(),
            'updated_at' => now()
        ]);

        $tp12 = DB::table('learning_objectives')->insertGetId([
            'id_atp' => $atp1->id_atp,
            'id_guru' => $idGuru,
            'id_mapel' => $idMapel,
            'kode_tp' => 'TP-1.1.2',
            'deskripsi_tp' => 'Menggunakan logaritma untuk memecahkan masalah kontekstual',
            'semester' => 'GANJIL',
            'created_at' => now(),
            'updated_at' => now()
        ]);

        $tp21 = DB::table('learning_objectives')->insertGetId([
            'id_atp' => $atp2->id_atp,
            'id_guru' => $idGuru,
            'id_mapel' => $idMapel,
            'kode_tp' => 'TP-2.1.1',
            'deskripsi_tp' => 'Membuat model matematika dari SPLTV kontekstual',
            'semester' => 'GANJIL',
            'created_at' => now(),
            'updated_at' => now()
        ]);

        // Hubungkan TP ke kelas
        foreach ([$tp11, $tp12, $tp21] as $idTp) {
            DB::table('learning_objective_class')->insert([
                'id_kelas' => $idKelas,
                'id_tp' => $idTp
            ]);
        }

        // 6. Buat Bab / Modul Belajar
        $bab1 = Bab::create([
            'id_mapel' => $idMapel,
            'nama_bab' => 'Eksponen dan Logaritma Dasar',
            'urutan' => 1,
            'semester' => 'GANJIL',
            'deskripsi' => 'Mempelajari konsep eksponen dasar, sifat eksponen, penyelesaian logaritma, dan penerapannya.'
        ]);
        $bab1->learningObjectives()->attach([$tp11, $tp12]);

        $bab2 = Bab::create([
            'id_mapel' => $idMapel,
            'nama_bab' => 'Sistem Persamaan Tiga Variabel (SPLTV)',
            'urutan' => 2,
            'semester' => 'GANJIL',
            'deskripsi' => 'Penyusunan model matematika SPLTV dan teknik eliminasi-substitusi.'
        ]);
        $bab2->learningObjectives()->attach([$tp21]);

        // 7. Buat Sub-Materi & Aktivitas Pembelajaran
        $sub1 = SubMateri::create([
            'id_bab' => $bab1->id_bab,
            'judul' => 'Operasi Eksponen & Bilangan Berpangkat',
            'tipe' => 'ARTIKEL',
            'konten' => 'Eksponen dasar: a^n artinya perkalian basis a sebanyak n kali. Sifat-sifat: a^m * a^n = a^(m+n), a^m / a^n = a^(m-n), dll.',
            'urutan' => 1
        ]);

        AktivitasPembelajaran::create([
            'id_sub_materi' => $sub1->id_sub_materi,
            'nama_aktivitas' => 'Diskusi Kelompok: Sifat Eksponen di Kehidupan Nyata',
            'tipe_aktivitas' => 'DISKUSI',
            'deskripsi' => 'Diskusikan penerapan eksponen dalam pembelahan bakteri di wadah makanan.',
            'status_wajib' => true
        ]);

        AktivitasPembelajaran::create([
            'id_sub_materi' => $sub1->id_sub_materi,
            'nama_aktivitas' => 'Tugas Mandiri: Sederhanakan Bentuk Pangkat',
            'tipe_aktivitas' => 'UPLOAD_TUGAS',
            'deskripsi' => 'Kerjakan latihan soal menyederhanakan pecahan berpangkat di kertas dan upload fotonya.',
            'status_wajib' => true
        ]);

        $sub2 = SubMateri::create([
            'id_bab' => $bab1->id_bab,
            'judul' => 'Logaritma Contextual & Skala Richter',
            'tipe' => 'LINK',
            'konten' => 'https://example.com/math/logarithms-seismology',
            'urutan' => 2
        ]);

        AktivitasPembelajaran::create([
            'id_sub_materi' => $sub2->id_sub_materi,
            'nama_aktivitas' => 'Nonton Penerapan Logaritma',
            'tipe_aktivitas' => 'MENONTON',
            'deskripsi' => 'Tonton video logaritma pada pengukuran gempa bumi.',
            'status_wajib' => false
        ]);

        // 8. Buat Rencana Penilaian (Planner)
        RencanaPenilaian::create([
            'id_bab' => $bab1->id_bab,
            'jumlah_formatif' => 3,
            'jumlah_sumatif' => 1
        ]);

        RencanaPenilaian::create([
            'id_bab' => $bab2->id_bab,
            'jumlah_formatif' => 2,
            'jumlah_sumatif' => 1
        ]);

        // 9. Buat Asesmen Formatif (3 untuk Bab 1, 2 untuk Bab 2)
        $asmF1 = Assessment::create([
            'id_bab' => $bab1->id_bab,
            'id_kelas' => $idKelas,
            'id_mapel' => $idMapel,
            'id_guru' => $idGuru,
            'nama_asesmen' => 'Formatif 1: Sifat Eksponen',
            'kategori' => 'FORMATIF',
            'bentuk_asesmen' => 'Tugas',
            'tanggal' => now()->subDays(9)->toDateString(),
            'status' => 'SELESAI',
            'semester' => 'GANJIL'
        ]);
        $asmF1->learningObjectives()->attach([$tp11]);

        $asmF2 = Assessment::create([
            'id_bab' => $bab1->id_bab,
            'id_kelas' => $idKelas,
            'id_mapel' => $idMapel,
            'id_guru' => $idGuru,
            'nama_asesmen' => 'Formatif 2: Kuis Pangkat Pecahan',
            'kategori' => 'FORMATIF',
            'bentuk_asesmen' => 'Quiz',
            'tanggal' => now()->subDays(7)->toDateString(),
            'status' => 'SELESAI',
            'semester' => 'GANJIL'
        ]);
        $asmF2->learningObjectives()->attach([$tp11]);

        $asmF3 = Assessment::create([
            'id_bab' => $bab1->id_bab,
            'id_kelas' => $idKelas,
            'id_mapel' => $idMapel,
            'id_guru' => $idGuru,
            'nama_asesmen' => 'Formatif 3: Kuis Logaritma Dasar',
            'kategori' => 'FORMATIF',
            'bentuk_asesmen' => 'Quiz',
            'tanggal' => now()->subDays(5)->toDateString(),
            'status' => 'SELESAI',
            'semester' => 'GANJIL'
        ]);
        $asmF3->learningObjectives()->attach([$tp12]);

        $asmF4 = Assessment::create([
            'id_bab' => $bab2->id_bab,
            'id_kelas' => $idKelas,
            'id_mapel' => $idMapel,
            'id_guru' => $idGuru,
            'nama_asesmen' => 'Formatif 4: Membuat Model SPLTV',
            'kategori' => 'FORMATIF',
            'bentuk_asesmen' => 'Tugas',
            'tanggal' => now()->subDays(3)->toDateString(),
            'status' => 'SELESAI',
            'semester' => 'GANJIL'
        ]);
        $asmF4->learningObjectives()->attach([$tp21]);

        // 10. Buat Asesmen Sumatif (STS dan SAS)
        $asmSTS = Assessment::create([
            'id_bab' => $bab1->id_bab,
            'id_kelas' => $idKelas,
            'id_mapel' => $idMapel,
            'id_guru' => $idGuru,
            'nama_asesmen' => 'Sumatif Tengah Semester (STS)',
            'kategori' => 'SUMATIF',
            'bentuk_asesmen' => 'STS',
            'tanggal' => now()->subDays(2)->toDateString(),
            'status' => 'SELESAI',
            'semester' => 'GANJIL'
        ]);

        $asmSAS = Assessment::create([
            'id_bab' => $bab1->id_bab,
            'id_kelas' => $idKelas,
            'id_mapel' => $idMapel,
            'id_guru' => $idGuru,
            'nama_asesmen' => 'Sumatif Akhir Semester (SAS)',
            'kategori' => 'SUMATIF',
            'bentuk_asesmen' => 'SAS',
            'tanggal' => now()->subDay()->toDateString(),
            'status' => 'SELESAI',
            'semester' => 'GANJIL'
        ]);

        // 11. Masukkan Skor Siswa yang Beragam (Okto, Chelsea, Bakianto, Estiawan, Patricia)
        $scoreMapping = [
            11 => [90, 85, 88, 92, 85, 88, 'Lulus KKM dengan performa sangat baik'],
            12 => [75, 78, 72, 80, 72, 75, 'Memenuhi KKM secara stabil'],
            13 => [60, 55, 62, 70, 58, 60, 'Perlu perbaikan intensif di materi eksponen & SPLTV'],
            14 => [95, 98, 92, 95, 94, 95, 'Performa istimewa, sangat mahir dalam matematika'],
            15 => [50, 45, 52, 60, 48, 50, 'Butuh bimbingan terstruktur dan remedial materi dasar'],
        ];

        foreach ($scoreMapping as $idSiswa => $scores) {
            // Formatif 1
            StudentAssessmentScore::create([
                'id_assessment' => $asmF1->id_assessment,
                'id_siswa' => $idSiswa,
                'nilai' => $scores[0],
                'catatan' => $scores[0] < 75 ? 'Perlu belajar mandiri' : 'Cukup baik'
            ]);

            // Formatif 2
            StudentAssessmentScore::create([
                'id_assessment' => $asmF2->id_assessment,
                'id_siswa' => $idSiswa,
                'nilai' => $scores[1],
                'catatan' => null
            ]);

            // Formatif 3
            StudentAssessmentScore::create([
                'id_assessment' => $asmF3->id_assessment,
                'id_siswa' => $idSiswa,
                'nilai' => $scores[2],
                'catatan' => null
            ]);

            // Formatif 4
            StudentAssessmentScore::create([
                'id_assessment' => $asmF4->id_assessment,
                'id_siswa' => $idSiswa,
                'nilai' => $scores[3],
                'catatan' => null
            ]);

            // STS Sumatif
            StudentAssessmentScore::create([
                'id_assessment' => $asmSTS->id_assessment,
                'id_siswa' => $idSiswa,
                'nilai' => $scores[4],
                'catatan' => 'Asesmen Tengah Semester'
            ]);

            // SAS Sumatif
            StudentAssessmentScore::create([
                'id_assessment' => $asmSAS->id_assessment,
                'id_siswa' => $idSiswa,
                'nilai' => $scores[5],
                'catatan' => 'Asesmen Akhir Semester'
            ]);

            // Buat ReportCard resmi untuk menyimpan Deskripsi Capaian Kompetensi
            DB::table('report_cards')->updateOrInsert(
                [
                    'id_siswa' => $idSiswa,
                    'id_class_subject' => $idClassSubject
                ],
                [
                    'nilai_sas' => $scores[5],
                    'nilai_akhir' => round(($scores[0]+$scores[1]+$scores[2]+$scores[3])/4 * 0.6 + $scores[4]*0.15 + $scores[5]*0.25),
                    'deskripsi_capaian' => $scores[6]
                ]
            );
        }
    }
}
