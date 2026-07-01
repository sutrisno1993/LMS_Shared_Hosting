<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Question extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_question';
    protected $fillable = [
        'id_bank', 'pertanyaan', 'gambar_pertanyaan', 
        'opsi_a', 'gambar_opsi_a', 
        'opsi_b', 'gambar_opsi_b', 
        'opsi_c', 'gambar_opsi_c', 
        'opsi_d', 'gambar_opsi_d', 
        'opsi_e', 'gambar_opsi_e', 
        'jawaban_benar', 'pembahasan'
    ];

    public function questionBank()
    {
        return $this->belongsTo(QuestionBank::class, 'id_bank', 'id_bank');
    }
}
