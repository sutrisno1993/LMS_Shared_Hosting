<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$teacher = DB::table('teachers')->where('nama_guru', 'LIKE', '%Astri Wulandari%')->first();
if ($teacher) {
    $kelas = DB::table('classes')->where('id_guru_wali', $teacher->id_guru)->first();
    if ($kelas) {
        echo 'YA|' . $kelas->nama_kelas;
    } else {
        echo 'TIDAK';
    }
} else {
    echo 'TIDAK_DITEMUKAN';
}
echo PHP_EOL;
