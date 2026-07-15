<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubMateri extends Model
{
    use HasFactory;

    protected $table = 'sub_materis';
    protected $primaryKey = 'id_sub_materi';
    protected $guarded = [];

    public function bab()
    {
        return $this->belongsTo(Bab::class, 'id_bab', 'id_bab');
    }

    public function aktivitasPembelajarans()
    {
        return $this->hasMany(AktivitasPembelajaran::class, 'id_sub_materi', 'id_sub_materi');
    }
}
