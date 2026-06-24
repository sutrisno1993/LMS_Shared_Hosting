<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class QuestionnaireResponse extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_response';
    protected $fillable = ['id_questionnaire', 'id_siswa', 'id_guru_target', 'id_q_question', 'rating_score', 'komentar'];

    public function questionnaire()
    {
        return $this->belongsTo(Questionnaire::class, 'id_questionnaire', 'id_questionnaire');
    }

    public function student()
    {
        return $this->belongsTo(Student::class, 'id_siswa', 'id_siswa');
    }

    public function targetTeacher()
    {
        return $this->belongsTo(Teacher::class, 'id_guru_target', 'id_guru');
    }

    public function question()
    {
        return $this->belongsTo(QuestionnaireQuestion::class, 'id_q_question', 'id_q_question');
    }
}
