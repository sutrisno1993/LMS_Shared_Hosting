<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Teacher;
use App\Models\Clas;
use App\Models\Subject;
use App\Models\TeacherSubject;
use App\Models\ClassSubject;
use App\Models\Timetable;

class TimetableSyncController extends Controller
{
    public function syncAll(Request $request)
    {
        // 1. Validasi Token Bearer
        $token = $request->bearerToken();
        if ($token !== config('services.sitab.key')) {
            return response()->json(['message' => 'Unauthorized Access - Invalid Token'], 401);
        }

        $data = $request->all();

        try {
            DB::transaction(function () use ($data) {
                
                // --- A. SYNC GURU ---
                $activeTeacherIds = [];
                if (isset($data['teachers'])) {
                    foreach ($data['teachers'] as $t) {
                        $teacher = Teacher::updateOrCreate(
                            ['kode_guru' => $t['kode_guru']],
                            [
                                'nama_guru'           => $t['nama_guru'],
                                'hari_tersedia'       => $t['hari_tersedia'],
                                'shift_pagi'          => $t['shift_pagi'],
                                'shift_siang'         => $t['shift_siang'],
                                'hari_tersedia_pagi'  => $t['hari_tersedia_pagi'] ?? null,
                                'hari_tersedia_siang' => $t['hari_tersedia_siang'] ?? null,
                                'min_jp'              => $t['min_jp'] ?? 2,
                                'max_jp'              => $t['max_jp'] ?? 60,
                                'allowed_jp_pagi'     => $t['allowed_jp_pagi'] ?? null,
                                'allowed_jp_siang'    => $t['allowed_jp_siang'] ?? null,
                                'no_wa'               => $t['no_wa'] ?? null
                            ]
                        );
                        $activeTeacherIds[] = $teacher->id_guru;
                    }
                }

                // --- B. SYNC KELAS ---
                $activeClassIds = [];
                if (isset($data['classes'])) {
                    foreach ($data['classes'] as $c) {
                        $class = Clas::updateOrCreate(
                            ['nama_kelas' => $c['nama_kelas']],
                            [
                                'shift_operasional' => $c['shift_operasional'],
                                'tingkat'           => $c['tingkat'] ?? null,
                                'jurusan'           => $c['jurusan'] ?? null
                            ]
                        );
                        $activeClassIds[] = $class->id_kelas;
                    }
                }

                // --- C. SYNC MAPEL ---
                $activeSubjectIds = [];
                if (isset($data['subjects'])) {
                    foreach ($data['subjects'] as $s) {
                        $subject = Subject::updateOrCreate(
                            ['nama_mapel' => $s['nama_mapel']],
                            [
                                'kategori_mapel' => $s['kategori_mapel'],
                                'tingkat'        => $s['tingkat'] ?? null,
                                'jurusan'        => $s['jurusan'] ?? null
                            ]
                        );
                        $activeSubjectIds[] = $subject->id_mapel;
                    }
                }

                // --- D. SYNC PENUGASAN GURU (TEACHER SUBJECTS) ---
                $activeTeacherSubjectIds = [];
                if (isset($data['teacher_subjects'])) {
                    foreach ($data['teacher_subjects'] as $ts) {
                        $tModel = Teacher::where('kode_guru', $ts['kode_guru'])->first();
                        $sModel = Subject::where('nama_mapel', $ts['nama_mapel'])->first();

                        if ($tModel && $sModel) {
                            $pivot = TeacherSubject::updateOrCreate(
                                [
                                    'id_guru'  => $tModel->id_guru,
                                    'id_mapel' => $sModel->id_mapel
                                ]
                            );
                            $activeTeacherSubjectIds[] = $pivot->id_teacher_subject;
                        }
                    }
                }

                // --- E. SYNC ALOKASI KURIKULUM (CLASS SUBJECTS) ---
                $activeClassSubjectIds = [];
                if (isset($data['class_subjects'])) {
                    foreach ($data['class_subjects'] as $cs) {
                        $cModel = Clas::where('nama_kelas', $cs['nama_kelas'])->first();
                        $sModel = Subject::where('nama_mapel', $cs['nama_mapel'])->first();

                        if ($cModel && $sModel) {
                            $gMutlakModel = null;
                            if (isset($cs['kode_guru_mutlak']) && $cs['kode_guru_mutlak']) {
                                $gMutlakModel = Teacher::where('kode_guru', $cs['kode_guru_mutlak'])->first();
                            }

                            $allocation = ClassSubject::updateOrCreate(
                                [
                                    'id_kelas' => $cModel->id_kelas,
                                    'id_mapel' => $sModel->id_mapel
                                ],
                                [
                                    'durasi_jp'       => $cs['durasi_jp'],
                                    'id_guru_mutlak'  => $gMutlakModel ? $gMutlakModel->id_guru : null
                                ]
                            );
                            $activeClassSubjectIds[] = $allocation->id_class_subject;
                        }
                    }
                }

                // --- F. PURGE JADWAL LAMA (TIMETABLE) & PIVOT LAIN ---
                Timetable::query()->delete();

                ClassSubject::whereNotIn('id_class_subject', $activeClassSubjectIds)->delete();
                TeacherSubject::whereNotIn('id_teacher_subject', $activeTeacherSubjectIds)->delete();
                Subject::whereNotIn('id_mapel', $activeSubjectIds)->delete();
                Clas::whereNotIn('id_kelas', $activeClassIds)->delete();
                Teacher::whereNotIn('id_guru', $activeTeacherIds)->delete();

                // --- G. SYNC JADWAL BARU (TIMETABLE) ---
                if (isset($data['timetable'])) {
                    foreach ($data['timetable'] as $slot) {
                        $cModel = Clas::where('nama_kelas', $slot['nama_kelas'])->first();
                        $sModel = Subject::where('nama_mapel', $slot['nama_mapel'])->first();

                        if ($cModel && $sModel) {
                            $csModel = ClassSubject::where([
                                'id_kelas' => $cModel->id_kelas,
                                'id_mapel' => $sModel->id_mapel
                            ])->first();

                            if ($csModel) {
                                $gModel = null;
                                if (isset($slot['kode_guru']) && $slot['kode_guru']) {
                                    $gModel = Teacher::where('kode_guru', $slot['kode_guru'])->first();
                                }

                                $gOrigModel = null;
                                if (isset($slot['original_guru_kode']) && $slot['original_guru_kode']) {
                                    $gOrigModel = Teacher::where('kode_guru', $slot['original_guru_kode'])->first();
                                }

                                Timetable::create([
                                    'id_class_subject' => $csModel->id_class_subject,
                                    'hari'             => $slot['hari'],
                                    'jam_ke'           => $slot['jam_ke'],
                                    'id_guru'          => $gModel ? $gModel->id_guru : null,
                                    'is_fallback'      => $slot['is_fallback'] ?? false,
                                    'original_guru_id' => $gOrigModel ? $gOrigModel->id_guru : null,
                                ]);
                            }
                        }
                    }
                }
            });

            return response()->json([
                'status'  => 'SUCCESS',
                'message' => 'Seluruh data master dan jadwal berhasil disinkronisasi ke LMS Laravel!'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'status'  => 'ERROR',
                'message' => 'Gagal melakukan sinkronisasi database LMS: ' . $e->getMessage()
            ], 500);
        }
    }
}
