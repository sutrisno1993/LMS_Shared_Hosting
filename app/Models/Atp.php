<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Atp extends Model
{
    use HasFactory;

    protected $table = 'atps';
    protected $primaryKey = 'id_atp';
    protected $guarded = [];

    public function learningElement()
    {
        return $this->belongsTo(LearningElement::class, 'id_element', 'id_element');
    }

    public function learningObjectives()
    {
        return $this->hasMany(LearningObjective::class, 'id_atp', 'id_atp');
    }
}
