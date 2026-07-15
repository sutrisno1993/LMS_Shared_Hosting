<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AktivitasPembelajaran extends Model
{
    use HasFactory;

    protected $table = 'aktivitas_pembelajarans';
    protected $primaryKey = 'id_aktivitas';
    protected $guarded = [];

    public function subMateri()
    {
        return $this->belongsTo(SubMateri::class, 'id_sub_materi', 'id_sub_materi');
    }
}
