<template>
  <Head title="Monitor Asesmen Live" />

  <AppLayout
    title="Monitoring Asesmen Live"
    subtitle="Pantau progres pengerjaan siswa secara real-time"
  >
    <div class="grid grid-cols-3 gap-6">
      
      <!-- Main Monitor -->
      <div class="col-span-2 space-y-6">
        <div class="rounded-2xl border border-white/10 p-6" style="background: var(--card)">
          <div class="flex items-center justify-between mb-6 pb-4 border-b border-white/5">
            <div>
              <div class="flex items-center gap-2 mb-1">
                <h2 class="text-xl font-black text-white">{{ exam.question_bank.judul }}</h2>
                <!-- Badge Jenis Asesmen -->
                <span v-if="exam.tujuan === 'DIAGNOSTIK'"
                  class="text-[10px] font-bold px-2 py-0.5 rounded-full bg-sky-500/20 text-sky-300 border border-sky-500/30">
                  🔬 Asesmen Diagnostik
                </span>
                <span v-else
                  class="text-[10px] font-bold px-2 py-0.5 rounded-full bg-green-500/20 text-green-300 border border-green-500/30">
                  📊 Asesmen Sumatif
                </span>
              </div>
              <p class="text-sm text-slate-400">
                Kelas: {{ exam.kbm_session.clas?.nama_kelas }} ·
                {{ totalQuestions }} soal ·
                Durasi {{ exam.durasi }} menit ·
                Sisa waktu: <span class="font-bold text-white">{{ timerDisplay }}</span>
              </p>
            </div>
            <div class="px-4 py-2 bg-red-500/20 text-red-400 border border-red-500/30 rounded-xl flex items-center gap-2 text-sm font-bold animate-pulse">
              <span class="w-2 h-2 bg-red-400 rounded-full"></span>
              SEDANG BERLANGSUNG
            </div>
          </div>

          <!-- Progress tiap siswa -->
          <div class="space-y-4">
            <div v-for="siswa in studentsProgress" :key="siswa.id_siswa" class="flex items-center gap-4">
              <div class="w-1/3 min-w-0">
                <div class="text-sm font-bold text-white truncate">{{ siswa.nama }}</div>
                <div class="text-xs text-slate-500">Terjawab: {{ siswa.answered }}/{{ siswa.total }}</div>
              </div>
              
              <div class="flex-1">
                <div class="h-2 rounded-full bg-white/5 overflow-hidden">
                  <div class="h-full bg-indigo-500 transition-all duration-500"
                       :style="`width: ${siswa.total ? (siswa.answered / siswa.total) * 100 : 0}%`"></div>
                </div>
              </div>

              <div class="w-24 text-right">
                <span v-if="siswa.is_finished" class="text-xs font-bold text-green-400">✓ Selesai</span>
                <span v-else class="text-xs font-bold text-indigo-400">
                  {{ siswa.total ? Math.round((siswa.answered / siswa.total) * 100) : 0 }}%
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Side Panel -->
      <div class="space-y-5">

        <!-- Statistik -->
        <div class="rounded-2xl border border-white/10 p-5 flex flex-col items-center text-center" style="background: var(--card)">
          <div class="w-20 h-20 rounded-full border-4 border-indigo-500/30 flex items-center justify-center mb-3">
            <span class="text-2xl font-black text-white">{{ stats.finished }}</span>
            <span class="text-sm text-slate-500 ml-1">/{{ studentsProgress.length }}</span>
          </div>
          <h3 class="text-sm font-bold text-white mb-0.5">Siswa Selesai</h3>
          <p class="text-xs text-slate-400 mb-4">Jawaban tersimpan otomatis setiap klik.</p>

          <form @submit.prevent="closeExam" class="w-full">
            <button type="submit" class="w-full px-5 py-3 rounded-xl text-sm font-bold text-white transition-colors border shadow-lg"
              :class="exam.tujuan === 'DIAGNOSTIK'
                ? 'bg-sky-700 hover:bg-sky-600 border-sky-500/50 shadow-sky-500/20'
                : 'bg-red-600 hover:bg-red-500 border-red-500/50 shadow-red-500/20'">
              <span v-if="exam.tujuan === 'DIAGNOSTIK'">🔬 Tutup & Lihat Laporan Diagnostik</span>
              <span v-else>📊 Tutup & Rekap Nilai Sumatif</span>
            </button>
          </form>
        </div>

        <!-- Info Jenis Asesmen -->
        <div v-if="exam.tujuan === 'DIAGNOSTIK'" class="p-4 rounded-xl border border-sky-500/20 bg-sky-500/5 text-xs text-sky-400 space-y-1">
          <div class="font-bold">🔬 Asesmen Diagnostik</div>
          <div class="text-slate-400">Hasil tidak akan masuk ke nilai rapor. Laporan diagnostik tersedia setelah ujian ditutup.</div>
        </div>
        <div v-else class="p-4 rounded-xl border border-green-500/20 bg-green-500/5 text-xs text-green-400 space-y-1">
          <div class="font-bold">📊 Asesmen Sumatif</div>
          <div class="text-slate-400">
            Nilai akan masuk ke:
            <span class="font-bold text-white block mt-1">
              {{ exam.learning_objective?.deskripsi_tp ?? '—' }}
            </span>
            <span class="text-slate-500">{{ exam.learning_topic?.nama_topik ?? 'Topik belum ditentukan' }}</span>
          </div>
        </div>

      </div>
    </div>
  </AppLayout>
</template>

<script setup>
import { Head, router } from '@inertiajs/vue3';
import { ref, computed, onMounted, onUnmounted } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  exam:             Object,
  studentsProgress: Array,
  secondsRemaining: Number,
  totalQuestions:   Number,
});

const secondsLeft = ref(props.secondsRemaining ?? 0);
let polling, timerInterval;

const timerDisplay = computed(() => {
  if (secondsLeft.value <= 0) return '⛔ Habis';
  const m = Math.floor(secondsLeft.value / 60);
  const s = secondsLeft.value % 60;
  return `${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`;
});

const stats = computed(() => ({
  finished: props.studentsProgress.filter(s => s.is_finished).length,
}));

onMounted(() => {
  // Timer countdown lokal
  timerInterval = setInterval(() => {
    if (secondsLeft.value > 0) secondsLeft.value--;
  }, 1000);

  // Poll progres siswa setiap 3 detik
  polling = setInterval(() => {
    router.reload({ only: ['studentsProgress', 'secondsRemaining'], preserveScroll: true });
  }, 3000);
});

onUnmounted(() => {
  if (polling)       clearInterval(polling);
  if (timerInterval) clearInterval(timerInterval);
});

const closeExam = () => {
  const msg = props.exam.tujuan === 'DIAGNOSTIK'
    ? 'Tutup asesmen diagnostik? Anda akan diarahkan ke laporan nilai.'
    : 'Tutup asesmen sumatif? Nilai siswa akan otomatis tersimpan ke daftar nilai.';
  if (confirm(msg)) {
    router.post(`/guru/live-exam/${props.exam.id_exam}/close`);
  }
};
</script>
