<template>
  <Head title="Selamat Datang" />

  <div class="min-h-screen flex items-center justify-center relative overflow-hidden"
       style="background: linear-gradient(135deg, #0F0C29 0%, #302B63 50%, #24243e 100%)">

    <!-- Animated background orbs -->
    <div class="absolute w-96 h-96 rounded-full opacity-30 blur-3xl animate-pulse"
         style="background:#4F46E5; top:-100px; left:-100px;"></div>
    <div class="absolute w-72 h-72 rounded-full opacity-30 blur-3xl"
         style="background:#7C3AED; bottom:-80px; right:-80px; animation: pulse 4s ease-in-out infinite alternate;"></div>
    <div class="absolute w-52 h-52 rounded-full opacity-20 blur-3xl animate-bounce"
         style="background:#2563EB; bottom:100px; left:200px; animation-duration: 6s;"></div>

    <!-- Grid overlay -->
    <div class="absolute inset-0 opacity-5"
         style="background-image: linear-gradient(rgba(255,255,255,0.5) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.5) 1px, transparent 1px); background-size: 50px 50px;"></div>

    <!-- Portal Card -->
    <div class="relative z-10 w-full max-w-md px-4">
      <div class="glass-card p-10 shadow-2xl shadow-black/50 rounded-3xl" style="background: rgba(255,255,255,0.03); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.05);">

        <!-- Logo -->
        <div class="text-center mb-9">
          <div class="w-18 h-18 mx-auto mb-4 rounded-2xl bg-gradient-to-br from-indigo-500 to-violet-600 flex items-center justify-center text-4xl shadow-xl shadow-indigo-500/40"
               style="width:80px;height:80px;">
            🎓
          </div>
          <h1 class="text-2xl font-bold text-white">LMS SMK 11 Maret</h1>
          <p class="text-sm text-slate-400 mt-2">Selamat Datang di Portal Pembelajaran Digital</p>
        </div>

        <!-- Role Selector -->
        <div class="mb-5">
          <label class="block text-center text-xs font-semibold text-slate-500 uppercase tracking-wider mb-6">Pilih Jalur Masuk</label>
          <div class="grid grid-cols-2 gap-4">
            <Link
              href="/login/admin"
              class="flex flex-col items-center justify-center p-4 rounded-2xl border bg-white/5 border-white/10 text-slate-300 hover:border-indigo-500/50 hover:bg-indigo-500/10 hover:text-white transition-all duration-300 hover:-translate-y-1"
            >
              <span class="text-3xl mb-2">⚙️</span>
              <span class="text-xs font-medium">Admin Kurikulum</span>
            </Link>
            
            <Link
              href="/login/guru"
              class="flex flex-col items-center justify-center p-4 rounded-2xl border bg-white/5 border-white/10 text-slate-300 hover:border-indigo-500/50 hover:bg-indigo-500/10 hover:text-white transition-all duration-300 hover:-translate-y-1"
            >
              <span class="text-3xl mb-2">📚</span>
              <span class="text-xs font-medium">Guru</span>
            </Link>
            
            <Link
              href="/login/walikelas"
              class="flex flex-col items-center justify-center p-4 rounded-2xl border bg-white/5 border-white/10 text-slate-300 hover:border-indigo-500/50 hover:bg-indigo-500/10 hover:text-white transition-all duration-300 hover:-translate-y-1"
            >
              <span class="text-3xl mb-2">🏠</span>
              <span class="text-xs font-medium">Wali Kelas</span>
            </Link>
            
            <Link
              href="/login/siswa"
              class="flex flex-col items-center justify-center p-4 rounded-2xl border bg-white/5 border-white/10 text-slate-300 hover:border-indigo-500/50 hover:bg-indigo-500/10 hover:text-white transition-all duration-300 hover:-translate-y-1"
            >
              <span class="text-3xl mb-2">🎒</span>
              <span class="text-xs font-medium">Siswa</span>
            </Link>
          </div>
        </div>

        <div class="mt-8 border-t border-white/8 pt-5 flex items-center justify-center gap-2 text-xs text-slate-600">
          <span class="w-1.5 h-1.5 rounded-full bg-green-500 animate-pulse"></span>
          SMK 11 Maret | 2026/2027
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { Head, Link } from '@inertiajs/vue3';
</script>
