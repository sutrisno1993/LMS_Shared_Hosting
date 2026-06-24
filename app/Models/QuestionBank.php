<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class QuestionBank extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_bank';
    protected $fillable = ['id_guru', 'id_mapel', 'judul', 'deskripsi'];

    public function teacher()
    {
        return $this->belongsTo(Teacher::class, 'id_guru', 'id_guru');
    }

    public function subject()
    {
        return $this->belongsTo(Subject::class, 'id_mapel', 'id_mapel');
    }

    public function questions()
    {
        return $this->hasMany(Question::class, 'id_bank', 'id_bank');
    }
}
