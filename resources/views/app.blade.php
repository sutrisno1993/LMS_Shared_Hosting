<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title inertia>{{ config('app.name', 'LMS SMK 11 Maret') }}</title>

        <!-- SEO -->
        <meta name="description" content="Learning Management System SMK 11 Maret — Monitoring KBM Real-Time, Presensi QR, Penilaian Kurikulum Merdeka.">
        <meta name="theme-color" content="#0B0F1A">

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

        <!-- Inertia Head -->
        @inertiaHead

        <!-- Vite Assets -->
        @vite(['resources/css/app.css', 'resources/js/app.js'])
    </head>
    <body class="antialiased">
        @inertia
    </body>
</html>
