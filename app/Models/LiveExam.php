<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LiveExam extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_exam';
    protected $fillable = ['id_kbm_session', 'id_bank', 'status'];

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
}
