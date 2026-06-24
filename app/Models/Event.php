<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    use HasFactory;

    protected $fillable = [
        'nama_event',
        'tanggal',
        'target_shift',
        'jam_ke',
        'target_kelas',
    ];

    protected $casts = [
        'tanggal' => 'date',
        'jam_ke' => 'array',
        'target_kelas' => 'array',
    ];
}
