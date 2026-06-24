<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Clas extends Model
{
    protected $table = 'classes';
    protected $primaryKey = 'id_kelas';
    protected $fillable = ['nama_kelas', 'shift_operasional', 'tingkat', 'jurusan', 'id_guru_wali'];

    public function waliKelas()
    {
        return $this->belongsTo(Teacher::class, 'id_guru_wali', 'id_guru');
    }
}
