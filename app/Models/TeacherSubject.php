<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TeacherSubject extends Model
{
    protected $table = 'teacher_subjects';
    protected $primaryKey = 'id_teacher_subject';
    protected $fillable = ['id_guru', 'id_mapel'];

    public function teacher() {
        return $this->belongsTo(Teacher::class, 'id_guru');
    }
    public function subject() {
        return $this->belongsTo(Subject::class, 'id_mapel');
    }
}
