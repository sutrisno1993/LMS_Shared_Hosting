<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

try {
    $t = \App\Models\Teacher::first();
    $t->piket_pagi = [];
    $t->save();
    echo "Saved empty array successfully.\n";
    
    $t->piket_pagi = ['SENIN', 'SELASA'];
    $t->save();
    echo "Saved array successfully.\n";
} catch (\Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
