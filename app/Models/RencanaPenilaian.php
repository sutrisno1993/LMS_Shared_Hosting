<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RencanaPenilaian extends Model
{
    use HasFactory;

    protected $table = 'rencana_penilaians';
    protected $primaryKey = 'id_rencana';
    protected $guarded = [];

    public function bab()
    {
        return $this->belongsTo(Bab::class, 'id_bab', 'id_bab');
    }

    public function assessments()
    {
        return $this->hasMany(Assessment::class, 'id_rencana', 'id_rencana');
    }
}
