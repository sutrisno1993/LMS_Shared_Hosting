<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JpSchedule extends Model
{
    use HasFactory;

    protected $table = 'jp_schedules';

    protected $fillable = [
        'shift',
        'hari',
        'jam_ke',
        'waktu_mulai',
        'waktu_selesai',
        'is_kbm',
        'keterangan',
    ];

    protected $casts = [
        'is_kbm' => 'boolean',
    ];
}
