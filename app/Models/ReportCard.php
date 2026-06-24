<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ReportCard extends Model
{
    use HasFactory;

    protected $table = 'report_cards';
    protected $primaryKey = 'id_rapor';

    protected $guarded = [];

    public function student()
    {
        return $this->belongsTo(Student::class, 'id_siswa', 'id_siswa');
    }

    public function classSubject()
    {
        return $this->belongsTo(ClassSubject::class, 'id_class_subject', 'id_class_subject');
    }
}
