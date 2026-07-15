<template>
  <Head title="Materi Pembelajaran & Progress Belajar" />

  <AppLayout
    title="Materi Belajar & Capaian TP"
    subtitle="Akses materi pembelajaran, kegiatan belajar mengajar, serta pantau ketercapaian Tujuan Pembelajaran (TP) Anda"
    :navigation="navigation"
  >
    <template #topbar-actions>
      <!-- Dropdown Pilih Mapel -->
      <div class="flex items-center gap-2 mr-4">
        <label class="text-xs text-slate-500 font-semibold uppercase">Mata Pelajaran:</label>
        <select v-model="selectedMapelForm" class="bg-[#111827] border border-white/10 rounded-lg px-3 py-1.5 text-sm text-white outline-none focus:border-indigo-500">
          <option v-for="cs in classSubjects" :key="cs.id_class_subject" :value="cs.id_mapel">
            {{ cs.subject?.nama_mapel }}
          </option>
        </select>
      </div>
    </template>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

      <!-- LEFT 2 COLS: BABS, SUB-MATERI & AKTIVITAS -->
      <div class="lg:col-span-2 space-y-6">
        <div class="flex items-center justify-between">
          <h3 class="text-base font-bold text-white">Daftar Bab & Modul Belajar</h3>
          <span class="text-xs text-slate-400">Pilih mapel di bar atas untuk mengganti materi.</span>
        </div>

        <div class="space-y-4">
          <div v-for="bab in babs" :key="bab.id_bab" class="rounded-2xl border border-white/8 bg-[#1A2035] p-5 space-y-4">
            <!-- Bab Header -->
            <div class="border-b border-white/5 pb-3">
              <span class="px-2 py-0.5 rounded-full text-[9px] font-bold bg-amber-500/10 text-amber-400 border border-amber-500/20">
                Bab {{ bab.urutan }} (Semester {{ bab.semester === 'GANJIL' ? '1' : '2' }})
              </span>
              <h4 class="font-bold text-white text-base mt-2">{{ bab.nama_bab }}</h4>
              <p class="text-xs text-slate-400 mt-1 leading-relaxed">{{ bab.deskripsi || 'Tidak ada deskripsi bab.' }}</p>
            </div>

            <!-- Sub Materis / Handout list -->
            <div class="space-y-3 pl-4 border-l border-white/10">
              <div class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Bahan Pembahasan & Sub-Materi</div>
              
              <div v-for="sub in bab.sub_materis" :key="sub.id_sub_materi" class="bg-white/2 rounded-xl p-4 border border-white/5 space-y-3">
                <div class="flex flex-wrap items-center justify-between gap-2 border-b border-white/3 pb-2">
                  <div class="flex items-center gap-2">
                    <span class="px-2 py-0.5 rounded text-[8px] font-bold tracking-wider bg-white/10 text-slate-300">
                      {{ sub.tipe }}
                    </span>
                    <h5 class="text-xs font-bold text-slate-200">{{ sub.judul }}</h5>
                  </div>
                  
                  <div class="flex items-center gap-2">
                    <!-- Download/View actions based on type -->
                    <a 
                      v-if="sub.konten && ['LINK', 'YOUTUBE'].includes(sub.tipe)" 
                      :href="sub.konten" 
                      target="_blank" 
                      class="px-3 py-1 bg-indigo-500/10 hover:bg-indigo-500/20 text-indigo-400 border border-indigo-500/20 rounded-lg text-[10px] font-bold transition-all"
                    >
                      🔗 Buka Tautan
                    </a>
                    <button 
                      v-else-if="sub.konten" 
                      @click="viewTextContent(sub)" 
                      class="px-3 py-1 bg-indigo-500/10 hover:bg-indigo-500/20 text-indigo-400 border border-indigo-500/20 rounded-lg text-[10px] font-bold transition-all"
                    >
                      📖 Baca Materi
                    </button>
                    <span v-else class="text-[10px] text-slate-500">Berkas Unduhan</span>
                  </div>
                </div>

                <!-- Aktivitas list -->
                <div class="space-y-2">
                  <span class="block text-[8px] font-bold text-slate-500 uppercase tracking-widest">Aktivitas yang Harus Diikuti:</span>
                  
                  <div v-for="akt in sub.aktivitas_pembelajarans" :key="akt.id_aktivitas" class="bg-black/15 border border-white/5 rounded-xl p-3 flex items-start justify-between gap-3">
                    <div class="space-y-1">
                      <div class="flex items-center gap-1.5 flex-wrap">
                        <span class="px-1.5 py-0.2 bg-green-500/10 text-green-400 border border-green-500/20 text-[8px] font-bold rounded">
                          {{ akt.tipe_aktivitas }}
                        </span>
                        <span class="text-xs font-bold text-slate-300">{{ akt.nama_aktivitas }}</span>
                        <span v-if="akt.status_wajib" class="text-[8px] text-rose-400 font-extrabold uppercase border border-rose-400/20 bg-rose-400/5 px-1 py-0.2 rounded">Wajib</span>
                      </div>
                      <p class="text-[11px] text-slate-400 leading-normal">{{ akt.deskripsi }}</p>
                    </div>
                  </div>

                  <div v-if="!sub.aktivitas_pembelajarans || sub.aktivitas_pembelajarans.length === 0" class="text-[10px] text-slate-500 text-center py-1">
                    Hanya membaca materi. Tidak ada tugas/aktivitas tambahan.
                  </div>
                </div>
              </div>

              <div v-if="!bab.sub_materis || bab.sub_materis.length === 0" class="text-xs text-slate-500 text-center py-4">
                Belum ada sub-materi di bab ini.
              </div>
            </div>
          </div>

          <div v-if="!babs || babs.length === 0" class="py-12 border border-dashed border-white/10 rounded-2xl text-center text-xs text-slate-500 bg-[#1A2035]">
            Belum ada materi pembelajaran yang dipetakan oleh guru untuk mapel ini.
          </div>
        </div>
      </div>

      <!-- RIGHT 1 COL: TP PROGRESS (KKM TRACKING) -->
      <div class="space-y-6">
        <div>
          <h3 class="text-base font-bold text-white">Status Ketercapaian TP</h3>
          <p class="text-xs text-slate-400">Laporan pemenuhan Kriteria Ketuntasan Minimal (KKM) mata pelajaran</p>
        </div>

        <div class="rounded-2xl border border-white/8 bg-[#1A2035] p-5 space-y-4">
          <div class="flex items-center justify-between border-b border-white/5 pb-3">
            <span class="text-xs font-bold text-slate-300">Target Belajar Mapel Ini</span>
            <span class="text-xs font-bold text-indigo-400">KKM: {{ kkm }}</span>
          </div>

          <div class="space-y-3">
            <div 
              v-for="tp in tpProgress" 
              :key="tp.id_tp"
              class="rounded-xl border p-3.5 space-y-2 bg-white/2"
              :class="tp.status === 'TERCAPAI' ? 'border-emerald-500/20' : 'border-white/5'"
            >
              <div class="flex items-center justify-between">
                <span class="text-xs font-bold font-mono text-slate-300">{{ tp.kode_tp }}</span>
                
                <span 
                  v-if="tp.status === 'TERCAPAI'"
                  class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[9px] font-extrabold uppercase bg-emerald-500/10 text-emerald-400 border border-emerald-500/20"
                >
                  ✓ Tercapai ({{ tp.nilai }})
                </span>
                <span 
                  v-else-if="tp.nilai !== null"
                  class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[9px] font-extrabold uppercase bg-amber-500/10 text-amber-400 border border-amber-500/20"
                >
                  ⏳ Belum KKM ({{ tp.nilai }})
                </span>
                <span 
                  v-else
                  class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[9px] font-extrabold uppercase bg-slate-500/10 text-slate-400 border border-white/5"
                >
                  ⚪ Belum Dinilai
                </span>
              </div>
              <p class="text-xs text-slate-300 leading-normal">{{ tp.deskripsi_tp }}</p>
            </div>

            <div v-if="!tpProgress || tpProgress.length === 0" class="text-center py-6 text-xs text-slate-500">
              Belum ada Tujuan Pembelajaran (TP) yang terpetakan untuk mapel ini.
            </div>
          </div>
        </div>
      </div>

    </div>

    <!-- TEXT CONTENT READER MODAL -->
    <div v-if="showReaderModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="bg-[#1F2937] border border-white/10 rounded-2xl w-full max-w-2xl overflow-hidden shadow-2xl animate-in fade-in zoom-in-95 duration-200">
        <div class="px-6 py-4 border-b border-white/10 flex justify-between items-center bg-white/3">
          <h3 class="font-bold text-white text-sm">📖 Baca Materi: {{ activeSub?.judul }}</h3>
          <button @click="showReaderModal = false" class="text-slate-400 hover:text-white transition-colors">✕</button>
        </div>
        <div class="p-6 max-h-[400px] overflow-y-auto custom-scrollbar text-sm text-slate-200 space-y-4 whitespace-pre-line leading-relaxed">
          {{ activeSub?.konten }}
        </div>
        <div class="px-6 py-4 border-t border-white/5 bg-white/3 flex justify-end shrink-0">
          <button @click="showReaderModal = false" class="px-5 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-colors">
            Selesai Membaca
          </button>
        </div>
      </div>
    </div>

  </AppLayout>
</template>

<script setup>
import { Head, router } from '@inertiajs/vue3';
import { ref, watch, computed } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  classSubjects: Array,
  selectedMapel: [String, Number],
  babs: Array,
  tpProgress: Array,
});

const navigation = [
  {
    label: 'Akademik',
    items: [
      { href: '/siswa/dashboard', icon: '🏠', label: 'Beranda' },
      { href: '/siswa/scan-qr', icon: '📷', label: 'Scan QR Presensi', badge: 'Live' },
      { href: '/siswa/materi', icon: '📁', label: 'Materi Belajar', badge: 'New' },
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

const selectedMapelForm = ref(props.selectedMapel);

// Watch selected mapel changes
watch(selectedMapelForm, (val) => {
  if (val) {
    router.get('/siswa/materi', { id_mapel: val }, { preserveState: true });
  }
});

// Compute KKM
const kkm = computed(() => {
  const current = (props.classSubjects || []).find(cs => cs.id_mapel === selectedMapelForm.value);
  return current?.subject?.kkm ?? 75;
});

// Modal reader for text materials
const showReaderModal = ref(false);
const activeSub = ref(null);
const viewTextContent = (sub) => {
  activeSub.value = sub;
  showReaderModal.value = true;
};
</script>

<style scoped>
.custom-scrollbar::-webkit-scrollbar {
  width: 6px;
}
.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}
.custom-scrollbar::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 9999px;
}
.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background: rgba(255, 255, 255, 0.2);
}
</style>
