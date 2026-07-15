<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StudentAssessmentScore extends Model
{
    use HasFactory;

    protected $table = 'student_assessment_scores';
    protected $guarded = [];

    public function assessment()
    {
        return $this->belongsTo(Assessment::class, 'id_assessment', 'id_assessment');
    }

    public function student()
    {
        return $this->belongsTo(Student::class, 'id_siswa', 'id_siswa');
    }
}
