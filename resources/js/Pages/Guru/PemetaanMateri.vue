<template>
  <Head title="Pemetaan Kurikulum Merdeka & Bahan Ajar" />

  <AppLayout
    title="Pemetaan Materi & Bahan Ajar"
    subtitle="Susun Capaian Pembelajaran (CP), ATP, TP, Bab, Sub-Materi, serta Aktivitas Pembelajaran"
    :navigation="navigation"
  >
    <template #topbar-actions>
      <!-- Dropdown Pilih Mapel -->
      <div class="flex items-center gap-1.5 sm:gap-2 mr-2 sm:mr-4">
        <label class="text-xs text-slate-500 font-semibold uppercase hidden sm:inline">Mapel:</label>
        <select v-model="selectedMapel" class="bg-[#111827] border border-white/10 rounded-lg px-2 py-1.5 sm:px-3 text-xs sm:text-sm text-white outline-none focus:border-indigo-500 max-w-[150px] sm:max-w-[250px] md:max-w-none truncate">
          <option v-for="mapel in uniqueMapels" :key="mapel.id_mapel" :value="mapel.id_mapel">
            {{ mapel.nama_mapel }}
          </option>
        </select>
      </div>

      <!-- Dropdown Pilih Kelas -->
      <div class="flex items-center gap-1.5 sm:gap-2 mr-2 sm:mr-4">
        <label class="text-xs text-slate-500 font-semibold uppercase hidden sm:inline">Kelas:</label>
        <select v-model="selectedKelasFilter" class="bg-[#111827] border border-white/10 rounded-lg px-2 py-1.5 sm:px-3 text-xs sm:text-sm text-white outline-none focus:border-indigo-500 max-w-[120px] sm:max-w-[200px] md:max-w-none truncate">
          <option value="">-- Semua Kelas --</option>
          <option v-for="cls in classesForSelectedMapel" :key="cls.id_kelas" :value="cls.id_kelas">
            {{ cls.nama_kelas }}
          </option>
        </select>
      </div>
    </template>

    <div class="grid grid-cols-1 lg:grid-cols-4 gap-6">

      <!-- LEFT SIDEBAR: Semester & Navigasi -->
      <div class="col-span-1 space-y-4">
        <div class="rounded-2xl border border-indigo-500/30 bg-indigo-500/10 p-5 shadow-lg shadow-indigo-500/10">
          <div class="flex items-center gap-3 mb-3">
            <div class="w-8 h-8 rounded-lg bg-indigo-500/20 text-indigo-400 flex items-center justify-center text-lg">💡</div>
            <h3 class="font-bold text-indigo-100 text-xs uppercase tracking-wider">Kurikulum Merdeka</h3>
          </div>
          <div class="text-[11px] text-indigo-200/80 space-y-2 leading-relaxed">
            <p>1. <strong>CP & ATP/TP:</strong> Kerangka akademik utama.</p>
            <p>2. <strong>Bab / Modul:</strong> Pengelompokan materi ajar untuk murid.</p>
            <p>3. <strong>Sub-Materi & Aktivitas:</strong> Konten harian dan kegiatan siswa.</p>
            <p>4. <strong>Rencana Penilaian:</strong> Draf target asesmen bab.</p>
          </div>
        </div>

        <!-- Filter Semester -->
        <div class="rounded-2xl border border-white/8 p-5 bg-white/2">
          <div class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-3">Semester Aktif</div>
          <div class="space-y-2">
            <button
              v-for="sem in ['GANJIL', 'GENAP']" :key="sem"
              @click="activeSemester = sem"
              :class="[
                'w-full flex items-center justify-between p-3 rounded-xl border transition-all text-left text-xs font-bold tracking-wide',
                activeSemester === sem
                  ? 'bg-indigo-500/20 border-indigo-500/50 text-indigo-300'
                  : 'bg-white/5 border-white/10 text-slate-400 hover:bg-white/10'
              ]">
              <span>SEMESTER {{ sem }}</span>
              <span v-if="activeSemester === sem" class="text-indigo-400">●</span>
            </button>
          </div>
        </div>
      </div>

      <!-- RIGHT SIDEBAR / MAIN WORKSPACE -->
      <div class="col-span-1 lg:col-span-3 space-y-6">
        
        <!-- TOP VIEW TABS -->
        <div class="flex gap-2 border-b border-white/10 pb-px">
          <button 
            @click="activeViewTab = 'curriculum'"
            :class="[
              'px-4 py-2.5 text-xs font-bold uppercase tracking-wider border-b-2 transition-all -mb-px',
              activeViewTab === 'curriculum' ? 'border-indigo-500 text-indigo-300' : 'border-transparent text-slate-400 hover:text-white'
            ]"
          >
            🗺️ CP, ATP & TP
          </button>
          <button 
            @click="activeViewTab = 'babs'"
            :class="[
              'px-4 py-2.5 text-xs font-bold uppercase tracking-wider border-b-2 transition-all -mb-px',
              activeViewTab === 'babs' ? 'border-indigo-500 text-indigo-300' : 'border-transparent text-slate-400 hover:text-white'
            ]"
          >
            📂 Bab & Sub Materi
          </button>
          <button 
            @click="activeViewTab = 'planner'"
            :class="[
              'px-4 py-2.5 text-xs font-bold uppercase tracking-wider border-b-2 transition-all -mb-px',
              activeViewTab === 'planner' ? 'border-indigo-500 text-indigo-300' : 'border-transparent text-slate-400 hover:text-white'
            ]"
          >
            📋 Rencana Penilaian
          </button>
        </div>

        <!-- TAB 1: CURRICULUM VIEW (CP, ATP & TP) -->
        <div v-if="activeViewTab === 'curriculum'" class="space-y-6">
          
          <!-- Banner Kelas Belum Terpetakan -->
          <div v-if="unmappedClasses.length > 0" class="rounded-2xl border border-yellow-500/20 bg-yellow-500/5 p-4 flex flex-col sm:flex-row sm:items-center justify-between gap-3 text-xs">
            <div class="space-y-1">
              <div class="font-bold text-yellow-400 flex items-center gap-1">
                <span>⚠️</span> <span>Kelas Belum Memiliki Pemetaan:</span>
              </div>
              <div class="text-slate-400">
                Ada {{ unmappedClasses.length }} kelas yang Anda ajar untuk mapel ini tapi belum memiliki pemetaan materi:
                <div class="mt-1 flex flex-wrap gap-1.5">
                  <span v-for="cls in unmappedClasses" :key="cls.id_kelas" class="px-2 py-0.5 bg-yellow-500/10 text-yellow-400 border border-yellow-500/20 rounded font-semibold text-[10px]">
                    {{ cls.nama_kelas }}
                  </span>
                </div>
              </div>
            </div>
            <div v-if="selectedKelasFilter && unmappedClasses.some(c => c.id_kelas === Number(selectedKelasFilter)) && mappedClasses.length > 0" class="flex flex-col gap-1.5 self-start sm:self-center">
              <span class="text-slate-500 font-extrabold uppercase tracking-widest text-[8px]">Salin Pemetaan Dari:</span>
              <div class="flex flex-wrap gap-1">
                <button 
                  v-for="source in mappedClasses" :key="source.id_kelas"
                  @click="copyMapping(source.id_kelas)"
                  class="px-2.5 py-1 bg-indigo-600/20 border border-indigo-500/30 hover:bg-indigo-500/30 text-indigo-300 rounded-lg text-[10px] font-bold transition-all"
                >
                  📋 {{ source.nama_kelas }}
                </button>
              </div>
            </div>
          </div>

          <div class="flex items-center justify-between">
            <h3 class="text-sm font-bold text-slate-200">Struktur Kurikulum Merdeka</h3>
            <button @click="openCreateElementModal" class="px-4 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-all">
              + Tambah CP / Elemen
            </button>
          </div>

          <div class="space-y-4">
            <div v-for="el in filteredElements" :key="el.id_element" class="rounded-2xl border border-white/8 bg-[#1A2035] p-5 space-y-4">
              <div class="flex justify-between items-start border-b border-white/5 pb-3">
                <div>
                  <span class="text-[9px] font-bold text-indigo-400 uppercase tracking-widest">Capaian Pembelajaran (CP)</span>
                  <h4 class="font-bold text-white text-base mt-1">{{ el.nama_elemen }}</h4>
                  <p class="text-xs text-slate-300 mt-1.5 leading-relaxed">{{ el.deskripsi_cp }}</p>
                </div>
                <div class="flex gap-2">
                  <button @click="openEditElementModal(el)" class="px-2.5 py-1.5 bg-white/5 border border-white/10 text-xs font-bold text-slate-300 rounded-lg hover:bg-white/10 transition-colors">✏️ Edit</button>
                  <button @click="deleteElement(el.id_element)" class="px-2.5 py-1.5 bg-rose-500/10 border border-rose-500/20 text-xs font-bold text-rose-400 rounded-lg hover:bg-rose-500/20 transition-colors">🗑️ Hapus</button>
                </div>
              </div>

              <!-- ATP & TP List under CP Element -->
              <div class="space-y-3 pl-4 border-l border-white/10">
                <div class="flex items-center justify-between">
                  <span class="text-[10px] font-extrabold text-slate-500 uppercase tracking-widest">Alur & Tujuan Pembelajaran (ATP / TP)</span>
                  <button @click="openCreateAtpModal(el)" class="text-xs font-bold text-indigo-400 hover:text-indigo-300">+ Tambah ATP</button>
                </div>

                <div v-for="atp in el.atps" :key="atp.id_atp" class="bg-white/2 rounded-xl p-4 border border-white/5 space-y-2">
                  <div class="flex justify-between items-center">
                    <span class="text-xs font-black text-indigo-400 font-mono">{{ atp.kode_atp }}</span>
                    <div class="flex gap-1.5">
                      <button @click="openEditAtpModal(atp)" class="text-[10px] text-slate-400 hover:text-white">✏️</button>
                      <button @click="deleteAtp(atp.id_atp)" class="text-[10px] text-rose-500 hover:text-rose-400">✕</button>
                    </div>
                  </div>
                  <p class="text-xs text-slate-300 leading-relaxed font-semibold">{{ atp.deskripsi_atp }}</p>

                  <!-- TPs list -->
                  <div class="mt-3 space-y-2 pl-3 border-l-2 border-indigo-500/30">
                    <span class="block text-[8px] font-bold text-slate-500 uppercase tracking-widest">Tujuan Pembelajaran (TP):</span>
                    <div v-for="tp in atp.learning_objectives" :key="tp.id_tp" class="flex items-start justify-between bg-black/10 p-2.5 rounded-lg border border-white/5">
                      <div class="space-y-1">
                        <div class="flex items-center gap-2">
                          <span class="text-[10px] font-mono font-bold text-emerald-400">{{ tp.kode_tp }}</span>
                          <span class="px-1.5 py-0.5 rounded text-[8px] font-bold tracking-wider" :class="tp.semester === 'GANJIL' ? 'bg-amber-500/10 text-amber-400' : 'bg-blue-500/10 text-blue-400'">
                            {{ tp.semester }}
                          </span>
                        </div>
                        <p class="text-xs text-slate-200">{{ tp.deskripsi_tp }}</p>
                        <div class="flex flex-wrap gap-1 mt-1">
                          <span v-for="c in tp.classes" :key="c.id_kelas" class="px-1.5 py-0.5 rounded-[4px] text-[8px] font-bold tracking-wider bg-white/5 text-slate-400 border border-white/10 uppercase">
                            {{ c.nama_kelas }}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div v-if="!el.atps || el.atps.length === 0" class="text-center py-4 text-xs text-slate-500">
                  Belum ada ATP/TP di bawah elemen CP ini.
                </div>
              </div>
            </div>
            <div v-if="filteredElements.length === 0" class="py-12 border border-dashed border-white/10 rounded-2xl text-center p-8 bg-white/2 space-y-4">
              <div class="text-4xl">📭</div>
              <div class="space-y-1">
                <h4 class="font-bold text-slate-300 text-sm">
                  {{ selectedKelasFilter ? 'Belum Ada Pemetaan Untuk Kelas Ini' : 'Belum Ada Pemetaan Terdaftar' }}
                </h4>
                <p class="text-xs text-slate-500 max-w-md mx-auto leading-relaxed">
                  {{ selectedKelasFilter 
                    ? 'Kelas ini terdaftar di jadwal mengajar Anda tetapi belum memiliki CP, ATP, atau TP yang terpetakan.' 
                    : 'Silakan mulai menyusun Capaian Pembelajaran, Alur Tujuan Pembelajaran, dan Tujuan Pembelajaran untuk mata pelajaran ini.' }}
                </p>
              </div>

              <!-- Tombol Cepat Salin Pemetaan dari Kelas Lain -->
              <div v-if="selectedKelasFilter && mappedClasses.length > 0" class="pt-4 space-y-2.5 max-w-sm mx-auto">
                <div class="text-[9px] font-bold text-slate-400 uppercase tracking-widest">Salin Pemetaan Dari Kelas Lain:</div>
                <div class="flex flex-col gap-2">
                  <button 
                    v-for="source in mappedClasses" :key="source.id_kelas"
                    @click="copyMapping(source.id_kelas)"
                    class="w-full flex items-center justify-between px-4 py-3 bg-indigo-500/10 border border-indigo-500/20 hover:bg-indigo-500/25 text-indigo-300 rounded-xl font-bold transition-all text-xs"
                  >
                    <span class="flex items-center gap-2">📋 Salin dari <strong>{{ source.nama_kelas }}</strong></span>
                    <span>→</span>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- TAB 2: BABS VIEW (Bab & Sub Materi & Aktivitas) -->
        <div v-if="activeViewTab === 'babs'" class="space-y-6">
          <div class="flex items-center justify-between">
            <h3 class="text-sm font-bold text-slate-200">Struktur Bab / Modul Belajar</h3>
            <button @click="openCreateBabModal" class="px-4 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-all">
              + Tambah Bab Baru
            </button>
          </div>

          <div class="space-y-4">
            <div v-for="bab in filteredBabs" :key="bab.id_bab" class="rounded-2xl border border-white/8 bg-[#1A2035] p-5 space-y-4">
              <div class="flex justify-between items-start border-b border-white/5 pb-3">
                <div>
                  <span class="px-2 py-0.5 rounded-full text-[9px] font-bold bg-amber-500/10 text-amber-400 border border-amber-500/20">
                    Bab {{ bab.urutan }} (Sem {{ bab.semester === 'GANJIL' ? '1' : '2' }})
                  </span>
                  <h4 class="font-bold text-white text-base mt-2">{{ bab.nama_bab }}</h4>
                  <p class="text-xs text-slate-400 mt-1 leading-relaxed">{{ bab.deskripsi || 'Tidak ada deskripsi.' }}</p>
                  
                  <div class="mt-2.5 flex items-center gap-1.5 flex-wrap">
                    <span class="text-[8px] font-bold text-slate-500 uppercase tracking-widest">TP Terpetakan:</span>
                    <span v-for="tp in bab.learning_objectives" :key="tp.id_tp" class="px-2 py-0.5 bg-indigo-500/10 text-indigo-400 border border-indigo-500/20 text-[9px] font-mono rounded-md">
                      {{ tp.kode_tp }}
                    </span>
                  </div>
                </div>
                <div class="flex gap-2">
                  <button @click="openEditBabModal(bab)" class="px-2.5 py-1.5 bg-white/5 border border-white/10 text-xs font-bold text-slate-300 rounded-lg hover:bg-white/10 transition-colors">✏️ Edit</button>
                  <button @click="deleteBab(bab.id_bab)" class="px-2.5 py-1.5 bg-rose-500/10 border border-rose-500/20 text-xs font-bold text-rose-400 rounded-lg hover:bg-rose-500/20 transition-colors">🗑️</button>
                </div>
              </div>

              <!-- Sub Materis List -->
              <div class="space-y-3 pl-4 border-l border-white/10">
                <div class="flex items-center justify-between">
                  <span class="text-[10px] font-extrabold text-slate-500 uppercase tracking-widest">Materi & Bahan Ajar (Sub-Materi)</span>
                  <button @click="openCreateSubMateriModal(bab)" class="text-xs font-bold text-indigo-400 hover:text-indigo-300">+ Tambah Sub-Materi</button>
                </div>

                <div v-for="sub in bab.sub_materis" :key="sub.id_sub_materi" class="bg-white/2 rounded-xl p-4 border border-white/5 space-y-3">
                  <div class="flex justify-between items-center border-b border-white/3 pb-2">
                    <div class="flex items-center gap-2">
                      <span class="px-2 py-0.5 rounded text-[8px] font-bold tracking-wider bg-white/10 text-slate-300">
                        {{ sub.tipe }}
                      </span>
                      <h5 class="text-xs font-black text-slate-200">{{ sub.judul }}</h5>
                    </div>
                    <div class="flex gap-2">
                      <button @click="openEditSubMateriModal(sub)" class="text-[10px] text-slate-400 hover:text-white">✏️</button>
                      <button @click="deleteSubMateri(sub.id_sub_materi)" class="text-[10px] text-rose-500 hover:text-rose-400">✕</button>
                    </div>
                  </div>

                  <!-- Aktivitas list -->
                  <div class="space-y-2">
                    <div class="flex items-center justify-between">
                      <span class="block text-[8px] font-bold text-slate-500 uppercase tracking-widest">Aktivitas Belajar Siswa:</span>
                      <button @click="openCreateAktivitasModal(sub)" class="text-[8px] font-bold text-green-400 hover:text-green-300">+ Tambah Aktivitas</button>
                    </div>

                    <div v-for="akt in sub.aktivitas_pembelajarans" :key="akt.id_aktivitas" class="flex items-start justify-between bg-black/10 p-2.5 rounded-lg border border-white/5">
                      <div class="space-y-1">
                        <div class="flex items-center gap-2">
                          <span class="px-1.5 py-0.5 rounded text-[8px] font-bold bg-green-500/10 text-green-400 border border-green-500/20">
                            {{ akt.tipe_aktivitas }}
                          </span>
                          <span class="text-xs font-bold text-slate-300">{{ akt.nama_aktivitas }}</span>
                          <span v-if="akt.status_wajib" class="text-[8px] text-rose-400 font-extrabold border border-rose-400/20 bg-rose-400/5 px-1 py-0.2 rounded uppercase">Wajib</span>
                        </div>
                        <p class="text-[11px] text-slate-400 leading-normal">{{ akt.deskripsi || 'Tidak ada deskripsi.' }}</p>
                      </div>
                      <button @click="deleteAktivitas(akt.id_aktivitas)" class="text-[9px] text-rose-500 hover:text-rose-400">✕</button>
                    </div>

                    <div v-if="!sub.aktivitas_pembelajarans || sub.aktivitas_pembelajarans.length === 0" class="text-[10px] text-slate-500 text-center py-2">
                      Belum ada aktivitas belajar. Murid hanya akan membaca dokumen.
                    </div>
                  </div>
                </div>

                <div v-if="!bab.sub_materis || bab.sub_materis.length === 0" class="text-center py-4 text-xs text-slate-500">
                  Belum ada materi ajar di dalam bab ini.
                </div>
              </div>
            </div>

            <div v-if="filteredBabs.length === 0" class="py-12 border border-dashed border-white/10 rounded-2xl text-center text-xs text-slate-500">
              Belum ada Bab / Modul terdaftar untuk mata pelajaran ini.
            </div>
          </div>
        </div>

        <!-- TAB 3: PLANNER & ASESMEN DRAFT -->
        <div v-if="activeViewTab === 'planner'" class="space-y-6">
          <div class="flex items-center justify-between">
            <div>
              <h3 class="text-sm font-bold text-slate-200">Rencana Penilaian & Asesmen (Planner)</h3>
              <p class="text-xs text-slate-400">Tentukan jumlah target penilaian per Bab untuk me-generate draf asesmen otomatis.</p>
            </div>
          </div>

          <div class="space-y-4">
            <div v-for="bab in filteredBabs" :key="bab.id_bab" class="rounded-2xl border border-white/8 bg-[#1A2035] p-5 space-y-4">
              <div class="flex flex-wrap items-center justify-between gap-4 border-b border-white/5 pb-3">
                <div>
                  <h4 class="font-bold text-white text-sm">Bab {{ bab.urutan }}: {{ bab.nama_bab }}</h4>
                  <p class="text-xs text-slate-400">Semester {{ bab.semester }}</p>
                </div>
                
                <!-- Planner Form -->
                <div class="flex items-center gap-3">
                  <div class="flex items-center gap-1.5">
                    <label class="text-[10px] text-slate-500 font-extrabold uppercase">Formatif:</label>
                    <input 
                      type="number" min="0" max="10" 
                      v-model.number="plannerForms[bab.id_bab].jumlah_formatif" 
                      class="bg-white/5 border border-white/10 rounded-lg w-12 text-center py-1 text-xs text-white outline-none focus:border-indigo-500" 
                    />
                  </div>
                  <div class="flex items-center gap-1.5">
                    <label class="text-[10px] text-slate-500 font-extrabold uppercase">Sumatif:</label>
                    <input 
                      type="number" min="0" max="5" 
                      v-model.number="plannerForms[bab.id_bab].jumlah_sumatif" 
                      class="bg-white/5 border border-white/10 rounded-lg w-12 text-center py-1 text-xs text-white outline-none focus:border-indigo-500" 
                    />
                  </div>
                  <button @click="savePlanner(bab.id_bab)" class="px-3 py-1 bg-indigo-600 hover:bg-indigo-500 text-[10px] font-bold text-white rounded-lg transition-colors">
                    Simpan Rencana
                  </button>
                </div>
              </div>

              <!-- Assessment Drafts list -->
              <div class="space-y-3">
                <div class="flex items-center justify-between bg-white/2 p-3.5 rounded-xl border border-white/5">
                  <div class="text-xs text-slate-400">
                    Sistem dapat membuat draf Asesmen secara otomatis berdasarkan rencana penilaian di atas.
                  </div>
                  <button 
                    @click="generateDrafts(bab.id_bab)" 
                    class="px-4 py-2 border border-emerald-500/40 bg-emerald-500/10 text-emerald-400 rounded-xl text-xs font-bold hover:bg-emerald-500/20 transition-all"
                  >
                    ⚡ Generate Draft Asesmen
                  </button>
                </div>

                <!-- Existing assessments inside this Bab -->
                <div class="space-y-2">
                  <span class="block text-[8px] font-bold text-slate-500 uppercase tracking-widest">Asesmen Aktif / Draft:</span>
                  <div v-for="asm in getAssessmentsForBab(bab.id_bab)" :key="asm.id_assessment" class="flex flex-wrap items-center justify-between p-3 rounded-xl border border-white/5 bg-black/10 gap-3">
                    <div class="space-y-1">
                      <div class="flex items-center gap-2">
                        <span class="text-xs font-bold text-slate-200">{{ asm.nama_asesmen }}</span>
                        <span class="px-2 py-0.2 rounded text-[8px] font-bold tracking-wider" :class="asm.kategori === 'FORMATIF' ? 'bg-indigo-500/10 text-indigo-400' : 'bg-emerald-500/10 text-emerald-400'">
                          {{ asm.kategori }}
                        </span>
                        <span class="px-2 py-0.2 rounded text-[8px] font-bold tracking-wider uppercase border border-white/10 text-slate-400 bg-white/5">
                          {{ asm.bentuk_asesmen }}
                        </span>
                      </div>
                      <div class="text-[10px] text-slate-400">
                        Status: 
                        <span class="font-extrabold uppercase text-[9px]" :class="asm.status === 'SELESAI' ? 'text-green-400' : asm.status === 'AKTIF' ? 'text-yellow-400' : 'text-slate-500'">
                          {{ asm.status }}
                        </span>
                      </div>
                    </div>
                  </div>

                  <div v-if="getAssessmentsForBab(bab.id_bab).length === 0" class="text-center py-2 text-xs text-slate-500">
                    Belum ada draf asesmen. Silakan generate di atas.
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>

    <!-- MODAL EDIT/TAMBAH CP ELEMENT -->
    <div v-if="showElementModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="bg-[#1F2937] border border-white/10 rounded-2xl w-full max-w-lg overflow-hidden shadow-2xl animate-in fade-in zoom-in-95 duration-200">
        <div class="px-6 py-4 border-b border-white/10 flex justify-between items-center">
          <h3 class="font-bold text-white text-sm">✏️ Kelola Capaian Pembelajaran (CP)</h3>
          <button @click="showElementModal = false" class="text-slate-400 hover:text-white transition-colors">✕</button>
        </div>
        
        <form @submit.prevent="submitElementForm" class="p-6 space-y-4">
          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Nama Elemen CP</label>
            <input v-model="elForm.nama_elemen" type="text" placeholder="Masukkan nama elemen (e.g., Dasar Jaringan)..." class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none" required />
          </div>

          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Deskripsi CP (Kompetensi)</label>
            <textarea v-model="elForm.deskripsi_cp" rows="4" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2.5 text-sm text-white focus:border-indigo-500 outline-none resize-none" placeholder="Pada akhir fase ini..." required></textarea>
          </div>

          <div class="flex justify-end gap-2 border-t border-white/5 pt-4">
            <button type="button" @click="showElementModal = false" class="px-4 py-2 border border-white/10 rounded-xl text-xs font-bold text-slate-300 hover:text-white transition-colors">Batal</button>
            <button type="submit" class="px-5 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-colors">Simpan CP</button>
          </div>
        </form>
      </div>
    </div>

    <!-- MODAL EDIT/TAMBAH ATP & TP -->
    <div v-if="showAtpModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="bg-[#1F2937] border border-white/10 rounded-2xl w-full max-w-lg overflow-hidden shadow-2xl animate-in fade-in zoom-in-95 duration-200">
        <div class="px-6 py-4 border-b border-white/10 flex justify-between items-center">
          <h3 class="font-bold text-white text-sm">➕ Kelola ATP & TP</h3>
          <button @click="showAtpModal = false" class="text-slate-400 hover:text-white transition-colors">✕</button>
        </div>
        
        <form @submit.prevent="submitAtpForm" class="p-6 space-y-4">
          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Kode ATP</label>
            <input v-model="atpForm.kode_atp" type="text" placeholder="E.g., ATP 1.1" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none" required />
          </div>

          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Deskripsi ATP</label>
            <textarea v-model="atpForm.deskripsi_atp" rows="2" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none resize-none" placeholder="Menentukan urutan..." required></textarea>
          </div>

          <!-- TP Sub-Form inside ATP -->
          <div class="border-t border-white/5 pt-4 space-y-3">
            <div class="flex justify-between items-center">
              <span class="text-[10px] font-extrabold text-indigo-400 uppercase tracking-widest">Tujuan Pembelajaran (TP)</span>
              <button type="button" @click="addNewTpInModal" class="text-xs font-bold text-green-400">+ Tambah TP</button>
            </div>

            <div v-for="(tp, tpIdx) in atpForm.tps" :key="tpIdx" class="bg-white/3 border border-white/5 p-3 rounded-xl relative space-y-3">
              <button type="button" @click="removeTpInModal(tpIdx)" class="absolute top-2.5 right-3 text-slate-500 hover:text-red-400">✕</button>
              
              <div class="grid grid-cols-6 gap-3">
                <div class="col-span-2">
                  <label class="block text-[8px] font-bold text-slate-500 uppercase mb-1">Kode TP</label>
                  <input v-model="tp.kode_tp" type="text" placeholder="E.g., TP 1.1.1" class="w-full bg-white/5 border border-white/10 rounded-lg px-2 py-1 text-xs text-white outline-none" required />
                </div>
                <div class="col-span-4">
                  <label class="block text-[8px] font-bold text-slate-500 uppercase mb-1">Semester</label>
                  <select v-model="tp.semester" class="w-full bg-white/5 border border-white/10 rounded-lg px-2 py-1.5 text-xs text-white outline-none">
                    <option value="GANJIL">GANJIL</option>
                    <option value="GENAP">GENAP</option>
                  </select>
                </div>
              </div>

              <div>
                <label class="block text-[8px] font-bold text-slate-500 uppercase mb-1">Deskripsi TP</label>
                <textarea v-model="tp.deskripsi_tp" rows="2" placeholder="Kompetensi terukur..." class="w-full bg-white/5 border border-white/10 rounded-lg px-2 py-1 text-xs text-white outline-none resize-none" required></textarea>
              </div>

              <div>
                <label class="block text-[8px] font-bold text-slate-500 uppercase mb-1.5">Terapkan ke Kelas</label>
                <div class="flex flex-wrap gap-1.5">
                  <label v-for="c in classesForSelectedMapel" :key="c.id_kelas" class="flex items-center gap-1 px-2 py-0.5 rounded border border-white/5 bg-white/3 text-[9px] text-slate-400 cursor-pointer select-none">
                    <input type="checkbox" :value="c.id_kelas" v-model="tp.target_kelas" class="w-3 h-3 rounded" />
                    <span>{{ c.nama_kelas }}</span>
                  </label>
                </div>
              </div>
            </div>
          </div>

          <div class="flex justify-end gap-2 border-t border-white/5 pt-4">
            <button type="button" @click="showAtpModal = false" class="px-4 py-2 border border-white/10 rounded-xl text-xs font-bold text-slate-300 hover:text-white transition-colors">Batal</button>
            <button type="submit" class="px-5 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-colors">Simpan ATP/TP</button>
          </div>
        </form>
      </div>
    </div>

    <!-- MODAL EDIT/TAMBAH BAB -->
    <div v-if="showBabModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="bg-[#1F2937] border border-white/10 rounded-2xl w-full max-w-lg overflow-hidden shadow-2xl animate-in fade-in zoom-in-95 duration-200">
        <div class="px-6 py-4 border-b border-white/10 flex justify-between items-center">
          <h3 class="font-bold text-white text-sm">➕ Kelola Bab / Modul Pembelajaran</h3>
          <button @click="showBabModal = false" class="text-slate-400 hover:text-white transition-colors">✕</button>
        </div>
        
        <form @submit.prevent="submitBabForm" class="p-6 space-y-4">
          <div class="grid grid-cols-3 gap-4">
            <div class="col-span-1">
              <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">No. Urut Bab</label>
              <input v-model.number="babForm.urutan" type="number" min="1" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none" required />
            </div>
            <div class="col-span-2">
              <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Semester</label>
              <select v-model="babForm.semester" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none">
                <option value="GANJIL">Semester Ganjil (1)</option>
                <option value="GENAP">Semester Genap (2)</option>
              </select>
            </div>
          </div>

          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Nama Bab / Modul</label>
            <input v-model="babForm.nama_bab" type="text" placeholder="E.g., Konsep Jaringan Komputer" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none" required />
          </div>

          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Deskripsi Bab</label>
            <textarea v-model="babForm.deskripsi" rows="2" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none resize-none" placeholder="Materi ini membahas..."></textarea>
          </div>

          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Hubungkan ke TP yang Diukur</label>
            <div class="flex flex-wrap gap-2 max-h-28 overflow-y-auto pr-1">
              <label v-for="tp in tps" :key="tp.id_tp" class="flex items-center gap-1.5 px-2.5 py-1 rounded-lg border border-white/5 bg-white/3 text-xs text-slate-300 cursor-pointer select-none">
                <input type="checkbox" :value="tp.id_tp" v-model="babForm.tp_ids" class="rounded border-white/10 text-indigo-600" />
                <span>{{ tp.kode_tp }}</span>
              </label>
            </div>
          </div>

          <div class="flex justify-end gap-2 border-t border-white/5 pt-4">
            <button type="button" @click="showBabModal = false" class="px-4 py-2 border border-white/10 rounded-xl text-xs font-bold text-slate-300 hover:text-white transition-colors">Batal</button>
            <button type="submit" class="px-5 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-colors">Simpan Bab</button>
          </div>
        </form>
      </div>
    </div>

    <!-- MODAL EDIT/TAMBAH SUB MATERI -->
    <div v-if="showSubMateriModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="bg-[#1F2937] border border-white/10 rounded-2xl w-full max-w-lg overflow-hidden shadow-2xl animate-in fade-in zoom-in-95 duration-200">
        <div class="px-6 py-4 border-b border-white/10 flex justify-between items-center">
          <h3 class="font-bold text-white text-sm">➕ Kelola Sub-Materi & Dokumen</h3>
          <button @click="showSubMateriModal = false" class="text-slate-400 hover:text-white transition-colors">✕</button>
        </div>
        
        <form @submit.prevent="submitSubMateriForm" class="p-6 space-y-4" enctype="multipart/form-data">
          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Judul Materi / Handout</label>
            <input v-model="subForm.judul" type="text" placeholder="E.g., Kabel UTP & Konektor RJ45" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none" required />
          </div>

          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Tipe Konten</label>
              <select v-model="subForm.tipe" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none">
                <option value="ARTIKEL">Artikel Ringkas</option>
                <option value="HTML">Modul HTML/Embed</option>
                <option value="PDF">Dokumen PDF</option>
                <option value="VIDEO">Dokumen Video (MP4)</option>
                <option value="PPT">Bahan Presentasi PPT</option>
                <option value="LINK">Tautan Web Luar</option>
                <option value="YOUTUBE">Tautan Youtube Video</option>
              </select>
            </div>
            <div>
              <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">No. Urut Tampil</label>
              <input v-model.number="subForm.urutan" type="number" min="1" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none" />
            </div>
          </div>

          <div v-if="['ARTIKEL', 'HTML', 'LINK', 'YOUTUBE'].includes(subForm.tipe)">
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Isi Konten / URL Link</label>
            <textarea v-model="subForm.konten" rows="3" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2.5 text-sm text-white focus:border-indigo-500 outline-none resize-none" placeholder="Masukkan tulisan artikel atau URL/Tautan video..."></textarea>
          </div>

          <div v-if="['PDF', 'VIDEO', 'PPT'].includes(subForm.tipe)">
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Unggah Berkas File (Maks. 20MB)</label>
            <input type="file" @change="handleFileUpload" class="w-full text-xs text-slate-400 border border-white/5 bg-white/3 p-3 rounded-xl file:mr-4 file:py-1.5 file:px-3 file:rounded-lg file:border-0 file:text-[10px] file:font-bold file:bg-indigo-600 file:text-white file:cursor-pointer" />
          </div>

          <div class="flex justify-end gap-2 border-t border-white/5 pt-4">
            <button type="button" @click="showSubMateriModal = false" class="px-4 py-2 border border-white/10 rounded-xl text-xs font-bold text-slate-300 hover:text-white transition-colors">Batal</button>
            <button type="submit" class="px-5 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-colors">Simpan Materi</button>
          </div>
        </form>
      </div>
    </div>

    <!-- MODAL EDIT/TAMBAH AKTIVITAS -->
    <div v-if="showAktivitasModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <div class="bg-[#1F2937] border border-white/10 rounded-2xl w-full max-w-lg overflow-hidden shadow-2xl animate-in fade-in zoom-in-95 duration-200">
        <div class="px-6 py-4 border-b border-white/10 flex justify-between items-center">
          <h3 class="font-bold text-white text-sm">➕ Kelola Aktivitas Siswa</h3>
          <button @click="showAktivitasModal = false" class="text-slate-400 hover:text-white transition-colors">✕</button>
        </div>
        
        <form @submit.prevent="submitAktivitasForm" class="p-6 space-y-4">
          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Nama Aktivitas / Kegiatan</label>
            <input v-model="aktForm.nama_aktivitas" type="text" placeholder="E.g., Tulis Ringkasan Topologi" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none" required />
          </div>

          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Jenis Aktivitas</label>
              <select v-model="aktForm.tipe_aktivitas" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none">
                <option value="MEMBACA">Membaca Handout</option>
                <option value="MENONTON">Menonton Penjelasan</option>
                <option value="DISKUSI">Diskusi Kelompok</option>
                <option value="UPLOAD_TUGAS">Mengunggah Tugas</option>
                <option value="PRAKTIK">Melakukan Praktik Kerja</option>
                <option value="QUIZ">Mengerjakan Quiz Latihan</option>
              </select>
            </div>
            <div>
              <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Sifat Aktivitas</label>
              <select v-model="aktForm.status_wajib" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none">
                <option :value="true">Wajib Dikerjakan</option>
                <option :value="false">Opsional (Pengayaan)</option>
              </select>
            </div>
          </div>

          <div>
            <label class="block text-[10px] font-bold text-slate-400 uppercase mb-1.5">Petunjuk Pengerjaan</label>
            <textarea v-model="aktForm.deskripsi" rows="3" class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2 text-sm text-white focus:border-indigo-500 outline-none resize-none" placeholder="Tulis instruksi pengerjaan aktivitas untuk siswa..."></textarea>
          </div>

          <div class="flex justify-end gap-2 border-t border-white/5 pt-4">
            <button type="button" @click="showAktivitasModal = false" class="px-4 py-2 border border-white/10 rounded-xl text-xs font-bold text-slate-300 hover:text-white transition-colors">Batal</button>
            <button type="submit" class="px-5 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-xl text-xs font-bold text-white transition-colors">Simpan Aktivitas</button>
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
  kelasMapelList: Array,
  elementsList: Array,
  babsList: Array,
  assessmentsList: Array,
  gradingConfigs: Array,
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
      { href: '/guru/nilai-akhir', icon: '📋', label: 'Nilai Akhir' },
      { href: '/guru/rapor-preview', icon: '📑', label: 'Rapor Preview' },
    ],
  },
];

const selectedMapel = ref('');
const selectedKelasFilter = ref('');
const activeSemester = ref('GANJIL');
const activeViewTab = ref('curriculum');

// Unique maps for filters
const uniqueMapels = computed(() => {
  const map = {};
  (props.kelasMapelList || []).forEach(item => {
    map[item.id_mapel] = { id_mapel: item.id_mapel, nama_mapel: item.nama_mapel };
  });
  return Object.values(map);
});

const classesForSelectedMapel = computed(() => {
  if (!selectedMapel.value) return [];
  return (props.kelasMapelList || []).filter(item => item.id_mapel === selectedMapel.value);
});

// Setup default selection on mount
onMounted(() => {
  if (uniqueMapels.value.length > 0) {
    selectedMapel.value = uniqueMapels.value[0].id_mapel;
  }
});

watch(selectedMapel, () => {
  selectedKelasFilter.value = '';
});

// Compute data lists based on filters
const filteredElements = computed(() => {
  if (!props.elementsList || !selectedMapel.value) return [];
  
  const elements = props.elementsList.filter(el => el.id_mapel === selectedMapel.value);
  
  if (selectedKelasFilter.value) {
    const classId = Number(selectedKelasFilter.value);
    
    return elements.map(el => {
      const filteredAtps = (el.atps || []).map(atp => {
        const filteredTps = (atp.learning_objectives || []).filter(tp => {
          return (tp.classes || []).some(cls => cls.id_kelas === classId);
        });
        return {
          ...atp,
          learning_objectives: filteredTps
        };
      }).filter(atp => atp.learning_objectives.length > 0);
      
      return {
        ...el,
        atps: filteredAtps
      };
    }).filter(el => el.atps.length > 0);
  }
  
  return elements;
});

const filteredBabs = computed(() => {
  if (!props.babsList || !selectedMapel.value) return [];
  
  const babs = props.babsList.filter(bab => {
    const matchSemester = bab.semester === activeSemester.value;
    const matchMapel = bab.id_mapel === selectedMapel.value;
    return matchSemester && matchMapel;
  });
  
  if (selectedKelasFilter.value) {
    const classId = Number(selectedKelasFilter.value);
    
    return babs.map(bab => {
      const filteredTps = (bab.learning_objectives || []).filter(tp => {
        return (tp.classes || []).some(cls => cls.id_kelas === classId);
      });
      return {
        ...bab,
        learning_objectives: filteredTps
      };
    }).filter(bab => bab.learning_objectives.length > 0);
  }
  return babs;
});

// Classes with and without mapping
const mappedClassIds = computed(() => {
  const ids = new Set();
  (props.elementsList || []).forEach(el => {
    if (el.id_mapel === selectedMapel.value) {
      (el.atps || []).forEach(atp => {
        (atp.learning_objectives || []).forEach(tp => {
          (tp.classes || []).forEach(cls => {
            ids.add(cls.id_kelas);
          });
        });
      });
    }
  });
  return ids;
});

const selectedClassObj = computed(() => {
  if (!selectedKelasFilter.value) return null;
  const classId = Number(selectedKelasFilter.value);
  return classesForSelectedMapel.value.find(c => c.id_kelas === classId) || null;
});

const mappedClasses = computed(() => {
  const list = classesForSelectedMapel.value.filter(cls => mappedClassIds.value.has(cls.id_kelas));
  if (selectedClassObj.value) {
    return list.filter(cls => cls.tingkat === selectedClassObj.value.tingkat);
  }
  return list;
});

const unmappedClasses = computed(() => {
  return classesForSelectedMapel.value.filter(cls => !mappedClassIds.value.has(cls.id_kelas));
});

const copyMapping = (sourceKelasId) => {
  if (!confirm('Apakah Anda yakin ingin menyalin seluruh pemetaan materi (CP, ATP, TP) dari kelas tersebut ke kelas ini?')) return;
  
  const form = useForm({
    id_mapel: selectedMapel.value,
    source_kelas_id: sourceKelasId,
    target_kelas_id: selectedKelasFilter.value
  });
  
  form.post('/guru/pemetaan-materi/copy', {
    preserveScroll: true,
    onSuccess: () => {
      window.dispatchEvent(new CustomEvent('toast', { 
        detail: { message: 'Pemetaan materi berhasil disalin!', type: 'success' } 
      }));
    }
  });
};

// Planner Forms
const plannerForms = ref({});
const initPlannerForms = () => {
  (props.babsList || []).forEach(bab => {
    const plan = bab.rencana_penilaians && bab.rencana_penilaians.length > 0 ? bab.rencana_penilaians[0] : null;
    plannerForms.value[bab.id_bab] = {
      jumlah_formatif: plan ? plan.jumlah_formatif : 0,
      jumlah_sumatif: plan ? plan.jumlah_sumatif : 0
    };
  });
};

watch(() => props.babsList, () => {
  initPlannerForms();
}, { deep: true, immediate: true });

const savePlanner = (idBab) => {
  const form = useForm({
    id_bab: idBab,
    jumlah_formatif: plannerForms.value[idBab].jumlah_formatif,
    jumlah_sumatif: plannerForms.value[idBab].jumlah_sumatif
  });
  form.post('/guru/rencana-penilaian', { preserveScroll: true });
};

const generateDrafts = (idBab) => {
  if (!selectedKelasFilter.value) {
    window.dispatchEvent(new CustomEvent('toast', { detail: { message: 'Silakan pilih Kelas filter terlebih dahulu di bar atas!', type: 'error' } }));
    return;
  }
  const form = useForm({
    id_bab: idBab,
    id_kelas: selectedKelasFilter.value,
    id_mapel: selectedMapel.value
  });
  form.post('/guru/rencana-penilaian/generate-draft', { preserveScroll: true });
};

const getAssessmentsForBab = (idBab) => {
  return (props.assessmentsList || []).filter(a => {
    const matchBab = a.id_bab === idBab;
    const matchKelas = !selectedKelasFilter.value || a.id_kelas === selectedKelasFilter.value;
    return matchBab && matchKelas;
  });
};

// Modal - CP Element
const showElementModal = ref(false);
const elForm = useForm({
  id_element: null,
  id_mapel: '',
  nama_elemen: '',
  deskripsi_cp: ''
});

const openCreateElementModal = () => {
  elForm.reset();
  elForm.id_mapel = selectedMapel.value;
  showElementModal.value = true;
};

const openEditElementModal = (el) => {
  elForm.id_element = el.id_element;
  elForm.id_mapel = el.id_mapel;
  elForm.nama_elemen = el.nama_elemen;
  elForm.deskripsi_cp = el.deskripsi_cp;
  showElementModal.value = true;
};

const submitElementForm = () => {
  elForm.post('/guru/pemetaan-materi', {
    preserveScroll: true,
    onSuccess: () => { showElementModal.value = false; }
  });
};

const deleteElement = (id) => {
  if (confirm('Apakah Anda yakin ingin menghapus Elemen beserta seluruh ATP/TP di dalamnya?')) {
    router.delete(`/guru/pemetaan-materi/element/${id}`, { preserveScroll: true });
  }
};

// Modal - ATP & TP
const showAtpModal = ref(false);
const atpForm = useForm({
  id_atp: null,
  id_element: '',
  kode_atp: '',
  deskripsi_atp: '',
  urutan: 1,
  tps: []
});

const openCreateAtpModal = (el) => {
  atpForm.reset();
  atpForm.id_element = el.id_element;
  atpForm.tps = [];
  showAtpModal.value = true;
};

const openEditAtpModal = (atp) => {
  atpForm.id_atp = atp.id_atp;
  atpForm.id_element = atp.id_element;
  atpForm.kode_atp = atp.kode_atp;
  atpForm.deskripsi_atp = atp.deskripsi_atp;
  atpForm.urutan = atp.urutan;
  atpForm.tps = (atp.learning_objectives || []).map(tp => ({
    id_tp: tp.id_tp,
    kode_tp: tp.kode_tp,
    deskripsi_tp: tp.deskripsi_tp,
    semester: tp.semester,
    target_kelas: tp.classes ? tp.classes.map(c => c.id_kelas) : []
  }));
  showAtpModal.value = true;
};

const addNewTpInModal = () => {
  const nextNum = atpForm.tps.length + 1;
  const allClassIds = classesForSelectedMapel.value.map(c => c.id_kelas);
  atpForm.tps.push({
    id_tp: null,
    kode_tp: 'TP-' + nextNum,
    deskripsi_tp: '',
    semester: activeSemester.value,
    target_kelas: allClassIds
  });
};

const removeTpInModal = (idx) => {
  atpForm.tps.splice(idx, 1);
};

const submitAtpForm = () => {
  atpForm.post('/guru/pemetaan-materi/atp', {
    preserveScroll: true,
    onSuccess: () => { showAtpModal.value = false; }
  });
};

const deleteAtp = (id) => {
  if (confirm('Hapus Alur Tujuan Pembelajaran ini?')) {
    router.delete(`/guru/pemetaan-materi/atp/${id}`, { preserveScroll: true });
  }
};

// Modal - Bab
const showBabModal = ref(false);
const babForm = useForm({
  id_bab: null,
  id_mapel: '',
  nama_bab: '',
  deskripsi: '',
  urutan: 1,
  semester: 'GANJIL',
  tp_ids: []
});

const openCreateBabModal = () => {
  babForm.reset();
  babForm.id_mapel = selectedMapel.value;
  babForm.semester = activeSemester.value;
  babForm.tp_ids = [];
  showBabModal.value = true;
};

const openEditBabModal = (bab) => {
  babForm.id_bab = bab.id_bab;
  babForm.id_mapel = bab.id_mapel;
  babForm.nama_bab = bab.nama_bab;
  babForm.deskripsi = bab.deskripsi;
  babForm.urutan = bab.urutan;
  babForm.semester = bab.semester;
  babForm.tp_ids = bab.learning_objectives ? bab.learning_objectives.map(tp => tp.id_tp) : [];
  showBabModal.value = true;
};

const submitBabForm = () => {
  babForm.post('/guru/pemetaan-materi/bab', {
    preserveScroll: true,
    onSuccess: () => { showBabModal.value = false; }
  });
};

const deleteBab = (id) => {
  if (confirm('Hapus Bab beserta materi & penugasan didalamnya?')) {
    router.delete(`/guru/pemetaan-materi/bab/${id}`, { preserveScroll: true });
  }
};

// Modal - Sub Materi
const showSubMateriModal = ref(false);
const subForm = useForm({
  id_sub_materi: null,
  id_bab: '',
  judul: '',
  tipe: 'ARTIKEL',
  konten: '',
  file: null,
  urutan: 1
});

const openCreateSubMateriModal = (bab) => {
  subForm.reset();
  subForm.id_bab = bab.id_bab;
  showSubMateriModal.value = true;
};

const openEditSubMateriModal = (sub) => {
  subForm.id_sub_materi = sub.id_sub_materi;
  subForm.id_bab = sub.id_bab;
  subForm.judul = sub.judul;
  subForm.tipe = sub.tipe;
  subForm.konten = sub.konten;
  subForm.urutan = sub.urutan;
  subForm.file = null;
  showSubMateriModal.value = true;
};

const handleFileUpload = (e) => {
  subForm.file = e.target.files[0];
};

const submitSubMateriForm = () => {
  subForm.post('/guru/pemetaan-materi/sub-materi', {
    preserveScroll: true,
    onSuccess: () => { showSubMateriModal.value = false; }
  });
};

const deleteSubMateri = (id) => {
  if (confirm('Hapus Sub-materi ini?')) {
    router.delete(`/guru/pemetaan-materi/sub-materi/${id}`, { preserveScroll: true });
  }
};

// Modal - Aktivitas
const showAktivitasModal = ref(false);
const aktForm = useForm({
  id_aktivitas: null,
  id_sub_materi: '',
  nama_aktivitas: '',
  tipe_aktivitas: 'MEMBACA',
  deskripsi: '',
  status_wajib: true
});

const openCreateAktivitasModal = (sub) => {
  aktForm.reset();
  aktForm.id_sub_materi = sub.id_sub_materi;
  showAktivitasModal.value = true;
};

const submitAktivitasForm = () => {
  aktForm.post('/guru/pemetaan-materi/aktivitas', {
    preserveScroll: true,
    onSuccess: () => { showAktivitasModal.value = false; }
  });
};

const deleteAktivitas = (id) => {
  if (confirm('Hapus Aktivitas Belajar ini?')) {
    router.delete(`/guru/pemetaan-materi/aktivitas/${id}`, { preserveScroll: true });
  }
};

// All TPs in selected subject (used to map TP to Bab or Asesmen)
const tps = computed(() => {
  const list = [];
  filteredElements.value.forEach(el => {
    (el.atps || []).forEach(atp => {
      (atp.learning_objectives || []).forEach(tp => {
        list.push(tp);
      });
    });
  });
  return list;
});
</script>
