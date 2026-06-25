<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Teacher;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class LinkGuruCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:link-guru';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Link all existing teachers to a user account';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $teachers = Teacher::all();
        $count = 0;

        foreach ($teachers as $teacher) {
            if ($teacher->no_wa) {
                $email = $teacher->no_wa . '@guru.lms.com';
                $user = User::firstOrCreate(
                    ['id_guru' => $teacher->id_guru],
                    [
                        'name' => $teacher->nama_guru,
                        'email' => $email,
                        'password' => Hash::make('password123'),
                        'role' => 'TEACHER',
                    ]
                );
                
                if ($user->wasRecentlyCreated) {
                    $this->info("Linked guru: {$teacher->nama_guru} ({$teacher->no_wa})");
                    $count++;
                }
            }
        }

        $this->info("Successfully linked {$count} new gurus.");
    }
}
