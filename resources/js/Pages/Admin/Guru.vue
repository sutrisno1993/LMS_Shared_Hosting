<template>
  <Head title="Daftar Guru Aktif" />

  <AppLayout
    title="Daftar Guru Aktif"
    subtitle="Daftar nama guru beserta kontak WhatsApp untuk koordinasi"
    :navigation="navigation"
  >
    <!-- Card Container -->
    <div class="rounded-2xl border border-white/8 flex flex-col overflow-hidden" style="background: var(--card)">
      <!-- Toolbar -->
      <div class="p-5 border-b border-white/8 flex flex-wrap items-center justify-between gap-4 bg-white/2">
        <div class="font-bold text-sm">Daftar Guru ({{ filteredTeachers.length }} Orang)</div>
        
        <!-- Search Input -->
        <div class="relative w-full sm:w-64">
          <input
            v-model="searchQuery"
            type="text"
            placeholder="🔍 Cari nama atau kode guru..."
            class="w-full bg-black/20 border border-white/10 rounded-xl px-4 py-2 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
          />
        </div>
      </div>

      <!-- Table / List -->
      <div class="overflow-x-auto">
        <table class="w-full text-left">
          <thead>
            <tr class="border-b border-white/8 bg-black/20">
              <th class="px-5 py-3.5 text-[10px] font-semibold text-slate-500 uppercase tracking-wider">Guru</th>
              <th class="px-5 py-3.5 text-[10px] font-semibold text-slate-500 uppercase tracking-wider">Kode Guru</th>
              <th class="px-5 py-3.5 text-[10px] font-semibold text-slate-500 uppercase tracking-wider">No. WhatsApp</th>
              <th class="px-5 py-3.5 text-[10px] font-semibold text-slate-500 uppercase tracking-wider text-right">Aksi</th>
            </tr>
          </thead>
          <tbody>
            <tr v-if="filteredTeachers.length === 0">
              <td colspan="4" class="px-5 py-12 text-center text-sm text-slate-500">
                Tidak ada data guru ditemukan dengan kata kunci tersebut.
              </td>
            </tr>
            <tr 
              v-for="guru in filteredTeachers" 
              :key="guru.id_guru"
              class="border-b border-white/4 hover:bg-white/5 transition-colors"
            >
              <!-- Info Name & Avatar -->
              <td class="px-5 py-3">
                <div class="flex items-center gap-3">
                  <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-indigo-500/20 to-violet-600/20 border border-indigo-500/30 flex items-center justify-center font-bold text-xs text-indigo-300">
                    {{ getInitials(guru.nama_guru) }}
                  </div>
                  <div>
                    <div class="text-sm font-semibold text-white">{{ guru.nama_guru }}</div>
                    <div class="text-[10px] text-slate-400">Guru Pengajar</div>
                  </div>
                </div>
              </td>

              <!-- Kode Guru -->
              <td class="px-5 py-3">
                <span class="px-2 py-1 bg-white/5 rounded text-xs font-mono font-bold border border-white/10 text-indigo-400">
                  {{ guru.kode_guru || '-' }}
                </span>
              </td>

              <!-- No WhatsApp -->
              <td class="px-5 py-3">
                <div v-if="guru.no_wa" class="flex items-center gap-1.5 text-xs text-slate-300">
                  <span class="text-emerald-400">🟢</span> {{ formatPhoneNumber(guru.no_wa) }}
                </div>
                <div v-else class="text-xs text-slate-500 font-italic">
                  Tidak ada kontak
                </div>
              </td>

              <!-- Action Button -->
              <td class="px-5 py-3 text-right">
                <a 
                  v-if="guru.no_wa"
                  :href="formatWaLink(guru.no_wa)" 
                  target="_blank" 
                  class="inline-flex items-center gap-1.5 px-3 py-1.5 bg-emerald-600/10 hover:bg-emerald-600 hover:text-white text-emerald-400 text-xs font-bold rounded-xl border border-emerald-500/20 transition-all hover:scale-[1.02] active:scale-[0.98]"
                >
                  <span>💬</span> Hubungi via WA
                </a>
                <span v-else class="text-[11px] text-slate-600 italic">No WA belum diatur</span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Footer Info -->
      <div class="p-4 border-t border-white/8 flex items-center justify-between text-xs text-slate-400">
        <div>Menampilkan {{ filteredTeachers.length }} dari {{ teachers.length }} total guru</div>
      </div>
    </div>
  </AppLayout>
</template>

<script setup>
import { ref, computed } from 'vue';
import { Head } from '@inertiajs/vue3';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  teachers: Array
});

const searchQuery = ref('');

// Filter guru berdasarkan search input
const filteredTeachers = computed(() => {
  if (!searchQuery.value) return props.teachers;
  const q = searchQuery.value.toLowerCase();
  return props.teachers.filter(guru => 
    guru.nama_guru.toLowerCase().includes(q) || 
    (guru.kode_guru && guru.kode_guru.toLowerCase().includes(q))
  );
});

// Dapatkan inisial nama guru
const getInitials = (name) => {
  if (!name) return 'G';
  return name.split(' ').map(w => w[0]).slice(0, 2).join('').toUpperCase();
};

// Format tampilan nomor HP (contoh: 0812-3456-7890)
const formatPhoneNumber = (num) => {
  if (!num) return '-';
  let clean = num.replace(/[^0-9]/g, '');
  if (clean.length > 4) {
    return clean.replace(/(\d{4})(\d{4})(\d{1,5})/, '$1-$2-$3');
  }
  return clean;
};

// Buat wa.me link dengan kode negara 62
const formatWaLink = (noWa) => {
  if (!noWa) return '#';
  let clean = noWa.replace(/[^0-9]/g, '');
  if (clean.startsWith('0')) {
    clean = '62' + clean.slice(1);
  }
  return `https://wa.me/${clean}`;
};

// Navigation
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
      { href: '/admin/jadwal-jp', icon: '⏰', label: 'Jadwal JP' },
      { href: '/admin/grade-config', icon: '⚖️', label: 'Bobot Nilai' },
      { href: '/admin/timeline', icon: '📅', label: 'Timeline' },
    ],
  },
  {
    label: 'Laporan',
    items: [
      { href: '/admin/monitoring-nilai', icon: '📈', label: 'Monitoring Nilai' },
      { href: '/admin/rapor', icon: '📋', label: 'Ekspor Rapor' },
      { href: '/admin/laporan-performa', icon: '🏆', label: 'Laporan Performa' },
      { href: '/admin/jurnal', icon: '📓', label: 'Jurnal Tatap Muka' },
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
