<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Teacher extends Model
{
    protected $primaryKey = 'id_guru';
    protected $fillable = [
        'nama_guru', 'kode_guru', 'hari_tersedia', 
        'shift_pagi', 'shift_siang', 'hari_tersedia_pagi', 
        'hari_tersedia_siang', 'min_jp', 'max_jp', 
        'allowed_jp_pagi', 'allowed_jp_siang', 'no_wa',
        'piket_pagi', 'piket_siang'
    ];

    protected $casts = [
        'hari_tersedia' => 'array',
        'hari_tersedia_pagi' => 'array',
        'hari_tersedia_siang' => 'array',
        'allowed_jp_pagi' => 'array',
        'allowed_jp_siang' => 'array',
        'shift_pagi' => 'boolean',
        'shift_siang' => 'boolean',
        'min_jp' => 'integer',
        'max_jp' => 'integer',
        'piket_pagi' => 'array',
        'piket_siang' => 'array',
    ];

    protected static function booted()
    {
        static::created(function ($teacher) {
            if ($teacher->no_wa) {
                $email = $teacher->no_wa . '@guru.lms.com';
                \App\Models\User::firstOrCreate(
                    ['id_guru' => $teacher->id_guru],
                    [
                        'name' => $teacher->nama_guru,
                        'email' => $email,
                        'password' => \Illuminate\Support\Facades\Hash::make('password123'),
                        'role' => 'TEACHER',
                    ]
                );
            }
        });
    }

    public function teacherSubjects()
    {
        return $this->hasMany(TeacherSubject::class, 'id_guru');
    }
}
