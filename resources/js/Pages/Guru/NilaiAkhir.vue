<template>
  <Head title="Kelola Nilai & Rapor" />

  <AppLayout
    title="Kelola Nilai & Rapor"
    subtitle="Kelola penilaian Formatif harian, STS, SAS, dan kalkulasi otomatis Nilai Rapor"
    :navigation="navigation"
  >
    <template #topbar-actions>
      <!-- Dropdown Pilih Mapel -->
      <div class="flex items-center gap-1.5 sm:gap-2 mr-2 sm:mr-4">
        <label class="text-xs text-slate-500 font-semibold uppercase hidden sm:inline">Mapel:</label>
        <select v-model="filterForm.id_mapel" class="bg-[#111827] border border-white/10 rounded-lg px-2 py-1.5 sm:px-3 text-xs sm:text-sm text-white outline-none focus:border-indigo-500">
          <option v-for="mapel in mapelList" :key="mapel.id_mapel" :value="mapel.id_mapel">
            {{ mapel.nama_mapel }}
          </option>
        </select>
      </div>

      <!-- Dropdown Pilih Kelas -->
      <div class="flex items-center gap-1.5 sm:gap-2 mr-2 sm:mr-4">
        <label class="text-xs text-slate-500 font-semibold uppercase hidden sm:inline">Kelas:</label>
        <select v-model="filterForm.id_kelas" class="bg-[#111827] border border-white/10 rounded-lg px-2 py-1.5 sm:px-3 text-xs sm:text-sm text-white outline-none focus:border-indigo-500">
          <option v-for="cls in kelasList" :key="cls.id_kelas" :value="cls.id_kelas">
            {{ cls.nama_kelas }}
          </option>
        </select>
      </div>
    </template>

    <div class="space-y-6">
      
      <!-- Top Stats & Info Banner -->
      <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div class="rounded-2xl border border-white/8 p-4 bg-white/2">
          <div class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">KKM Mapel Aktif</div>
          <div class="mt-2 text-2xl font-black text-white">{{ kkm }}</div>
          <div class="text-xs text-indigo-400 mt-1">Ditetapkan oleh Sekolah</div>
        </div>

        <div class="rounded-2xl border border-white/8 p-4 bg-white/2">
          <div class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Total Siswa</div>
          <div class="mt-2 text-2xl font-black text-white">
            {{ midSemesterData?.students?.length || 0 }} <span class="text-xs font-normal text-slate-400">Siswa</span>
          </div>
          <div class="text-xs text-emerald-400 mt-1">✓ Terdaftar aktif di Kelas</div>
        </div>

        <div class="rounded-2xl border border-white/8 p-4 bg-white/2">
          <div class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Bobot Rapor STS</div>
          <div class="mt-2 text-sm font-semibold text-slate-200">
            F: <span class="text-indigo-400">60%</span> | STS: <span class="text-emerald-400">30%</span> | Abs: <span class="text-amber-400">10%</span>
          </div>
          <div class="text-xs text-slate-400 mt-1">Rapor Tengah Semester</div>
        </div>

        <div class="rounded-2xl border border-white/8 p-4 bg-white/2">
          <div class="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Bobot Rapor Akhir (SAS)</div>
          <div class="mt-2 text-sm font-semibold text-slate-200">
            F: <span class="text-indigo-400">60%</span> | STS: <span class="text-purple-400">15%</span> | SAS: <span class="text-green-400">25%</span>
          </div>
          <div class="text-xs text-slate-400 mt-1">Rapor Akhir Semester</div>
        </div>
      </div>

      <!-- MAIN TABS NAVIGATION -->
      <div class="flex flex-wrap gap-2 border-b border-white/10 pb-px">
        <button 
          v-for="tab in ['formatif', 'sts', 'sas', 'akhir']" 
          :key="tab"
          @click="activeTab = tab"
          :class="[
            'px-5 py-3 text-xs font-bold uppercase tracking-wider border-b-2 transition-all -mb-px',
            activeTab === tab 
              ? 'border-indigo-500 text-indigo-400 font-extrabold'
              : 'border-transparent text-slate-400 hover:text-white hover:border-white/20'
          ]"
        >
          📂 {{ getTabLabel(tab) }}
        </button>
      </div>

      <!-- TAB 1: NILAI FORMATIF -->
      <div v-if="activeTab === 'formatif'" class="space-y-4">
        <div class="flex items-center justify-between">
          <h3 class="text-sm font-bold text-slate-200">Daftar Asesmen Formatif (Harian)</h3>
          <button @click="openCreateAssessmentModal" class="px-4 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-all">
            + Tambah Formatif
          </button>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          <div v-for="asm in formatifAssessments" :key="asm.id_assessment" class="rounded-2xl border border-white/8 p-5 bg-white/2 hover:border-indigo-500/30 transition-all flex flex-col justify-between">
            <div class="space-y-2">
              <div class="flex justify-between items-start">
                <span class="px-2 py-0.5 rounded-full text-[9px] font-bold bg-indigo-500/10 text-indigo-400 border border-indigo-500/20">
                  {{ asm.bentuk_asesmen }}
                </span>
                <span class="text-[10px] text-slate-500">{{ asm.tanggal || '-' }}</span>
              </div>
              <h4 class="font-bold text-white text-sm">{{ asm.nama_asesmen }}</h4>
              <p class="text-xs text-slate-400 line-clamp-2">{{ asm.deskripsi || 'Tidak ada deskripsi.' }}</p>
              
              <div class="space-y-1">
                <span class="block text-[8px] font-bold text-slate-500 uppercase tracking-widest">TP yang diukur:</span>
                <div class="flex flex-wrap gap-1">
                  <span v-for="tp in asm.learning_objectives" :key="tp.id_tp" class="px-2 py-0.5 rounded-md text-[8px] font-mono bg-white/5 text-slate-300">
                    {{ tp.kode_tp }}
                  </span>
                </div>
              </div>
            </div>

            <div class="flex gap-2 mt-4 border-t border-white/5 pt-3">
              <button @click="openInputScorePanel(asm)" class="flex-1 px-3 py-1.5 bg-indigo-500/10 hover:bg-indigo-500/20 border border-indigo-500/20 rounded-lg text-xs font-bold text-indigo-400 transition-colors">
                📝 Input Nilai
              </button>
              <button @click="deleteAssessment(asm.id_assessment)" class="px-3 py-1.5 bg-rose-500/10 hover:bg-rose-500/20 border border-rose-500/20 rounded-lg text-xs font-bold text-rose-400 transition-colors">
                🗑️
              </button>
            </div>
          </div>

          <div v-if="formatifAssessments.length === 0" class="col-span-full py-12 rounded-2xl border border-dashed border-white/10 text-center text-xs text-slate-500">
            Belum ada asesmen formatif yang dibuat untuk semester/kelas ini.
          </div>
        </div>
      </div>

      <!-- TAB 2: NILAI STS -->
      <div v-if="activeTab === 'sts'" class="space-y-4">
        <div class="flex items-center justify-between">
          <div>
            <h3 class="text-sm font-bold text-slate-200">Input Nilai Sumatif Tengah Semester (STS)</h3>
            <p class="text-xs text-slate-400">STS hanya diinput satu kali dalam semester aktif.</p>
          </div>
          <button @click="saveStsScores" class="px-4 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-all shadow-md">
            Simpan Nilai STS
          </button>
        </div>

        <div class="rounded-2xl border border-white/8 overflow-hidden bg-[#1A2035]">
          <table class="w-full text-left border-collapse">
            <thead>
              <tr class="bg-white/4 border-b border-white/8">
                <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase w-12 text-center">No</th>
                <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase">Nama Siswa</th>
                <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase w-48 text-center bg-indigo-500/5">Nilai STS (0-100)</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(student, idx) in stsForm.students" :key="student.id_siswa" class="border-b border-white/4">
                <td class="px-4 py-3 text-sm text-slate-500 text-center">{{ idx + 1 }}</td>
                <td class="px-4 py-3">
                  <div class="text-sm font-semibold text-white">{{ student.nama }}</div>
                  <div class="text-[10px] text-slate-500">{{ student.nis }}</div>
                </td>
                <td class="p-0 bg-indigo-500/5 relative">
                  <input 
                    v-model.number="student.nilai" 
                    type="number" min="0" max="100" 
                    class="w-full h-12 bg-transparent text-center text-sm font-bold text-indigo-300 outline-none focus:bg-indigo-500/10"
                    placeholder="-"
                  />
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- TAB 3: NILAI SAS -->
      <div v-if="activeTab === 'sas'" class="space-y-4">
        <div class="flex items-center justify-between">
          <div>
            <h3 class="text-sm font-bold text-slate-200">Input Nilai Sumatif Akhir Semester (SAS)</h3>
            <p class="text-xs text-slate-400">SAS hanya diinput satu kali pada akhir semester.</p>
          </div>
          <button @click="saveSasScores" class="px-4 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-all shadow-md">
            Simpan Nilai SAS
          </button>
        </div>

        <div class="rounded-2xl border border-white/8 overflow-hidden bg-[#1A2035]">
          <table class="w-full text-left border-collapse">
            <thead>
              <tr class="bg-white/4 border-b border-white/8">
                <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase w-12 text-center">No</th>
                <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase">Nama Siswa</th>
                <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase w-48 text-center bg-indigo-500/5">Nilai SAS (0-100)</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(student, idx) in sasForm.students" :key="student.id_siswa" class="border-b border-white/4">
                <td class="px-4 py-3 text-sm text-slate-500 text-center">{{ idx + 1 }}</td>
                <td class="px-4 py-3">
                  <div class="text-sm font-semibold text-white">{{ student.nama }}</div>
                  <div class="text-[10px] text-slate-500">{{ student.nis }}</div>
                </td>
                <td class="p-0 bg-indigo-500/5 relative">
                  <input 
                    v-model.number="student.nilai" 
                    type="number" min="0" max="100" 
                    class="w-full h-12 bg-transparent text-center text-sm font-bold text-indigo-300 outline-none focus:bg-indigo-500/10"
                    placeholder="-"
                  />
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- TAB 4: REKAP NILAI AKHIR (AUTOMATED) -->
      <div v-if="activeTab === 'akhir'" class="space-y-4">
        <!-- Sub-phase tabs -->
        <div class="flex gap-2">
          <button 
            @click="activeSubPhase = 'mid'" 
            :class="[
              'px-4 py-1.5 rounded-lg text-xs font-bold transition-all',
              activeSubPhase === 'mid' 
                ? 'bg-indigo-500/20 border border-indigo-500 text-indigo-300' 
                : 'bg-white/5 border border-white/10 text-slate-400 hover:bg-white/10'
            ]"
          >
            Rapor Tengah Semester (STS)
          </button>
          <button 
            @click="activeSubPhase = 'end'" 
            :class="[
              'px-4 py-1.5 rounded-lg text-xs font-bold transition-all',
              activeSubPhase === 'end' 
                ? 'bg-indigo-500/20 border border-indigo-500 text-indigo-300' 
                : 'bg-white/5 border border-white/10 text-slate-400 hover:bg-white/10'
            ]"
          >
            Rapor Akhir Semester (SAS)
          </button>
        </div>

        <div v-if="activeSubPhase === 'mid'" class="space-y-2">
          <div class="flex items-center justify-between text-xs text-slate-400 bg-white/3 border border-white/8 p-3.5 rounded-xl">
            <span>⚙️ <strong>Bobot Tengah Semester Aktif:</strong> Kehadiran (10%), Formatif (60%), STS (30%)</span>
            <span>Formula: <code>(Absensi*10% + Formatif*60% + STS*30%)</code></span>
          </div>

          <div class="rounded-2xl border border-white/8 overflow-hidden bg-[#1A2035] shadow-xl">
            <table class="w-full text-left border-collapse">
              <thead>
                <tr class="bg-white/4 border-b border-white/8">
                  <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase w-12 text-center">No</th>
                  <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase">Nama Siswa</th>
                  <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase text-center w-28">Absensi<br/><span class="text-amber-400">(10%)</span></th>
                  <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase text-center w-28">Formatif<br/><span class="text-indigo-400">(60%)</span></th>
                  <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase text-center w-28">STS<br/><span class="text-purple-400">(30%)</span></th>
                  <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase text-center w-32 bg-indigo-500/10">Nilai Rapor (NR)</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(student, idx) in midSemesterData?.students" :key="student.id_siswa" class="border-b border-white/4 hover:bg-white/2">
                  <td class="px-4 py-3 text-sm text-slate-500 text-center">{{ idx + 1 }}</td>
                  <td class="px-4 py-3">
                    <div class="text-sm font-semibold text-white">{{ student.nama }}</div>
                    <div class="text-[10px] text-slate-500">{{ student.nis }}</div>
                  </td>
                  <td class="px-4 py-3 text-center font-mono text-sm text-amber-400">{{ student.absensi }}%</td>
                  <td class="px-4 py-3 text-center font-mono text-sm text-indigo-300">{{ student.formatif ?? '-' }}</td>
                  <td class="px-4 py-3 text-center font-mono text-sm text-purple-300">{{ student.sts ?? '-' }}</td>
                  <td 
                    class="px-4 py-3 text-center bg-indigo-500/10 font-black text-base text-white border-l border-white/5"
                    :class="student.nilai_rapor < kkm ? 'bg-rose-500/10 text-rose-400' : ''"
                  >
                    {{ student.nilai_rapor }}
                    <span v-if="student.nilai_rapor < kkm" class="block text-[8px] font-bold uppercase tracking-wider text-rose-500/80 mt-0.5">⚠️ Remedi</span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <div v-if="activeSubPhase === 'end'" class="space-y-2">
          <div class="flex items-center justify-between text-xs text-slate-400 bg-white/3 border border-white/8 p-3.5 rounded-xl">
            <span>⚙️ <strong>Bobot Akhir Semester Aktif:</strong> Formatif (60%), STS (15%), SAS (25%)</span>
            <span>Formula: <code>(Formatif*60% + STS*15% + SAS*25%)</code></span>
          </div>

          <div class="rounded-2xl border border-white/8 overflow-hidden bg-[#1A2035] shadow-xl">
            <table class="w-full text-left border-collapse">
              <thead>
                <tr class="bg-white/4 border-b border-white/8">
                  <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase w-12 text-center">No</th>
                  <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase">Nama Siswa</th>
                  <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase text-center w-28">Formatif<br/><span class="text-indigo-400">(60%)</span></th>
                  <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase text-center w-28">STS<br/><span class="text-purple-400">(15%)</span></th>
                  <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase text-center w-28">SAS<br/><span class="text-green-400">(25%)</span></th>
                  <th class="px-4 py-3 text-[10px] font-bold text-slate-400 uppercase text-center w-32 bg-indigo-500/10">Nilai Rapor (NR)</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(student, idx) in endSemesterData?.students" :key="student.id_siswa" class="border-b border-white/4 hover:bg-white/2">
                  <td class="px-4 py-3 text-sm text-slate-500 text-center">{{ idx + 1 }}</td>
                  <td class="px-4 py-3">
                    <div class="text-sm font-semibold text-white">{{ student.nama }}</div>
                    <div class="text-[10px] text-slate-500">{{ student.nis }}</div>
                  </td>
                  <td class="px-4 py-3 text-center font-mono text-sm text-indigo-300">{{ student.formatif ?? '-' }}</td>
                  <td class="px-4 py-3 text-center font-mono text-sm text-purple-300">{{ student.sts ?? '-' }}</td>
                  <td class="px-4 py-3 text-center font-mono text-sm text-green-300">{{ student.sas ?? '-' }}</td>
                  <td 
                    class="px-4 py-3 text-center bg-indigo-500/10 font-black text-base text-white border-l border-white/5"
                    :class="student.nilai_rapor < kkm ? 'bg-rose-500/10 text-rose-400' : ''"
                  >
                    {{ student.nilai_rapor }}
                    <span v-if="student.nilai_rapor < kkm" class="block text-[8px] font-bold uppercase tracking-wider text-rose-500/80 mt-0.5">⚠️ Remedi</span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

    </div>

    <!-- MODAL 1: BUAT/EDIT ASESMEN FORMATIF -->
    <div v-if="showAssessmentModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="bg-[#1F2937] border border-white/10 rounded-2xl w-full max-w-lg overflow-hidden shadow-2xl animate-in fade-in zoom-in-95 duration-200">
        <div class="px-6 py-4 border-b border-white/10 flex justify-between items-center">
          <h3 class="font-bold text-white text-sm">➕ Tambah Asesmen Formatif</h3>
          <button @click="showAssessmentModal = false" class="text-slate-400 hover:text-white transition-colors">✕</button>
        </div>
        
        <form @submit.prevent="submitAssessmentForm" class="p-6 space-y-4">
          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Nama Asesmen</label>
            <input v-model="asmForm.nama_asesmen" type="text" placeholder="E.g., Tugas 1 Jaringan..." class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none" required />
          </div>

          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Bentuk Asesmen</label>
              <select v-model="asmForm.bentuk_asesmen" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none">
                <option value="Tugas">Tugas</option>
                <option value="Quiz">Quiz</option>
                <option value="Observasi">Observasi</option>
                <option value="Praktik">Praktik</option>
                <option value="Diskusi">Diskusi</option>
                <option value="Presentasi">Presentasi</option>
                <option value="Portofolio">Portofolio</option>
              </select>
            </div>
            <div>
              <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Bab Terkait</label>
              <select v-model="asmForm.id_bab" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none" required>
                <option v-for="bab in babs" :key="bab.id_bab" :value="bab.id_bab">
                  Bab {{ bab.urutan }}: {{ bab.nama_bab }}
                </option>
              </select>
            </div>
          </div>

          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Tanggal Pelaksanaan</label>
              <input v-model="asmForm.tanggal" type="date" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none" />
            </div>
            <div>
              <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Status</label>
              <select v-model="asmForm.status" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none">
                <option value="DRAFT">DRAFT</option>
                <option value="AKTIF">AKTIF</option>
                <option value="SELESAI">SELESAI</option>
              </select>
            </div>
          </div>

          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Tujuan Pembelajaran (TP) yang Diukur</label>
            <div class="flex flex-wrap gap-2 max-h-24 overflow-y-auto pr-1">
              <label v-for="tp in tps" :key="tp.id_tp" class="flex items-center gap-1.5 px-2.5 py-1 rounded-lg border border-white/5 bg-white/3 text-xs text-slate-300 cursor-pointer select-none">
                <input type="checkbox" :value="tp.id_tp" v-model="asmForm.tp_ids" class="rounded border-white/10 text-indigo-600 focus:ring-indigo-500" />
                <span>{{ tp.kode_tp }}</span>
              </label>
            </div>
          </div>

          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Deskripsi / Catatan</label>
            <textarea v-model="asmForm.deskripsi" rows="2" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none resize-none"></textarea>
          </div>

          <div class="flex justify-end gap-2 border-t border-white/5 pt-4">
            <button type="button" @click="showAssessmentModal = false" class="px-4 py-2 border border-white/10 rounded-xl text-xs font-bold text-slate-300 hover:text-white transition-colors">Batal</button>
            <button type="submit" class="px-5 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-colors">Simpan Asesmen</button>
          </div>
        </form>
      </div>
    </div>

    <div v-if="showScorePanel" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="bg-[#1F2937] border border-white/10 rounded-2xl w-full max-w-5xl overflow-hidden shadow-2xl animate-in fade-in zoom-in-95 duration-200">
        <div class="px-6 py-4 border-b border-white/10 flex justify-between items-center bg-white/3">
          <div>
            <h3 class="font-bold text-white text-sm">📝 Input Nilai Formatif</h3>
            <p class="text-[10px] text-indigo-400 font-semibold">{{ activeAsm?.nama_asesmen }}</p>
          </div>
          <button @click="showScorePanel = false" class="text-slate-400 hover:text-white transition-colors">✕</button>
        </div>
        
        <form @submit.prevent="submitScoreForm" class="flex flex-col h-[500px]">
          <div class="flex-1 overflow-y-auto p-6 space-y-3 custom-scrollbar">
            <table class="w-full border-collapse text-left">
              <thead>
                <tr class="border-b border-white/5 pb-2">
                  <th class="text-[10px] font-bold text-slate-400 uppercase w-12 text-center pb-2">No</th>
                  <th class="text-[10px] font-bold text-slate-400 uppercase pb-2">Nama Siswa</th>
                  <th class="text-[10px] font-bold text-slate-400 uppercase w-32 text-center pb-2 bg-indigo-500/5">Nilai (0-100)</th>
                  <th class="text-[10px] font-bold text-slate-400 uppercase pb-2 pl-4">Catatan / Keterangan</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(student, idx) in scoreForm.students" :key="student.id_siswa" class="border-b border-white/4">
                  <td class="py-2.5 text-xs text-slate-500 text-center">{{ idx + 1 }}</td>
                  <td class="py-2.5">
                    <div class="text-xs font-bold text-slate-200">{{ student.nama }}</div>
                    <div class="text-[9px] text-slate-500">{{ student.nis }}</div>
                  </td>
                  <td class="p-0 bg-indigo-500/5 relative">
                    <input 
                      v-model.number="student.nilai" 
                      type="number" min="0" max="100" 
                      class="w-full h-10 bg-transparent text-center text-xs font-bold text-indigo-300 outline-none"
                      placeholder="-"
                    />
                  </td>
                  <td class="p-0 pl-4">
                    <input 
                      v-model="student.catatan" 
                      type="text" 
                      class="w-full bg-transparent border-none outline-none text-xs text-slate-300"
                      placeholder="Tulis catatan jika ada..."
                    />
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="px-6 py-4 border-t border-white/5 bg-white/3 flex justify-end gap-2 shrink-0">
            <button type="button" @click="showScorePanel = false" class="px-4 py-2 border border-white/10 rounded-xl text-xs font-bold text-slate-300 hover:text-white transition-colors">Batal</button>
            <button type="submit" class="px-5 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-colors shadow-lg shadow-indigo-500/20">
              Simpan Semua Nilai
            </button>
          </div>
        </form>
      </div>
    </div>

  </AppLayout>
</template>

<script setup>
import { Head, router, useForm } from '@inertiajs/vue3';
import { ref, watch, onMounted, computed } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  kelasList: Array,
  mapelList: Array,
  selectedKelas: [String, Number],
  selectedMapel: [String, Number],
  midSemesterData: Object,
  endSemesterData: Object,
  kkm: Number,
  assessments: Array,
  babs: Array,
  tps: Array,
});

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
      { href: '/guru/nilai-akhir', icon: '📋', label: 'Kelola Nilai' },
      { href: '/guru/rapor-preview', icon: '📑', label: 'Rapor Preview' },
    ],
  },
];

const activeTab = ref('formatif');
const activeSubPhase = ref('mid');

// Form Filter
const filterForm = useForm({
  id_kelas: props.selectedKelas,
  id_mapel: props.selectedMapel,
});

// Watch filter changes
watch(() => filterForm.id_kelas, (val) => {
  if (val) router.get('/guru/nilai-akhir', { id_kelas: val, id_mapel: filterForm.id_mapel }, { preserveState: true });
});
watch(() => filterForm.id_mapel, (val) => {
  if (val) router.get('/guru/nilai-akhir', { id_kelas: filterForm.id_kelas, id_mapel: val }, { preserveState: true });
});

// Form Asesmen Formatif (Tambah/Edit)
const showAssessmentModal = ref(false);
const asmForm = useForm({
  id_assessment: null,
  id_bab: '',
  id_kelas: props.selectedKelas,
  id_mapel: props.selectedMapel,
  nama_asesmen: '',
  kategori: 'FORMATIF',
  bentuk_asesmen: 'Tugas',
  tanggal: new Date().toISOString().substr(0, 10),
  deskripsi: '',
  status: 'DRAFT',
  tp_ids: [],
});

const openCreateAssessmentModal = () => {
  asmForm.reset();
  asmForm.id_kelas = props.selectedKelas;
  asmForm.id_mapel = props.selectedMapel;
  asmForm.tp_ids = [];
  if (props.babs && props.babs.length > 0) {
    asmForm.id_bab = props.babs[0].id_bab;
  }
  showAssessmentModal.value = true;
};

const submitAssessmentForm = () => {
  if (asmForm.tp_ids.length === 0) {
    window.dispatchEvent(new CustomEvent('toast', { detail: { message: 'Pilih minimal satu Tujuan Pembelajaran (TP) yang diukur!', type: 'error' } }));
    return;
  }
  asmForm.post('/guru/asesmen/store', {
    preserveScroll: true,
    onSuccess: () => {
      showAssessmentModal.value = false;
    }
  });
};

const deleteAssessment = (id) => {
  if (confirm('Apakah Anda yakin ingin menghapus asesmen formatif ini?')) {
    router.delete(`/guru/asesmen/${id}`, {
      preserveScroll: true
    });
  }
};

// Form Input Skor (Siswa)
const showScorePanel = ref(false);
const activeAsm = ref(null);
const scoreForm = useForm({
  id_assessment: null,
  students: []
});

const openInputScorePanel = (asm) => {
  activeAsm.value = asm;
  scoreForm.id_assessment = asm.id_assessment;
  
  // Map student list from props.midSemesterData
  const baseStudents = props.midSemesterData?.students || [];
  scoreForm.students = baseStudents.map(s => {
    // Find if score already exists for this assessment
    const existScore = (asm.scores || []).find(sc => sc.id_siswa === s.id_siswa);
    return {
      id_siswa: s.id_siswa,
      nama: s.nama,
      nis: s.nis,
      nilai: existScore ? Math.round(existScore.nilai) : '',
      catatan: existScore ? existScore.catatan : ''
    };
  });

  showScorePanel.value = true;
};

const submitScoreForm = () => {
  scoreForm.post('/guru/asesmen/input-nilai', {
    preserveScroll: true,
    onSuccess: () => {
      showScorePanel.value = false;
    }
  });
};

// Form STS Input
const stsForm = useForm({
  id_kelas: props.selectedKelas,
  id_mapel: props.selectedMapel,
  tipe: 'STS',
  students: []
});

// Form SAS Input
const sasForm = useForm({
  id_kelas: props.selectedKelas,
  id_mapel: props.selectedMapel,
  tipe: 'SAS',
  students: []
});

// Sync STS & SAS Forms when props change
const syncSumativeForms = () => {
  stsForm.id_kelas = props.selectedKelas;
  stsForm.id_mapel = props.selectedMapel;
  
  const baseStudents = props.midSemesterData?.students || [];
  stsForm.students = baseStudents.map(s => ({
    id_siswa: s.id_siswa,
    nama: s.nama,
    nis: s.nis,
    nilai: s.sts !== null ? Math.round(s.sts) : '',
  }));

  sasForm.id_kelas = props.selectedKelas;
  sasForm.id_mapel = props.selectedMapel;
  const sasStudents = props.endSemesterData?.students || [];
  sasForm.students = sasStudents.map(s => ({
    id_siswa: s.id_siswa,
    nama: s.nama,
    nis: s.nis,
    nilai: s.sas !== null ? Math.round(s.sas) : '',
  }));
};

onMounted(() => {
  syncSumativeForms();
});

watch(() => props.midSemesterData, () => {
  syncSumativeForms();
}, { deep: true });

const saveStsScores = () => {
  stsForm.post('/guru/nilai-akhir', {
    preserveScroll: true,
  });
};

const saveSasScores = () => {
  sasForm.post('/guru/nilai-akhir', {
    preserveScroll: true,
  });
};

// Computations & Utilities
const formatifAssessments = computed(() => {
  return (props.assessments || []).filter(a => a.kategori === 'FORMATIF');
});

const getTabLabel = (tab) => {
  if (tab === 'formatif') return 'Nilai Formatif';
  if (tab === 'sts') return 'Nilai STS';
  if (tab === 'sas') return 'Nilai SAS';
  return 'Nilai Rapor Akhir';
};
</script>

<style scoped>
input[type="number"]::-webkit-inner-spin-button,
input[type="number"]::-webkit-outer-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
input[type="number"] {
  -moz-appearance: textfield;
}
</style>
