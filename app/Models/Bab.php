<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bab extends Model
{
    use HasFactory;

    protected $table = 'babs';
    protected $primaryKey = 'id_bab';
    protected $guarded = [];

    public function subject()
    {
        return $this->belongsTo(Subject::class, 'id_mapel', 'id_mapel');
    }

    public function learningObjectives()
    {
        return $this->belongsToMany(LearningObjective::class, 'bab_tp', 'id_bab', 'id_tp');
    }

    public function subMateris()
    {
        return $this->hasMany(SubMateri::class, 'id_bab', 'id_bab')->orderBy('urutan');
    }

    public function rencanaPenilaians()
    {
        return $this->hasMany(RencanaPenilaian::class, 'id_bab', 'id_bab');
    }

    public function assessments()
    {
        return $this->hasMany(Assessment::class, 'id_bab', 'id_bab');
    }
}
