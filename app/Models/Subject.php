<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Subject extends Model
{
    protected $primaryKey = 'id_mapel';
    protected $fillable = ['nama_mapel', 'kategori_mapel', 'tingkat', 'jurusan'];
}
