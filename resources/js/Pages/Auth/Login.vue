<template>
  <Head title="Login" />

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

    <!-- Login Card -->
    <div class="relative z-10 w-full max-w-md px-4">
      <div class="glass-card p-10 shadow-2xl shadow-black/50">

        <!-- Logo -->
        <div class="text-center mb-9">
          <div class="w-18 h-18 mx-auto mb-4 rounded-2xl bg-gradient-to-br from-indigo-500 to-violet-600 flex items-center justify-center text-4xl shadow-xl shadow-indigo-500/40"
               style="width:72px;height:72px;">
            🎓
          </div>
          <h1 class="text-xl font-bold text-white">LMS SMK 11 Maret</h1>
          <p class="text-xs text-slate-500 mt-1">Learning Management System — TP 2026/2027</p>
        </div>

        <!-- Role Selector -->
        <div class="mb-5">
          <label class="block text-[11px] font-semibold text-slate-500 uppercase tracking-wider mb-2">Masuk Sebagai</label>
          <div class="grid grid-cols-2 gap-2">
            <button
              v-for="role in roles"
              :key="role.value"
              type="button"
              @click="form.role = role.value"
              :class="[
                'flex flex-col items-center py-2.5 rounded-xl border text-xs font-medium transition-all duration-150',
                form.role === role.value
                  ? 'bg-indigo-500/20 border-indigo-500/50 text-white'
                  : 'bg-white/5 border-white/10 text-slate-400 hover:border-indigo-500/30 hover:text-slate-200'
              ]"
            >
              <span class="text-lg mb-1">{{ role.icon }}</span>
              {{ role.label }}
            </button>
          </div>
        </div>

        <!-- Form -->
        <form @submit.prevent="submit" class="space-y-4">
          <div>
            <label class="block text-[11px] font-semibold text-slate-500 uppercase tracking-wider mb-2">Email</label>
            <div class="relative">
              <span class="absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-500">✉️</span>
              <input
                v-model="form.email"
                type="email"
                required
                placeholder="nama@smk11maret.sch.id"
                class="w-full bg-white/5 border border-white/10 rounded-xl py-3.5 pl-10 pr-4 text-sm text-white placeholder-slate-600 outline-none focus:border-indigo-500 focus:bg-indigo-500/10 focus:ring-2 focus:ring-indigo-500/20 transition-all"
              />
            </div>
            <p v-if="form.errors.email" class="text-red-400 text-xs mt-1">{{ form.errors.email }}</p>
          </div>

          <div>
            <label class="block text-[11px] font-semibold text-slate-500 uppercase tracking-wider mb-2">Password</label>
            <div class="relative">
              <span class="absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-500">🔒</span>
              <input
                v-model="form.password"
                :type="showPass ? 'text' : 'password'"
                required
                placeholder="••••••••"
                class="w-full bg-white/5 border border-white/10 rounded-xl py-3.5 pl-10 pr-10 text-sm text-white placeholder-slate-600 outline-none focus:border-indigo-500 focus:bg-indigo-500/10 focus:ring-2 focus:ring-indigo-500/20 transition-all"
              />
              <button type="button" @click="showPass = !showPass"
                class="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-600 hover:text-slate-400 transition-colors text-sm">
                {{ showPass ? '🙈' : '👁️' }}
              </button>
            </div>
            <p v-if="form.errors.password" class="text-red-400 text-xs mt-1">{{ form.errors.password }}</p>
          </div>

          <div class="flex justify-end">
            <a href="#" class="text-xs text-indigo-400 hover:text-indigo-300 transition-colors">Lupa password?</a>
          </div>

          <button
            type="submit"
            :disabled="form.processing"
            class="w-full relative overflow-hidden py-4 rounded-xl text-sm font-semibold text-white transition-all duration-200 hover:-translate-y-0.5 disabled:opacity-60 disabled:cursor-not-allowed"
            style="background: linear-gradient(135deg, #4F46E5, #7C3AED); box-shadow: 0 8px 20px rgba(79,70,229,0.4);"
          >
            <span v-if="!form.processing">Masuk ke Dashboard →</span>
            <span v-else class="flex items-center justify-center gap-2">
              <svg class="animate-spin h-4 w-4" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"></path>
              </svg>
              Memverifikasi...
            </span>
            <!-- Shine overlay -->
            <div class="absolute inset-0 bg-gradient-to-r from-white/10 to-transparent pointer-events-none"></div>
          </button>
        </form>

        <div class="mt-6 border-t border-white/8 pt-5 flex items-center justify-center gap-2 text-xs text-slate-600">
          <span class="w-1.5 h-1.5 rounded-full bg-green-500 animate-pulse"></span>
          Secure Login — SMK 11 Maret &nbsp;|&nbsp; Laravel 12 + Inertia.js
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { Head, useForm } from '@inertiajs/vue3';
import { ref } from 'vue';

const showPass = ref(false);

const roles = [
  { value: 'ADMIN',   icon: '⚙️', label: 'Admin Kurikulum' },
  { value: 'TEACHER', icon: '📚', label: 'Guru' },
  { value: 'HOMEROOM',icon: '🏠', label: 'Wali Kelas' },
  { value: 'STUDENT', icon: '🎒', label: 'Siswa' },
];

const form = useForm({
  email: '',
  password: '',
  role: 'TEACHER',
  remember: false,
});

const submit = () => {
  form.post('/login', {
    onFinish: () => form.reset('password'),
  });
};
</script>
