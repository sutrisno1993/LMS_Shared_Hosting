<template>
  <Head title="Laporan Kehadiran Siswa" />

  <AppLayout
    title="Kepatuhan KBM (Laporan Kehadiran Siswa)"
    subtitle="Monitoring siswa sering absen dan tindakan wali kelas (Semester Berjalan)"
    :navigation="navigation"
  >
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
      <!-- SUMMARY CARDS -->
      <div class="lg:col-span-1 space-y-6">
        <div class="rounded-2xl border border-white/8 p-6 bg-red-500/10 border-l-4 border-l-red-500 shadow-lg">
          <h3 class="font-bold mb-1 text-red-400">🚨 Status Kritis</h3>
          <p class="text-xs text-slate-300 mb-4">Siswa Alfa >= 5 yang belum ditindaklanjuti Wali Kelas</p>
          <div class="text-5xl font-black text-white">{{ summary.totalKritis }}</div>
        </div>

        <div class="rounded-2xl border border-white/8 p-6" style="background: var(--card)">
          <h3 class="font-bold mb-4 flex items-center gap-2"><span>🏆</span> Top 3 Alfa Terbanyak</h3>
          <div class="space-y-4">
            <div v-if="summary.top3.length === 0" class="text-sm text-slate-500 text-center py-4">Belum ada data.</div>
            <div v-for="(siswa, index) in summary.top3" :key="siswa.id_siswa" class="flex items-center justify-between p-3 bg-white/5 rounded-xl border border-white/5">
              <div class="flex items-center gap-3">
                <div class="w-8 h-8 rounded-full bg-indigo-500/20 text-indigo-400 flex items-center justify-center font-bold text-sm">
                  {{ index + 1 }}
                </div>
                <div>
                  <div class="text-sm font-bold">{{ siswa.nama_siswa }}</div>
                  <div class="text-xs text-slate-400">{{ siswa.kelas }}</div>
                </div>
              </div>
              <div class="px-3 py-1 bg-red-500/20 text-red-400 rounded-lg font-bold text-sm border border-red-500/30">
                {{ siswa.alpa }} A
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- MAIN TABLE -->
      <div class="lg:col-span-2">
        <div class="rounded-2xl border border-white/8 flex flex-col h-full" style="background: var(--card)">
          <div class="p-5 border-b border-white/8 flex flex-wrap items-center justify-between gap-4 bg-white/2">
            <div class="font-bold text-sm">Data Seluruh Siswa (Diurutkan dari Alfa tertinggi)</div>
          </div>

          <div class="overflow-x-auto flex-1">
            <table class="w-full text-left">
              <thead>
                <tr class="border-b border-white/8 bg-black/20">
                  <th class="px-5 py-3 text-[10px] font-semibold text-slate-500 uppercase tracking-wider">Siswa & Kelas</th>
                  <th class="px-5 py-3 text-[10px] font-semibold text-slate-500 uppercase tracking-wider text-center">Statistik (A/I/S/T)</th>
                  <th class="px-5 py-3 text-[10px] font-semibold text-slate-500 uppercase tracking-wider">Status Penanganan</th>
                  <th class="px-5 py-3 text-[10px] font-semibold text-slate-500 uppercase tracking-wider text-right">Aksi</th>
                </tr>
              </thead>
              <tbody>
                <tr v-if="laporanData.length === 0">
                  <td colspan="4" class="px-5 py-10 text-center text-sm text-slate-500">
                    Tidak ada siswa yang absen pada semester ini.
                  </td>
                </tr>
                <tr v-for="siswa in laporanData" :key="siswa.id_siswa" class="border-b border-white/4 hover:bg-white/5 transition-colors">
                  <td class="px-5 py-4">
                    <div class="flex items-center gap-3">
                      <!-- Profil Singkat -->
                      <div class="w-10 h-10 rounded-full bg-slate-800 border border-white/10 flex items-center justify-center text-slate-400 font-bold">
                        {{ siswa.nama_siswa.substring(0, 1) }}
                      </div>
                      <div>
                        <div class="text-sm font-bold text-white">{{ siswa.nama_siswa }}</div>
                        <div class="text-[11px] text-slate-400 mt-0.5">NIS: {{ siswa.nis }} • Kelas: <span class="text-indigo-400 font-medium">{{ siswa.kelas }}</span></div>
                        <div class="text-[10px] text-slate-500 mt-0.5">Walas: {{ siswa.wali_kelas }}</div>
                      </div>
                    </div>
                  </td>
                  <td class="px-5 py-4 text-center">
                    <div class="flex items-center justify-center gap-2">
                      <span class="px-2.5 py-1 rounded-md text-xs font-bold border" :class="siswa.alpa > 0 ? 'bg-red-500/20 border-red-500/30 text-red-400' : 'bg-white/5 border-white/10 text-slate-500'">{{ siswa.alpa }} A</span>
                      <span class="px-2.5 py-1 rounded-md text-xs font-bold border" :class="siswa.izin > 0 ? 'bg-yellow-500/20 border-yellow-500/30 text-yellow-400' : 'bg-white/5 border-white/10 text-slate-500'">{{ siswa.izin }} I</span>
                      <span class="px-2.5 py-1 rounded-md text-xs font-bold border" :class="siswa.sakit > 0 ? 'bg-blue-500/20 border-blue-500/30 text-blue-400' : 'bg-white/5 border-white/10 text-slate-500'">{{ siswa.sakit }} S</span>
                      <span class="px-2.5 py-1 rounded-md text-xs font-bold border" :class="siswa.terlambat > 0 ? 'bg-orange-500/20 border-orange-500/30 text-orange-400' : 'bg-white/5 border-white/10 text-slate-500'">{{ siswa.terlambat }} T</span>
                    </div>
                  </td>
                  <td class="px-5 py-4">
                    <div v-if="siswa.status_penanganan === 'BELUM_DITINDAK'" class="flex items-center gap-2 text-red-400 text-xs font-bold bg-red-500/10 border border-red-500/20 px-3 py-1.5 rounded-lg w-max">
                      <span>🔴</span> Belum Ada Tindakan
                    </div>
                    <div v-else-if="siswa.status_penanganan === 'SUDAH_DITINDAK'" class="flex items-center gap-2 text-emerald-400 text-xs font-bold bg-emerald-500/10 border border-emerald-500/20 px-3 py-1.5 rounded-lg w-max">
                      <span>🟢</span> Sudah Ditindak
                    </div>
                    <div v-else class="flex items-center gap-2 text-yellow-400 text-xs font-bold bg-yellow-500/10 border border-yellow-500/20 px-3 py-1.5 rounded-lg w-max">
                      <span>🟡</span> Perlu Dipantau
                    </div>
                  </td>
                  <td class="px-5 py-4 text-right">
                    <div class="flex items-center justify-end gap-2">
                      <button 
                        @click="openHistoryModal(siswa)"
                        class="px-3 py-1.5 bg-slate-800 hover:bg-slate-700 text-white rounded-lg text-xs font-semibold transition-colors border border-white/10 flex items-center gap-1.5"
                      >
                        📄 Riwayat
                      </button>
                      <a 
                        v-if="siswa.status_penanganan === 'BELUM_DITINDAK' && siswa.no_hp_wali"
                        :href="`https://wa.me/${siswa.no_hp_wali}?text=Halo Bapak/Ibu ${siswa.wali_kelas}, mohon segera menindaklanjuti absensi siswa atas nama ${siswa.nama_siswa} (${siswa.kelas}) yang sudah memiliki ${siswa.alpa} Alfa.`"
                        target="_blank"
                        class="px-3 py-1.5 bg-emerald-600 hover:bg-emerald-500 text-white rounded-lg text-xs font-semibold transition-colors shadow-lg shadow-emerald-600/20 flex items-center gap-1.5"
                      >
                        💬 Hubungi Walas
                      </a>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>

    <!-- MODAL RIWAYAT -->
    <div v-if="showModal" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/80 backdrop-blur-sm animate-fade-in">
      <div class="bg-[#1a1b2e] rounded-2xl border border-white/10 shadow-2xl w-full max-w-2xl flex flex-col max-h-[85vh] overflow-hidden">
        <div class="p-5 border-b border-white/10 flex items-center justify-between bg-white/5">
          <h2 class="text-sm font-bold text-white flex items-center gap-2">
            <span>📄</span> Riwayat Tindakan Wali Kelas
          </h2>
          <button @click="showModal = false" class="text-slate-400 hover:text-white transition-colors text-2xl leading-none">&times;</button>
        </div>
        
        <div class="p-6 overflow-y-auto">
          <div class="flex items-center gap-4 mb-6 p-4 bg-black/20 rounded-xl border border-white/5">
            <div class="w-12 h-12 rounded-full bg-indigo-500/20 flex items-center justify-center text-indigo-400 font-bold text-lg">
              {{ selectedSiswa.nama_siswa.substring(0, 1) }}
            </div>
            <div>
              <div class="font-bold text-lg text-white">{{ selectedSiswa.nama_siswa }}</div>
              <div class="text-xs text-slate-400">Kelas: {{ selectedSiswa.kelas }} | Walas: {{ selectedSiswa.wali_kelas }}</div>
            </div>
          </div>

          <h3 class="font-bold text-sm mb-4 text-slate-300">Timeline Tindakan</h3>
          
          <div v-if="selectedSiswa.riwayat_tindakan.length === 0" class="text-center p-8 border border-dashed border-white/10 rounded-xl bg-white/2">
            <div class="text-3xl mb-2">📭</div>
            <div class="text-sm text-slate-400">Belum ada riwayat tindakan yang dicatat oleh wali kelas untuk absensi siswa ini.</div>
          </div>

          <div v-else class="relative border-l border-white/10 ml-4 space-y-6">
            <div v-for="riwayat in selectedSiswa.riwayat_tindakan" :key="riwayat.id" class="relative pl-6">
              <!-- Dot Timeline -->
              <div class="absolute w-3 h-3 bg-indigo-500 rounded-full -left-[6.5px] top-1.5 shadow-[0_0_10px_rgba(99,102,241,0.5)]"></div>
              
              <div class="bg-white/5 border border-white/10 rounded-xl p-4">
                <div class="flex justify-between items-start mb-2">
                  <div class="font-bold text-sm text-indigo-400">{{ riwayat.tipe_tindakan }}</div>
                  <div class="text-[10px] text-slate-400 bg-black/20 px-2 py-1 rounded">{{ formatDate(riwayat.tanggal) }}</div>
                </div>
                <p class="text-xs text-slate-300 mb-3 leading-relaxed">{{ riwayat.keterangan }}</p>
                <div v-if="riwayat.foto" class="mt-3">
                  <img :src="`/storage/${riwayat.foto}`" class="w-full max-w-[200px] rounded-lg border border-white/10" alt="Bukti Tindakan" />
                </div>
                <div v-if="riwayat.tindakan_lanjut" class="mt-3 text-[11px] bg-yellow-500/10 text-yellow-400 p-2 rounded-lg border border-yellow-500/20">
                  <span class="font-bold">Tindak Lanjut:</span> {{ riwayat.tindakan_lanjut }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </AppLayout>
</template>

<script setup>
import { ref } from 'vue';
import { Head } from '@inertiajs/vue3';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  laporanData: Array,
  summary: Object
});

const showModal = ref(false);
const selectedSiswa = ref(null);

const openHistoryModal = (siswa) => {
  selectedSiswa.value = siswa;
  showModal.value = true;
};

const formatDate = (dateString) => {
  if (!dateString) return '-';
  const options = { year: 'numeric', month: 'long', day: 'numeric' };
  return new Date(dateString).toLocaleDateString('id-ID', options);
};

// Sama seperti di AdminController
const navigation = [
  {
    label: 'Utama',
    items: [
      { href: '/admin/dashboard', icon: '📊', label: 'Dashboard' },
    ],
  },
  {
    label: 'Sekolah',
    items: [
      { href: '/admin/wali-kelas', icon: '👤', label: 'Wali Kelas' },
      { href: '/admin/siswa', icon: '👥', label: 'Data Siswa' },
      { href: '/admin/guru', icon: '👨‍🏫', label: 'Daftar Guru' },
      { href: '/admin/events', icon: '🗓️', label: 'Event & Libur' },
      { href: '/admin/kuesioner', icon: '⭐', label: 'Kuesioner Kinerja' },
    ],
  },
  {
    label: 'Konfigurasi',
    items: [
      { href: '/admin/piket', icon: '👮', label: 'Manajemen Piket' },
      { href: '/admin/jadwal-jp', icon: '⏰', label: 'Jadwal JP' },
      { href: '/admin/grade-config', icon: '⚖️', label: 'Bobot Nilai' },
      { href: '/admin/timeline', icon: '📅', label: 'Timeline' },
    ],
  },
  {
    label: 'Laporan',
    items: [
      { href: '/admin/laporan-kehadiran', icon: '📋', label: 'Kepatuhan KBM' },
      { href: '/admin/monitoring-nilai', icon: '📈', label: 'Monitoring Nilai' },
      { href: '/admin/rapor', icon: '📋', label: 'Ekspor Rapor' },
      { href: '/admin/laporan-performa', icon: '🏆', label: 'Laporan Performa' },
      { href: '/admin/jurnal', icon: '📓', label: 'Jurnal Tatap Muka' },
      { href: '/admin/laporan-kasus-siswa', icon: '⚡', label: 'Laporan Kasus' },
    ],
  }
];
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease, transform 0.3s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}
</style>
