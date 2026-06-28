<template>
  <Head title="Tugas Piket" />

  <AppLayout
    title="Laporan Kehadiran Guru"
    :subtitle="`Shift ${shift} — ${hariIni}`"
    :navigation="navigation"
  >
    <template #topbar-actions>
      <button @click="generateLaporanWa" class="flex items-center gap-2 px-4 py-2 rounded-lg bg-green-500 hover:bg-green-400 text-white text-sm font-bold transition-all shadow-[0_0_15px_rgba(34,197,94,0.3)] hover:scale-105">
        <span class="text-lg">💬</span> Share Laporan ke WA
      </button>
    </template>

    <!-- TABS -->
    <div class="flex gap-4 mb-6 border-b border-white/10 pb-2">
      <button 
        @click="activeTab = 'GURU'" 
        class="px-4 py-2 font-bold transition-colors"
        :class="activeTab === 'GURU' ? 'text-indigo-400 border-b-2 border-indigo-400' : 'text-slate-400 hover:text-white'">
        1. Kehadiran Guru
      </button>
      <button 
        @click="activeTab = 'SISWA'" 
        class="px-4 py-2 font-bold transition-colors"
        :class="activeTab === 'SISWA' ? 'text-indigo-400 border-b-2 border-indigo-400' : 'text-slate-400 hover:text-white'">
        2. Keterlambatan Siswa
      </button>
    </div>

    <!-- TAB 1: KEHADIRAN GURU -->
    <div v-show="activeTab === 'GURU'" class="bg-[#18181B] border border-white/10 rounded-2xl overflow-hidden shadow-2xl animate-fade-in">
      <div class="p-5 border-b border-white/10 flex items-center justify-between">
        <div>
          <h3 class="text-lg font-black text-white">Daftar Guru Terjadwal Shift {{ shift }}</h3>
          <p class="text-xs text-slate-400">Silakan ceklis atau pilih status kehadiran guru secara real-time.</p>
        </div>
        <div class="flex items-center gap-3">
           <div class="px-3 py-1 bg-white/5 border border-white/10 rounded-lg text-xs font-semibold text-slate-300">
             Total: {{ teachers.length }} Guru
           </div>
        </div>
      </div>
      
      <div class="overflow-x-auto">
        <table class="w-full text-left border-collapse">
          <thead>
            <tr class="bg-white/5 border-b border-white/10">
              <th class="px-6 py-4 text-xs font-semibold text-slate-300 uppercase tracking-wider w-10">No</th>
              <th class="px-6 py-4 text-xs font-semibold text-slate-300 uppercase tracking-wider">Hadir?</th>
              <th class="px-6 py-4 text-xs font-semibold text-slate-300 uppercase tracking-wider">Nama Guru</th>
              <th class="px-6 py-4 text-xs font-semibold text-slate-300 uppercase tracking-wider">Jadwal Pertama</th>
              <th class="px-6 py-4 text-xs font-semibold text-slate-300 uppercase tracking-wider">Status & Ket.</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-white/10">
            <tr v-for="(guru, index) in teachers" :key="guru.id_guru" 
                class="transition-colors"
                :class="guru.status === 'HADIR' ? 'bg-green-900/10' : 'hover:bg-white/5'">
              <td class="px-6 py-4 text-slate-400 text-sm font-mono">{{ index + 1 }}</td>
              
              <!-- Ceklis Cepat Hadir -->
              <td class="px-6 py-4">
                <button 
                  @click="toggleHadir(guru)"
                  class="w-8 h-8 rounded-lg flex items-center justify-center transition-all border shadow-sm"
                  :class="guru.status === 'HADIR' ? 'bg-green-500 border-green-400 text-white' : 'bg-white/5 border-white/20 text-transparent hover:bg-white/10'"
                >
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                  </svg>
                </button>
              </td>
              
              <td class="px-6 py-4">
                <div class="font-bold text-white">{{ guru.nama_guru }}</div>
              </td>
              
              <td class="px-6 py-4">
                <div class="text-sm font-semibold text-indigo-400">Jam ke-{{ guru.jam_ke }}</div>
              </td>
              
              <!-- Opsi Status Lainnya -->
              <td class="px-6 py-4">
                <div class="flex items-center gap-2">
                  <select 
                    v-model="guru.status" 
                    @change="updateStatus(guru)"
                    class="bg-white/5 border border-white/10 text-white rounded-lg px-2 py-1.5 text-xs focus:outline-none focus:border-indigo-500 min-w-[100px]">
                    <option :value="null">-- Belum Ada --</option>
                    <option value="HADIR">HADIR</option>
                    <option value="SAKIT">SAKIT</option>
                    <option value="IZIN">IZIN</option>
                    <option value="LAINNYA">Manual / Lainnya</option>
                  </select>

                  <input 
                    v-if="guru.status !== 'HADIR'"
                    v-model="guru.keterangan_jam"
                    @blur="updateStatus(guru)"
                    placeholder="Contoh: Mulai Jam ke-2"
                    class="bg-white/5 border border-white/10 text-white rounded-lg px-2 py-1.5 text-xs w-40 focus:outline-none focus:border-indigo-500"
                  />
                </div>
              </td>
            </tr>
            <tr v-if="teachers.length === 0">
              <td colspan="5" class="px-6 py-12 text-center text-slate-400">
                <div class="text-4xl mb-3">😴</div>
                Tidak ada jadwal guru di shift ini.
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- TAB 2: SISWA TERLAMBAT -->
    <div v-show="activeTab === 'SISWA'" class="animate-fade-in space-y-6">
      <!-- Form Input -->
      <div class="bg-[#18181B] border border-white/10 rounded-2xl p-6 shadow-2xl">
        <h3 class="text-lg font-black text-white mb-4">Catat Siswa Terlambat</h3>
        <form @submit.prevent="submitSiswaTelat" class="grid grid-cols-1 md:grid-cols-4 gap-4 items-end">
          <div class="col-span-1 md:col-span-1 relative">
            <label class="block text-xs font-bold text-slate-400 mb-1">Cari Siswa</label>
            <input 
              v-model="searchQuery" 
              @focus="showDropdown = true"
              placeholder="Ketik Nama / NIS..."
              class="w-full bg-black/20 border border-white/10 rounded-lg px-3 py-2 text-white focus:border-indigo-500 outline-none text-sm"
            />
            <!-- Dropdown -->
            <div v-if="showDropdown && filteredStudents.length > 0" class="absolute z-50 mt-1 w-[300px] max-h-60 overflow-y-auto bg-[#1a1b2e] border border-white/10 rounded-lg shadow-xl">
              <div 
                v-for="s in filteredStudents" 
                :key="s.id" 
                @click="selectStudent(s)"
                class="px-3 py-2 hover:bg-indigo-500/20 cursor-pointer border-b border-white/5 transition-colors"
              >
                <div class="text-sm font-bold text-white">{{ s.nama }}</div>
                <div class="text-xs text-indigo-300">{{ s.nis }} - {{ s.kelas }}</div>
              </div>
            </div>
          </div>
          
          <div class="col-span-1 md:col-span-1">
            <label class="block text-xs font-bold text-slate-400 mb-1">Terpilih</label>
            <div class="w-full bg-indigo-500/10 border border-indigo-500/20 rounded-lg px-3 py-2 text-indigo-200 text-sm h-[38px] flex items-center overflow-hidden whitespace-nowrap">
              {{ formTelat.nama_siswa || 'Belum memilih...' }}
            </div>
          </div>

          <div class="col-span-1 md:col-span-1">
            <label class="block text-xs font-bold text-slate-400 mb-1">Alasan / Keterangan</label>
            <input 
              v-model="formTelat.alasan" 
              placeholder="Contoh: Bangun kesiangan"
              class="w-full bg-black/20 border border-white/10 rounded-lg px-3 py-2 text-white focus:border-indigo-500 outline-none text-sm"
            />
          </div>

          <div class="col-span-1 md:col-span-1 flex gap-2">
            <div class="flex-1">
              <label class="block text-xs font-bold text-slate-400 mb-1">Tindakan</label>
              <input 
                v-model="formTelat.tindakan" 
                required
                placeholder="Contoh: Pungut sampah"
                class="w-full bg-black/20 border border-white/10 rounded-lg px-3 py-2 text-white focus:border-indigo-500 outline-none text-sm"
              />
            </div>
            <button 
              type="submit" 
              :disabled="!formTelat.id_siswa || formTelat.processing"
              class="h-[38px] px-4 mt-5 rounded-lg font-bold text-sm bg-indigo-600 hover:bg-indigo-500 text-white disabled:opacity-50 transition-colors shadow-lg"
            >
              Catat!
            </button>
          </div>
        </form>
      </div>

      <!-- Tabel Riwayat Hari Ini -->
      <div class="bg-[#18181B] border border-white/10 rounded-2xl overflow-hidden shadow-2xl">
        <div class="p-5 border-b border-white/10">
          <h3 class="text-lg font-black text-white">Riwayat Terlambat Hari Ini</h3>
        </div>
        <div class="overflow-x-auto">
          <table class="w-full text-left text-sm border-collapse">
            <thead>
              <tr class="bg-white/5 border-b border-white/10 text-slate-400 uppercase tracking-wider text-xs">
                <th class="px-6 py-3 font-semibold">Waktu</th>
                <th class="px-6 py-3 font-semibold">Nama Siswa</th>
                <th class="px-6 py-3 font-semibold">Kelas</th>
                <th class="px-6 py-3 font-semibold">Alasan</th>
                <th class="px-6 py-3 font-semibold">Tindakan</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-white/10">
              <tr v-for="late in lateStudentsToday" :key="late.id" class="hover:bg-white/5 transition-colors">
                <td class="px-6 py-3 text-indigo-400 font-mono">{{ late.waktu }}</td>
                <td class="px-6 py-3 text-white font-bold">{{ late.nama }}</td>
                <td class="px-6 py-3 text-slate-300">{{ late.kelas }}</td>
                <td class="px-6 py-3 text-slate-300">{{ late.keterangan || '-' }}</td>
                <td class="px-6 py-3 text-rose-400">{{ late.tipe_tindakan }}</td>
              </tr>
              <tr v-if="lateStudentsToday.length === 0">
                <td colspan="5" class="px-6 py-8 text-center text-slate-400">Belum ada siswa yang dicatat terlambat hari ini. Bagus!</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </AppLayout>
</template>

<script setup>
import { ref, computed } from 'vue';
import { Head, router, usePage, useForm } from '@inertiajs/vue3';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  shift: String,
  hariIni: String,
  teachers: Array,
  students: {
    type: Array,
    default: () => []
  },
  lateStudentsToday: {
    type: Array,
    default: () => []
  },
});

const page = usePage();
const activeTab = ref('GURU'); // 'GURU' atau 'SISWA'

// Fitur Pencarian Siswa
const searchQuery = ref('');
const showDropdown = ref(false);

const filteredStudents = computed(() => {
  if (!searchQuery.value) return [];
  const query = searchQuery.value.toLowerCase();
  return props.students.filter(s => 
    s.nama.toLowerCase().includes(query) || 
    s.nis.toLowerCase().includes(query)
  ).slice(0, 5); // Batasi 5 hasil agar tidak berat
});

const formTelat = useForm({
  id_siswa: null,
  nama_siswa: '',
  alasan: '',
  tindakan: '',
});

const selectStudent = (student) => {
  formTelat.id_siswa = student.id;
  formTelat.nama_siswa = student.nama + ' (' + student.kelas + ')';
  searchQuery.value = '';
  showDropdown.value = false;
};

const submitSiswaTelat = () => {
  formTelat.post('/guru/tugas-piket/siswa-telat', {
    preserveScroll: true,
    onSuccess: () => {
      formTelat.reset();
      window.dispatchEvent(new CustomEvent('toast', { detail: { message: 'Siswa terlambat berhasil dicatat!', type: 'success' } }));
    }
  });
};

const toggleHadir = (guru) => {
  if (guru.status === 'HADIR') {
    guru.status = null;
    guru.keterangan_jam = null;
  } else {
    guru.status = 'HADIR';
    guru.keterangan_jam = null;
  }
  updateStatus(guru);
};

const updateStatus = (guru) => {
  router.post('/guru/tugas-piket/absensi', {
    id_guru: guru.id_guru,
    status: guru.status || 'LAINNYA',
    keterangan_jam: guru.keterangan_jam,
  }, {
    preserveScroll: true,
  });
};

const generateLaporanWa = () => {
  let text = `*Laporan Kehadiran Guru*\n*Tanggal:* ${props.hariIni}\n*Shift:* ${props.shift}\n\n`;
  
  props.teachers.forEach((guru, index) => {
    let checkmark = guru.status === 'HADIR' ? '✅' : '  ';
    let line = `${index + 1}. [${checkmark}] ${guru.nama_guru} (Jam ke-${guru.jam_ke})`;
    
    if (guru.status === 'SAKIT') line += ` - *Sakit*`;
    else if (guru.status === 'IZIN') line += ` - *Izin*`;
    else if (guru.status === 'LAINNYA' && guru.keterangan_jam) line += ` - *${guru.keterangan_jam}*`;
    
    text += line + '\n';
  });
  
  text += `\n*Petugas Piket:* ${/* Nama guru piket here */ 'Sistem Piket'}`;

  const encodedText = encodeURIComponent(text);
  // URL Encode to WhatsApp
  window.open(`https://wa.me/?text=${encodedText}`, '_blank');
};

const navigation = [
  {
    label: 'KBM (Kegiatan Belajar Mengajar)',
    items: [
      { href: '/guru/dashboard', icon: '📊', label: 'Dashboard' },
      { href: '/guru/jadwal', icon: '📅', label: 'Jadwal Mengajar' },
      { href: '/guru/riwayat-jurnal', icon: '📜', label: 'Riwayat Jurnal' },
    ],
  },
  {
    label: 'Tugas Khusus',
    items: [
      { href: '/guru/tugas-piket', icon: '👮', label: 'Tugas Piket' },
    ],
  },
];
</script>
