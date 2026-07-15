<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Clas extends Model
{
    protected $table = 'classes';
    protected $primaryKey = 'id_kelas';
    protected $fillable = ['nama_kelas', 'shift_operasional', 'tingkat', 'jurusan', 'id_guru_wali', 'cctv_type', 'cctv_url', 'cctv_verification_code'];

    public function waliKelas()
    {
        return $this->belongsTo(Teacher::class, 'id_guru_wali', 'id_guru');
    }

    public function students()
    {
        return $this->hasMany(Student::class, 'id_kelas', 'id_kelas');
    }

    // Alias agar bisa dipanggil dengan ->siswa juga
    public function siswa()
    {
        return $this->hasMany(Student::class, 'id_kelas', 'id_kelas');
    }
}

