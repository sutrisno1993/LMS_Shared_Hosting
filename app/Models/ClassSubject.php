<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ClassSubject extends Model
{
    protected $table = 'class_subjects';
    protected $primaryKey = 'id_class_subject';
    protected $fillable = ['id_kelas', 'id_mapel', 'durasi_jp', 'id_guru_mutlak'];

    public function clas() {
        return $this->belongsTo(Clas::class, 'id_kelas');
    }
    public function subject() {
        return $this->belongsTo(Subject::class, 'id_mapel');
    }
    public function guruMutlak() {
        return $this->belongsTo(Teacher::class, 'id_guru_mutlak');
    }
}
