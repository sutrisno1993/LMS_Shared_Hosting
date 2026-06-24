<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class QuestionnaireQuestion extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_q_question';
    protected $fillable = ['id_questionnaire', 'pertanyaan'];

    public function questionnaire()
    {
        return $this->belongsTo(Questionnaire::class, 'id_questionnaire', 'id_questionnaire');
    }
}
