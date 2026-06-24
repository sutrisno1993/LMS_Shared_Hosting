<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StudentAnswer extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_answer';
    protected $fillable = ['id_exam', 'id_siswa', 'id_question', 'jawaban_siswa', 'is_correct'];

    public function liveExam()
    {
        return $this->belongsTo(LiveExam::class, 'id_exam', 'id_exam');
    }

    public function student()
    {
        return $this->belongsTo(Student::class, 'id_siswa', 'id_siswa');
    }

    public function question()
    {
        return $this->belongsTo(Question::class, 'id_question', 'id_question');
    }
}
