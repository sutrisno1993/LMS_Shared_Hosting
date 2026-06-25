<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TeacherAttendance extends Model
{
    use HasFactory;

    protected $table = 'teacher_attendances';

    protected $fillable = [
        'tanggal',
        'id_guru',
        'shift',
        'waktu_datang',
        'status',
        'keterangan_jam',
    ];

    /**
     * Get the teacher that owns the attendance.
     */
    public function teacher()
    {
        return $this->belongsTo(Teacher::class, 'id_guru', 'id_guru');
    }
}
