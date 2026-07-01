<template>
  <Head :title="`Detail Bank Soal: ${bank.judul}`" />

  <AppLayout
    title="Detail Bank Soal"
    :subtitle="bank.judul"
    :navigation="navigation"
  >
    <div class="max-w-4xl mx-auto space-y-6">
      
      <!-- Header Card -->
      <div class="rounded-2xl border border-white/10 p-6 space-y-4 shadow-lg" style="background: var(--card)">
        <div class="flex items-start justify-between flex-wrap gap-4">
          <div class="space-y-1">
            <span class="px-3 py-1 bg-indigo-500/10 border border-indigo-500/20 rounded-lg text-xs font-semibold text-indigo-400">
              {{ bank.subject?.nama_mapel || 'Mapel Umum' }}
            </span>
            <h2 class="text-xl font-black text-white pt-1">{{ bank.judul }}</h2>
            <p class="text-sm text-slate-400">{{ bank.deskripsi || 'Tidak ada deskripsi' }}</p>
          </div>
          
          <div class="flex items-center gap-2">
            <a :href="`/guru/bank-soal/${bank.id_bank}/edit`" class="flex items-center gap-2 px-4 py-2 rounded-xl text-xs font-bold text-white bg-indigo-600 hover:bg-indigo-500 transition-colors shadow-lg cursor-pointer border border-indigo-500/20">
              <span>✏️</span> Edit Paket Soal
            </a>
            <a href="/guru/bank-soal" class="px-4 py-2 rounded-xl text-xs font-bold text-slate-300 bg-white/5 hover:bg-white/10 transition-colors cursor-pointer border border-white/5">
              Kembali
            </a>
          </div>
        </div>
        
        <div class="flex items-center gap-6 text-xs text-slate-500 pt-2 border-t border-white/5">
          <div>Jumlah Soal: <span class="font-bold text-indigo-400">{{ bank.questions?.length || 0 }} Butir</span></div>
          <div>Dibuat Pada: <span class="font-bold text-slate-300">{{ formatDate(bank.created_at) }}</span></div>
        </div>
      </div>

      <!-- Question List -->
      <div class="space-y-6">
        <h3 class="text-base font-bold text-white">Daftar Soal</h3>
        
        <div v-for="(q, index) in bank.questions" :key="q.id" class="rounded-2xl border border-white/10 p-6 relative" style="background: var(--card)">
          <!-- Number badge -->
          <div class="absolute -left-3 -top-3 w-8 h-8 rounded-full bg-indigo-600 text-white flex items-center justify-center font-bold text-sm shadow-lg shadow-indigo-500/50">
            {{ index + 1 }}
          </div>

          <div class="space-y-4">
            <!-- Question text -->
            <p class="text-sm font-semibold text-white whitespace-pre-line leading-relaxed pl-2">{{ q.pertanyaan }}</p>
            
            <!-- Options grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-3 pl-2">
              <div 
                v-for="opt in ['A','B','C','D','E']" 
                :key="opt"
                class="flex items-center gap-3 p-2.5 rounded-xl border transition-all text-xs"
                :class="q.jawaban_benar === opt 
                  ? 'bg-green-500/10 border-green-500/30 text-green-400 font-bold' 
                  : 'bg-black/20 border-white/5 text-slate-300'"
              >
                <span class="font-bold">{{ opt }}.</span>
                <span>{{ q[`opsi_${opt.toLowerCase()}`] }}</span>
                <span v-if="q.jawaban_benar === opt" class="ml-auto text-green-400">✓ Kunci</span>
              </div>
            </div>

            <!-- Pembahasan -->
            <div v-if="q.pembahasan" class="mt-2 p-3 bg-white/5 rounded-xl border border-white/5 text-xs text-slate-400 leading-relaxed">
              <div class="font-bold text-slate-300 mb-1">📖 Pembahasan:</div>
              {{ q.pembahasan }}
            </div>
          </div>
        </div>

        <div v-if="!bank.questions || bank.questions.length === 0" class="py-10 text-center text-slate-500">
          Paket soal ini belum memiliki butir pertanyaan.
        </div>
      </div>

    </div>
  </AppLayout>
</template>

<script setup>
import { Head } from '@inertiajs/vue3';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  bank: Object
});

const navigation = [
  {
    label: 'KBM (Kegiatan Belajar Mengajar)',
    items: [
      { href: '/guru/dashboard', icon: '📊', label: 'Dashboard' },
      { href: '/guru/jadwal', icon: '📅', label: 'Jadwal Mengajar' },
      { href: '/guru/riwayat-jurnal', icon: '📜', label: 'Riwayat Jurnal Mengajar' },
      { href: '/guru/materi', icon: '📁', label: 'Materi Pembelajaran' },
    ],
  },
  {
    label: 'Evaluasi & Penilaian',
    items: [
      { href: '/guru/pemetaan-materi', icon: '🗺️', label: 'Pemetaan Materi' },
      { href: '/guru/bank-soal', icon: '📝', label: 'Bank Soal & Ujian Live' },
      { href: '/guru/nilai-sumatif', icon: '📊', label: 'Nilai Sumatif' },
      { href: '/guru/nilai-akhir', icon: '📋', label: 'Nilai Akhir' },
      { href: '/guru/rapor-preview', icon: '📑', label: 'Rapor Preview' },
    ],
  },
];

const formatDate = (dateString) => {
  const d = new Date(dateString);
  return d.toLocaleDateString('id-ID', { day: 'numeric', month: 'long', year: 'numeric' });
};
</script>
