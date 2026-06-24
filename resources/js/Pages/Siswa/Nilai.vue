<template>
  <Head title="Capaian & Nilai" />

  <AppLayout
    title="Capaian & Nilai"
    subtitle="Laporan Hasil Belajar Kurikulum Merdeka"
    :navigation="navigation"
  >
    <div class="max-w-4xl mx-auto space-y-6">

      <!-- Semester Selector -->
      <div class="flex items-center justify-between border-b border-white/10 pb-4">
        <h2 class="text-lg font-bold text-white">Nilai Akademik</h2>
        <select class="bg-white/5 border border-white/10 rounded-lg px-4 py-2 text-sm text-white font-semibold outline-none focus:border-indigo-500">
          <option>T.A 2026/2027 - Semester Ganjil</option>
          <option>T.A 2025/2026 - Semester Genap</option>
        </select>
      </div>

      <!-- Ringkasan Rapor -->
      <div class="grid grid-cols-3 gap-4">
        <div class="rounded-2xl border border-white/8 p-5 bg-gradient-to-br from-indigo-500/20 to-transparent">
          <div class="text-[10px] font-bold text-indigo-300 uppercase tracking-widest mb-1">Rata-rata Kelas</div>
          <div class="text-3xl font-black text-white">84.5</div>
          <div class="text-xs text-slate-400 mt-2">Berdasarkan 12 Mata Pelajaran</div>
        </div>
        <div class="rounded-2xl border border-white/8 p-5 bg-white/2">
          <div class="text-[10px] font-bold text-slate-500 uppercase tracking-widest mb-1">Peringkat Kelas</div>
          <div class="text-3xl font-black text-white">8 <span class="text-sm text-slate-500 font-normal">/ 36</span></div>
          <div class="text-xs text-green-400 mt-2">↑ Naik 2 peringkat</div>
        </div>
        <div class="rounded-2xl border border-white/8 p-5 bg-white/2">
          <div class="text-[10px] font-bold text-slate-500 uppercase tracking-widest mb-1">Total Ketidakhadiran</div>
          <div class="text-3xl font-black text-white">3 <span class="text-sm text-slate-500 font-normal">Sesi</span></div>
          <div class="text-xs text-yellow-400 mt-2">2 Izin, 1 Alpa</div>
        </div>
      </div>

      <!-- Detail Nilai per Mapel -->
      <div class="space-y-4">
        <div v-for="mapel in nilaiList" :key="mapel.id"
             class="rounded-2xl border border-white/8 overflow-hidden transition-all hover:border-white/20"
             style="background: var(--card)">
          
          <div class="px-5 py-4 border-b border-white/5 flex items-start justify-between cursor-pointer" @click="mapel.expanded = !mapel.expanded">
            <div>
              <h3 class="font-bold text-base text-white">{{ mapel.nama }}</h3>
              <p class="text-xs text-slate-400 mt-0.5">Guru: {{ mapel.guru }}</p>
            </div>
            <div class="flex items-center gap-4">
              <div class="text-right">
                <div class="text-2xl font-black" :class="mapel.nilai < 75 ? 'text-red-400' : 'text-green-400'">{{ mapel.nilai }}</div>
                <div class="text-[10px] font-bold text-slate-500 uppercase tracking-widest mt-0.5">Nilai Rapor</div>
              </div>
              <div class="text-slate-500 text-lg transition-transform" :class="{ 'rotate-180': mapel.expanded }">▼</div>
            </div>
          </div>

          <!-- Expanded Detail (Capaian Kompetensi) -->
          <div v-if="mapel.expanded" class="p-5 bg-black/20 text-sm">
            <h4 class="font-bold text-slate-300 mb-3 text-xs uppercase tracking-wider">Capaian Kompetensi (Kurikulum Merdeka)</h4>
            <p class="text-slate-300 leading-relaxed text-justify mb-4">
              {{ mapel.deskripsi }}
            </p>
            
            <div class="grid grid-cols-2 gap-4">
              <div class="rounded-xl border border-white/5 p-3 bg-white/5">
                <div class="text-[10px] font-bold text-slate-500 uppercase mb-1">Rata-rata Formatif & TP</div>
                <div class="text-lg font-bold text-white">{{ mapel.rataTP }}</div>
              </div>
              <div class="rounded-xl border border-white/5 p-3 bg-white/5">
                <div class="text-[10px] font-bold text-slate-500 uppercase mb-1">Sumatif Akhir Semester (SAS)</div>
                <div class="text-lg font-bold text-white">{{ mapel.sas }}</div>
              </div>
            </div>
          </div>

        </div>
      </div>

    </div>
  </AppLayout>
</template>

<script setup>
import { Head } from '@inertiajs/vue3';
import { ref } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';

const navigation = [
  {
    label: 'Akademik',
    items: [
      { href: '/siswa/dashboard', icon: '🏠', label: 'Beranda' },
      { href: '/siswa/scan-qr', icon: '📷', label: 'Scan QR Presensi', badge: 'Live' },
    ],
  },
  {
    label: 'Laporan',
    items: [
      { href: '/siswa/nilai', icon: '📊', label: 'Nilai & Capaian' },
      { href: '/siswa/kuesioner', icon: '📝', label: 'Evaluasi Pembelajaran' },
    ],
  },
];

const nilaiList = ref([
  {
    id: 1,
    nama: 'Dasar-Dasar Jaringan Komputer',
    guru: 'Reza Patriota Putra, S.Kom',
    nilai: 87,
    rataTP: 86,
    sas: 88,
    deskripsi: 'Menunjukkan penguasaan yang sangat baik dalam merancang arsitektur jaringan sesuai dengan standar keamanan fisik. Namun, perlu pendampingan lebih lanjut pada kemampuan menganalisis kebutuhan perangkat keras berdasarkan topologi Star dan Tree.',
    expanded: true
  },
  {
    id: 2,
    nama: 'Pendidikan Agama Islam',
    guru: 'Suharno, S.Pdi',
    nilai: 92,
    rataTP: 90,
    sas: 95,
    deskripsi: 'Sangat menguasai pemahaman ayat suci Al-Qur\'an dan penerapannya dalam kehidupan sehari-hari secara konsisten.',
    expanded: false
  },
  {
    id: 3,
    nama: 'Matematika Terapan',
    guru: 'Sari Widyastuti, S.Pd',
    nilai: 72,
    rataTP: 70,
    sas: 75,
    deskripsi: 'Cukup mampu menyelesaikan persamaan linier dua variabel, namun perlu banyak latihan dalam memecahkan soal cerita berbasis logika matematika.',
    expanded: false
  }
]);
</script>
