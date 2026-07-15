<?php

namespace App\Services;

use App\Models\Assessment;
use App\Models\Student;
use App\Models\StudentAssessmentScore;
use App\Models\StudentAttendance;
use App\Models\KbmSession;
use App\Models\SchoolGradingConfig;
use App\Models\Subject;
use App\Models\LearningObjective;

class GradingService
{
    /**
     * Menghitung nilai rapor tengah semester (pasca-STS) untuk kelas dan mapel tertentu.
     */
    public function calculateMidSemesterGrades($idKelas, $idMapel)
    {
        $config = SchoolGradingConfig::where('tipe_rapor', 'TENGAH_SEMESTER')
            ->where('is_active', true)
            ->first() ?? new SchoolGradingConfig([
                'bobot_absensi' => 10,
                'bobot_formatif' => 60,
                'bobot_sts' => 30,
                'bobot_sas' => 0
            ]);

        $students = Student::where('id_kelas', $idKelas)->orderBy('nama_siswa')->get();
        
        // Total sesi KBM selesai untuk absensi
        $totalSessions = KbmSession::where('id_kelas', $idKelas)
            ->where('id_mapel', $idMapel)
            ->where('status_sesi', 'SELESAI')
            ->count();

        // Cari asesmen STS untuk mapel & kelas ini
        $stsAssessment = Assessment::where('id_kelas', $idKelas)
            ->where('id_mapel', $idMapel)
            ->where('kategori', 'SUMATIF')
            ->where(function($q) {
                $q->where('bentuk_asesmen', 'STS')
                  ->orWhere('bentuk_asesmen', 'Sumatif Tengah Semester');
            })
            ->where('status', 'SELESAI')
            ->first();

        // Cari semua asesmen formatif selesai untuk mapel & kelas ini
        $formativeAssessments = Assessment::where('id_kelas', $idKelas)
            ->where('id_mapel', $idMapel)
            ->where('kategori', 'FORMATIF')
            ->where('status', 'SELESAI')
            ->get();

        $result = [];

        foreach ($students as $student) {
            // 1. Absensi
            $presentSessions = StudentAttendance::where('id_siswa', $student->id_siswa)
                ->where('status', 'HADIR')
                ->whereHas('kbmSession', function ($q) use ($idKelas, $idMapel) {
                    $q->where('id_kelas', $idKelas)
                      ->where('id_mapel', $idMapel)
                      ->where('status_sesi', 'SELESAI');
                })
                ->count();
            $nilaiAbsensi = $totalSessions > 0 ? round(($presentSessions / $totalSessions) * 100, 1) : 100.0;

            // 2. Formatif (Rata-rata)
            $formativeScores = StudentAssessmentScore::whereIn('id_assessment', $formativeAssessments->pluck('id_assessment'))
                ->where('id_siswa', $student->id_siswa)
                ->whereNotNull('nilai')
                ->pluck('nilai');
            $nilaiFormatif = $formativeScores->count() > 0 ? round($formativeScores->average(), 1) : null;

            // 3. STS
            $nilaiSts = null;
            if ($stsAssessment) {
                $scoreRecord = StudentAssessmentScore::where('id_assessment', $stsAssessment->id_assessment)
                    ->where('id_siswa', $student->id_siswa)
                    ->first();
                $nilaiSts = $scoreRecord ? $scoreRecord->nilai : null;
            }

            // 4. Kalkulasi Nilai Rapor (NR)
            // NR = (Formatif * BobotF + STS * BobotSTS + Absensi * BobotAbs) / Total Bobot
            $totalBobot = 0;
            $weightedSum = 0;

            if ($nilaiFormatif !== null) {
                $weightedSum += $nilaiFormatif * $config->bobot_formatif;
                $totalBobot += $config->bobot_formatif;
            }
            if ($nilaiSts !== null) {
                $weightedSum += $nilaiSts * $config->bobot_sts;
                $totalBobot += $config->bobot_sts;
            }
            if ($nilaiAbsensi !== null && $config->bobot_absensi > 0) {
                $weightedSum += $nilaiAbsensi * $config->bobot_absensi;
                $totalBobot += $config->bobot_absensi;
            }

            $nilaiRapor = $totalBobot > 0 ? round($weightedSum / $totalBobot) : 0;

            $result[] = [
                'id_siswa' => $student->id_siswa,
                'nama' => $student->nama_siswa,
                'nis' => $student->nis,
                'absensi' => $nilaiAbsensi,
                'formatif' => $nilaiFormatif,
                'sts' => $nilaiSts,
                'nilai_rapor' => $nilaiRapor,
            ];
        }

        return [
            'students' => $result,
            'config' => $config
        ];
    }

    /**
     * Menghitung nilai rapor akhir semester (pasca-SAS) untuk kelas dan mapel tertentu.
     */
    public function calculateEndSemesterGrades($idKelas, $idMapel)
    {
        $config = SchoolGradingConfig::where('tipe_rapor', 'AKHIR_SEMESTER')
            ->where('is_active', true)
            ->first() ?? new SchoolGradingConfig([
                'bobot_absensi' => 0,
                'bobot_formatif' => 60,
                'bobot_sts' => 15,
                'bobot_sas' => 25
            ]);

        $students = Student::where('id_kelas', $idKelas)->orderBy('nama_siswa')->get();

        // Cari asesmen STS & SAS selesai
        $stsAssessment = Assessment::where('id_kelas', $idKelas)
            ->where('id_mapel', $idMapel)
            ->where('kategori', 'SUMATIF')
            ->where(function($q) {
                $q->where('bentuk_asesmen', 'STS')
                  ->orWhere('bentuk_asesmen', 'Sumatif Tengah Semester');
            })
            ->where('status', 'SELESAI')
            ->first();

        $sasAssessment = Assessment::where('id_kelas', $idKelas)
            ->where('id_mapel', $idMapel)
            ->where('kategori', 'SUMATIF')
            ->where(function($q) {
                $q->where('bentuk_asesmen', 'SAS')
                  ->orWhere('bentuk_asesmen', 'Sumatif Akhir Semester');
            })
            ->where('status', 'SELESAI')
            ->first();

        // Cari semua asesmen formatif selesai untuk mapel & kelas ini
        $formativeAssessments = Assessment::where('id_kelas', $idKelas)
            ->where('id_mapel', $idMapel)
            ->where('kategori', 'FORMATIF')
            ->where('status', 'SELESAI')
            ->get();

        $result = [];

        foreach ($students as $student) {
            // 1. Formatif (Rata-rata)
            $formativeScores = StudentAssessmentScore::whereIn('id_assessment', $formativeAssessments->pluck('id_assessment'))
                ->where('id_siswa', $student->id_siswa)
                ->whereNotNull('nilai')
                ->pluck('nilai');
            $nilaiFormatif = $formativeScores->count() > 0 ? round($formativeScores->average(), 1) : null;

            // 2. STS
            $nilaiSts = null;
            if ($stsAssessment) {
                $scoreRecord = StudentAssessmentScore::where('id_assessment', $stsAssessment->id_assessment)
                    ->where('id_siswa', $student->id_siswa)
                    ->first();
                $nilaiSts = $scoreRecord ? $scoreRecord->nilai : null;
            }

            // 3. SAS
            $nilaiSas = null;
            if ($sasAssessment) {
                $scoreRecord = StudentAssessmentScore::where('id_assessment', $sasAssessment->id_assessment)
                    ->where('id_siswa', $student->id_siswa)
                    ->first();
                $nilaiSas = $scoreRecord ? $scoreRecord->nilai : null;
            }

            // 4. Kalkulasi Nilai Rapor (NR)
            // NR = (Formatif * BobotF + STS * BobotSTS + SAS * BobotSAS) / Total Bobot
            $totalBobot = 0;
            $weightedSum = 0;

            if ($nilaiFormatif !== null) {
                $weightedSum += $nilaiFormatif * $config->bobot_formatif;
                $totalBobot += $config->bobot_formatif;
            }
            if ($nilaiSts !== null) {
                $weightedSum += $nilaiSts * $config->bobot_sts;
                $totalBobot += $config->bobot_sts;
            }
            if ($nilaiSas !== null) {
                $weightedSum += $nilaiSas * $config->bobot_sas;
                $totalBobot += $config->bobot_sas;
            }

            $nilaiRapor = $totalBobot > 0 ? round($weightedSum / $totalBobot) : 0;

            $result[] = [
                'id_siswa' => $student->id_siswa,
                'nama' => $student->nama_siswa,
                'nis' => $student->nis,
                'formatif' => $nilaiFormatif,
                'sts' => $nilaiSts,
                'sas' => $nilaiSas,
                'nilai_rapor' => $nilaiRapor,
            ];
        }

        return [
            'students' => $result,
            'config' => $config
        ];
    }

    /**
     * Menghitung progress ketercapaian Tujuan Pembelajaran (TP) untuk siswa pada mapel tertentu.
     */
    public function calculateStudentTpProgress($idSiswa, $idMapel)
    {
        $subject = Subject::findOrFail($idMapel);
        $kkm = $subject->kkm ?? 75;

        // Ambil semua TP untuk mapel ini (melalui ATP)
        $tps = LearningObjective::whereHas('atp', function ($q) use ($idMapel) {
            $q->where('id_mapel', $idMapel);
        })->get();

        if ($tps->isEmpty()) {
            return [
                'progress_percent' => 0,
                'tps' => []
            ];
        }

        $totalTps = $tps->count();
        $achievedCount = 0;
        $tpResults = [];

        foreach ($tps as $tp) {
            // Cari semua asesmen selesai yang mengukur TP ini
            $assessments = $tp->assessments()
                ->where('id_mapel', $idMapel)
                ->where('status', 'SELESAI')
                ->get();

            if ($assessments->isEmpty()) {
                $status = 'BELUM_DIMULAI';
                $rataNilai = null;
            } else {
                $scores = StudentAssessmentScore::whereIn('id_assessment', $assessments->pluck('id_assessment'))
                    ->where('id_siswa', $idSiswa)
                    ->whereNotNull('nilai')
                    ->pluck('nilai');

                if ($scores->isEmpty()) {
                    $status = 'BELUM_DIMULAI';
                    $rataNilai = null;
                } else {
                    $rataNilai = round($scores->average(), 1);
                    if ($rataNilai >= $kkm) {
                        $status = 'TERCAPAI';
                        $achievedCount++;
                    } else {
                        $status = 'SEDANG_DIPELAJARI';
                    }
                }
            }

            $tpResults[] = [
                'id_tp' => $tp->id_tp,
                'kode_tp' => $tp->kode_tp,
                'deskripsi_tp' => $tp->deskripsi_tp,
                'status' => $status,
                'rata_nilai' => $rataNilai,
            ];
        }

        $progressPercent = round(($achievedCount / $totalTps) * 100);

        return [
            'progress_percent' => $progressPercent,
            'kkm' => $kkm,
            'total_tps' => $totalTps,
            'achieved_tps' => $achievedCount,
            'tps' => $tpResults
        ];
    }
}
