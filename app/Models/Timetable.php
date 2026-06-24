<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Timetable extends Model
{
    protected $table = 'timetable';
    protected $primaryKey = 'id_timetable';
    protected $fillable = ['id_class_subject', 'hari', 'jam_ke', 'id_guru', 'is_fallback', 'original_guru_id'];

    protected $casts = [
        'is_fallback' => 'boolean',
        'jam_ke' => 'integer',
    ];

    public function classSubject() {
        return $this->belongsTo(ClassSubject::class, 'id_class_subject');
    }
    public function teacher() {
        return $this->belongsTo(Teacher::class, 'id_guru');
    }
    public function originalTeacher() {
        return $this->belongsTo(Teacher::class, 'original_guru_id');
    }

}
