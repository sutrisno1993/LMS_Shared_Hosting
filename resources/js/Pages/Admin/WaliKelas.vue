<template>
  <Head title="Manajemen Wali Kelas" />

  <AppLayout
    title="Penugasan Wali Kelas"
    subtitle="Kelola guru pendamping untuk setiap rombongan belajar"
    :navigation="navigation"
  >
    <!-- Alert notification is handled globally by AppLayout toast -->

    <div class="flex justify-end mb-6">
      <button 
        @click="resetAll"
        :disabled="isResettingAll"
        class="px-4 py-2 bg-rose-500/10 text-rose-400 border border-rose-500/20 hover:bg-rose-500 hover:text-white transition-all rounded-xl text-sm font-bold flex items-center gap-2 disabled:opacity-50"
      >
        <span>⚠️</span> {{ isResettingAll ? 'Mereset...' : 'Reset Seluruh Wali Kelas' }}
      </button>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
      <div 
        v-for="cls in classes" 
        :key="cls.id_kelas"
        class="rounded-2xl border border-white/8 overflow-hidden relative group hover:border-indigo-500/50 transition-colors"
        style="background: var(--card)"
      >
        <div class="p-5 flex flex-col h-full">
          <!-- Class Badge -->
          <div class="flex items-center justify-between mb-4">
            <div class="text-xs font-bold px-2 py-1 rounded bg-indigo-500/20 text-indigo-400 tracking-wider">
              {{ cls.tingkat }} {{ cls.jurusan }}
            </div>
            <div class="w-2 h-2 rounded-full" :class="cls.id_guru_wali ? 'bg-green-500 shadow-[0_0_8px_rgba(34,197,94,0.6)]' : 'bg-red-500/50'"></div>
          </div>
          
          <h3 class="text-2xl font-black tracking-tight mb-6">{{ cls.nama_kelas }}</h3>
          
          <!-- CCTV Config Info -->
          <div class="mb-5 bg-black/10 rounded-xl p-3 border border-white/5 flex items-center justify-between">
            <div>
              <div class="text-[9px] uppercase font-bold text-slate-500 tracking-wider">CCTV Kelas</div>
              <div class="text-xs font-bold mt-0.5" :class="cls.cctv_type && cls.cctv_type !== 'NONE' ? 'text-indigo-400' : 'text-slate-400'">
                {{ cls.cctv_type && cls.cctv_type !== 'NONE' ? `Aktif (${cls.cctv_type})` : 'Nonaktif' }}
              </div>
            </div>
            <button 
              @click="openCctvConfig(cls)"
              class="px-2.5 py-1.5 bg-indigo-600/10 hover:bg-indigo-600 hover:text-white text-indigo-400 border border-indigo-500/20 rounded-lg text-[10px] font-bold transition-all"
            >
              🎥 Atur
            </button>
          </div>
          
          <div class="mt-auto">
            <div class="flex items-center justify-between mb-2">
              <label class="block text-[10px] uppercase font-bold text-slate-500 tracking-wider">Wali Kelas</label>
              <button 
                v-if="cls.id_guru_wali" 
                @click="resetWaliKelas(cls)" 
                class="text-[10px] text-rose-400 hover:text-rose-300 transition-colors font-bold flex items-center gap-1"
                title="Hapus penugasan wali kelas"
              >
                <span>✕</span> Kosongkan
              </button>
            </div>
            <div class="relative">
              <select 
                v-model="cls.id_guru_wali" 
                @change="updateWaliKelas(cls)"
                class="w-full bg-black/20 border border-white/10 rounded-lg pl-3 pr-8 py-2.5 text-sm font-medium text-white appearance-none focus:outline-none focus:ring-1 focus:ring-indigo-500 focus:border-indigo-500 transition-all hover:bg-black/40"
                :class="{'text-slate-400': !cls.id_guru_wali}"
              >
                <option :value="null">-- Belum Ditugaskan --</option>
                <option 
                  v-for="guru in teachers" 
                  :key="guru.id_guru" 
                  :value="guru.id_guru"
                  :disabled="isTeacherAssigned(guru.id_guru, cls.id_kelas)"
                >
                  {{ guru.nama_guru }} {{ isTeacherAssigned(guru.id_guru, cls.id_kelas) ? '(Sudah Ditugaskan)' : '' }}
                </option>
              </select>
              <!-- custom dropdown arrow -->
              <div class="absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none text-slate-500 text-xs">▼</div>
            </div>
          </div>
        </div>
        
        <!-- Loading overlay -->
        <div v-if="savingId === cls.id_kelas" class="absolute inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-10 rounded-2xl">
          <div class="w-6 h-6 rounded-full border-2 border-indigo-500 border-t-transparent animate-spin"></div>
        </div>
      </div>
    </div>

    <!-- CCTV CONFIG MODAL -->
    <div v-if="selectedClassForCctv" class="fixed inset-0 z-[100] bg-black/60 backdrop-blur-sm flex items-center justify-center p-4">
      <div class="bg-[#1E293B] rounded-2xl border border-white/10 w-full max-w-md overflow-hidden shadow-2xl relative">
        <div class="px-6 py-4 border-b border-white/10 bg-indigo-600/20 flex justify-between items-center">
          <h3 class="text-lg font-black text-white">Pengaturan CCTV - {{ selectedClassForCctv.nama_kelas }}</h3>
          <button @click="closeCctvConfig" class="text-white/50 hover:text-white transition-colors">✕</button>
        </div>
        <form @submit.prevent="saveCctvConfig" class="p-6 space-y-4">
          <div>
            <label class="block text-xs uppercase font-bold text-slate-400 mb-2">Tipe Koneksi CCTV</label>
            <select 
              v-model="cctvForm.cctv_type"
              class="w-full bg-[#111827] border border-white/10 rounded-lg px-3 py-2.5 text-sm font-medium text-white focus:outline-none focus:ring-1 focus:ring-indigo-500 focus:border-indigo-500 transition-all"
            >
              <option value="NONE">Tidak Ada / Nonaktif</option>
              <option value="STREAM">Direct HLS Stream (.m3u8)</option>
              <option value="IFRAME">EZVIZ Iframe Embed Link</option>
            </select>
          </div>

          <div v-if="cctvForm.cctv_type !== 'NONE'">
            <label class="block text-xs uppercase font-bold text-slate-400 mb-2">
              {{ cctvForm.cctv_type === 'IFRAME' ? 'Link Iframe Embed (Ezviz)' : 'URL Stream (.m3u8 / RTSP Gateway)' }}
            </label>
            <input 
              type="text" 
              v-model="cctvForm.cctv_url"
              placeholder="https://..."
              class="w-full bg-[#111827] border border-white/10 rounded-lg px-3 py-2.5 text-sm text-white focus:outline-none focus:ring-1 focus:ring-indigo-500 focus:border-indigo-500 transition-all"
              required
            />
            <p class="text-[10px] text-slate-500 mt-1">
              {{ cctvForm.cctv_type === 'IFRAME' 
                ? 'Contoh: https://open.ys7.com/openlive/xxxx.html?autoplay=1 atau link https://open.ezvizlife.com/ezopen/h5/iframe?url=...' 
                : 'Contoh: http://192.168.1.100:8554/live/kelas_10a.m3u8 (HLS Stream dari media server local seperti MediaMTX)' 
              }}
            </p>
          </div>

          <div v-if="cctvForm.cctv_type !== 'NONE'">
            <label class="block text-xs uppercase font-bold text-slate-400 mb-2">Kode Verifikasi CCTV (Opsional)</label>
            <input 
              type="text" 
              v-model="cctvForm.cctv_verification_code"
              placeholder="Masukkan kode verifikasi (biasanya di label CCTV)"
              class="w-full bg-[#111827] border border-white/10 rounded-lg px-3 py-2.5 text-sm text-white focus:outline-none focus:ring-1 focus:ring-indigo-500 focus:border-indigo-500 transition-all"
            />
          </div>

          <div class="pt-4 border-t border-white/5 flex justify-end gap-2">
            <button 
              type="button" 
              @click="closeCctvConfig" 
              class="px-4 py-2 bg-slate-700 hover:bg-slate-600 rounded-lg text-xs font-bold text-white transition-colors"
            >
              Batal
            </button>
            <button 
              type="submit" 
              :disabled="isSavingCctv"
              class="px-4 py-2 bg-indigo-600 hover:bg-indigo-500 disabled:opacity-50 rounded-lg text-xs font-bold text-white transition-colors"
            >
              {{ isSavingCctv ? 'Menyimpan...' : 'Simpan Pengaturan' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </AppLayout>
</template>

<script setup>
import { ref } from 'vue';
import { Head, router } from '@inertiajs/vue3';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  classes: Array,
  teachers: Array
});

const savingId = ref(null);

const selectedClassForCctv = ref(null);
const isSavingCctv = ref(false);
const cctvForm = ref({
  id_kelas: null,
  cctv_type: 'NONE',
  cctv_url: '',
  cctv_verification_code: ''
});

const openCctvConfig = (cls) => {
  selectedClassForCctv.value = cls;
  cctvForm.value = {
    id_kelas: cls.id_kelas,
    cctv_type: cls.cctv_type || 'NONE',
    cctv_url: cls.cctv_url || '',
    cctv_verification_code: cls.cctv_verification_code || ''
  };
};

const closeCctvConfig = () => {
  selectedClassForCctv.value = null;
};

const saveCctvConfig = () => {
  isSavingCctv.value = true;
  router.post('/admin/classes/cctv', cctvForm.value, {
    preserveScroll: true,
    onSuccess: () => {
      closeCctvConfig();
    },
    onFinish: () => {
      isSavingCctv.value = false;
    }
  });
};

const isTeacherAssigned = (guruId, currentClassId) => {
  if (!guruId) return false;
  return props.classes.some(c => c.id_guru_wali === guruId && c.id_kelas !== currentClassId);
};

// Same navigation structure
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

const updateWaliKelas = (cls) => {
  savingId.value = cls.id_kelas;

  router.post('/admin/wali-kelas', {
    id_kelas: cls.id_kelas,
    id_guru_wali: cls.id_guru_wali
  }, {
    preserveScroll: true,
    onFinish: () => {
      savingId.value = null;
    }
  });
};

const resetWaliKelas = (cls) => {
  if(confirm(`Yakin ingin mengosongkan wali kelas untuk ${cls.nama_kelas}?`)) {
    cls.id_guru_wali = null;
    updateWaliKelas(cls);
  }
};

const isResettingAll = ref(false);
const resetAll = () => {
  if (confirm("⚠️ PERINGATAN!\nApakah Anda yakin ingin MENGOSONGKAN SELURUH penugasan Wali Kelas di semua kelas?\nAksi ini tidak dapat dibatalkan!")) {
    isResettingAll.value = true;
    router.post('/admin/wali-kelas/reset', {}, {
      onFinish: () => {
        isResettingAll.value = false;
      }
    });
  }
};
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
