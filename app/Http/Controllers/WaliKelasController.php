<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Auth;

class WaliKelasController extends Controller
{
    public function dashboard()
    {
        return Inertia::render('WaliKelas/Dashboard');
    }

    public function p5Assessment()
    {
        return Inertia::render('WaliKelas/P5Assessment');
    }
}
