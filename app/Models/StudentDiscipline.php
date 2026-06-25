<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StudentDiscipline extends Model
{
    use HasFactory;

    protected $table = 'student_disciplines';

    protected $fillable = [
        'id_siswa',
        'kategori_kasus',
        'kasus_detail',
        'tipe_tindakan',
        'tanggal_tindakan',
        'keterangan',
        'tindakan_lanjut',
        'foto_bukti'
    ];

    public function student()
    {
        return $this->belongsTo(Student::class, 'id_siswa', 'id_siswa');
    }
}
