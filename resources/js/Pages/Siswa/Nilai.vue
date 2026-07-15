<template>
  <Head title="Capaian Belajar & Nilai Rapor" />

  <AppLayout
    title="Laporan Nilai & Capaian Belajar"
    subtitle="Pantau nilai formatif, STS, SAS, serta hasil kalkulasi Nilai Rapor Anda secara berkala"
    :navigation="navigation"
  >
    <div class="max-w-5xl mx-auto space-y-6">

      <!-- Header -->
      <div class="flex items-center justify-between border-b border-white/10 pb-4">
        <h2 class="text-lg font-bold text-white">Nilai Akademik Anda</h2>
        <span class="text-xs text-slate-400">Tahun Ajaran Aktif (Kurikulum Merdeka)</span>
      </div>

      <!-- Detail Nilai per Mapel -->
      <div class="space-y-4">
        <div v-for="mapel in nilaiList" :key="mapel.id"
             class="rounded-2xl border border-white/8 overflow-hidden transition-all hover:border-indigo-500/20"
             style="background: var(--card)">
          
          <div class="px-5 py-4 border-b border-white/5 flex items-start justify-between cursor-pointer hover:bg-white/1" @click="mapel.expanded = !mapel.expanded">
            <div class="space-y-1">
              <h3 class="font-bold text-base text-white hover:text-indigo-400 transition-colors">{{ mapel.nama }}</h3>
              <p class="text-xs text-slate-400">Guru: {{ mapel.guru }} | KKM: <span class="text-indigo-400 font-bold">{{ mapel.kkm }}</span></p>
            </div>
            
            <div class="flex items-center gap-6">
              <!-- Rapor Tengah Semester -->
              <div class="text-center">
                <div class="text-lg font-black" :class="mapel.mid?.nilai_rapor < mapel.kkm ? 'text-rose-400' : 'text-slate-200'">
                  {{ mapel.mid?.nilai_rapor ?? '-' }}
                </div>
                <div class="text-[9px] font-bold text-slate-500 uppercase tracking-wider">Rapor Tengah</div>
              </div>

              <!-- Rapor Akhir Semester -->
              <div class="text-center border-l border-white/5 pl-4">
                <div class="text-xl font-black text-emerald-400" :class="mapel.end?.nilai_rapor < mapel.kkm ? 'text-rose-400' : 'text-emerald-400'">
                  {{ mapel.end?.nilai_rapor ?? '-' }}
                </div>
                <div class="text-[9px] font-bold text-slate-500 uppercase tracking-wider">Rapor Akhir</div>
              </div>

              <div class="text-slate-500 text-lg transition-transform duration-200" :class="{ 'rotate-180': mapel.expanded }">▼</div>
            </div>
          </div>

          <!-- Expanded Detail (Capaian Kompetensi) -->
          <div v-if="mapel.expanded" class="p-5 bg-black/20 text-sm space-y-6">
            <!-- Deskripsi Capaian Rapor -->
            <div>
              <h4 class="font-bold text-slate-400 mb-2 text-[10px] uppercase tracking-wider">Deskripsi Capaian Kompetensi</h4>
              <p class="text-slate-300 leading-relaxed text-xs">
                {{ mapel.deskripsi }}
              </p>
            </div>
            
            <!-- Formulas Breakdown Columns -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <!-- Rapor Tengah -->
              <div class="rounded-xl border border-white/5 p-4 bg-white/2 space-y-2">
                <div class="text-[10px] font-bold text-indigo-400 uppercase tracking-widest border-b border-white/5 pb-1">
                  Kalkulasi Rapor Tengah Semester
                </div>
                <div class="grid grid-cols-3 gap-2 text-center text-xs">
                  <div class="bg-black/20 p-2 rounded">
                    <span class="block text-[8px] text-slate-500 uppercase">Absensi (10%)</span>
                    <span class="font-bold text-amber-400">{{ mapel.mid?.absensi }}%</span>
                  </div>
                  <div class="bg-black/20 p-2 rounded">
                    <span class="block text-[8px] text-slate-500 uppercase">Formatif (60%)</span>
                    <span class="font-bold text-indigo-300">{{ mapel.mid?.formatif ?? '-' }}</span>
                  </div>
                  <div class="bg-black/20 p-2 rounded">
                    <span class="block text-[8px] text-slate-500 uppercase">STS (30%)</span>
                    <span class="font-bold text-purple-300">{{ mapel.mid?.sts ?? '-' }}</span>
                  </div>
                </div>
              </div>

              <!-- Rapor Akhir -->
              <div class="rounded-xl border border-white/5 p-4 bg-white/2 space-y-2">
                <div class="text-[10px] font-bold text-emerald-400 uppercase tracking-widest border-b border-white/5 pb-1">
                  Kalkulasi Rapor Akhir Semester
                </div>
                <div class="grid grid-cols-4 gap-2 text-center text-xs">
                  <div class="bg-black/20 p-2 rounded">
                    <span class="block text-[8px] text-slate-500 uppercase">Formatif (60%)</span>
                    <span class="font-bold text-indigo-300">{{ mapel.end?.formatif ?? '-' }}</span>
                  </div>
                  <div class="bg-black/20 p-2 rounded">
                    <span class="block text-[8px] text-slate-500 uppercase">STS (15%)</span>
                    <span class="font-bold text-purple-300">{{ mapel.end?.sts ?? '-' }}</span>
                  </div>
                  <div class="bg-black/20 p-2 rounded">
                    <span class="block text-[8px] text-slate-500 uppercase">SAS (25%)</span>
                    <span class="font-bold text-green-300">{{ mapel.end?.sas ?? '-' }}</span>
                  </div>
                  <div class="bg-black/20 p-2 rounded">
                    <span class="block text-[8px] text-slate-500 uppercase">Absensi (0%)</span>
                    <span class="font-bold text-slate-400">-</span>
                  </div>
                </div>
              </div>
            </div>

            <!-- Formative Details (TP Breakdown) -->
            <div class="pt-4 border-t border-white/5 space-y-3">
              <h4 class="font-bold text-slate-400 text-[10px] uppercase tracking-wider">Detail Nilai Formatif (Tujuan Pembelajaran)</h4>
              <div class="divide-y divide-white/5">
                <div v-for="tp in mapel.details" :key="tp.id_tp" class="py-2.5 flex items-start justify-between gap-4">
                  <div class="flex-1 space-y-0.5">
                    <div class="flex items-center gap-2">
                      <span class="text-xs font-bold text-indigo-400 font-mono">{{ tp.kode_tp }}</span>
                      <span class="px-1.5 py-0.2 bg-white/5 border border-white/10 text-[8px] font-bold text-slate-400 rounded">
                        Sem {{ tp.semester }}
                      </span>
                    </div>
                    <p class="text-xs text-slate-300">{{ tp.deskripsi_tp }}</p>
                  </div>
                  
                  <div class="shrink-0">
                    <span v-if="tp.nilai === null" class="px-2.5 py-1 text-[10px] font-bold rounded-lg bg-slate-500/10 text-slate-400 border border-white/5">
                      Belum Dinilai
                    </span>
                    <span v-else-if="tp.status === 'BELUM_TERCAPAI'" class="px-2.5 py-1 text-[10px] font-bold rounded-lg bg-rose-500/10 text-rose-400 border border-rose-500/20" :title="'Di bawah KKM ' + mapel.kkm">
                      🔴 {{ tp.nilai }} (Perbaikan)
                    </span>
                    <span v-else class="px-2.5 py-1 text-[10px] font-bold rounded-lg bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                      🟢 {{ tp.nilai }}
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>

        </div>

        <div v-if="!nilaiList || nilaiList.length === 0" class="rounded-2xl border border-white/8 p-12 text-center text-slate-500 bg-[#1A2035]">
          Tidak ada data nilai hasil belajar siswa saat ini.
        </div>
      </div>

    </div>
  </AppLayout>
</template>

<script setup>
import { Head } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  nilaiList: Array,
});

const navigation = [
  {
    label: 'Akademik',
    items: [
      { href: '/siswa/dashboard', icon: '🏠', label: 'Beranda' },
      { href: '/siswa/scan-qr', icon: '📷', label: 'Scan QR Presensi', badge: 'Live' },
      { href: '/siswa/materi', icon: '📁', label: 'Materi Belajar' },
      { href: '/siswa/jadwal', icon: '📅', label: 'Jadwal Kelas' },
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

const nilaiList = ref([]);

watch(() => props.nilaiList, (newVal) => {
  if (newVal) {
    nilaiList.value = newVal.map(n => ({ ...n, expanded: false }));
  }
}, { immediate: true });
</script>
