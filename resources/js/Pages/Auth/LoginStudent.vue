<template>
  <Head :title="`Login Siswa - ${$page.props.app.branch.name}`" />

  <div class="min-h-screen flex items-center justify-center relative overflow-hidden transition-all duration-500"
       :style="isBekasi ? 'background: linear-gradient(135deg, #051D14 0%, #0D4730 50%, #062217 100%)' : 'background: linear-gradient(135deg, #0F0C29 0%, #302B63 50%, #24243e 100%)'">

    <div class="absolute inset-0 opacity-5"
         style="background-image: linear-gradient(rgba(255,255,255,0.5) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.5) 1px, transparent 1px); background-size: 50px 50px;"></div>

    <div class="relative z-10 w-full max-w-md px-4">
      <Link href="/login" class="inline-flex items-center gap-2 text-sm text-slate-400 hover:text-white mb-6 transition-colors">
        <span>←</span> Kembali ke Portal
      </Link>

      <div class="glass-card p-10 shadow-2xl shadow-black/50 rounded-3xl" style="background: rgba(255,255,255,0.03); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.05);">

        <div class="text-center mb-9">
          <div class="w-16 h-16 mx-auto mb-4 rounded-2xl flex items-center justify-center text-3xl shadow-xl transition-all duration-500"
               :class="isBekasi ? 'bg-gradient-to-br from-emerald-500 to-teal-600 shadow-emerald-500/40' : 'bg-gradient-to-br from-indigo-500 to-violet-600 shadow-indigo-500/40'">
            🎒
          </div>
          <h1 class="text-xl font-bold text-white">Login Siswa</h1>
          <p class="text-xs text-slate-300 mt-1">Masuk dengan NISN atau NIS Anda ({{ $page.props.app.branch.name }})</p>
        </div>

        <form @submit.prevent="submit" class="space-y-4">
          <div>
            <label class="block text-[11px] font-semibold text-slate-500 uppercase tracking-wider mb-2">NISN / NIS</label>
            <div class="relative">
              <span class="absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-500">🆔</span>
              <input
                v-model="form.nisn"
                type="text"
                required
                placeholder="Nomor Induk Siswa Nasional / NIS"
                :class="[
                  'w-full bg-white/5 border border-white/10 rounded-xl py-3.5 pl-10 pr-4 text-sm text-white placeholder-slate-600 outline-none transition-all duration-300',
                  isBekasi ? 'focus:border-emerald-500 focus:bg-emerald-500/10 focus:ring-2 focus:ring-emerald-500/20' : 'focus:border-indigo-500 focus:bg-indigo-500/10 focus:ring-2 focus:ring-indigo-500/20'
                ]"
              />
            </div>
            <p v-if="form.errors.nisn" class="text-red-400 text-xs mt-1">{{ form.errors.nisn }}</p>
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
                :class="[
                  'w-full bg-white/5 border border-white/10 rounded-xl py-3.5 pl-10 pr-10 text-sm text-white placeholder-slate-600 outline-none transition-all duration-300',
                  isBekasi ? 'focus:border-emerald-500 focus:bg-emerald-500/10 focus:ring-2 focus:ring-emerald-500/20' : 'focus:border-indigo-500 focus:bg-indigo-500/10 focus:ring-2 focus:ring-indigo-500/20'
                ]"
              />
              <button type="button" @click="showPass = !showPass"
                class="absolute right-3.5 top-1/2 -translate-y-1/2 text-slate-600 hover:text-slate-400 transition-colors text-sm">
                {{ showPass ? '🙈' : '👁️' }}
              </button>
            </div>
            <p v-if="form.errors.password" class="text-red-400 text-xs mt-1">{{ form.errors.password }}</p>
          </div>

          <button
            type="submit"
            :disabled="form.processing"
            class="w-full relative overflow-hidden py-4 rounded-xl text-sm font-semibold text-white transition-all duration-300 hover:-translate-y-0.5 disabled:opacity-60 disabled:cursor-not-allowed mt-2"
            :style="isBekasi 
              ? 'background: linear-gradient(135deg, #10B981, #059669); box-shadow: 0 8px 20px rgba(16,185,129,0.4);' 
              : 'background: linear-gradient(135deg, #4F46E5, #7C3AED); box-shadow: 0 8px 20px rgba(79,70,229,0.4);'"
          >
            <span v-if="!form.processing">Masuk ke Dashboard →</span>
            <span v-else>Memverifikasi...</span>
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { Head, Link, useForm, usePage } from '@inertiajs/vue3';
import { ref, computed } from 'vue';

const page = usePage();
const isBekasi = computed(() => page.props.app.branch.code === 'BKS');

const showPass = ref(false);

const form = useForm({
  nisn: '',
  password: '',
});

const submit = () => {
  form.post('/login/siswa', {
    onFinish: () => form.reset('password'),
  });
};
</script>
