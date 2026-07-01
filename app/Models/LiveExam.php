<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LiveExam extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_exam';
    protected $fillable = [
        'id_kbm_session', 'id_bank', 'status',
        'durasi', 'limit_soal', 'acak_soal', 'tujuan',
        'id_tp', 'id_topic', 'started_at'
    ];

    protected $casts = [
        'acak_soal'  => 'boolean',
        'started_at' => 'datetime',
    ];

    public function kbmSession()
    {
        return $this->belongsTo(KbmSession::class, 'id_kbm_session', 'id');
    }

    public function questionBank()
    {
        return $this->belongsTo(QuestionBank::class, 'id_bank', 'id_bank');
    }

    public function studentAnswers()
    {
        return $this->hasMany(StudentAnswer::class, 'id_exam', 'id_exam');
    }

    public function learningObjective()
    {
        return $this->belongsTo(LearningObjective::class, 'id_tp', 'id_tp');
    }

    public function learningTopic()
    {
        return $this->belongsTo(LearningTopic::class, 'id_topic', 'id_topic');
    }
}
