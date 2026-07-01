<template>
  <Head title="Kepatuhan KBM Guru" />

  <AppLayout
    title="Laporan Kepatuhan Pembelajaran Guru"
    subtitle="Pantau guru yang mengajar tanpa pemetaan materi atau tanpa pernah melakukan asesmen"
  >
    <div class="max-w-6xl mx-auto w-full pb-16 space-y-6">
      
      <!-- Ringkasan Kepatuhan -->
      <div class="grid grid-cols-2 gap-4">
        <div class="rounded-2xl border border-amber-500/30 p-5 bg-amber-500/5 flex items-center justify-between">
          <div>
            <div class="text-[10px] font-bold text-amber-500 uppercase tracking-widest">GURU BELUM BUAT MATERI</div>
            <div class="text-3xl font-black text-white mt-1">{{ no_tp_mapping.length }} Guru</div>
            <div class="text-xs text-slate-400 mt-1">Belum menginput Tujuan Pembelajaran (TP)</div>
          </div>
          <span class="text-4xl">⚠️</span>
        </div>
        <div class="rounded-2xl border border-red-500/30 p-5 bg-red-500/5 flex items-center justify-between">
          <div>
            <div class="text-[10px] font-bold text-red-500 uppercase tracking-widest font-black">GURU BELUM ASESMEN</div>
            <div class="text-3xl font-black text-white mt-1">{{ empty_grades.length }} TP</div>
            <div class="text-xs text-slate-400 mt-1">Sudah petakan TP tapi nilai siswa masih kosong</div>
          </div>
          <span class="text-4xl">📊</span>
        </div>
      </div>

      <!-- Main Layout -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

        <!-- Panel Kiri: Tanpa Pemetaan Materi -->
        <div class="rounded-2xl border border-white/10 overflow-hidden" style="background: var(--card)">
          <div class="px-5 py-4 border-b border-white/8 bg-amber-500/5">
            <h3 class="font-bold text-sm text-white">Guru Tanpa Pemetaan Materi</h3>
            <p class="text-[11px] text-slate-400 mt-0.5">Sudah terjadwal di kelas tetapi tidak mendaftarkan TP/Materi di aplikasi</p>
          </div>
          <div class="divide-y divide-white/5 overflow-y-auto max-h-[500px]">
            <div v-for="(g, idx) in no_tp_mapping" :key="idx" class="p-4 flex items-center justify-between hover:bg-white/2 transition-colors">
              <div class="min-w-0 pr-4">
                <div class="text-sm font-bold text-white">{{ g.nama_guru }}</div>
                <div class="text-xs text-slate-400 mt-0.5">Mapel: <span class="text-indigo-300 font-semibold">{{ g.nama_mapel }}</span></div>
                <div class="text-xs text-slate-500 mt-0.5">Mengajar di: <span class="text-slate-300 font-mono">{{ g.nama_kelas }}</span></div>
              </div>
              <a v-if="g.no_wa"
                 :href="`https://wa.me/${g.no_wa}?text=Halo%20Bapak/Ibu%20${encodeURIComponent(g.nama_guru)},%20mohon%20segera%20mengisi%20Pemetaan%20Materi%20(Tujuan%20Pembelajaran/TP)%20untuk%20mata%20pelajaran%20${encodeURIComponent(g.nama_mapel)}%20di%20kelas%20${encodeURIComponent(g.nama_kelas)}%20pada%20sistem%20LMS%2011%20Maret.%20Terima%20kasih.`"
                 target="_blank"
                 class="px-3 py-2 bg-emerald-600 hover:bg-emerald-500 text-white rounded-lg text-xs font-bold transition-all flex items-center gap-1 shrink-0">
                💬 Tegur (WA)
              </a>
            </div>
            <div v-if="no_tp_mapping.length === 0" class="py-20 text-center text-slate-500 text-sm">
              🎉 Bagus! Semua guru pengajar telah membuat pemetaan materi (TP).
            </div>
          </div>
        </div>

        <!-- Panel Kanan: Tanpa Asesmen -->
        <div class="rounded-2xl border border-white/10 overflow-hidden" style="background: var(--card)">
          <div class="px-5 py-4 border-b border-white/8 bg-red-500/5">
            <h3 class="font-bold text-sm text-white">Pemetaan Ada, Belum Asesmen</h3>
            <p class="text-[11px] text-slate-400 mt-0.5">Sudah petakan Tujuan Pembelajaran tapi nilai seluruh murid di TP ini masih kosong</p>
          </div>
          <div class="divide-y divide-white/5 overflow-y-auto max-h-[500px]">
            <div v-for="(t, idx) in empty_grades" :key="idx" class="p-4 flex items-center justify-between hover:bg-white/2 transition-colors">
              <div class="min-w-0 pr-4 flex-1">
                <div class="text-sm font-bold text-white">{{ t.nama_guru }}</div>
                <div class="text-xs text-slate-400 mt-0.5">Mapel: <span class="text-indigo-300 font-semibold">{{ t.nama_mapel }}</span></div>
                <div class="text-xs text-slate-500 mt-0.5">Kelas: <span class="text-slate-300 font-mono">{{ t.nama_kelas }}</span></div>
                <div class="text-xs text-rose-300 bg-rose-500/10 border border-rose-500/20 px-2 py-1.5 rounded-lg mt-2 font-medium">
                  📖 TP: {{ t.deskripsi_tp }}
                </div>
              </div>
              <a v-if="t.no_wa"
                 :href="`https://wa.me/${t.no_wa}?text=Halo%20Bapak/Ibu%20${encodeURIComponent(t.nama_guru)},%20kami%20melihat%20materi%20${encodeURIComponent(t.deskripsi_tp)}%20sudah%20dibuatkan%20pemetaannya,%20tetapi%20nilai%20asesmen%20siswa%20masih%20kosong.%20Mohon%20segera%20melaksanakan%20asesmen%20atau%20menginput%20nilai%20pada%20sistem%20LMS%2011%20Maret.%20Terima%20kasih.`"
                 target="_blank"
                 class="px-3 py-2 bg-emerald-600 hover:bg-emerald-500 text-white rounded-lg text-xs font-bold transition-all flex items-center gap-1 shrink-0">
                💬 Tegur (WA)
              </a>
            </div>
            <div v-if="empty_grades.length === 0" class="py-20 text-center text-slate-500 text-sm">
              🎉 Bagus! Semua TP yang dipetakan guru sudah memiliki nilai murid.
            </div>
          </div>
        </div>

      </div>

    </div>
  </AppLayout>
</template>

<script setup>
import { Head } from '@inertiajs/vue3';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  no_tp_mapping: Array,
  empty_grades:  Array,
});
</script>
