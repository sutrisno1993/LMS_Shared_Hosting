# Panduan Deployment Production - LMS 11 Maret

Panduan ini berisi instruksi lengkap dari awal hingga akhir untuk mengunggah (deploy) dan menjalankan LMS 11 Maret di server *production* yang asli (seperti VPS Ubuntu/Debian).

> [!IMPORTANT]
> Pastikan server sudah terinstal Docker, Docker Compose, Git, dan Make. Panduan ini menggunakan Docker environment bawaan proyek.

## 1. Persiapan Server & Kode Sumber

Pertama, masuk ke server Anda (via SSH) dan clone repositori ini:

```bash
git clone https://github.com/sutrisno1993/LMS11MARET.git
cd LMS11MARET
```

## 2. Pengaturan `.env` (Sangat Penting)

Gunakan file `.env.example` atau `.env.docker` sebagai kerangka awal:

```bash
cp .env.docker .env
```

Buka file `.env` (misal dengan `nano .env`) dan pastikan konfigurasi berikut **wajib disesuaikan**:

```ini
APP_ENV=production
APP_DEBUG=false
APP_URL=https://lms.smk11maret.sch.id  # (Ganti dengan domain asli Anda)

# Konfigurasi Database (Biarkan lms_db & lms_user jika memakai Docker bawaan)
DB_DATABASE=lms_db
DB_USERNAME=lms_user
DB_PASSWORD=lms_password
```

> [!WARNING]
> Jangan biarkan `APP_DEBUG=true` di server asli karena dapat membocorkan informasi rahasia sistem ke publik saat terjadi error.

## 3. Menjalankan Server & Kompilasi Aset

Setelah konfigurasi siap, jalankan aplikasi melalui sistem Docker bawaan (Makefile):

```bash
# Menyalakan seluruh container (Nginx, MySQL, Laravel) di background
make up
```

Lalu kita perlu mengkompilasi file frontend (Vite/Inertia) khusus untuk mode production agar berjalan super cepat:

```bash
# Membuat build production Vue JS
docker compose exec app npm run build
```

## 4. Konfigurasi Database (Trik Seeder Bersih)

Berkat modifikasi kode sebelumnya, kini perintah `seeder` dirancang cerdas untuk memisahkan data *Dummy (Testing)* dari *Production*.

Untuk membuat database baru yang strukturnya siap dipakai namun tabelnya masih kosong/bersih dari data uji coba, jalankan:

```bash
# Hapus semua tabel, buat ulang tabel kosong, lalu masukkan data inti saja (Akun Super Admin)
docker compose exec app php artisan migrate:fresh --seed
```

> [!TIP]
> **Hasil dari perintah di atas:**
> 1. Tabel murid, guru, dan nilai dipastikan **0 data** (Kosong). 
> 2. Akun **Super Admin** (`admin@smk11maret.sch.id` / `admin2@smk11maret.sch.id`) akan otomatis dibuat. Anda bisa login menggunakan akun tersebut untuk langkah selanjutnya!

## 5. Optimasi Kecepatan Laravel (Caching)

Langkah terakhir agar aplikasi tidak berat saat diakses ribuan pengguna secara bersamaan:

```bash
docker compose exec app php artisan optimize
docker compose exec app php artisan view:cache
docker compose exec app php artisan event:cache
```

---

### Perintah Penting (Cheat Sheet)

* **Melihat log error aplikasi**: `docker compose logs -f app`
* **Masuk ke database (phpMyAdmin)**: Buka `http://[IP-SERVER]:8080` (Akses langsung ke port 8080 dari luar hanya jika tidak di-firewall).
* **Me-restart aplikasi**: `make restart`
* **Menghentikan aplikasi**: `make down`
