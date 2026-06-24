<template>
  <Head :title="`Sesi KBM — ${session?.mapel}`" />

  <AppLayout
    :title="`Sesi KBM Aktif`"
    :subtitle="`${session?.mapel} — ${session?.kelas}`"
    :navigation="navigation"
  >
    <template #topbar-actions>
      <span class="text-xs font-mono" :class="sessionStatus === 'AKTIF' ? 'text-green-400' : 'text-yellow-400'">
        {{ sessionStatus === 'AKTIF' ? '🟢 Sesi Tervalidasi' : '🟡 Menunggu Scan Pertama' }}
      </span>
    </template>

    <div class="grid grid-cols-2 gap-6">

      <!-- ===================== PANEL KIRI: QR ENGINE ===================== -->
      <div class="space-y-5">

        <!-- Status Card -->
        <div :class="[
          'rounded-2xl border p-5 transition-all duration-500',
          sessionStatus === 'AKTIF'
            ? 'border-green-500/30 bg-green-500/8'
            : 'border-yellow-500/30 bg-yellow-500/8'
        ]">
          <div class="flex items-center gap-3">
            <div :class="[
              'w-12 h-12 rounded-xl flex items-center justify-center text-2xl flex-shrink-0',
              sessionStatus === 'AKTIF' ? 'bg-green-500/20' : 'bg-yellow-500/20'
            ]">
              {{ sessionStatus === 'AKTIF' ? '✅' : '⏳' }}
            </div>
            <div>
              <div class="font-bold" :class="sessionStatus === 'AKTIF' ? 'text-green-400' : 'text-yellow-400'">
                {{ sessionStatus === 'AKTIF' ? 'KELAS AKTIF / VALID' : 'PENDING — Menunggu Scan Pertama' }}
              </div>
              <div class="text-xs text-slate-500 mt-0.5">
                {{ sessionStatus === 'AKTIF'
                  ? `${firstScanTime} — Divalidasi oleh ${firstScanStudent}`
                  : 'Minta 1 siswa untuk scan QR Code agar sesi dikonfirmasi'
                }}
              </div>
            </div>
          </div>
        </div>

        <!-- QR Code Container -->
        <div class="rounded-2xl border border-white/8 p-7 text-center" style="background: var(--card)">
          <div class="text-sm font-bold mb-1">QR Code Absensi</div>
          <div class="text-xs text-slate-500 mb-5">Token berputar otomatis setiap 15 menit</div>

          <!-- QR + Countdown ring -->
          <div class="relative inline-block">
            <!-- SVG Countdown ring -->
            <svg class="absolute inset-0 w-full h-full -rotate-90" viewBox="0 0 200 200"
                 style="width:220px;height:220px;top:-10px;left:-10px;">
              <circle cx="100" cy="100" r="90" fill="none" stroke="rgba(255,255,255,0.05)" stroke-width="4"/>
              <circle
                cx="100" cy="100" r="90"
                fill="none"
                stroke="#4F46E5"
                stroke-width="4"
                stroke-linecap="round"
                :stroke-dasharray="565"
                :stroke-dashoffset="565 - (565 * countdownPct / 100)"
                style="transition: stroke-dashoffset 1s linear;"
              />
            </svg>

            <!-- QR Code box -->
            <div class="relative w-48 h-48 mx-auto rounded-2xl bg-white flex items-center justify-center shadow-2xl shadow-indigo-500/20"
                 style="width:200px;height:200px;">
              <!-- Simulated QR grid -->
              <div class="grid gap-0.5 p-3" style="display:grid;grid-template-columns:repeat(7,1fr);gap:3px;padding:12px;">
                <div v-for="i in 49" :key="i"
                     :class="['rounded-sm', qrPattern[i % qrPattern.length] ? 'bg-gray-900' : 'bg-transparent']"
                     style="width:18px;height:18px;">
                </div>
              </div>
              <!-- Corner markers -->
              <div class="absolute top-2.5 left-2.5 w-8 h-8 border-4 border-gray-900 rounded"></div>
              <div class="absolute top-2.5 right-2.5 w-8 h-8 border-4 border-gray-900 rounded"></div>
              <div class="absolute bottom-2.5 left-2.5 w-8 h-8 border-4 border-gray-900 rounded"></div>
              <div class="absolute top-4 left-4 w-4 h-4 bg-gray-900 rounded-sm"></div>
              <div class="absolute top-4 right-4 w-4 h-4 bg-gray-900 rounded-sm"></div>
              <div class="absolute bottom-4 left-4 w-4 h-4 bg-gray-900 rounded-sm"></div>

              <!-- Scanning line animation -->
              <div class="absolute inset-x-0 h-0.5 bg-gradient-to-r from-transparent via-indigo-500 to-transparent opacity-80"
                   :style="`top: ${scanLineY}%;transition: top 0.05s linear;`"></div>
            </div>
          </div>

          <!-- Countdown display -->
          <div class="mt-6">
            <div class="text-3xl font-black font-mono tabular-nums"
                 :class="countdownSecs < 60 ? 'text-red-400' : countdownSecs < 180 ? 'text-yellow-400' : 'text-indigo-400'">
              {{ countdownDisplay }}
            </div>
            <div class="text-xs text-slate-500 mt-1">Token kedaluwarsa dalam</div>
          </div>

          <!-- Refresh button (manual) -->
          <button
            @click="refreshToken"
            :disabled="isRefreshing"
            class="mt-4 px-4 py-2 rounded-lg border border-white/10 text-xs text-slate-400 hover:text-white hover:border-white/25 transition-colors disabled:opacity-40">
            {{ isRefreshing ? '🔄 Memperbarui...' : '🔄 Perbarui Token Sekarang' }}
          </button>
        </div>

        <!-- Session Info -->
        <div class="rounded-2xl border border-white/8 p-5" style="background: var(--card)">
          <div class="text-sm font-bold mb-4">Informasi Sesi</div>
          <div class="grid grid-cols-2 gap-3">
            <div v-for="info in sessionInfo" :key="info.label"
                 class="bg-white/4 rounded-xl p-3">
              <div class="text-[10px] text-slate-600 uppercase tracking-wide">{{ info.label }}</div>
              <div class="text-sm font-semibold mt-1" :class="info.color || 'text-white'">{{ info.value }}</div>
            </div>
          </div>
        </div>

        <!-- ===================== MODUL UJIAN LIVE ===================== -->
        <div v-if="sessionStatus === 'AKTIF'" class="rounded-2xl border border-indigo-500/30 p-5 bg-indigo-500/5 shadow-[0_0_20px_rgba(79,70,229,0.1)]">
          <div class="flex items-center gap-3 mb-4">
            <div class="w-10 h-10 rounded-xl bg-indigo-500/20 text-indigo-400 flex items-center justify-center text-xl">🚀</div>
            <div>
              <h3 class="font-bold text-white text-sm">Luncurkan Ujian Live</h3>
              <p class="text-[10px] text-indigo-300">Pilih paket soal untuk dikirim ke HP siswa saat ini juga.</p>
            </div>
          </div>

          <form @submit.prevent="launchExam" v-if="questionBanks && questionBanks.length > 0">
            <select v-model="selectedBankId" required class="w-full bg-black/50 border border-indigo-500/30 rounded-xl px-3 py-2.5 text-xs text-white mb-3 outline-none focus:border-indigo-400">
              <option value="" disabled>Pilih Paket Soal...</option>
              <option v-for="bank in questionBanks" :key="bank.id_bank" :value="bank.id_bank">{{ bank.judul }}</option>
            </select>
            <button type="submit" class="w-full py-2.5 rounded-xl font-bold text-xs text-white transition-all bg-indigo-600 hover:bg-indigo-500 shadow-lg shadow-indigo-500/20">
              Mulai Ujian Sekarang
            </button>
          </form>

          <div v-else class="text-xs text-slate-400 bg-white/5 p-3 rounded-xl border border-white/10 text-center">
            Anda belum memiliki bank soal untuk mapel ini. 
            <a href="/guru/bank-soal/create" class="text-indigo-400 hover:underline block mt-1">Buat Paket Soal</a>
          </div>
        </div>

      </div>

      <!-- ===================== PANEL KANAN: ABSENSI SISWA ===================== -->
      <div class="space-y-5">

        <!-- Attendance summary -->
        <div class="grid grid-cols-4 gap-3">
          <div v-for="s in attendanceSummary" :key="s.label"
               class="rounded-xl border border-white/8 p-3.5 text-center"
               style="background: var(--card)">
            <div class="text-xl font-black" :style="`color:${s.color}`">{{ s.count }}</div>
            <div class="text-[10px] text-slate-600 mt-0.5">{{ s.label }}</div>
          </div>
        </div>

        <!-- Student list -->
        <div class="rounded-2xl border border-white/8 overflow-hidden" style="background: var(--card)">
          <div class="flex items-center justify-between px-5 py-4 border-b border-white/8">
            <div>
              <div class="font-bold text-sm">Daftar Siswa</div>
              <div class="text-xs text-slate-500">{{ session?.kelas }} — {{ students.length }} siswa</div>
            </div>
            <!-- Manual absensi hanya aktif setelah sesi AKTIF -->
            <div v-if="sessionStatus !== 'AKTIF'"
                 class="text-[10px] text-yellow-400 bg-yellow-500/10 border border-yellow-500/20 px-2.5 py-1.5 rounded-lg">
              🔒 Tunggu scan pertama
            </div>
            <div v-else class="text-[10px] text-green-400">
              ✅ Absensi manual terbuka
            </div>
          </div>

          <!-- Filter tabs -->
          <div class="flex border-b border-white/8">
            <button v-for="tab in ['Semua', 'Hadir', 'Belum']" :key="tab"
                    @click="activeTab = tab"
                    :class="[
                      'flex-1 py-2.5 text-xs font-semibold transition-colors',
                      activeTab === tab
                        ? 'text-indigo-400 border-b-2 border-indigo-500'
                        : 'text-slate-600 hover:text-slate-400'
                    ]">
              {{ tab }}
            </button>
          </div>

          <!-- Search -->
          <div class="px-4 py-3 border-b border-white/5">
            <input
              v-model="searchQuery"
              type="text"
              placeholder="🔍 Cari nama siswa..."
              class="w-full bg-white/5 border border-white/8 rounded-lg px-3 py-2 text-xs text-white placeholder-slate-600 outline-none focus:border-indigo-500/50"
            />
          </div>

          <!-- Students -->
          <div class="overflow-y-auto" style="max-height: 420px;">
            <div v-for="siswa in filteredStudents" :key="siswa.id"
                 class="flex items-center gap-3 px-4 py-3 border-b border-white/4 hover:bg-white/2 transition-colors">

              <!-- Avatar -->
              <div class="w-8 h-8 rounded-lg flex items-center justify-center text-xs font-bold flex-shrink-0"
                   :class="siswa.status === 'HADIR' ? 'bg-green-500/20 text-green-400' : 'bg-white/8 text-slate-500'">
                {{ siswa.nama.split(' ').map(w=>w[0]).slice(0,2).join('') }}
              </div>

              <!-- Name + NIS -->
              <div class="flex-1 min-w-0">
                <div class="text-xs font-semibold truncate">{{ siswa.nama }}</div>
                <div class="text-[10px] text-slate-600">{{ siswa.nis }}</div>
              </div>

              <!-- Metode badge (jika sudah hadir) -->
              <div v-if="siswa.status === 'HADIR'" class="text-right">
                <div class="badge-hadir text-[10px]">{{ siswa.metode === 'SCAN_QR' ? '📱 QR' : '✋ Manual' }}</div>
                <div class="text-[10px] text-slate-600 mt-0.5">{{ siswa.waktu }}</div>
              </div>

              <!-- Manual action (hanya jika sesi AKTIF dan siswa belum hadir) -->
              <div v-else-if="sessionStatus === 'AKTIF'" class="flex items-center gap-1.5 flex-shrink-0">
                <select
                  v-model="siswa.statusPilihan"
                  class="bg-white/6 border border-white/12 rounded-lg px-2 py-1.5 text-[11px] text-slate-300 outline-none focus:border-indigo-500/50"
                  :disabled="siswa.status === 'HADIR'">
                  <option value="ALPA">Alpa</option>
                  <option value="IZIN">Izin</option>
                  <option value="SAKIT">Sakit</option>
                </select>
                <button
                  @click="absenManual(siswa)"
                  class="w-8 h-8 rounded-lg bg-indigo-600 hover:bg-indigo-500 text-white text-xs flex items-center justify-center transition-colors">
                  ✓
                </button>
              </div>

              <!-- Locked state -->
              <div v-else class="text-slate-700 text-sm">—</div>

            </div>
          </div>
        </div>

        <!-- Save all button -->
        <button
          v-if="sessionStatus === 'AKTIF'"
          class="w-full py-3.5 rounded-xl font-bold text-sm text-white transition-all hover:-translate-y-0.5"
          style="background: linear-gradient(135deg, #22C55E, #16A34A); box-shadow: 0 8px 20px rgba(34,197,94,0.3);">
          💾 Simpan Semua Presensi
        </button>

      </div>
    </div>
  </AppLayout>
</template>

<script setup>
import { Head, router } from '@inertiajs/vue3';
import { ref, computed, onMounted, onUnmounted } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({ 
  sessionId: [String, Number], 
  session: Object, 
  students: Array,
  questionBanks: Array
});

// ---- Session state ----
const sessionStatus = ref('PENDING'); // PENDING | AKTIF
const firstScanTime = ref('07:47');
const firstScanStudent = ref('Ahmad Rifai');
const isRefreshing = ref(false);

const selectedBankId = ref('');
const launchExam = () => {
  if (!selectedBankId.value) return;
  router.post(`/guru/live-exam/launch`, {
    id_bank: selectedBankId.value,
    id_kbm_session: props.sessionId
  });
};

// ---- QR Countdown (900 detik = 15 menit) ----
const countdownSecs = ref(785);
let countdownTimer;

onMounted(() => {
  // Simulasi: setelah 3 detik, langsung AKTIF untuk demo
  setTimeout(() => sessionStatus.value = 'AKTIF', 3000);

  countdownTimer = setInterval(() => {
    if (countdownSecs.value > 0) {
      countdownSecs.value--;
    } else {
      countdownSecs.value = 900;
      refreshToken();
    }
  }, 1000);

  // Animate scan line
  scanLineInterval = setInterval(() => {
    scanLineY.value = (scanLineY.value + 0.8) % 100;
  }, 30);
});

onUnmounted(() => {
  clearInterval(countdownTimer);
  clearInterval(scanLineInterval);
});

const countdownDisplay = computed(() => {
  const m = Math.floor(countdownSecs.value / 60);
  const s = countdownSecs.value % 60;
  return `${String(m).padStart(2,'0')}:${String(s).padStart(2,'0')}`;
});
const countdownPct = computed(() => (countdownSecs.value / 900) * 100);

// Scan line animation
const scanLineY = ref(0);
let scanLineInterval;

// QR pattern for visual (purely decorative)
const qrPattern = [1,0,1,1,0,0,1,0,1,0,1,1,0,1,1,0,0,1,0,0,1,1,0,1,0,1,0,0,1,1,0,0,1,1,0,1,0,1,1,0,0,1,1,1,0,1,0,0,1];

const refreshToken = () => {
  isRefreshing.value = true;
  // In real app: axios.post(`/guru/sesi-kbm/${props.sessionId}/refresh-token`)
  setTimeout(() => {
    isRefreshing.value = false;
    countdownSecs.value = 900;
  }, 1200);
};

// ---- Session info ----
const session = ref(props.session || {
  mapel: 'Dasar-Dasar Jaringan Komputer',
  kelas: 'XII TKJ 1',
  ruang: 'Lab TKJ',
  jamMulai: '07:45',
  jamSelesai: '09:15',
  tanggal: 'Sabtu, 21 Juni 2026',
  statusGuru: 'HADIR',
  waktuMulai: '07:47',
});

const sessionInfo = computed(() => [
  { label: 'Mata Pelajaran', value: session.value.mapel },
  { label: 'Kelas', value: session.value.kelas },
  { label: 'Jam Pelajaran', value: `${session.value.jamMulai} – ${session.value.jamSelesai}` },
  { label: 'Status Guru', value: session.value.statusGuru, color: session.value.statusGuru === 'HADIR' ? 'text-green-400' : session.value.statusGuru === 'TERLAMBAT' ? 'text-yellow-400' : 'text-red-400' },
  { label: 'Waktu Aktivasi', value: session.value.waktuMulai },
  { label: 'Tanggal', value: session.value.tanggal },
]);

// ---- Students ----
const activeTab = ref('Semua');
const searchQuery = ref('');

const students = ref(props.students || [
  { id: 1, nama: 'Ahmad Rifai', nis: '2024001', status: 'HADIR', metode: 'SCAN_QR', waktu: '07:47', statusPilihan: 'ALPA' },
  { id: 2, nama: 'Budi Santoso', nis: '2024002', status: 'HADIR', metode: 'SCAN_QR', waktu: '07:48', statusPilihan: 'ALPA' },
  { id: 3, nama: 'Citra Dewi', nis: '2024003', status: 'HADIR', metode: 'MANUAL_GURU', waktu: '07:50', statusPilihan: 'ALPA' },
  { id: 4, nama: 'Dian Pratama', nis: '2024004', status: null, metode: null, waktu: null, statusPilihan: 'ALPA' },
  { id: 5, nama: 'Eka Rahayu', nis: '2024005', status: null, metode: null, waktu: null, statusPilihan: 'IZIN' },
  { id: 6, nama: 'Farhan Maulana', nis: '2024006', status: null, metode: null, waktu: null, statusPilihan: 'ALPA' },
  { id: 7, nama: 'Gita Novia', nis: '2024007', status: 'HADIR', metode: 'SCAN_QR', waktu: '07:49', statusPilihan: 'ALPA' },
  { id: 8, nama: 'Hendra Wijaya', nis: '2024008', status: null, metode: null, waktu: null, statusPilihan: 'SAKIT' },
  { id: 9, nama: 'Intan Permata', nis: '2024009', status: 'HADIR', metode: 'SCAN_QR', waktu: '07:51', statusPilihan: 'ALPA' },
  { id: 10, nama: 'Joko Susilo', nis: '2024010', status: null, metode: null, waktu: null, statusPilihan: 'ALPA' },
  { id: 11, nama: 'Kartika Sari', nis: '2024011', status: 'HADIR', metode: 'SCAN_QR', waktu: '07:52', statusPilihan: 'ALPA' },
  { id: 12, nama: 'Luthfi Hakim', nis: '2024012', status: null, metode: null, waktu: null, statusPilihan: 'ALPA' },
]);

const filteredStudents = computed(() => {
  let list = students.value;
  if (activeTab.value === 'Hadir') list = list.filter(s => s.status === 'HADIR');
  if (activeTab.value === 'Belum') list = list.filter(s => s.status !== 'HADIR');
  if (searchQuery.value) {
    const q = searchQuery.value.toLowerCase();
    list = list.filter(s => s.nama.toLowerCase().includes(q) || s.nis.includes(q));
  }
  return list;
});

const attendanceSummary = computed(() => [
  { label: 'Hadir', count: students.value.filter(s => s.status === 'HADIR').length, color: '#22C55E' },
  { label: 'Alpa', count: students.value.filter(s => !s.status).length, color: '#EF4444' },
  { label: 'Izin', count: students.value.filter(s => s.statusPilihan === 'IZIN' && !s.status).length, color: '#3B82F6' },
  { label: 'Sakit', count: students.value.filter(s => s.statusPilihan === 'SAKIT' && !s.status).length, color: '#F59E0B' },
]);

const absenManual = (siswa) => {
  siswa.status = 'HADIR';
  siswa.metode = 'MANUAL_GURU';
  siswa.waktu = new Date().toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit' });
  // router.post(...)
};

const navigation = [
  {
    label: 'KBM (Kegiatan Belajar Mengajar)',
    items: [
      { href: '/guru/dashboard', icon: '📊', label: 'Dashboard' },
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
</script>
