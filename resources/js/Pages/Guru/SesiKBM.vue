<template>
  <Head :title="`Sesi KBM — ${session?.mapel}`" />

  <AppLayout
    :title="`Sesi KBM Aktif`"
    :subtitle="`${session?.mapel} — ${session?.kelas}`"
    :navigation="navigation"
  >
    <template #topbar-actions>
      <span class="text-xs font-mono" :class="sessionStatus === 'AKTIF' ? 'text-green-400' : sessionStatus === 'SELESAI' ? 'text-blue-400' : sessionStatus === 'SCANNING' ? 'text-indigo-400' : 'text-yellow-400'">
        {{ sessionStatus === 'AKTIF' ? '🟢 Sesi Aktif' : sessionStatus === 'SELESAI' ? '🔵 Sesi Selesai' : sessionStatus === 'SCANNING' ? '⚡ Menunggu Selfie Guru' : '🟡 Menunggu Start' }}
      </span>
    </template>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

      <!-- ===================== PANEL KIRI: QR ENGINE / JURNAL ===================== -->
      <div class="space-y-5">

        <!-- Status Card -->
        <div :class="[
          'rounded-2xl border p-5 transition-all duration-500',
          sessionStatus === 'AKTIF' ? 'border-green-500/30 bg-green-500/8' :
          sessionStatus === 'SELESAI' ? 'border-blue-500/30 bg-blue-500/8' :
          sessionStatus === 'SCANNING' ? 'border-indigo-500/30 bg-indigo-500/8' :
          'border-yellow-500/30 bg-yellow-500/8'
        ]">
          <div class="flex items-center gap-3">
            <div :class="[
              'w-12 h-12 rounded-xl flex items-center justify-center text-2xl flex-shrink-0',
              sessionStatus === 'AKTIF' ? 'bg-green-500/20' :
              sessionStatus === 'SELESAI' ? 'bg-blue-500/20' :
              sessionStatus === 'SCANNING' ? 'bg-indigo-500/20' :
              'bg-yellow-500/20'
            ]">
              {{ sessionStatus === 'AKTIF' ? '✅' : sessionStatus === 'SELESAI' ? '✓' : sessionStatus === 'SCANNING' ? '⚡' : '⏳' }}
            </div>
            <div>
              <div class="font-bold" :class="sessionStatus === 'AKTIF' ? 'text-green-400' : sessionStatus === 'SELESAI' ? 'text-blue-400' : sessionStatus === 'SCANNING' ? 'text-indigo-400' : 'text-yellow-400'">
                {{ sessionStatus === 'AKTIF' ? 'KELAS AKTIF' : sessionStatus === 'SELESAI' ? 'SESI SELESAI' : sessionStatus === 'SCANNING' ? 'MENUNGGU SELFIE GURU' : 'PENDING' }}
              </div>
              <div class="text-xs text-slate-500 mt-0.5">
                {{ sessionStatus === 'AKTIF' ? 'Pembelajaran sedang berlangsung. Absensi default hadir.' : 
                   sessionStatus === 'SELESAI' ? 'Pertemuan kelas ini sudah selesai dideklarasikan.' :
                   sessionStatus === 'SCANNING' ? 'Silakan ambil foto selfie bersama siswa di kelas untuk mengaktifkan sesi KBM.' :
                   'Tekan tombol Mulai Sesi KBM di Dashboard untuk memulai kelas.' }}
              </div>
            </div>
          </div>
        </div>

        <!-- Selfie Check-in Container (hanya jika SCANNING) -->
        <div v-if="sessionStatus === 'SCANNING'" class="rounded-2xl border border-white/8 p-6 text-center shadow-lg" style="background: var(--card)">
          <div class="text-sm font-bold mb-1 text-white">Verifikasi Selfie Check-in</div>
          <div class="text-xs text-amber-400 font-bold mb-4 animate-pulse">⚠️ PENTING: Wajib memutar HP ke posisi horizontal (landscape) agar seluruh siswa masuk dalam foto.</div>

          <!-- Video Stream or Capture Preview -->
          <div class="relative w-full max-w-sm mx-auto aspect-[4/3] rounded-2xl bg-black/50 overflow-hidden border border-white/8 shadow-inner flex items-center justify-center">
            <!-- Captured Image preview -->
            <img 
              v-if="capturedImage"
              :src="capturedImage"
              class="w-full h-full object-cover"
              alt="Hasil Capture Selfie"
            />

            <!-- Placeholder / Camera Off -->
            <div v-else class="text-slate-500 text-xs p-4 flex flex-col items-center gap-3 w-full">
              <span class="text-4xl animate-bounce">📷</span>
              <span class="font-semibold text-slate-400">Silakan ambil foto selfie bersama murid</span>
              
              <div class="flex flex-col gap-2 w-full max-w-[240px]">
                <!-- Input file/kamera bawaan HP (Utama) -->
                <label 
                  class="w-full py-3 bg-emerald-600 hover:bg-emerald-500 text-white font-bold rounded-xl text-xs transition-all shadow-md active:scale-95 cursor-pointer text-center flex items-center justify-center gap-1.5"
                >
                  📸 Ambil Foto via Kamera HP
                  <input 
                    type="file" 
                    accept="image/*" 
                    capture="user" 
                    class="hidden" 
                    @change="handleFileInput"
                  />
                </label>
              </div>
            </div>

            <!-- Fetching GPS indicator -->
            <div v-if="isLocationFetching" class="absolute top-3 left-3 bg-black/85 px-3 py-1.5 rounded-full text-[10px] text-indigo-300 border border-indigo-500/25 flex items-center gap-1.5 backdrop-blur-md">
              <span class="w-2 h-2 rounded-full bg-indigo-400 animate-ping"></span>
              Menentukan koordinat GPS...
            </div>
            
            <!-- GPS ready indicator -->
            <div v-else-if="coords.latitude" class="absolute top-3 left-3 bg-black/85 px-3 py-1.5 rounded-full text-[10px] text-green-400 border border-green-500/25 flex items-center gap-1.5 backdrop-blur-md">
              <span class="w-2 h-2 rounded-full bg-green-400"></span>
              GPS Terkunci ({{ coords.latitude.toFixed(4) }}, {{ coords.longitude.toFixed(4) }})
            </div>
          </div>

          <!-- GPS Warning if not supported / error -->
          <div v-if="!isLocationFetching && !coords.latitude" class="mt-3.5 text-[10px] text-amber-400 bg-amber-500/10 border border-amber-500/20 px-3.5 py-2.5 rounded-xl text-center max-w-sm mx-auto">
            ⚠️ Izin lokasi/GPS diperlukan untuk validasi kehadiran. Aktifkan GPS lalu izinkan browser mengakses lokasi.
          </div>

          <!-- Controls -->
          <div class="mt-5 space-y-2.5 max-w-sm mx-auto">
            <!-- Action buttons after capture -->
            <div v-if="capturedImage" class="flex gap-2">
              <label 
                class="flex-1 py-3 bg-white/5 hover:bg-white/10 text-slate-300 hover:text-white border border-white/10 font-bold rounded-xl text-xs transition-colors cursor-pointer text-center flex items-center justify-center gap-1.5"
              >
                🔄 Foto Ulang
                <input 
                  type="file" 
                  accept="image/*" 
                  capture="user" 
                  class="hidden" 
                  @change="handleFileInput"
                />
              </label>
              <button 
                type="button"
                @click="submitSelfie"
                :disabled="isUploadingSelfie"
                class="flex-1 py-3 bg-green-600 hover:bg-green-500 text-white font-bold rounded-xl text-xs transition-all shadow-lg hover:-translate-y-0.5 active:translate-y-0 active:scale-[0.98] flex items-center justify-center gap-1.5 disabled:opacity-50"
              >
                <span v-if="isUploadingSelfie" class="w-3.5 h-3.5 rounded-full border-2 border-white/20 border-t-white animate-spin"></span>
                🚀 Unggah & Aktifkan KBM
              </button>
            </div>
          </div>

          <!-- Dev mode bypass button -->
          <div v-if="$page.props.app?.is_local_env && !capturedImage" class="mt-5 pt-4 border-t border-white/5 max-w-sm mx-auto">
            <button 
              type="button"
              @click="bypassScan"
              :disabled="isBypassing"
              class="w-full py-2.5 bg-amber-600 hover:bg-amber-500 disabled:bg-slate-700 text-white rounded-xl text-xs font-bold transition-all shadow-md hover:-translate-y-0.5 disabled:-translate-y-0 flex items-center justify-center gap-1.5"
            >
              <span v-if="isBypassing" class="w-3.5 h-3.5 rounded-full border-2 border-white/20 border-t-white animate-spin"></span>
              ⚡ Simulasi Selfie (Bypass/Isi Otomatis)
            </button>
          </div>
        </div>

        <!-- Jurnal Pembelajaran (Hanya tampil jika AKTIF) -->
        <div v-if="sessionStatus === 'AKTIF'" class="rounded-2xl border border-white/8 p-5 space-y-4" style="background: var(--card)">
          <div>
            <h3 class="text-sm font-bold text-white">Jurnal Pembelajaran Harian</h3>
            <p class="text-[10px] text-slate-500 mt-0.5">Catat ringkasan materi pembelajaran pertemuan tatap muka hari ini.</p>
          </div>
          <div class="space-y-1.5">
            <label class="text-[10px] text-slate-500 uppercase tracking-widest font-semibold">Ringkasan Materi / Catatan KBM</label>
            <textarea
              v-model="materiLog"
              rows="4"
              placeholder="Contoh: Belajar dasar routing statik dan konfigurasi IP Address di router Cisco..."
              class="w-full bg-white/5 border border-white/8 rounded-xl px-3.5 py-2.5 text-xs text-white placeholder-slate-600 outline-none focus:border-indigo-500/50 resize-none transition-colors"
            ></textarea>
          </div>
        </div>

        <!-- Session Info -->
        <div class="rounded-2xl border border-white/8 p-5" style="background: var(--card)">
          <div class="text-sm font-bold mb-4">Informasi Sesi</div>
          <div class="grid grid-cols-2 gap-3">
            <div v-for="info in sessionInfo" :key="info.label"
                 class="bg-white/4 rounded-xl p-3">
              <div class="text-[10px] text-slate-600 uppercase tracking-wide">{{ info.label }}</div>
              <div class="text-sm font-semibold mt-1" :class="info.color || 'text-white'">{{ info.value }}</div>
            </div>
          </div>
        </div>

        <!-- ===================== MODUL UJIAN LIVE ===================== -->
        <div v-if="sessionStatus === 'AKTIF'" class="rounded-2xl border border-indigo-500/30 p-5 bg-indigo-500/5 shadow-[0_0_20px_rgba(79,70,229,0.1)]">
          <div class="flex items-center gap-3 mb-4">
            <div class="w-10 h-10 rounded-xl bg-indigo-500/20 text-indigo-400 flex items-center justify-center text-xl">🚀</div>
            <div>
              <h3 class="font-bold text-white text-sm">Luncurkan Ujian Live</h3>
              <p class="text-[10px] text-indigo-300">Pilih paket soal, atur pra-ujian, lalu kirim ke HP siswa.</p>
            </div>
          </div>

          <div v-if="questionBanks && questionBanks.length > 0" class="space-y-3">
            <select v-model="selectedBankId" required @change="onBankChange" class="w-full bg-black/50 border border-indigo-500/30 rounded-xl px-3 py-2.5 text-xs text-white outline-none focus:border-indigo-400">
              <option value="" disabled>Pilih Paket Soal...</option>
              <option v-for="bank in questionBanks" :key="bank.id_bank" :value="bank.id_bank">{{ bank.judul }} ({{ bank.questions_count ?? '?' }} butir)</option>
            </select>
            <button @click="showPreExamModal = true" :disabled="!selectedBankId" class="w-full py-2.5 rounded-xl font-bold text-xs text-white transition-all bg-indigo-600 hover:bg-indigo-500 shadow-lg shadow-indigo-500/20 disabled:opacity-40 disabled:cursor-not-allowed">
              ⚙️ Atur & Mulai Ujian
            </button>
          </div>

          <div v-else class="text-xs text-slate-400 bg-white/5 p-3 rounded-xl border border-white/10 text-center">
            Anda belum memiliki bank soal untuk mapel ini. 
            <a href="/guru/bank-soal/create" class="text-indigo-400 hover:underline block mt-1">Buat Paket Soal</a>
          </div>
        </div>

        <!-- ===================== MODAL PRA-UJIAN ===================== -->
        <Teleport to="body">
          <div v-if="showPreExamModal" class="fixed inset-0 z-50 flex items-center justify-center p-4" style="background: rgba(0,0,0,0.75); backdrop-filter: blur(8px);">
            <div class="w-full max-w-lg rounded-2xl border border-white/10 p-6 space-y-5 overflow-y-auto max-h-[90vh]" style="background: #0f1623;">
              <!-- Header -->
              <div class="flex items-center justify-between">
                <h2 class="text-base font-black text-white">⚙️ Pengaturan Ujian Live</h2>
                <button @click="showPreExamModal = false" class="text-slate-500 hover:text-white text-xl leading-none">✕</button>
              </div>

              <form @submit.prevent="launchExam" class="space-y-4">

                <!-- Durasi -->
                <div>
                  <label class="block text-xs font-bold text-slate-400 mb-1">⏱ Durasi Ujian (Menit)</label>
                  <div class="flex items-center gap-2">
                    <input type="range" v-model="examSettings.durasi" min="5" max="120" step="5" class="flex-1 accent-indigo-500">
                    <span class="text-indigo-400 font-black text-sm w-12 text-center">{{ examSettings.durasi }}'</span>
                  </div>
                  <p class="text-[10px] text-slate-500 mt-1">Siswa tidak bisa menjawab setelah waktu habis.</p>
                </div>

                <hr class="border-white/5">

                <!-- Limit Soal -->
                <div>
                  <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" v-model="examSettings.useLimitSoal" class="w-4 h-4 rounded accent-indigo-500">
                    <span class="text-xs font-bold text-slate-300">Batasi jumlah soal yang ditampilkan</span>
                  </label>
                  <div v-if="examSettings.useLimitSoal" class="mt-2 flex items-center gap-3">
                    <input type="number" v-model="examSettings.limit_soal" :max="selectedBankQuestionCount" min="1"
                      class="w-24 bg-black/50 border border-white/10 rounded-xl px-3 py-2 text-sm text-white outline-none focus:border-indigo-500">
                    <span class="text-xs text-slate-500">dari {{ selectedBankQuestionCount }} soal tersedia</span>
                  </div>
                </div>

                <!-- Acak Soal -->
                <div>
                  <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" v-model="examSettings.acak_soal" class="w-4 h-4 rounded accent-indigo-500">
                    <span class="text-xs font-bold text-slate-300">Acak urutan soal untuk setiap siswa</span>
                  </label>
                  <p class="text-[10px] text-slate-500 mt-0.5 ml-6">Setiap siswa akan menerima urutan soal yang berbeda.</p>
                </div>

                <hr class="border-white/5">

                <!-- Jenis Asesmen -->
                <div>
                  <label class="block text-xs font-bold text-slate-400 mb-2">🎯 Jenis Asesmen</label>
                  <div class="grid grid-cols-2 gap-2">
                    <button type="button" @click="examSettings.tujuan = 'DIAGNOSTIK'"
                      :class="examSettings.tujuan === 'DIAGNOSTIK' ? 'border-sky-500 bg-sky-500/15 text-sky-300' : 'border-white/10 bg-white/5 text-slate-400'"
                      class="py-3 px-4 rounded-xl border text-xs font-bold transition-all text-left">
                      🔬 Asesmen Diagnostik
                      <div class="text-[10px] font-normal opacity-70 mt-0.5">Ada laporan, tidak masuk nilai</div>
                    </button>
                    <button type="button" @click="examSettings.tujuan = 'SUMATIF'; loadTpList()"
                      :class="examSettings.tujuan === 'SUMATIF' ? 'border-green-500 bg-green-500/15 text-green-300' : 'border-white/10 bg-white/5 text-slate-400'"
                      class="py-3 px-4 rounded-xl border text-xs font-bold transition-all text-left">
                      📊 Asesmen Sumatif
                      <div class="text-[10px] font-normal opacity-70 mt-0.5">Masuk ke nilai resmi Bab</div>
                    </button>
                  </div>
                </div>

                <!-- Info Diagnostik -->
                <div v-if="examSettings.tujuan === 'DIAGNOSTIK'" class="p-3 rounded-xl border border-sky-500/20 bg-sky-500/5">
                  <p class="text-[11px] text-sky-400">ℹ️ Hasil asesmen diagnostik akan tersimpan dan bisa dilihat di <strong>Laporan Diagnostik</strong>, namun <strong>tidak dihitung</strong> ke dalam nilai sumatif maupun rapor siswa.</p>
                </div>

                <!-- Pilih Bab & Topik (muncul jika SUMATIF) -->
                <div v-if="examSettings.tujuan === 'SUMATIF'" class="space-y-3 p-4 rounded-xl border border-green-500/20 bg-green-500/5">
                  <p class="text-[10px] text-green-400 font-bold">Nilai akan otomatis masuk ke Bab dan Topik Penilaian yang Anda pilih.</p>

                  <!-- Pilih Bab (TP) -->
                  <div>
                    <label class="block text-xs font-semibold text-slate-400 mb-1">Bab / Tujuan Pembelajaran (TP)</label>
                    <select v-model="examSettings.id_tp" @change="onTpChange" class="w-full bg-black/50 border border-white/10 rounded-xl px-3 py-2 text-xs text-white outline-none focus:border-green-500">
                      <option value="" disabled>Pilih Bab...</option>
                      <option v-for="tp in tpList" :key="tp.id_tp" :value="tp.id_tp">{{ tp.kode_tp }} — {{ tp.deskripsi_tp }}</option>
                    </select>
                  </div>

                  <!-- Pilih Topik Penilaian -->
                  <div v-if="examSettings.id_tp">
                    <label class="block text-xs font-semibold text-slate-400 mb-1">Topik / Judul Penilaian</label>
                    <select v-model="examSettings.id_topic" class="w-full bg-black/50 border border-white/10 rounded-xl px-3 py-2 text-xs text-white outline-none focus:border-green-500 mb-2">
                      <option value="">— Pilih Topik Lama —</option>
                      <option v-for="t in selectedTpTopics" :key="t.id_topic" :value="t.id_topic">{{ t.nama_topik }}</option>
                    </select>
                    <div v-if="!examSettings.id_topic" class="flex gap-2 items-center">
                      <input type="text" v-model="examSettings.nama_topik_baru" placeholder="Atau ketik nama topik baru (misal: UH 2)..."
                        class="flex-1 bg-black/50 border border-white/10 rounded-xl px-3 py-2 text-xs text-white outline-none focus:border-green-500">
                    </div>
                    <p class="text-[10px] text-slate-500 mt-1">Jika Topik belum ada, ketik nama baru. Sistem akan membuatnya otomatis.</p>
                  </div>
                </div>

                <!-- Actions -->
                <div class="flex gap-3 pt-2">
                  <button type="button" @click="showPreExamModal = false" class="flex-1 py-2.5 rounded-xl text-xs font-bold border border-white/10 text-slate-400 hover:text-white hover:border-white/20 transition-colors">
                    Batal
                  </button>
                  <button type="submit" class="flex-1 py-2.5 rounded-xl text-xs font-bold text-white bg-indigo-600 hover:bg-indigo-500 transition-colors shadow-lg shadow-indigo-500/20">
                    🚀 Luncurkan Ujian
                  </button>
                </div>
              </form>
            </div>
          </div>
        </Teleport>

      </div>

      <!-- ===================== PANEL KANAN: ABSENSI SISWA ===================== -->
      <div class="space-y-5">

        <!-- Attendance summary -->
        <div class="grid grid-cols-4 gap-3">
          <div v-for="s in attendanceSummary" :key="s.label"
               class="rounded-xl border border-white/8 p-3.5 text-center"
               style="background: var(--card)">
            <div class="text-xl font-black" :style="`color:${s.color}`">{{ s.count }}</div>
            <div class="text-[10px] text-slate-600 mt-0.5">{{ s.label }}</div>
          </div>
        </div>

        <!-- Student list -->
        <div class="rounded-2xl border border-white/8 overflow-hidden" style="background: var(--card)">
          <div class="flex items-center justify-between px-5 py-4 border-b border-white/8">
            <div>
              <div class="font-bold text-sm">Daftar Kehadiran Siswa</div>
              <div class="text-xs text-slate-500">{{ session?.kelas }} — {{ students.length }} siswa</div>
            </div>
            <!-- Manual absensi hanya aktif setelah sesi AKTIF -->
            <div v-if="sessionStatus === 'PENDING' || sessionStatus === 'SCANNING'"
                 class="text-[10px] text-yellow-400 bg-yellow-500/10 border border-yellow-500/20 px-2.5 py-1.5 rounded-lg">
              🔒 Tunggu Selfie Check-in
            </div>
            <div v-else-if="sessionStatus === 'SELESAI'"
                 class="text-[10px] text-slate-400 bg-white/5 border border-white/10 px-2.5 py-1.5 rounded-lg">
              🔒 Sesi Selesai (Read-only)
            </div>
            <div v-else class="text-[10px] text-green-400 bg-green-500/10 border border-green-500/20 px-2.5 py-1.5 rounded-lg font-semibold">
              ✓ Klik Status untuk Mengubah
            </div>
          </div>

          <!-- Filter tabs -->
          <div class="flex border-b border-white/8">
            <button v-for="tab in ['Semua', 'Hadir', 'Izin', 'Sakit', 'Alpa']" :key="tab"
                    @click="activeTab = tab"
                    :class="[
                      'flex-1 py-2.5 text-xs font-semibold transition-colors',
                      activeTab === tab
                        ? 'text-indigo-400 border-b-2 border-indigo-500'
                        : 'text-slate-600 hover:text-slate-400'
                    ]">
              {{ tab }}
            </button>
          </div>

          <!-- Search -->
          <div class="px-4 py-3 border-b border-white/5">
            <input
              v-model="searchQuery"
              type="text"
              placeholder="🔍 Cari nama siswa..."
              class="w-full bg-white/5 border border-white/8 rounded-lg px-3 py-2 text-xs text-white placeholder-slate-600 outline-none focus:border-indigo-500/50"
            />
          </div>

          <!-- Students -->
          <div class="overflow-y-auto" style="max-height: 400px;">
            <div v-for="siswa in filteredStudents" :key="siswa.id"
                 class="flex items-center justify-between px-4 py-3.5 border-b border-white/4 hover:bg-white/2 transition-colors">

              <div class="flex items-center gap-3 min-w-0">
                <!-- Avatar -->
                <div class="w-8 h-8 rounded-lg flex items-center justify-center text-xs font-bold flex-shrink-0"
                     :class="[
                       siswa.status === 'HADIR' ? 'bg-green-500/10 text-green-400' :
                       siswa.status === 'IZIN' ? 'bg-blue-500/10 text-blue-400' :
                       siswa.status === 'SAKIT' ? 'bg-amber-500/10 text-amber-400' :
                       'bg-red-500/10 text-red-400'
                     ]">
                  {{ siswa.nama.split(' ').map(w=>w[0]).slice(0,2).join('') }}
                </div>

                <!-- Name + NIS -->
                <div class="min-w-0">
                  <div class="text-xs font-semibold truncate">{{ siswa.nama }}</div>
                  <div class="text-[10px] text-slate-600">{{ siswa.nis }}</div>
                </div>
              </div>

              <!-- Clickable Badge Action -->
              <div>
                <button
                  @click="toggleStatus(siswa)"
                  :disabled="sessionStatus !== 'AKTIF'"
                  class="px-3 py-1.5 rounded-xl font-bold text-[11px] transition-all duration-150 flex items-center gap-1.5 select-none"
                  :class="[
                    siswa.status === 'HADIR' ? 'bg-green-500/15 text-green-400 hover:bg-green-500/25' :
                    siswa.status === 'IZIN' ? 'bg-blue-500/15 text-blue-400 hover:bg-blue-500/25' :
                    siswa.status === 'SAKIT' ? 'bg-amber-500/15 text-amber-400 hover:bg-amber-500/25' :
                    'bg-red-500/15 text-red-400 hover:bg-red-500/25',
                    sessionStatus === 'AKTIF' ? 'cursor-pointer hover:scale-[1.03] active:scale-[0.97]' : 'cursor-default'
                  ]"
                >
                  <span>{{ statusLabel(siswa.status) }}</span>
                  <span v-if="siswa.status === 'HADIR' && siswa.metode" class="text-[9px] opacity-75 font-normal">
                    ({{ siswa.metode === 'SCAN_QR' ? '📱 QR' : '✋ Manual' }})
                  </span>
                </button>
              </div>

            </div>

            <!-- Empty state -->
            <div v-if="filteredStudents.length === 0" class="py-10 text-center text-xs text-slate-500">
              Tidak ada siswa dengan filter ini
            </div>
          </div>
        </div>

        <!-- Action Buttons -->
        <div v-if="sessionStatus === 'AKTIF'" class="space-y-3">
          <button
            @click="saveAttendance"
            :disabled="isSaving"
            class="w-full py-3.5 rounded-xl font-bold text-sm text-white transition-all hover:-translate-y-0.5 flex items-center justify-center gap-2"
            style="background: linear-gradient(135deg, #22C55E, #16A34A); box-shadow: 0 8px 20px rgba(34,197,94,0.3);">
            {{ isSaving ? '⏳ Menyimpan...' : '💾 Simpan Presensi & Jurnal' }}
          </button>
          
          <button
            @click="akhiriKbm"
            class="w-full py-3.5 rounded-xl font-bold text-sm text-red-400 border border-red-500/30 hover:bg-red-500/10 transition-colors flex items-center justify-center gap-2">
            🛑 Akhiri Sesi KBM (Selesai)
          </button>
        </div>

      </div>
    </div>
  </AppLayout>
</template>

<script setup>
import { Head, router, usePage } from '@inertiajs/vue3';
import { ref, computed, onMounted, onUnmounted, watch } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({ 
  sessionId: [String, Number], 
  session: Object, 
  students: Array,
  questionBanks: Array
});

// ---- Session state ----
const sessionStatus = ref(props.session?.status_sesi || 'PENDING'); 
const isRefreshing = ref(false);
const isSaving = ref(false);
const materiLog = ref(props.session?.materi_log || '');

const selectedBankId = ref('');
const showPreExamModal = ref(false);
const tpList = ref([]);
const selectedTpTopics = ref([]);

const examSettings = ref({
  durasi: 30,
  useLimitSoal: false,
  limit_soal: 10,
  acak_soal: true,
  tujuan: 'DIAGNOSTIK',
  id_tp: '',
  id_topic: '',
  nama_topik_baru: '',
});

const selectedBankQuestionCount = computed(() => {
  const bank = props.questionBanks?.find(b => b.id_bank === selectedBankId.value);
  return bank?.questions_count ?? 0;
});

const onBankChange = () => {
  examSettings.value.limit_soal = selectedBankQuestionCount.value || 10;
};

const loadTpList = async () => {
  if (tpList.value.length > 0) return;
  try {
    const res = await fetch(`/guru/live-exam/tp-list?id_kbm_session=${props.sessionId}`);
    const data = await res.json();
    tpList.value = data.tps || [];
  } catch (e) {
    console.error('Gagal load TP list', e);
  }
};

const onTpChange = () => {
  examSettings.value.id_topic = '';
  examSettings.value.nama_topik_baru = '';
  const tp = tpList.value.find(t => t.id_tp === examSettings.value.id_tp);
  selectedTpTopics.value = tp?.topics || [];
};

const launchExam = () => {
  if (!selectedBankId.value) return;
  router.post(`/guru/live-exam/launch`, {
    id_bank: selectedBankId.value,
    id_kbm_session: props.sessionId,
    durasi: examSettings.value.durasi,
    limit_soal: examSettings.value.useLimitSoal ? examSettings.value.limit_soal : null,
    acak_soal: examSettings.value.acak_soal,
    tujuan: examSettings.value.tujuan,
    id_tp: examSettings.value.tujuan === 'SUMATIF' ? examSettings.value.id_tp : null,
    id_topic: examSettings.value.id_topic || null,
    nama_topik_baru: !examSettings.value.id_topic ? examSettings.value.nama_topik_baru : null,
  });
};

// ---- Camera and Selfie state ----
const videoRef = ref(null);
const stream = ref(null);
const capturedImage = ref(null);
const isCameraActive = ref(false);
const isLocationFetching = ref(false);
const coords = ref({ latitude: null, longitude: null });
const isUploadingSelfie = ref(false);
const isBypassing = ref(false);

const startCamera = async () => {
  try {
    capturedImage.value = null;
    isCameraActive.value = true;
    stream.value = await navigator.mediaDevices.getUserMedia({
      video: { facingMode: 'user', width: { ideal: 640 }, height: { ideal: 480 } },
      audio: false
    });
    if (videoRef.value) {
      videoRef.value.srcObject = stream.value;
    }
  } catch (err) {
    console.error("Gagal mengakses kamera:", err);
    window.dispatchEvent(new CustomEvent('toast', { detail: { message: 'Gagal mengakses kamera. Silakan periksa izin kamera Anda.', type: 'danger' } }));
    isCameraActive.value = false;
  }
};

const stopCamera = () => {
  if (stream.value) {
    stream.value.getTracks().forEach(track => track.stop());
    stream.value = null;
  }
  isCameraActive.value = false;
};

const getGeolocation = () => {
  return new Promise((resolve) => {
    if (!navigator.geolocation) {
      resolve(null);
      return;
    }
    isLocationFetching.value = true;
    navigator.geolocation.getCurrentPosition(
      (position) => {
        coords.value.latitude = position.coords.latitude;
        coords.value.longitude = position.coords.longitude;
        isLocationFetching.value = false;
        resolve(position.coords);
      },
      (error) => {
        console.error("Gagal mendapatkan lokasi:", error);
        isLocationFetching.value = false;
        resolve(null);
      },
      { enableHighAccuracy: true, timeout: 7000, maximumAge: 0 }
    );
  });
};

const capturePhoto = async () => {
  if (!videoRef.value) return;

  const video = videoRef.value;

  // Wajibkan landscape mode
  if (video.videoWidth < video.videoHeight) {
    window.dispatchEvent(new CustomEvent('toast', { detail: { message: 'Gagal jepret! Wajib memutar HP ke posisi horizontal (landscape) agar semua siswa masuk dalam foto.', type: 'danger' } }));
    return;
  }

  const canvas = document.createElement('canvas');
  canvas.width = video.videoWidth || 640;
  canvas.height = video.videoHeight || 480;

  const ctx = canvas.getContext('2d');
  
  // Efek cermin saat menggambar dari video selfie (facingMode user)
  ctx.translate(canvas.width, 0);
  ctx.scale(-1, 1);
  ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
  ctx.setTransform(1, 0, 0, 1, 0, 0); // reset transform

  // Jalankan fetch koordinat secara async paralel jika belum ada
  if (!coords.value.latitude) {
    await getGeolocation();
  }

  // Tambahkan Watermark yang lebih tebal dan jelas
  ctx.fillStyle = 'rgba(0, 0, 0, 0.75)';
  ctx.fillRect(0, canvas.height - 80, canvas.width, 80);

  ctx.fillStyle = '#FFFFFF';
  ctx.font = 'bold 13px sans-serif';

  // Watermark Waktu
  const now = new Date();
  const dateStr = now.toLocaleDateString('id-ID', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' }) + ' ' + now.toLocaleTimeString('id-ID');
  ctx.fillText(`📅 WAKTU : ${dateStr}`, 15, canvas.height - 48);

  // Watermark Lokasi GPS
  const latVal = coords.value.latitude ? coords.value.latitude.toFixed(6) : 'Tidak Terdeteksi';
  const lngVal = coords.value.longitude ? coords.value.longitude.toFixed(6) : 'Tidak Terdeteksi';
  ctx.fillText(`📍 LOKASI: Lat: ${latVal}, Lng: ${lngVal}`, 15, canvas.height - 20);

  // Kompresi kualitas JPEG 0.6 (60%)
  capturedImage.value = canvas.toDataURL('image/jpeg', 0.6);
  stopCamera();
};

const handleFileInput = async (e) => {
  const file = e.target.files[0];
  if (!file) return;

  // Cek koordinat GPS
  if (!coords.value.latitude) {
    await getGeolocation();
  }

  const reader = new FileReader();
  reader.onload = (event) => {
    const img = new Image();
    img.onload = () => {
      // Wajibkan landscape mode
      if (img.width < img.height) {
        window.dispatchEvent(new CustomEvent('toast', { detail: { message: 'Foto ditolak! Wajib mengambil foto dalam posisi horizontal/landscape agar seluruh kelas terlihat.', type: 'danger' } }));
        return;
      }

      const canvas = document.createElement('canvas');
      const maxW = 640;
      const maxH = 480;
      let w = img.width;
      let h = img.height;
      if (w > maxW) {
        h = Math.round((h * maxW) / w);
        w = maxW;
      }
      if (h > maxH) {
        w = Math.round((w * maxH) / h);
        h = maxH;
      }
      canvas.width = w;
      canvas.height = h;

      const ctx = canvas.getContext('2d');
      ctx.drawImage(img, 0, 0, w, h);

      // Tambahkan Watermark yang lebih tebal dan jelas
      ctx.fillStyle = 'rgba(0, 0, 0, 0.75)';
      ctx.fillRect(0, canvas.height - 80, canvas.width, 80);

      ctx.fillStyle = '#FFFFFF';
      ctx.font = 'bold 13px sans-serif';

      // Watermark Waktu
      const nowTime = new Date();
      const dateStr = nowTime.toLocaleDateString('id-ID', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' }) + ' ' + nowTime.toLocaleTimeString('id-ID');
      ctx.fillText(`📅 WAKTU : ${dateStr}`, 15, canvas.height - 48);

      // Watermark Lokasi GPS
      const latVal = coords.value.latitude ? coords.value.latitude.toFixed(6) : 'Tidak Terdeteksi';
      const lngVal = coords.value.longitude ? coords.value.longitude.toFixed(6) : 'Tidak Terdeteksi';
      ctx.fillText(`📍 LOKASI: Lat: ${latVal}, Lng: ${lngVal}`, 15, canvas.height - 20);

      // Kompresi kualitas JPEG 0.6 (60%)
      capturedImage.value = canvas.toDataURL('image/jpeg', 0.6);
    };
    img.src = event.target.result;
  };
  reader.readAsDataURL(file);
};

const submitSelfie = () => {
  if (!capturedImage.value) return;

  isUploadingSelfie.value = true;
  router.post(`/guru/sesi-kbm/${props.sessionId}/selfie`, {
    foto: capturedImage.value,
    latitude: coords.value.latitude ? String(coords.value.latitude) : null,
    longitude: coords.value.longitude ? String(coords.value.longitude) : null
  }, {
    onSuccess: () => {
      window.dispatchEvent(new CustomEvent('toast', { detail: { message: 'Selfie berhasil diverifikasi & KBM aktif!', type: 'success' } }));
    },
    onError: (err) => {
      console.error(err);
      window.dispatchEvent(new CustomEvent('toast', { detail: { message: 'Gagal mengunggah selfie check-in.', type: 'danger' } }));
    },
    onFinish: () => {
      isUploadingSelfie.value = false;
    }
  });
};

const bypassScan = () => {
  isBypassing.value = true;
  router.post(`/dev/kbm-session/${props.sessionId}/bypass-scan`, {}, {
    onSuccess: () => {
      window.dispatchEvent(new CustomEvent('toast', { detail: { message: 'KBM diaktifkan via bypass simulasi!', type: 'success' } }));
    },
    onFinish: () => {
      isBypassing.value = false;
    }
  });
};

onMounted(() => {
  if (sessionStatus.value === 'SCANNING') {
    getGeolocation();
  }
});

// ---- Session info ----
const sessionInfo = computed(() => [
  { label: 'Mata Pelajaran', value: props.session?.subject?.nama_mapel || '-' },
  { label: 'Kelas', value: props.session?.clas?.nama_kelas || '-' },
  { label: 'Jam Pelajaran', value: `Jam ke-${props.session?.jam_ke || '-'}` },
  { label: 'Status Guru', value: props.session?.status_guru || 'PENDING', color: props.session?.status_guru === 'HADIR' ? 'text-green-400' : props.session?.status_guru === 'TERLAMBAT' ? 'text-yellow-400' : 'text-red-400' },
  { label: 'Tanggal', value: props.session?.tanggal ? new Date(props.session.tanggal).toLocaleDateString('id-ID', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' }) : '-' },
  { label: 'Waktu Aktif', value: props.session?.waktu_scan_masuk ? new Date(props.session.waktu_scan_masuk).toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit' }) : '-' },
]);

// ---- Students ----
const activeTab = ref('Semua');
const searchQuery = ref('');

const students = ref(props.students?.map(s => ({
  ...s,
  status: s.status || 'HADIR',
  metode: s.metode,
  waktu: s.waktu,
})) || []);

// Sinkronisasi data ketika props berubah (misal setelah scan/reload)
watch(() => props.students, (newVal) => {
  if (newVal) {
    students.value = newVal.map(s => ({
      ...s,
      status: s.status || 'HADIR',
      metode: s.metode,
      waktu: s.waktu,
    }));
  }
}, { deep: true });

watch(() => props.session, (newVal) => {
  if (newVal) {
    sessionStatus.value = newVal.status_sesi || 'PENDING';
    materiLog.value = newVal.materi_log || '';
  }
}, { deep: true });

const filteredStudents = computed(() => {
  let list = students.value;
  if (activeTab.value === 'Hadir') list = list.filter(s => s.status === 'HADIR');
  if (activeTab.value === 'Izin') list = list.filter(s => s.status === 'IZIN');
  if (activeTab.value === 'Sakit') list = list.filter(s => s.status === 'SAKIT');
  if (activeTab.value === 'Alpa') list = list.filter(s => s.status === 'ALPA');
  
  if (searchQuery.value) {
    const q = searchQuery.value.toLowerCase();
    list = list.filter(s => s.nama.toLowerCase().includes(q) || s.nis.includes(q));
  }
  return list;
});

const attendanceSummary = computed(() => [
  { label: 'Hadir', count: students.value.filter(s => s.status === 'HADIR').length, color: '#22C55E' },
  { label: 'Izin', count: students.value.filter(s => s.status === 'IZIN').length, color: '#3B82F6' },
  { label: 'Sakit', count: students.value.filter(s => s.status === 'SAKIT').length, color: '#F59E0B' },
  { label: 'Alpa', count: students.value.filter(s => s.status === 'ALPA').length, color: '#EF4444' },
]);

const statusLabel = (s) => {
  return {
    'HADIR': 'Hadir',
    'IZIN': 'Izin',
    'SAKIT': 'Sakit',
    'ALPA': 'Alpa'
  }[s] || 'Hadir';
};

const toggleStatus = (siswa) => {
  if (sessionStatus.value !== 'AKTIF') return;
  const statusCycle = {
    'HADIR': 'IZIN',
    'IZIN': 'SAKIT',
    'SAKIT': 'ALPA',
    'ALPA': 'HADIR'
  };
  siswa.status = statusCycle[siswa.status] || 'HADIR';
  
  if (siswa.status === 'HADIR') {
    siswa.metode = 'MANUAL_GURU';
    siswa.waktu = new Date().toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit' });
  } else {
    siswa.metode = null;
    siswa.waktu = null;
  }
};

const saveAttendance = () => {
  isSaving.value = true;
  router.post(`/guru/sesi-kbm/${props.sessionId}/presensi`, {
    students: students.value,
    materi_log: materiLog.value
  }, {
    preserveState: true,
    preserveScroll: true,
    onFinish: () => {
      isSaving.value = false;
    }
  });
};

const akhiriKbm = () => {
  if (confirm('Apakah Anda yakin ingin menyelesaikan sesi KBM ini? Data presensi dan jurnal yang belum disimpan otomatis tersimpan.')) {
    // Simpan dahulu untuk memastikan data terbaru terkirim
    router.post(`/guru/sesi-kbm/${props.sessionId}/presensi`, {
      students: students.value,
      materi_log: materiLog.value
    }, {
      onSuccess: () => {
        router.post(`/guru/sesi-kbm/${props.sessionId}/selesai`);
      }
    });
  }
};

const navigation = [
  {
    label: 'KBM (Kegiatan Belajar Mengajar)',
    items: [
      { href: '/guru/dashboard', icon: '📊', label: 'Dashboard' },
      { href: '/guru/jadwal', icon: '📅', label: 'Jadwal Mengajar' },
      { href: '/guru/riwayat-jurnal', icon: '📜', label: 'Riwayat Jurnal Mengajar' },
      { href: '/guru/materi', icon: '📁', label: 'Materi Pembelajaran' },
    ],
  },
  {
    label: 'Evaluasi & Penilaian',
    items: [
      { href: '/guru/pemetaan-materi', icon: '🗺️', label: 'Pemetaan Materi' },
      { href: '/guru/bank-soal', icon: '📝', label: 'Bank Soal & Ujian Live' },
      { href: '/guru/nilai-sumatif', icon: '📊', label: 'Nilai Sumatif' },
      { href: '/guru/nilai-akhir', icon: '📋', label: 'Nilai Akhir' },
      { href: '/guru/rapor-preview', icon: '📑', label: 'Rapor Preview' },
    ],
  },
];
</script>

<style scoped>
@keyframes shimmer {
  0% { transform: skewX(-12deg) translateX(-200%); }
  100% { transform: skewX(-12deg) translateX(200%); }
}
</style>
