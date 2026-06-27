<template>
  <Head title="Persetujuan Reset Password" />

  <AppLayout
    title="Persetujuan Reset Password Siswa"
    :subtitle="`Daftar pengajuan reset password dari kelas perwalian Anda (${nama_kelas})`"
    :navigation="navigation"
  >
    <div class="space-y-6 max-w-6xl">
      <div v-if="$page.props.flash.success" class="p-4 bg-green-500/20 border border-green-500/30 text-green-400 text-sm rounded-xl">
        {{ $page.props.flash.success }}
      </div>
      <div v-if="$page.props.flash.error" class="p-4 bg-red-500/20 border border-red-500/30 text-red-400 text-sm rounded-xl">
        {{ $page.props.flash.error }}
      </div>

      <div class="rounded-2xl border border-white/8 overflow-hidden bg-[#1E293B] shadow-xl">
        <div class="px-5 py-4 border-b border-white/8 bg-white/2">
          <h3 class="font-bold text-sm">Daftar Pengajuan Pending</h3>
        </div>

        <div class="overflow-x-auto">
          <table class="w-full text-left border-collapse">
            <thead>
              <tr class="bg-black/20 border-b border-white/8">
                <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider w-12 text-center">No</th>
                <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Nama Siswa / NIS</th>
                <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-center">NISN</th>
                <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-center">Waktu Pengajuan</th>
                <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-center">Status</th>
                <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase tracking-wider text-center">Aksi</th>
              </tr>
            </thead>
            <tbody>
              <tr v-if="pendingRequests.length === 0">
                <td colspan="6" class="px-4 py-8 text-center text-xs text-slate-500">Tidak ada pengajuan reset password pending.</td>
              </tr>
              <tr v-else v-for="(req, idx) in pendingRequests" :key="req.id" class="border-b border-white/4 hover:bg-white/2 transition-colors">
                <td class="px-4 py-3 text-sm text-slate-500 text-center">{{ idx + 1 }}</td>
                <td class="px-4 py-3">
                  <div class="text-sm font-semibold text-white">{{ req.nama_siswa }}</div>
                  <div class="text-[10px] text-slate-500 mt-0.5">NIS: {{ req.nis }}</div>
                </td>
                <td class="px-4 py-3 text-center text-xs text-slate-300">{{ req.nisn }}</td>
                <td class="px-4 py-3 text-center text-xs text-slate-400">{{ req.tanggal }}</td>
                <td class="px-4 py-3 text-center">
                  <span class="px-2 py-0.5 rounded text-[9px] font-bold bg-yellow-500/20 text-yellow-400 border border-yellow-500/20 uppercase tracking-wider">
                    {{ req.status }}
                  </span>
                </td>
                <td class="px-4 py-3 text-center">
                  <div class="flex items-center justify-center gap-2">
                    <button @click="approve(req.id)" class="text-xs font-bold text-white bg-green-600 hover:bg-green-500 px-3 py-1.5 rounded-lg transition-colors">
                      Setujui
                    </button>
                    <button @click="reject(req.id)" class="text-xs font-bold text-white bg-red-600 hover:bg-red-500 px-3 py-1.5 rounded-lg transition-colors">
                      Tolak
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Riwayat Pengajuan Lainnya -->
      <div v-if="processedRequests.length > 0" class="rounded-2xl border border-white/8 overflow-hidden bg-[#1E293B]/60 shadow-xl">
        <div class="px-5 py-4 border-b border-white/8 bg-white/2">
          <h3 class="font-bold text-sm text-slate-400">Riwayat Pengajuan Sebelumnya</h3>
        </div>

        <div class="overflow-x-auto">
          <table class="w-full text-left border-collapse">
            <thead>
              <tr class="bg-black/10 border-b border-white/8">
                <th class="px-4 py-3 text-[10px] font-bold text-slate-500 uppercase tracking-wider w-12 text-center">No</th>
                <th class="px-4 py-3 text-[10px] font-bold text-slate-500 uppercase tracking-wider">Nama Siswa / NIS</th>
                <th class="px-4 py-3 text-[10px] font-bold text-slate-500 uppercase tracking-wider text-center">Waktu Pengajuan</th>
                <th class="px-4 py-3 text-[10px] font-bold text-slate-500 uppercase tracking-wider text-center">Status</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(req, idx) in processedRequests" :key="req.id" class="border-b border-white/4 text-slate-400">
                <td class="px-4 py-3 text-xs text-center">{{ idx + 1 }}</td>
                <td class="px-4 py-3">
                  <div class="text-xs font-medium text-slate-300">{{ req.nama_siswa }}</div>
                  <div class="text-[10px] text-slate-600">NIS: {{ req.nis }}</div>
                </td>
                <td class="px-4 py-3 text-center text-xs">{{ req.tanggal }}</td>
                <td class="px-4 py-3 text-center">
                  <span v-if="req.status === 'APPROVED'" class="px-2 py-0.5 rounded text-[9px] font-bold bg-green-500/10 text-green-400 border border-green-500/10 uppercase tracking-wider">
                    Disetujui
                  </span>
                  <span v-else class="px-2 py-0.5 rounded text-[9px] font-bold bg-red-500/10 text-red-400 border border-red-500/10 uppercase tracking-wider">
                    Ditolak
                  </span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

    </div>
  </AppLayout>
</template>

<script setup>
import { Head, router } from '@inertiajs/vue3';
import { computed } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  requests: Array,
  nama_kelas: String,
});

const pendingRequests = computed(() => props.requests.filter(r => r.status === 'PENDING'));
const processedRequests = computed(() => props.requests.filter(r => r.status !== 'PENDING'));

const approve = (id) => {
  if (confirm('Apakah Anda yakin ingin menyetujui reset password untuk siswa ini?')) {
    router.post(`/walikelas/reset-requests/${id}/approve`);
  }
};

const reject = (id) => {
  if (confirm('Apakah Anda yakin ingin menolak pengajuan reset password ini?')) {
    router.post(`/walikelas/reset-requests/${id}/reject`);
  }
};

const navigation = [
  {
    label: 'Perwalian',
    items: [
      { href: '/walikelas/dashboard', icon: '🏠', label: 'Dashboard Kelas' },
      { href: '/walikelas/jurnal', icon: '📓', label: 'Jurnal KBM Kelas' },
      { href: '/walikelas/pembinaan', icon: '⚡', label: 'Pembinaan & SP Siswa' },
      { href: '/walikelas/p5-assessment', icon: '🌱', label: 'Asesmen P5' },
      { href: '/walikelas/reset-requests', icon: '🔑', label: 'Reset Password' },
    ],
  },
];
</script>
