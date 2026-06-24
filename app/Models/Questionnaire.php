<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Questionnaire extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_questionnaire';
    protected $fillable = ['judul', 'deskripsi', 'tipe', 'is_active'];

    public function questions()
    {
        return $this->hasMany(QuestionnaireQuestion::class, 'id_questionnaire', 'id_questionnaire');
    }

    public function responses()
    {
        return $this->hasMany(QuestionnaireResponse::class, 'id_questionnaire', 'id_questionnaire');
    }
}
