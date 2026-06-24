<template>
  <Head title="Live Exam Monitor" />

  <AppLayout
    title="Monitoring Ujian Live"
    subtitle="Pantau progres pengerjaan siswa secara real-time"
  >
    <div class="grid grid-cols-3 gap-6">
      
      <!-- Main Monitor -->
      <div class="col-span-2 space-y-6">
        <div class="rounded-2xl border border-white/10 p-6" style="background: var(--card)">
          <div class="flex items-center justify-between mb-6 pb-4 border-b border-white/5">
            <div>
              <h2 class="text-xl font-black text-white mb-1">{{ exam.question_bank.judul }}</h2>
              <p class="text-sm text-slate-400">Kelas: {{ exam.kbm_session.clas?.nama_kelas }} | Total: {{ studentsProgress.length }} Siswa</p>
            </div>
            <div class="px-4 py-2 bg-red-500/20 text-red-400 border border-red-500/30 rounded-xl flex items-center gap-2 text-sm font-bold animate-pulse">
              <span class="w-2 h-2 bg-red-400 rounded-full"></span>
              UJIAN SEDANG BERJALAN
            </div>
          </div>

          <div class="space-y-4">
            <div v-for="siswa in studentsProgress" :key="siswa.id_siswa" class="flex items-center gap-4">
              <div class="w-1/3 min-w-0">
                <div class="text-sm font-bold text-white truncate">{{ siswa.nama }}</div>
                <div class="text-xs text-slate-500">Terjawab: {{ siswa.answered }}/{{ siswa.total }}</div>
              </div>
              
              <div class="flex-1">
                <div class="h-2 rounded-full bg-white/5 overflow-hidden">
                  <div class="h-full bg-indigo-500 transition-all duration-500" :style="`width: ${(siswa.answered / siswa.total) * 100}%`"></div>
                </div>
              </div>

              <div class="w-16 text-right">
                <div v-if="siswa.is_finished" class="text-xs font-bold text-green-400">Selesai</div>
                <div v-else class="text-xs font-bold text-indigo-400">{{ Math.round((siswa.answered / siswa.total) * 100) }}%</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Side Panel -->
      <div class="space-y-6">
        <div class="rounded-2xl border border-white/10 p-6 flex flex-col items-center text-center shadow-[0_0_40px_rgba(79,70,229,0.1)]" style="background: var(--card)">
          <div class="w-20 h-20 rounded-full border-4 border-indigo-500/30 flex items-center justify-center mb-4">
            <span class="text-2xl font-black text-white">{{ stats.finished }}</span>
            <span class="text-sm text-slate-500 ml-1">/{{ studentsProgress.length }}</span>
          </div>
          <h3 class="text-sm font-bold text-white mb-1">Siswa Selesai</h3>
          <p class="text-xs text-slate-400 mb-6">Sistem merekam setiap jawaban yang dipilih siswa secara otomatis.</p>
          
          <form @submit.prevent="closeExam" class="w-full">
            <button type="submit" class="w-full px-5 py-3 rounded-xl text-sm font-bold text-white bg-red-600 hover:bg-red-500 transition-colors border border-red-500/50 shadow-lg shadow-red-500/20">
              Tutup Ujian & Rekap Nilai
            </button>
          </form>
        </div>
      </div>

    </div>
  </AppLayout>
</template>

<script setup>
import { Head, router } from '@inertiajs/vue3';
import { computed, onMounted, onUnmounted } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  exam: Object,
  studentsProgress: Array
});

const stats = computed(() => {
  const finished = props.studentsProgress.filter(s => s.is_finished).length;
  return { finished };
});

let polling;
onMounted(() => {
  polling = setInterval(() => {
    router.reload({ only: ['studentsProgress'], preserveScroll: true });
  }, 3000);
});

onUnmounted(() => {
  if (polling) clearInterval(polling);
});

const closeExam = () => {
  if (confirm('Yakin ingin menutup ujian? Siswa tidak bisa menjawab lagi setelah ini.')) {
    router.post(`/guru/live-exam/${props.exam.id_exam}/close`);
  }
};
</script>
