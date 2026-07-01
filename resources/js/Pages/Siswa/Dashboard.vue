<template>
  <Head title="Dashboard Siswa" />

  <AppLayout
    title="Dashboard Siswa"
    :subtitle="`Selamat datang, ${$page.props.auth?.user?.name || 'Siswa'}`"
    :navigation="navigation"
  >
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-5xl mx-auto">
      
      <!-- KIRI: Info Profil & Ringkasan -->
      <div class="md:col-span-1 space-y-4">
        
        <!-- Kartu Pelajar Digital -->
        <div class="relative overflow-hidden rounded-2xl p-5 border border-white/10 text-white shadow-xl"
             style="background: linear-gradient(135deg, #1E1B4B, #4C1D95, #3B82F6)">
          <div class="absolute top-0 right-0 w-32 h-32 bg-white/5 rounded-full blur-2xl -translate-y-1/2 translate-x-1/4"></div>
          
          <div class="flex items-start justify-between relative z-10">
            <div class="w-12 h-12 rounded-full bg-white/20 backdrop-blur-sm border border-white/20 p-2 flex items-center justify-center text-xl shadow-lg">
              🎓
            </div>
            <div class="text-right">
              <div class="text-[10px] font-bold text-indigo-200 uppercase tracking-widest">T.A 2026/2027</div>
              <div class="text-xs text-white/80">Semester Ganjil</div>
            </div>
          </div>

          <div class="mt-6 relative z-10">
            <h2 class="text-lg font-black tracking-wide">{{ studentData.nama }}</h2>
            <div class="text-sm text-indigo-200 font-mono mt-0.5">{{ studentData.nis }} / {{ studentData.nisn }}</div>
            <div class="flex items-center justify-between mt-3 gap-2">
              <div class="inline-block px-3 py-1.5 rounded-lg bg-white/10 border border-white/20 text-xs font-bold shadow-inner truncate">
                🏫 {{ studentData.kelas }} — {{ studentData.jurusan }}
              </div>
              <button 
                @click="showQrModal = true"
                type="button"
                class="flex-shrink-0 px-3 py-1.5 rounded-lg bg-emerald-600 hover:bg-emerald-500 text-[10px] font-bold shadow-md transition-colors flex items-center gap-1 border border-emerald-500/20 cursor-pointer text-white"
                title="Tampilkan QR Code Kartu Pelajar"
              >
                <span>📱</span> Tampilkan QR
              </button>
            </div>
          </div>
        </div>

        <!-- Progress Kehadiran -->
        <div class="rounded-2xl border border-white/8 p-5" style="background: var(--card)">
          <div class="text-sm font-bold mb-4">Statistik Kehadiran Anda</div>
          
          <div class="flex items-center gap-4 mb-4">
            <div class="relative w-16 h-16">
              <svg viewBox="0 0 36 36" class="w-full h-full -rotate-90">
                <circle cx="18" cy="18" r="16" fill="none" class="stroke-white/10" stroke-width="3"></circle>
                <circle cx="18" cy="18" r="16" fill="none" class="stroke-green-500" stroke-width="3"
                        stroke-dasharray="100" :stroke-dashoffset="100 - studentData.kehadiranPct" stroke-linecap="round"></circle>
              </svg>
              <div class="absolute inset-0 flex items-center justify-center text-xs font-bold text-green-400">
                {{ studentData.kehadiranPct }}%
              </div>
            </div>
            <div class="flex-1 space-y-2">
              <div class="flex justify-between text-xs">
                <span class="text-slate-400">Hadir</span>
                <span class="font-bold text-white">{{ studentData.hadir }} Sesi</span>
              </div>
              <div class="flex justify-between text-xs">
                <span class="text-slate-400">Alpa/Izin</span>
                <span class="font-bold text-white">{{ studentData.absen }} Sesi</span>
              </div>
            </div>
          </div>
          
          <div v-if="studentData.kehadiranPct < 80" class="mt-2 text-[10px] text-red-400 bg-red-500/10 p-2 rounded-lg border border-red-500/20">
            ⚠️ Perhatian: Tingkat kehadiran Anda di bawah batas aman. Harap perbaiki.
          </div>
          <div v-else class="mt-2 text-[10px] text-green-400 bg-green-500/10 p-2 rounded-lg border border-green-500/20">
            ✅ Bagus! Pertahankan kehadiran Anda.
          </div>
        </div>

      </div>

      <!-- KANAN: Jadwal & Action -->
      <div class="md:col-span-2 space-y-6">
        
        <!-- Alert Ujian Live Aktif -->
        <div v-if="activeLiveExam" class="rounded-2xl border border-rose-500/30 p-5 flex flex-col sm:flex-row items-center justify-between gap-4 bg-rose-500/10 shadow-lg shadow-rose-500/5 animate-pulse">
          <div class="flex items-center gap-3">
            <span class="text-3xl">📝</span>
            <div>
              <div class="flex items-center gap-2">
                <h4 class="font-black text-white text-sm">ASESMEN SEDANG BERLANGSUNG</h4>
                <span :class="activeLiveExam.tujuan === 'DIAGNOSTIK' ? 'bg-sky-500/20 text-sky-300 border-sky-500/30' : 'bg-green-500/20 text-green-300 border-green-500/30'"
                  class="text-[9px] font-extrabold px-2 py-0.5 rounded-full border">
                  {{ activeLiveExam.tujuan }}
                </span>
              </div>
              <p class="text-xs text-slate-300 font-medium mt-0.5">{{ activeLiveExam.judul }} ({{ activeLiveExam.durasi }} Menit)</p>
            </div>
          </div>
          <a href="/siswa/ujian-live" class="w-full sm:w-auto px-5 py-2.5 bg-rose-600 hover:bg-rose-500 text-white rounded-xl text-xs font-black transition-all hover:scale-105 shadow-md shadow-rose-500/20 text-center">
            🚀 Mulai Kerjakan
          </a>
        </div>

        <!-- Action Utama (Scanner) -->
        <div class="rounded-2xl border border-indigo-500/30 p-1 flex items-center bg-gradient-to-r from-indigo-500/10 to-transparent">
          <div class="p-4 flex-1">
            <h3 class="font-bold text-white">Sesi KBM Sedang Berlangsung?</h3>
            <p class="text-xs text-slate-400 mt-1">Gunakan scanner QR Code untuk melakukan presensi real-time di kelas.</p>
          </div>
          <div class="pr-4">
            <a href="/siswa/scan-qr" class="flex items-center gap-2 px-5 py-3 bg-indigo-600 hover:bg-indigo-500 text-white rounded-xl text-sm font-bold transition-all hover:scale-105 shadow-lg shadow-indigo-500/30">
              <span class="text-xl">📷</span> Buka Scanner
            </a>
          </div>
        </div>

        <!-- Jadwal Hari Ini -->
        <div class="rounded-2xl border border-white/8 overflow-hidden" style="background: var(--card)">
          <div class="px-5 py-4 border-b border-white/8 flex items-center justify-between">
            <h3 class="font-bold text-sm">Jadwal Kelas Hari Ini</h3>
            <div class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">{{ todayLabel }}</div>
          </div>
          
          <div class="divide-y divide-white/5">
            <div v-for="sesi in jadwalList" :key="sesi.id" 
                 class="p-4 flex items-center gap-4 transition-colors hover:bg-white/2"
                 :class="[
                   sesi.isTimeActive || sesi.status === 'AKTIF' || sesi.status === 'SCANNING'
                     ? 'border-l-4 border-l-indigo-500 bg-indigo-500/10 shadow-lg shadow-indigo-500/5'
                     : 'border-l-4 border-l-transparent bg-transparent',
                   sesi.status === 'BREAK' ? 'opacity-85 bg-white/2' : ''
                 ]">
              
              <!-- Waktu & JP -->
              <div class="w-28 text-center shrink-0">
                <div class="text-sm font-bold font-mono text-white" :class="{ 'text-indigo-400': sesi.isTimeActive || sesi.status === 'AKTIF' || sesi.status === 'SCANNING' }">
                  {{ sesi.jamMulai }} - {{ sesi.jamSelesai }}
                </div>
                <div v-if="sesi.status !== 'BREAK'" class="text-[10px] text-slate-500 mt-0.5">JP {{ sesi.jamKe }}</div>
                <div v-else class="text-[10px] text-amber-400 mt-0.5">☕ BREAK</div>
              </div>
              
              <!-- Info Sesi / Break -->
              <div class="flex-1 min-w-0">
                <div class="font-bold text-sm truncate" :class="{ 'text-amber-400': sesi.status === 'BREAK', 'text-indigo-200': sesi.isTimeActive || sesi.status === 'AKTIF' || sesi.status === 'SCANNING' }">
                  {{ sesi.mapel }}
                </div>
                <div class="text-xs text-slate-400 mt-0.5 flex items-center gap-2">
                  <span>{{ sesi.status === 'BREAK' ? '⏱️ Sesi Istirahat' : '👨‍🏫 ' + sesi.guru }}</span>
                  <span>•</span>
                  <span>📍 {{ sesi.ruang }}</span>
                </div>
              </div>
              
              <!-- Status Presensi / KBM -->
              <div class="shrink-0 text-right">
                <div v-if="sesi.presensiSiswa === 'HADIR'" class="badge-hadir">Hadir</div>
                <div v-else-if="sesi.status === 'AKTIF' || sesi.status === 'SCANNING'" class="text-xs font-bold text-indigo-400 animate-pulse">Sedang KBM</div>
                <div v-else-if="sesi.isTimeActive" class="text-xs font-bold text-indigo-400 animate-pulse">Jam Berlangsung</div>
                <div v-else-if="sesi.isTimePassed" class="badge-pending">Selesai</div>
                <div v-else-if="sesi.status === 'BREAK'" class="text-xs font-semibold text-amber-500/80">☕ Istirahat</div>
                <div v-else class="text-[10px] text-slate-500">Menunggu Sesi</div>
              </div>

            </div>

            <!-- Empty State -->
            <div v-if="jadwalList.length === 0" class="p-8 text-center">
              <div class="text-4xl mb-3">🏖️</div>
              <div class="text-sm font-bold text-slate-300">Tidak ada jadwal kelas hari ini.</div>
              <div class="text-xs text-slate-500 mt-1">Waktunya istirahat atau belajar mandiri!</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal QR Code -->
    <div v-if="showQrModal" class="fixed inset-0 z-50 flex items-center justify-center p-4">
      <!-- Backdrop -->
      <div class="fixed inset-0 bg-black/80 backdrop-blur-sm" @click="showQrModal = false"></div>
      
      <!-- Content -->
      <div class="relative w-full max-w-sm rounded-2xl border border-white/12 shadow-2xl p-6 overflow-hidden flex flex-col items-center text-center z-10" style="background: var(--card)">
        <div class="flex items-center justify-between w-full border-b border-white/8 pb-3 mb-4">
          <h3 class="text-sm font-bold text-white flex items-center gap-2">
            <span>📱</span> QR Kartu Pelajar
          </h3>
          <button @click="showQrModal = false" class="text-slate-400 hover:text-white transition-colors text-lg font-bold">
            ✕
          </button>
        </div>

        <div class="bg-white p-4 rounded-2xl border border-white/10 shadow-inner mb-4">
          <QrcodeVue
            :value="studentData.nis"
            :size="200"
            level="H"
            render-as="svg"
          />
        </div>

        <h4 class="text-base font-black text-white leading-tight mb-1">{{ studentData.nama }}</h4>
        <p class="text-xs text-indigo-400 font-mono mb-2">NIS: {{ studentData.nis }}</p>
        <p class="text-[10px] text-slate-500 italic">Tunjukkan QR Code ini ke guru piket untuk mencatat keterlambatan.</p>
      </div>
    </div>

  </AppLayout>
</template>

<script setup>
import { Head } from '@inertiajs/vue3';
import { ref, computed } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';
import QrcodeVue from 'qrcode.vue';

const showQrModal = ref(false);

const props = defineProps({
  siswa: Object,
  kelas: String,
  jadwal: Array,
  activeLiveExam: Object,
});

const todayLabel = computed(() =>
  new Date().toLocaleDateString('id-ID', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })
);

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

// Computed Data Siswa dari Props
const studentData = computed(() => {
  return {
    nama: props.siswa?.nama_siswa || 'Unknown',
    nis: props.siswa?.nis || 'N/A',
    nisn: props.siswa?.nisn || 'N/A',
    kelas: props.kelas || 'Unknown',
    jurusan: 'Sesuai Penjurusan', // Bisa diambil dari tabel kelas
    hadir: 42, // Dummy
    absen: 3,  // Dummy
    kehadiranPct: 93 // Dummy
  };
});

// Computed Jadwal dari Props
const jadwalList = computed(() => props.jadwal || []);
</script>
