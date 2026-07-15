<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Assessment extends Model
{
    use HasFactory;

    protected $table = 'assessments';
    protected $primaryKey = 'id_assessment';
    protected $guarded = [];

    public function rencanaPenilaian()
    {
        return $this->belongsTo(RencanaPenilaian::class, 'id_rencana', 'id_rencana');
    }

    public function bab()
    {
        return $this->belongsTo(Bab::class, 'id_bab', 'id_bab');
    }

    public function clas()
    {
        return $this->belongsTo(Clas::class, 'id_kelas', 'id_kelas');
    }

    public function subject()
    {
        return $this->belongsTo(Subject::class, 'id_mapel', 'id_mapel');
    }

    public function teacher()
    {
        return $this->belongsTo(Teacher::class, 'id_guru', 'id_guru');
    }

    public function learningObjectives()
    {
        return $this->belongsToMany(LearningObjective::class, 'assessment_tp', 'id_assessment', 'id_tp');
    }

    public function scores()
    {
        return $this->hasMany(StudentAssessmentScore::class, 'id_assessment', 'id_assessment');
    }
}
