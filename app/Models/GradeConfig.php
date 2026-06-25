<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GradeConfig extends Model
{
    use HasFactory;

    protected $fillable = ['bobot_formatif', 'bobot_sumatif', 'bobot_absensi'];
}
