<template>
  <Head :title="`Laporan Diagnostik — ${exam.question_bank?.judul ?? 'Asesmen'}`" />

  <AppLayout
    title="Laporan Asesmen Diagnostik"
    :subtitle="`${exam.question_bank?.judul} · ${exam.kbm_session?.tanggal ?? ''}`"
  >
    <div class="max-w-4xl mx-auto w-full pb-16 space-y-6">

      <!-- Header Info -->
      <div class="rounded-2xl border border-sky-500/30 p-5 bg-sky-500/5 flex flex-wrap items-center gap-4 justify-between">
        <div>
          <div class="flex items-center gap-2 mb-1">
            <span class="text-xl">🔬</span>
            <h2 class="text-base font-black text-white">{{ exam.question_bank?.judul }}</h2>
            <span class="text-[10px] font-bold px-2 py-0.5 rounded-full bg-sky-500/20 text-sky-300 border border-sky-500/30">DIAGNOSTIK</span>
          </div>
          <p class="text-xs text-slate-400">
            {{ exam.kbm_session?.subject?.nama_mapel ?? '—' }} ·
            Kelas {{ exam.kbm_session?.clas?.nama_kelas ?? '—' }} ·
            Durasi {{ exam.durasi }} menit · {{ totalQuestions }} soal
          </p>
        </div>
        <div class="text-right">
          <div class="text-2xl font-black text-sky-400">{{ avgScore }}</div>
          <div class="text-[10px] text-slate-500">Rata-rata kelas</div>
        </div>
      </div>

      <!-- Disclaimer -->
      <div class="flex items-start gap-3 p-4 rounded-xl border border-amber-500/20 bg-amber-500/5">
        <span class="text-lg mt-0.5">⚠️</span>
        <p class="text-xs text-amber-400">
          Hasil asesmen ini <strong>tidak masuk ke nilai sumatif</strong> maupun rapor siswa.
          Gunakan laporan ini untuk mengidentifikasi kebutuhan belajar siswa sebelum pembelajaran dimulai.
        </p>
      </div>

      <!-- Ringkasan Distribusi -->
      <div class="grid grid-cols-3 gap-4">
        <div class="rounded-2xl border border-white/10 p-4 text-center" style="background: var(--card)">
          <div class="text-2xl font-black text-green-400">{{ countTuntas }}</div>
          <div class="text-[11px] text-slate-400 mt-1">Tuntas (≥ 75)</div>
        </div>
        <div class="rounded-2xl border border-white/10 p-4 text-center" style="background: var(--card)">
          <div class="text-2xl font-black text-red-400">{{ countBelumTuntas }}</div>
          <div class="text-[11px] text-slate-400 mt-1">Belum Tuntas (&lt; 75)</div>
        </div>
        <div class="rounded-2xl border border-white/10 p-4 text-center" style="background: var(--card)">
          <div class="text-2xl font-black text-slate-500">{{ countBelumMengerjakan }}</div>
          <div class="text-[11px] text-slate-400 mt-1">Tidak Mengerjakan</div>
        </div>
      </div>

      <!-- Tabel Nilai Siswa -->
      <div class="rounded-2xl border border-white/10 overflow-hidden" style="background: var(--card)">
        <div class="flex items-center justify-between px-5 py-4 border-b border-white/8">
          <div>
            <div class="font-bold text-sm text-white">Nilai Per Siswa</div>
            <div class="text-xs text-slate-500">{{ studentsResult.length }} siswa</div>
          </div>
          <!-- Filter -->
          <div class="flex gap-2">
            <button
              v-for="f in filters" :key="f.value"
              @click="activeFilter = f.value"
              :class="activeFilter === f.value ? 'bg-sky-500/20 text-sky-300 border-sky-500/40' : 'bg-white/5 text-slate-500 border-white/10'"
              class="px-3 py-1.5 rounded-lg text-[10px] font-bold border transition-colors">
              {{ f.label }}
            </button>
          </div>
        </div>

        <div class="divide-y divide-white/5">
          <div v-for="(siswa, idx) in filteredStudents" :key="siswa.id_siswa"
               class="flex items-center gap-4 px-5 py-3.5 hover:bg-white/3 transition-colors">
            <!-- No -->
            <div class="w-6 text-center text-xs text-slate-600 font-bold">{{ idx + 1 }}</div>
            <!-- Nama -->
            <div class="flex-1 text-sm font-medium text-white">{{ siswa.nama }}</div>
            <!-- Jawaban -->
            <div class="text-xs text-slate-400">{{ siswa.answered }}/{{ totalQuestions }} dijawab</div>
            <!-- Score Bar -->
            <div class="w-32">
              <div class="h-1.5 rounded-full bg-white/10 overflow-hidden">
                <div class="h-full rounded-full transition-all duration-500"
                     :class="siswa.score >= 75 ? 'bg-green-500' : siswa.score > 0 ? 'bg-red-500' : 'bg-white/20'"
                     :style="`width: ${siswa.score}%`"></div>
              </div>
            </div>
            <!-- Score Badge -->
            <div class="w-16 text-right">
              <span v-if="siswa.answered === 0" class="text-[10px] text-slate-600 font-medium">—</span>
              <span v-else class="text-sm font-black"
                    :class="siswa.score >= 75 ? 'text-green-400' : 'text-red-400'">
                {{ siswa.score }}
              </span>
            </div>
            <!-- Status Pill -->
            <div class="w-20 text-right">
              <span v-if="siswa.answered === 0" class="text-[10px] px-2 py-0.5 rounded-full bg-white/5 text-slate-500 border border-white/10">Absen</span>
              <span v-else-if="siswa.score >= 75" class="text-[10px] px-2 py-0.5 rounded-full bg-green-500/15 text-green-400 border border-green-500/30">Tuntas</span>
              <span v-else class="text-[10px] px-2 py-0.5 rounded-full bg-red-500/15 text-red-400 border border-red-500/30">Perlu Bimbingan</span>
            </div>
          </div>

          <div v-if="filteredStudents.length === 0" class="py-10 text-center text-sm text-slate-500">
            Tidak ada data untuk filter ini.
          </div>
        </div>
      </div>

      <!-- Analisis Per Soal -->
      <div class="rounded-2xl border border-white/10 overflow-hidden" style="background: var(--card)">
        <div class="px-5 py-4 border-b border-white/8">
          <div class="font-bold text-sm text-white">Analisis Per Butir Soal</div>
          <div class="text-xs text-slate-500">Persentase siswa yang menjawab benar</div>
        </div>
        <div class="divide-y divide-white/5">
          <div v-for="(q, idx) in questionAnalysis" :key="q.id_question" class="flex items-center gap-4 px-5 py-3.5">
            <div class="w-6 text-center text-xs text-slate-600 font-bold">{{ idx + 1 }}</div>
            <div class="flex-1 text-xs text-slate-300 line-clamp-1">{{ q.pertanyaan }}</div>
            <div class="w-40">
              <div class="h-1.5 rounded-full bg-white/10 overflow-hidden">
                <div class="h-full rounded-full transition-all"
                     :class="q.correctPct >= 70 ? 'bg-green-500' : q.correctPct >= 40 ? 'bg-amber-500' : 'bg-red-500'"
                     :style="`width: ${q.correctPct}%`"></div>
              </div>
            </div>
            <div class="w-20 text-right text-xs font-bold"
                 :class="q.correctPct >= 70 ? 'text-green-400' : q.correctPct >= 40 ? 'text-amber-400' : 'text-red-400'">
              {{ q.correctPct }}%
            </div>
            <div class="w-24 text-right text-[10px] text-slate-500">
              {{ q.correctCount }}/{{ q.totalAnswered }} benar
            </div>
          </div>
        </div>
      </div>

    </div>
  </AppLayout>
</template>

<script setup>
import { Head } from '@inertiajs/vue3';
import { ref, computed } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  exam:            Object,
  studentsResult:  Array,   // [{ id_siswa, nama, answered, score }]
  questionAnalysis: Array,  // [{ id_question, pertanyaan, correctPct, correctCount, totalAnswered }]
  totalQuestions:  Number,
});

const activeFilter = ref('ALL');
const filters = [
  { value: 'ALL',     label: 'Semua' },
  { value: 'TUNTAS',  label: 'Tuntas' },
  { value: 'BELUM',   label: 'Perlu Bimbingan' },
  { value: 'ABSEN',   label: 'Tidak Mengerjakan' },
];

const filteredStudents = computed(() => {
  if (activeFilter.value === 'ALL')    return props.studentsResult;
  if (activeFilter.value === 'TUNTAS') return props.studentsResult.filter(s => s.answered > 0 && s.score >= 75);
  if (activeFilter.value === 'BELUM')  return props.studentsResult.filter(s => s.answered > 0 && s.score < 75);
  if (activeFilter.value === 'ABSEN')  return props.studentsResult.filter(s => s.answered === 0);
  return props.studentsResult;
});

const avgScore = computed(() => {
  const done = props.studentsResult.filter(s => s.answered > 0);
  if (!done.length) return '—';
  return Math.round(done.reduce((a, s) => a + s.score, 0) / done.length);
});

const countTuntas          = computed(() => props.studentsResult.filter(s => s.answered > 0 && s.score >= 75).length);
const countBelumTuntas     = computed(() => props.studentsResult.filter(s => s.answered > 0 && s.score < 75).length);
const countBelumMengerjakan = computed(() => props.studentsResult.filter(s => s.answered === 0).length);
</script>
