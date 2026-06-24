-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 23 Jun 2026 pada 15.40
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lms_11maret`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `academic_calendars`
--

CREATE TABLE `academic_calendars` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `type` enum('LIBUR','UJIAN','KEGIATAN','LAINNYA') NOT NULL DEFAULT 'LAINNYA',
  `color` varchar(20) NOT NULL DEFAULT '#4F46E5',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-jp_schedules_today_1', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:16:{i:0;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:1;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:1;s:11:\"waktu_mulai\";s:8:\"06:30:00\";s:13:\"waktu_selesai\";s:8:\"07:30:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:11:\"KBM/Upacara\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:1;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:1;s:11:\"waktu_mulai\";s:8:\"06:30:00\";s:13:\"waktu_selesai\";s:8:\"07:30:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:11:\"KBM/Upacara\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:2;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:2;s:11:\"waktu_mulai\";s:8:\"07:30:00\";s:13:\"waktu_selesai\";s:8:\"08:10:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:2;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:2;s:11:\"waktu_mulai\";s:8:\"07:30:00\";s:13:\"waktu_selesai\";s:8:\"08:10:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:3;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";s:8:\"08:10:00\";s:13:\"waktu_selesai\";s:8:\"08:50:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:3;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";s:8:\"08:10:00\";s:13:\"waktu_selesai\";s:8:\"08:50:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:4;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:4;s:11:\"waktu_mulai\";s:8:\"08:50:00\";s:13:\"waktu_selesai\";s:8:\"09:30:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:4;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:4;s:11:\"waktu_mulai\";s:8:\"08:50:00\";s:13:\"waktu_selesai\";s:8:\"09:30:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:5;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:0;s:11:\"waktu_mulai\";s:8:\"09:30:00\";s:13:\"waktu_selesai\";s:8:\"10:00:00\";s:6:\"is_kbm\";i:0;s:10:\"keterangan\";s:9:\"Istirahat\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:5;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:0;s:11:\"waktu_mulai\";s:8:\"09:30:00\";s:13:\"waktu_selesai\";s:8:\"10:00:00\";s:6:\"is_kbm\";i:0;s:10:\"keterangan\";s:9:\"Istirahat\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:6;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:5;s:11:\"waktu_mulai\";s:8:\"10:00:00\";s:13:\"waktu_selesai\";s:8:\"10:35:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:6;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:5;s:11:\"waktu_mulai\";s:8:\"10:00:00\";s:13:\"waktu_selesai\";s:8:\"10:35:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:6;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:7;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:6;s:11:\"waktu_mulai\";s:8:\"10:35:00\";s:13:\"waktu_selesai\";s:8:\"11:10:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:7;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:6;s:11:\"waktu_mulai\";s:8:\"10:35:00\";s:13:\"waktu_selesai\";s:8:\"11:10:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:7;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:8;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:7;s:11:\"waktu_mulai\";s:8:\"11:10:00\";s:13:\"waktu_selesai\";s:8:\"11:45:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:8;s:5:\"shift\";s:4:\"PAGI\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:7;s:11:\"waktu_mulai\";s:8:\"11:10:00\";s:13:\"waktu_selesai\";s:8:\"11:45:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:8;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:48;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:1;s:11:\"waktu_mulai\";s:8:\"12:45:00\";s:13:\"waktu_selesai\";s:8:\"13:30:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:48;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:1;s:11:\"waktu_mulai\";s:8:\"12:45:00\";s:13:\"waktu_selesai\";s:8:\"13:30:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:9;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:49;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:2;s:11:\"waktu_mulai\";s:8:\"13:30:00\";s:13:\"waktu_selesai\";s:8:\"14:15:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:49;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:2;s:11:\"waktu_mulai\";s:8:\"13:30:00\";s:13:\"waktu_selesai\";s:8:\"14:15:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:10;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:50;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";s:8:\"14:15:00\";s:13:\"waktu_selesai\";s:8:\"15:00:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:50;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";s:8:\"14:15:00\";s:13:\"waktu_selesai\";s:8:\"15:00:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:11;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:51;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:4;s:11:\"waktu_mulai\";s:8:\"15:00:00\";s:13:\"waktu_selesai\";s:8:\"15:45:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:51;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:4;s:11:\"waktu_mulai\";s:8:\"15:00:00\";s:13:\"waktu_selesai\";s:8:\"15:45:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:12;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:52;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:0;s:11:\"waktu_mulai\";s:8:\"15:45:00\";s:13:\"waktu_selesai\";s:8:\"16:15:00\";s:6:\"is_kbm\";i:0;s:10:\"keterangan\";s:9:\"Istirahat\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:52;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:0;s:11:\"waktu_mulai\";s:8:\"15:45:00\";s:13:\"waktu_selesai\";s:8:\"16:15:00\";s:6:\"is_kbm\";i:0;s:10:\"keterangan\";s:9:\"Istirahat\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:13;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:53;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:5;s:11:\"waktu_mulai\";s:8:\"16:15:00\";s:13:\"waktu_selesai\";s:8:\"17:00:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:53;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:5;s:11:\"waktu_mulai\";s:8:\"16:15:00\";s:13:\"waktu_selesai\";s:8:\"17:00:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:14;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:54;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:6;s:11:\"waktu_mulai\";s:8:\"17:00:00\";s:13:\"waktu_selesai\";s:8:\"17:45:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:54;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:6;s:11:\"waktu_mulai\";s:8:\"17:00:00\";s:13:\"waktu_selesai\";s:8:\"17:45:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:15;O:21:\"App\\Models\\JpSchedule\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:12:\"jp_schedules\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:10:{s:2:\"id\";i:55;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:7;s:11:\"waktu_mulai\";s:8:\"17:45:00\";s:13:\"waktu_selesai\";s:8:\"18:30:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:11:\"\0*\0original\";a:10:{s:2:\"id\";i:55;s:5:\"shift\";s:5:\"SIANG\";s:4:\"hari\";s:5:\"SENIN\";s:6:\"jam_ke\";i:7;s:11:\"waktu_mulai\";s:8:\"17:45:00\";s:13:\"waktu_selesai\";s:8:\"18:30:00\";s:6:\"is_kbm\";i:1;s:10:\"keterangan\";s:9:\"KBM Aktif\";s:10:\"created_at\";s:19:\"2026-06-22 07:06:59\";s:10:\"updated_at\";s:19:\"2026-06-22 07:06:59\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"is_kbm\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:7:{i:0;s:5:\"shift\";i:1;s:4:\"hari\";i:2;s:6:\"jam_ke\";i:3;s:11:\"waktu_mulai\";i:4;s:13:\"waktu_selesai\";i:5;s:6:\"is_kbm\";i:6;s:10:\"keterangan\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 1782150102),
('laravel-cache-kbm_generated_2026-06-22', 'b:1;', 1782172800);

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `classes`
--

CREATE TABLE `classes` (
  `id_kelas` bigint(20) UNSIGNED NOT NULL,
  `nama_kelas` varchar(255) NOT NULL,
  `shift_operasional` enum('PAGI','SIANG') NOT NULL,
  `tingkat` varchar(255) DEFAULT NULL,
  `jurusan` varchar(255) DEFAULT NULL,
  `id_guru_wali` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `classes`
--

INSERT INTO `classes` (`id_kelas`, `nama_kelas`, `shift_operasional`, `tingkat`, `jurusan`, `id_guru_wali`, `created_at`, `updated_at`) VALUES
(1, 'X AK 1', 'PAGI', 'X', 'AK', 2, '2026-06-22 07:58:12', '2026-06-22 09:18:02'),
(2, 'X OTKP 1', 'PAGI', 'X', 'OTKP', 1, '2026-06-22 07:58:12', '2026-06-22 09:20:30'),
(3, 'X OTKP 2', 'SIANG', 'X', 'OTKP', 3, '2026-06-22 07:58:12', '2026-06-22 09:20:33'),
(4, 'X TKJ 1', 'PAGI', 'X', 'TKJ', 5, '2026-06-22 07:58:12', '2026-06-22 09:20:39'),
(5, 'X TKJ 2', 'SIANG', 'X', 'TKJ', 4, '2026-06-22 07:58:12', '2026-06-22 09:17:56'),
(6, 'X TKR 1', 'PAGI', 'X', 'TKR', 6, '2026-06-22 07:58:12', '2026-06-22 09:20:42'),
(7, 'X TKR 2', 'SIANG', 'X', 'TKR', 7, '2026-06-22 07:58:12', '2026-06-22 09:20:45'),
(8, 'X TSM 1', 'PAGI', 'X', 'TSM', 8, '2026-06-22 07:58:12', '2026-06-22 09:20:47'),
(9, 'X TSM 2', 'SIANG', 'X', 'TSM', 9, '2026-06-22 07:58:12', '2026-06-22 09:20:51'),
(10, 'XI AK 1', 'SIANG', 'XI', 'AK', 10, '2026-06-22 07:58:12', '2026-06-22 09:20:53'),
(11, 'XI OTKP 1', 'SIANG', 'XI', 'OTKP', 11, '2026-06-22 07:58:12', '2026-06-22 09:20:56'),
(12, 'XI OTKP 2', 'SIANG', 'XI', 'OTKP', 12, '2026-06-22 07:58:12', '2026-06-22 09:20:59'),
(13, 'XI TKJ 1', 'SIANG', 'XI', 'TKJ', 13, '2026-06-22 07:58:12', '2026-06-22 09:21:03'),
(14, 'XI TKJ 2', 'SIANG', 'XI', 'TKJ', 14, '2026-06-22 07:58:12', '2026-06-22 09:21:05'),
(15, 'XI TKR 1', 'SIANG', 'XI', 'TKR', 15, '2026-06-22 07:58:12', '2026-06-22 09:21:07'),
(16, 'XI TKR 2', 'SIANG', 'XI', 'TKR', 16, '2026-06-22 07:58:12', '2026-06-22 09:21:09'),
(17, 'XI TSM 1', 'SIANG', 'XI', 'TSM', 17, '2026-06-22 07:58:12', '2026-06-22 09:21:12'),
(18, 'XI TSM 2', 'SIANG', 'XI', 'TSM', 18, '2026-06-22 07:58:12', '2026-06-22 09:21:14'),
(19, 'XII AK 1', 'PAGI', 'XII', 'AK', 19, '2026-06-22 07:58:12', '2026-06-22 09:21:17'),
(20, 'XII OTKP 1', 'PAGI', 'XII', 'OTKP', 25, '2026-06-22 07:58:12', '2026-06-22 09:21:57'),
(21, 'XII OTKP 2', 'PAGI', 'XII', 'OTKP', 21, '2026-06-22 07:58:12', '2026-06-22 09:21:36'),
(22, 'XII TKJ 1', 'PAGI', 'XII', 'TKJ', 22, '2026-06-22 07:58:12', '2026-06-22 09:21:40'),
(23, 'XII TKJ 2', 'PAGI', 'XII', 'TKJ', 29, '2026-06-22 07:58:12', '2026-06-22 09:21:21'),
(24, 'XII TKR 1', 'PAGI', 'XII', 'TKR', 28, '2026-06-22 07:58:12', '2026-06-22 09:21:26'),
(25, 'XII TKR 2', 'PAGI', 'XII', 'TKR', 20, '2026-06-22 07:58:12', '2026-06-22 09:21:30'),
(26, 'XII TSM 1', 'PAGI', 'XII', 'TSM', 24, '2026-06-22 07:58:12', '2026-06-22 09:21:48'),
(27, 'XII TSM 2', 'PAGI', 'XII', 'TSM', 23, '2026-06-22 07:58:12', '2026-06-22 09:21:44');

-- --------------------------------------------------------

--
-- Struktur dari tabel `class_subjects`
--

CREATE TABLE `class_subjects` (
  `id_class_subject` bigint(20) UNSIGNED NOT NULL,
  `id_kelas` bigint(20) UNSIGNED NOT NULL,
  `id_mapel` bigint(20) UNSIGNED NOT NULL,
  `durasi_jp` int(11) NOT NULL,
  `id_guru_mutlak` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `class_subjects`
--

INSERT INTO `class_subjects` (`id_class_subject`, `id_kelas`, `id_mapel`, `durasi_jp`, `id_guru_mutlak`, `created_at`, `updated_at`) VALUES
(1, 1, 8, 3, 14, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(2, 1, 9, 2, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(3, 1, 10, 3, 36, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(4, 1, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(5, 1, 15, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(6, 1, 17, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(7, 1, 18, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(8, 1, 19, 2, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(9, 1, 24, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(10, 1, 30, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(11, 1, 42, 2, 3, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(12, 1, 43, 2, 27, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(13, 1, 44, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(14, 1, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(15, 1, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(16, 1, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(17, 2, 4, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(18, 2, 10, 3, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(19, 2, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(20, 2, 17, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(21, 2, 18, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(22, 2, 19, 2, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(23, 2, 25, 3, 9, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(24, 2, 30, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(25, 2, 31, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(26, 2, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(27, 2, 43, 2, 34, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(28, 2, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(29, 2, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(30, 2, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(31, 2, 53, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(32, 3, 4, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(33, 3, 10, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(34, 3, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(35, 3, 17, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(36, 3, 18, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(37, 3, 19, 2, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(38, 3, 25, 3, 9, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(39, 3, 30, 5, 7, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(40, 3, 31, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(41, 3, 42, 2, 3, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(42, 3, 43, 2, 34, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(43, 3, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(44, 3, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(45, 3, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(46, 3, 53, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(47, 4, 10, 3, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(48, 4, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(49, 4, 12, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(50, 4, 13, 4, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(51, 4, 17, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(52, 4, 18, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(53, 4, 19, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(54, 4, 30, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(55, 4, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(56, 4, 43, 2, 27, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(57, 4, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(58, 4, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(59, 4, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(60, 4, 52, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(61, 5, 10, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(62, 5, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(63, 5, 12, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(64, 5, 13, 4, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(65, 5, 17, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(66, 5, 18, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(67, 5, 19, 3, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(68, 5, 30, 5, 7, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(69, 5, 42, 2, 3, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(70, 5, 43, 2, 27, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(71, 5, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(72, 5, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(73, 5, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(74, 5, 52, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(75, 6, 10, 3, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(76, 6, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(77, 6, 16, 3, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(78, 6, 17, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(79, 6, 18, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(80, 6, 19, 2, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(81, 6, 30, 5, 7, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(82, 6, 40, 4, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(83, 6, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(84, 6, 43, 2, 34, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(85, 6, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(86, 6, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(87, 6, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(88, 6, 49, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(89, 7, 10, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(90, 7, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(91, 7, 16, 3, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(92, 7, 17, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(93, 7, 18, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(94, 7, 19, 2, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(95, 7, 30, 5, 7, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(96, 7, 40, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(97, 7, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(98, 7, 43, 2, 34, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(99, 7, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(100, 7, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(101, 7, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(102, 7, 49, 4, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(103, 8, 10, 3, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(104, 8, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(105, 8, 16, 3, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(106, 8, 17, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(107, 8, 18, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(108, 8, 19, 2, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(109, 8, 30, 5, 7, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(110, 8, 40, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(111, 8, 42, 2, 3, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(112, 8, 43, 2, 34, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(113, 8, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(114, 8, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(115, 8, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(116, 8, 49, 4, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(117, 9, 10, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(118, 9, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(119, 9, 16, 3, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(120, 9, 17, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(121, 9, 18, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(122, 9, 19, 2, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(123, 9, 30, 5, 7, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(124, 9, 40, 4, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(125, 9, 42, 2, 3, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(126, 9, 43, 2, 34, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(127, 9, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(128, 9, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(129, 9, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(130, 9, 49, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(131, 10, 1, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(132, 10, 4, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(133, 10, 5, 2, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(134, 10, 6, 2, 14, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(135, 10, 7, 3, 14, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(136, 10, 10, 2, 36, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(137, 10, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(138, 10, 14, 2, 14, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(139, 10, 23, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(140, 10, 24, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(141, 10, 30, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(142, 10, 42, 2, 3, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(143, 10, 43, 2, 28, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(144, 10, 45, 3, 35, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(145, 10, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(146, 10, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(147, 10, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(148, 11, 10, 3, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(149, 11, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(150, 11, 20, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(151, 11, 23, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(152, 11, 30, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(153, 11, 32, 4, 9, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(154, 11, 34, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(155, 11, 36, 3, 14, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(156, 11, 38, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(157, 11, 42, 2, 3, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(158, 11, 43, 2, 28, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(159, 11, 45, 3, 35, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(160, 11, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(161, 11, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(162, 11, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(163, 12, 10, 3, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(164, 12, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(165, 12, 20, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(166, 12, 23, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(167, 12, 30, 5, 25, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(168, 12, 32, 4, 9, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(169, 12, 34, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(170, 12, 36, 3, 14, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(171, 12, 38, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(172, 12, 42, 2, 3, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(173, 12, 43, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(174, 12, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(175, 12, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(176, 12, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(177, 12, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(178, 13, 2, 4, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(179, 13, 10, 3, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(180, 13, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(181, 13, 23, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(182, 13, 30, 5, 30, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(183, 13, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(184, 13, 43, 2, 34, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(185, 13, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(186, 13, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(187, 13, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(188, 13, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(189, 13, 50, 3, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(190, 13, 51, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(191, 13, 54, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(192, 14, 2, 4, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(193, 14, 10, 3, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(194, 14, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(195, 14, 23, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(196, 14, 30, 5, 30, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(197, 14, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(198, 14, 43, 2, 34, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(199, 14, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(200, 14, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(201, 14, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(202, 14, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(203, 14, 50, 3, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(204, 14, 51, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(205, 14, 54, 3, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(206, 15, 10, 3, 36, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(207, 15, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(208, 15, 21, 4, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(209, 15, 23, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(210, 15, 26, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(211, 15, 28, 4, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(212, 15, 30, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(213, 15, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(214, 15, 43, 2, 27, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(215, 15, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(216, 15, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(217, 15, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(218, 15, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(219, 16, 10, 3, 36, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(220, 16, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(221, 16, 21, 4, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(222, 16, 23, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(223, 16, 26, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(224, 16, 28, 4, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(225, 16, 30, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(226, 16, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(227, 16, 43, 2, 27, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(228, 16, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(229, 16, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(230, 16, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(231, 16, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(232, 17, 10, 3, 36, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(233, 17, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(234, 17, 22, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(235, 17, 23, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(236, 17, 27, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(237, 17, 29, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(238, 17, 30, 5, 7, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(239, 17, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(240, 17, 43, 2, 34, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(241, 17, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(242, 17, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(243, 17, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(244, 17, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(245, 18, 10, 3, 36, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(246, 18, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(247, 18, 22, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(248, 18, 23, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(249, 18, 27, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(250, 18, 29, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(251, 18, 30, 5, 7, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(252, 18, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(253, 18, 43, 2, 34, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(254, 18, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(255, 18, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(256, 18, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(257, 18, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(258, 19, 1, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(259, 19, 5, 3, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(260, 19, 6, 3, 14, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(261, 19, 7, 4, 14, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(262, 19, 10, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(263, 19, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(264, 19, 24, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(265, 19, 30, 5, 7, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(266, 19, 42, 2, 3, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(267, 19, 43, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(268, 19, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(269, 19, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(270, 19, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(271, 19, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(272, 20, 10, 3, 36, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(273, 20, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(274, 20, 30, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(275, 20, 33, 5, 9, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(276, 20, 35, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(277, 20, 37, 3, 14, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(278, 20, 39, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(279, 20, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(280, 20, 43, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(281, 20, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(282, 20, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(283, 20, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(284, 20, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(285, 21, 10, 3, 36, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(286, 21, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(287, 21, 30, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(288, 21, 33, 5, 9, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(289, 21, 35, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(290, 21, 37, 3, 14, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(291, 21, 39, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(292, 21, 42, 2, 3, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(293, 21, 43, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(294, 21, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(295, 21, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(296, 21, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(297, 21, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(298, 22, 2, 4, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(299, 22, 10, 3, 36, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(300, 22, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(301, 22, 30, 5, 7, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(302, 22, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(303, 22, 43, 2, 27, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(304, 22, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(305, 22, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(306, 22, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(307, 22, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(308, 22, 50, 4, 20, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(309, 22, 51, 4, 20, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(310, 22, 54, 3, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(311, 23, 2, 4, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(312, 23, 10, 3, 36, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(313, 23, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(314, 23, 30, 5, 7, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(315, 23, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(316, 23, 43, 2, 27, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(317, 23, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(318, 23, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(319, 23, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(320, 23, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(321, 23, 50, 4, 20, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(322, 23, 51, 4, 20, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(323, 23, 54, 3, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(324, 24, 10, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(325, 24, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(326, 24, 21, 5, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(327, 24, 26, 5, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(328, 24, 28, 5, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(329, 24, 30, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(330, 24, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(331, 24, 43, 2, 27, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(332, 24, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(333, 24, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(334, 24, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(335, 24, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(336, 25, 10, 3, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(337, 25, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(338, 25, 21, 5, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(339, 25, 26, 5, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(340, 25, 28, 5, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(341, 25, 30, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(342, 25, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(343, 25, 43, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(344, 25, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(345, 25, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(346, 25, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(347, 25, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(348, 26, 10, 3, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(349, 26, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(350, 26, 22, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(351, 26, 27, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(352, 26, 29, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(353, 26, 30, 5, 25, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(354, 26, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(355, 26, 43, 2, 27, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(356, 26, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(357, 26, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(358, 26, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(359, 26, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(360, 27, 10, 3, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(361, 27, 11, 4, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(362, 27, 22, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(363, 27, 27, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(364, 27, 29, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(365, 27, 30, 5, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(366, 27, 42, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(367, 27, 43, 2, 27, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(368, 27, 45, 3, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(369, 27, 46, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(370, 27, 47, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(371, 27, 48, 2, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `events`
--

CREATE TABLE `events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_event` varchar(255) NOT NULL,
  `tanggal` date NOT NULL,
  `target_shift` enum('PAGI','SIANG') DEFAULT NULL,
  `jam_ke` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`jam_ke`)),
  `target_kelas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`target_kelas`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `grade_configs`
--

CREATE TABLE `grade_configs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bobot_formatif` int(11) NOT NULL DEFAULT 50,
  `bobot_sumatif` int(11) NOT NULL DEFAULT 50,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `grade_configs`
--

INSERT INTO `grade_configs` (`id`, `bobot_formatif`, `bobot_sumatif`, `created_at`, `updated_at`) VALUES
(1, 50, 50, '2026-06-22 00:09:03', '2026-06-22 00:09:03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jp_schedules`
--

CREATE TABLE `jp_schedules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shift` enum('PAGI','SIANG') NOT NULL,
  `hari` enum('SENIN','SELASA','RABU','KAMIS','JUMAT','SABTU') NOT NULL,
  `jam_ke` int(11) DEFAULT NULL,
  `waktu_mulai` time NOT NULL,
  `waktu_selesai` time NOT NULL,
  `is_kbm` tinyint(1) NOT NULL DEFAULT 1,
  `keterangan` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `jp_schedules`
--

INSERT INTO `jp_schedules` (`id`, `shift`, `hari`, `jam_ke`, `waktu_mulai`, `waktu_selesai`, `is_kbm`, `keterangan`, `created_at`, `updated_at`) VALUES
(1, 'PAGI', 'SENIN', 1, '06:30:00', '07:30:00', 1, 'KBM/Upacara', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(2, 'PAGI', 'SENIN', 2, '07:30:00', '08:10:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(3, 'PAGI', 'SENIN', 3, '08:10:00', '08:50:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(4, 'PAGI', 'SENIN', 4, '08:50:00', '09:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(5, 'PAGI', 'SENIN', 0, '09:30:00', '10:00:00', 0, 'Istirahat', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(6, 'PAGI', 'SENIN', 5, '10:00:00', '10:35:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(7, 'PAGI', 'SENIN', 6, '10:35:00', '11:10:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(8, 'PAGI', 'SENIN', 7, '11:10:00', '11:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(9, 'PAGI', 'SELASA', 1, '06:30:00', '07:30:00', 1, 'KBM/Upacara', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(10, 'PAGI', 'SELASA', 2, '07:30:00', '08:10:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(11, 'PAGI', 'SELASA', 3, '08:10:00', '08:50:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(12, 'PAGI', 'SELASA', 4, '08:50:00', '09:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(13, 'PAGI', 'SELASA', 0, '09:30:00', '10:00:00', 0, 'Istirahat', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(14, 'PAGI', 'SELASA', 5, '10:00:00', '10:35:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(15, 'PAGI', 'SELASA', 6, '10:35:00', '11:10:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(16, 'PAGI', 'SELASA', 7, '11:10:00', '11:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(17, 'PAGI', 'RABU', 1, '06:30:00', '07:30:00', 1, 'KBM/Upacara', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(18, 'PAGI', 'RABU', 2, '07:30:00', '08:10:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(19, 'PAGI', 'RABU', 3, '08:10:00', '08:50:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(20, 'PAGI', 'RABU', 4, '08:50:00', '09:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(21, 'PAGI', 'RABU', 0, '09:30:00', '10:00:00', 0, 'Istirahat', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(22, 'PAGI', 'RABU', 5, '10:00:00', '10:35:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(23, 'PAGI', 'RABU', 6, '10:35:00', '11:10:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(24, 'PAGI', 'RABU', 7, '11:10:00', '11:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(25, 'PAGI', 'KAMIS', 1, '06:30:00', '07:30:00', 1, 'KBM/Upacara', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(26, 'PAGI', 'KAMIS', 2, '07:30:00', '08:10:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(27, 'PAGI', 'KAMIS', 3, '08:10:00', '08:50:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(28, 'PAGI', 'KAMIS', 4, '08:50:00', '09:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(29, 'PAGI', 'KAMIS', 0, '09:30:00', '10:00:00', 0, 'Istirahat', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(30, 'PAGI', 'KAMIS', 5, '10:00:00', '10:35:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(31, 'PAGI', 'KAMIS', 6, '10:35:00', '11:10:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(32, 'PAGI', 'KAMIS', 7, '11:10:00', '11:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(33, 'PAGI', 'JUMAT', 1, '07:00:00', '07:40:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(34, 'PAGI', 'JUMAT', 2, '07:40:00', '08:20:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(35, 'PAGI', 'JUMAT', 3, '08:20:00', '09:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(36, 'PAGI', 'JUMAT', 4, '09:00:00', '09:40:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(37, 'PAGI', 'JUMAT', 0, '09:40:00', '10:00:00', 0, 'Istirahat', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(38, 'PAGI', 'JUMAT', 5, '10:00:00', '10:40:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(39, 'PAGI', 'JUMAT', 6, '10:40:00', '11:20:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(40, 'PAGI', 'SABTU', 1, '07:00:00', '07:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(41, 'PAGI', 'SABTU', 2, '07:45:00', '08:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(42, 'PAGI', 'SABTU', 3, '08:30:00', '09:15:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(43, 'PAGI', 'SABTU', 4, '09:15:00', '10:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(44, 'PAGI', 'SABTU', 0, '10:00:00', '10:30:00', 0, 'Istirahat', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(45, 'PAGI', 'SABTU', 5, '10:30:00', '11:15:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(46, 'PAGI', 'SABTU', 6, '11:15:00', '12:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(47, 'PAGI', 'SABTU', 7, '12:00:00', '12:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(48, 'SIANG', 'SENIN', 1, '12:45:00', '13:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(49, 'SIANG', 'SENIN', 2, '13:30:00', '14:15:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(50, 'SIANG', 'SENIN', 3, '14:15:00', '15:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(51, 'SIANG', 'SENIN', 4, '15:00:00', '15:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(52, 'SIANG', 'SENIN', 0, '15:45:00', '16:15:00', 0, 'Istirahat', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(53, 'SIANG', 'SENIN', 5, '16:15:00', '17:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(54, 'SIANG', 'SENIN', 6, '17:00:00', '17:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(55, 'SIANG', 'SENIN', 7, '17:45:00', '18:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(56, 'SIANG', 'SELASA', 1, '12:45:00', '13:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(57, 'SIANG', 'SELASA', 2, '13:30:00', '14:15:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(58, 'SIANG', 'SELASA', 3, '14:15:00', '15:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(59, 'SIANG', 'SELASA', 4, '15:00:00', '15:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(60, 'SIANG', 'SELASA', 0, '15:45:00', '16:15:00', 0, 'Istirahat', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(61, 'SIANG', 'SELASA', 5, '16:15:00', '17:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(62, 'SIANG', 'SELASA', 6, '17:00:00', '17:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(63, 'SIANG', 'SELASA', 7, '17:45:00', '18:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(64, 'SIANG', 'RABU', 1, '12:45:00', '13:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(65, 'SIANG', 'RABU', 2, '13:30:00', '14:15:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(66, 'SIANG', 'RABU', 3, '14:15:00', '15:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(67, 'SIANG', 'RABU', 4, '15:00:00', '15:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(68, 'SIANG', 'RABU', 0, '15:45:00', '16:15:00', 0, 'Istirahat', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(69, 'SIANG', 'RABU', 5, '16:15:00', '17:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(70, 'SIANG', 'RABU', 6, '17:00:00', '17:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(71, 'SIANG', 'RABU', 7, '17:45:00', '18:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(72, 'SIANG', 'KAMIS', 1, '12:45:00', '13:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(73, 'SIANG', 'KAMIS', 2, '13:30:00', '14:15:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(74, 'SIANG', 'KAMIS', 3, '14:15:00', '15:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(75, 'SIANG', 'KAMIS', 4, '15:00:00', '15:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(76, 'SIANG', 'KAMIS', 0, '15:45:00', '16:15:00', 0, 'Istirahat', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(77, 'SIANG', 'KAMIS', 5, '16:15:00', '17:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(78, 'SIANG', 'KAMIS', 6, '17:00:00', '17:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(79, 'SIANG', 'KAMIS', 7, '17:45:00', '18:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(80, 'SIANG', 'JUMAT', 1, '13:30:00', '14:15:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(81, 'SIANG', 'JUMAT', 2, '14:15:00', '15:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(82, 'SIANG', 'JUMAT', 3, '15:00:00', '15:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(83, 'SIANG', 'JUMAT', 0, '15:45:00', '16:15:00', 0, 'Istirahat', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(84, 'SIANG', 'JUMAT', 4, '16:15:00', '17:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(85, 'SIANG', 'JUMAT', 5, '17:00:00', '17:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(86, 'SIANG', 'JUMAT', 6, '17:45:00', '18:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(87, 'SIANG', 'SABTU', 1, '12:45:00', '13:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(88, 'SIANG', 'SABTU', 2, '13:30:00', '14:15:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(89, 'SIANG', 'SABTU', 3, '14:15:00', '15:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(90, 'SIANG', 'SABTU', 4, '15:00:00', '15:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(91, 'SIANG', 'SABTU', 0, '15:45:00', '16:15:00', 0, 'Istirahat', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(92, 'SIANG', 'SABTU', 5, '16:15:00', '17:00:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(93, 'SIANG', 'SABTU', 6, '17:00:00', '17:45:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59'),
(94, 'SIANG', 'SABTU', 7, '17:45:00', '18:30:00', 1, 'KBM Aktif', '2026-06-22 00:06:59', '2026-06-22 00:06:59');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kbm_sessions`
--

CREATE TABLE `kbm_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tanggal` date NOT NULL,
  `id_timetable` bigint(20) UNSIGNED DEFAULT NULL,
  `id_kelas` bigint(20) UNSIGNED DEFAULT NULL,
  `id_mapel` bigint(20) UNSIGNED DEFAULT NULL,
  `jam_ke` int(11) DEFAULT NULL,
  `id_guru_terjadwal` bigint(20) UNSIGNED DEFAULT NULL,
  `id_guru_aktual` bigint(20) UNSIGNED DEFAULT NULL,
  `status_sesi` enum('PENDING','AKTIF','SELESAI','KOSONG','EVENT') NOT NULL DEFAULT 'PENDING',
  `status_guru` enum('PENDING','HADIR','TERLAMBAT','ALPA','DISPENSASI') NOT NULL DEFAULT 'PENDING',
  `waktu_scan_masuk` timestamp NULL DEFAULT NULL,
  `waktu_scan_keluar` timestamp NULL DEFAULT NULL,
  `materi_log` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `kbm_sessions`
--

INSERT INTO `kbm_sessions` (`id`, `tanggal`, `id_timetable`, `id_kelas`, `id_mapel`, `jam_ke`, `id_guru_terjadwal`, `id_guru_aktual`, `status_sesi`, `status_guru`, `waktu_scan_masuk`, `waktu_scan_keluar`, `materi_log`, `created_at`, `updated_at`) VALUES
(1, '2026-06-22', 35, 1, 15, 2, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(2, '2026-06-22', 36, 1, 15, 3, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(3, '2026-06-22', 37, 1, 48, 4, 24, 24, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(4, '2026-06-22', 38, 1, 48, 5, 24, 24, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(5, '2026-06-22', 39, 1, 24, 6, 15, 15, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(6, '2026-06-22', 40, 1, 24, 7, 15, 15, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(7, '2026-06-22', 75, 2, 11, 2, 26, 26, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(8, '2026-06-22', 76, 2, 30, 3, 8, 8, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(9, '2026-06-22', 77, 2, 30, 4, 8, 8, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(10, '2026-06-22', 78, 2, 30, 5, 8, 8, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(11, '2026-06-22', 79, 2, 30, 6, 8, 8, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(12, '2026-06-22', 80, 2, 30, 7, 8, 8, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(13, '2026-06-22', 114, 3, 46, 1, 11, 11, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(14, '2026-06-22', 115, 3, 46, 2, 11, 11, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(15, '2026-06-22', 116, 3, 18, 3, 5, 5, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(16, '2026-06-22', 117, 3, 18, 4, 5, 5, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(17, '2026-06-22', 118, 3, 19, 5, 17, 17, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(18, '2026-06-22', 119, 3, 48, 6, 24, 24, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(19, '2026-06-22', 120, 3, 48, 7, 24, 24, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(20, '2026-06-22', 155, 4, 47, 2, 22, 22, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(21, '2026-06-22', 156, 4, 47, 3, 22, 22, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(22, '2026-06-22', 157, 4, 46, 4, 2, 2, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(23, '2026-06-22', 158, 4, 12, 5, 29, 29, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(24, '2026-06-22', 159, 4, 10, 6, 4, 4, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(25, '2026-06-22', 160, 4, 17, 7, 29, 29, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(26, '2026-06-22', 194, 5, 11, 1, 26, 26, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(27, '2026-06-22', 195, 5, 11, 2, 26, 26, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(28, '2026-06-22', 196, 5, 48, 3, 24, 24, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(29, '2026-06-22', 197, 5, 48, 4, 24, 24, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(30, '2026-06-22', 198, 5, 46, 5, 11, 11, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(31, '2026-06-22', 199, 5, 46, 6, 11, 11, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(32, '2026-06-22', 200, 5, 30, 7, 7, 7, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(33, '2026-06-22', 235, 6, 48, 2, 24, 24, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(34, '2026-06-22', 236, 6, 17, 3, 1, 1, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(35, '2026-06-22', 237, 6, 19, 4, 17, 17, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(36, '2026-06-22', 238, 6, 40, 5, 37, 37, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(37, '2026-06-22', 239, 6, 40, 6, 37, 37, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(38, '2026-06-22', 240, 6, 40, 7, 37, 37, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(39, '2026-06-22', 274, 7, 16, 1, 17, 17, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(40, '2026-06-22', 275, 7, 16, 2, 17, 17, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(41, '2026-06-22', 276, 7, 11, 3, 26, 26, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(42, '2026-06-22', 277, 7, 11, 4, 26, 26, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(43, '2026-06-22', 278, 7, 11, 5, 26, 26, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(44, '2026-06-22', 279, 7, 11, 6, 26, 26, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(45, '2026-06-22', 280, 7, 49, 7, 17, 17, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(46, '2026-06-22', 315, 8, 43, 2, 34, 34, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(47, '2026-06-22', 316, 8, 43, 3, 34, 34, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(48, '2026-06-22', 317, 8, 46, 4, 22, 22, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(49, '2026-06-22', 318, 8, 46, 5, 22, 22, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(50, '2026-06-22', 319, 8, 18, 6, 5, 5, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(51, '2026-06-22', 320, 8, 18, 7, 5, 5, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(52, '2026-06-22', 354, 9, 43, 1, 34, 34, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(53, '2026-06-22', 355, 9, 43, 2, 34, 34, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(54, '2026-06-22', 356, 9, 16, 3, 17, 17, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(55, '2026-06-22', 357, 9, 16, 4, 17, 17, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(56, '2026-06-22', 358, 9, 17, 5, 1, 1, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(57, '2026-06-22', 359, 9, 47, 6, 22, 22, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(58, '2026-06-22', 360, 9, 47, 7, 22, 22, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(59, '2026-06-22', 394, 10, 47, 1, 22, 22, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(60, '2026-06-22', 395, 10, 47, 2, 22, 22, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(61, '2026-06-22', 396, 10, 30, 3, 8, 8, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(62, '2026-06-22', 397, 10, 30, 4, 8, 8, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(63, '2026-06-22', 398, 10, 5, 5, 4, 4, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(64, '2026-06-22', 399, 10, 5, 6, 4, 4, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(65, '2026-06-22', 400, 10, 42, 7, 3, 3, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(66, '2026-06-22', 434, 11, 38, 1, 19, 19, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(67, '2026-06-22', 435, 11, 38, 2, 19, 19, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(68, '2026-06-22', 436, 11, 20, 3, 19, 19, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(69, '2026-06-22', 437, 11, 20, 4, 19, 19, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(70, '2026-06-22', 438, 11, 30, 5, 8, 8, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(71, '2026-06-22', 439, 11, 30, 6, 8, 8, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(72, '2026-06-22', 440, 11, 23, 7, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(73, '2026-06-22', 474, 12, 10, 1, 4, 4, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(74, '2026-06-22', 475, 12, 10, 2, 4, 4, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(75, '2026-06-22', 476, 12, 23, 3, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(76, '2026-06-22', 477, 12, 34, 4, 33, 33, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(77, '2026-06-22', 478, 12, 34, 5, 33, 33, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(78, '2026-06-22', 479, 12, 45, 6, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(79, '2026-06-22', 480, 12, 45, 7, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(80, '2026-06-22', 514, 13, 50, 1, 1, 1, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(81, '2026-06-22', 515, 13, 50, 2, 1, 1, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(82, '2026-06-22', 516, 13, 50, 3, 1, 1, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(83, '2026-06-22', 517, 13, 23, 4, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(84, '2026-06-22', 518, 13, 30, 5, 30, 30, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(85, '2026-06-22', 519, 13, 43, 6, 34, 34, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(86, '2026-06-22', 520, 13, 43, 7, 34, 34, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(87, '2026-06-22', 554, 14, 45, 1, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(88, '2026-06-22', 555, 14, 23, 2, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(89, '2026-06-22', 556, 14, 10, 3, 4, 4, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(90, '2026-06-22', 557, 14, 10, 4, 4, 4, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(91, '2026-06-22', 558, 14, 45, 5, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(92, '2026-06-22', 559, 14, 50, 6, 1, 1, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(93, '2026-06-22', 560, 14, 50, 7, 1, 1, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(94, '2026-06-22', 594, 15, 26, 1, 12, 12, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(95, '2026-06-22', 595, 15, 45, 2, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(96, '2026-06-22', 596, 15, 45, 3, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(97, '2026-06-22', 597, 15, 45, 4, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(98, '2026-06-22', 598, 15, 23, 5, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(99, '2026-06-22', 599, 15, 23, 6, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(100, '2026-06-22', 600, 15, 30, 7, 30, 30, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(101, '2026-06-22', 634, 16, 26, 1, 37, 37, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(102, '2026-06-22', 635, 16, 26, 2, 37, 37, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(103, '2026-06-22', 636, 16, 26, 3, 37, 37, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(104, '2026-06-22', 637, 16, 26, 4, 37, 37, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(105, '2026-06-22', 638, 16, 26, 5, 37, 37, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(106, '2026-06-22', 639, 16, 46, 6, 2, 2, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(107, '2026-06-22', 640, 16, 46, 7, 2, 2, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(108, '2026-06-22', 674, 17, 11, 1, 31, 31, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(109, '2026-06-22', 675, 17, 11, 2, 31, 31, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(110, '2026-06-22', 676, 17, 46, 3, 22, 22, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(111, '2026-06-22', 677, 17, 46, 4, 22, 22, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(112, '2026-06-22', 678, 17, 27, 5, 16, 16, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(113, '2026-06-22', 679, 17, 27, 6, 16, 16, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(114, '2026-06-22', 680, 17, 27, 7, 16, 16, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(115, '2026-06-22', 714, 18, 23, 1, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(116, '2026-06-22', 715, 18, 42, 2, 3, 3, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(117, '2026-06-22', 716, 18, 42, 3, 3, 3, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(118, '2026-06-22', 717, 18, 11, 4, 31, 31, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(119, '2026-06-22', 718, 18, 11, 5, 31, 31, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(120, '2026-06-22', 719, 18, 11, 6, 31, 31, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(121, '2026-06-22', 720, 18, 11, 7, 31, 31, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(122, '2026-06-22', 755, 19, 30, 2, 7, 7, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(123, '2026-06-22', 756, 19, 30, 3, 7, 7, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(124, '2026-06-22', 757, 19, 10, 4, 4, 4, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(125, '2026-06-22', 758, 19, 42, 5, 3, 3, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(126, '2026-06-22', 759, 19, 42, 6, 3, 3, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(127, '2026-06-22', 760, 19, 10, 7, 4, 4, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(128, '2026-06-22', 795, 20, 46, 2, 11, 11, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(129, '2026-06-22', 796, 20, 46, 3, 11, 11, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(130, '2026-06-22', 797, 20, 39, 4, 19, 19, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(131, '2026-06-22', 798, 20, 39, 5, 19, 19, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(132, '2026-06-22', 799, 20, 39, 6, 19, 19, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(133, '2026-06-22', 800, 20, 39, 7, 19, 19, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(134, '2026-06-22', 835, 21, 39, 2, 19, 19, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(135, '2026-06-22', 836, 21, 39, 3, 19, 19, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(136, '2026-06-22', 837, 21, 30, 4, 7, 7, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(137, '2026-06-22', 838, 21, 30, 5, 7, 7, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(138, '2026-06-22', 839, 21, 45, 6, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(139, '2026-06-22', 840, 21, 45, 7, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(140, '2026-06-22', 875, 22, 51, 2, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(141, '2026-06-22', 876, 22, 48, 3, 24, 24, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(142, '2026-06-22', 877, 22, 2, 4, 1, 1, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(143, '2026-06-22', 878, 22, 2, 5, 1, 1, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(144, '2026-06-22', 879, 22, 50, 6, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(145, '2026-06-22', 880, 22, 50, 7, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(146, '2026-06-22', 915, 23, 2, 2, 1, 1, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(147, '2026-06-22', 916, 23, 50, 3, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(148, '2026-06-22', 917, 23, 50, 4, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(149, '2026-06-22', 918, 23, 50, 5, 20, 20, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(150, '2026-06-22', 919, 23, 2, 6, 1, 1, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(151, '2026-06-22', 920, 23, 2, 7, 1, 1, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(152, '2026-06-22', 955, 24, 21, 2, 37, 37, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(153, '2026-06-22', 956, 24, 21, 3, 37, 37, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(154, '2026-06-22', 957, 24, 30, 4, 30, 30, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(155, '2026-06-22', 958, 24, 30, 5, 30, 30, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(156, '2026-06-22', 959, 24, 30, 6, 30, 30, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(157, '2026-06-22', 960, 24, 30, 7, 30, 30, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(158, '2026-06-22', 995, 25, 30, 2, 30, 30, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(159, '2026-06-22', 996, 25, 30, 3, 30, 30, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(160, '2026-06-22', 997, 25, 28, 4, 37, 37, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(161, '2026-06-22', 998, 25, 10, 5, 4, 4, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(162, '2026-06-22', 999, 25, 11, 6, 26, 26, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(163, '2026-06-22', 1000, 25, 11, 7, 26, 26, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(164, '2026-06-22', 1035, 26, 10, 2, 4, 4, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(165, '2026-06-22', 1036, 26, 10, 3, 4, 4, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(166, '2026-06-22', 1037, 26, 22, 4, 16, 16, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(167, '2026-06-22', 1038, 26, 22, 5, 16, 16, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(168, '2026-06-22', 1039, 26, 22, 6, 16, 16, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(169, '2026-06-22', 1040, 26, 22, 7, 16, 16, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(170, '2026-06-22', 1075, 27, 22, 2, 16, 16, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(171, '2026-06-22', 1076, 27, 22, 3, 16, 16, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(172, '2026-06-22', 1077, 27, 45, 4, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(173, '2026-06-22', 1078, 27, 45, 5, 13, 13, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(174, '2026-06-22', 1079, 27, 43, 6, 27, 27, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33'),
(175, '2026-06-22', 1080, 27, 43, 7, 27, 27, 'PENDING', 'PENDING', NULL, NULL, NULL, '2026-06-21 23:56:33', '2026-06-21 23:56:33');

-- --------------------------------------------------------

--
-- Struktur dari tabel `learning_objectives`
--

CREATE TABLE `learning_objectives` (
  `id_tp` bigint(20) UNSIGNED NOT NULL,
  `id_guru` bigint(20) UNSIGNED NOT NULL,
  `id_mapel` bigint(20) UNSIGNED NOT NULL,
  `kode_tp` varchar(255) NOT NULL,
  `deskripsi_tp` text NOT NULL,
  `semester` enum('GANJIL','GENAP') NOT NULL DEFAULT 'GANJIL',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `live_exams`
--

CREATE TABLE `live_exams` (
  `id_exam` bigint(20) UNSIGNED NOT NULL,
  `id_kbm_session` bigint(20) UNSIGNED NOT NULL,
  `id_bank` bigint(20) UNSIGNED NOT NULL,
  `status` enum('DRAFT','ACTIVE','FINISHED') NOT NULL DEFAULT 'DRAFT',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_06_21_000001_create_teachers_table', 1),
(5, '2026_06_21_000002_create_classes_table', 1),
(6, '2026_06_21_000003_create_subjects_table', 1),
(7, '2026_06_21_000004_create_teacher_subjects_table', 1),
(8, '2026_06_21_000005_create_class_subjects_table', 1),
(9, '2026_06_21_000006_create_timetable_table', 1),
(10, '2026_06_21_041557_create_personal_access_tokens_table', 1),
(11, '2026_06_21_100000_create_jp_schedules_table', 1),
(12, '2026_06_21_100001_create_students_table', 1),
(13, '2026_06_21_100002_add_roles_to_users_table', 1),
(14, '2026_06_21_110000_create_learning_objectives_table', 1),
(15, '2026_06_21_110001_create_student_grades_table', 1),
(16, '2026_06_21_110002_create_report_cards_table', 1),
(17, '2026_06_22_000001_add_id_guru_wali_to_classes_table', 1),
(18, '2026_06_22_000002_create_kbm_sessions_table', 1),
(19, '2026_06_22_000003_create_events_table', 1),
(20, '2026_06_22_000004_create_question_banks_table', 1),
(21, '2026_06_22_000005_create_questions_table', 1),
(22, '2026_06_22_000006_create_live_exams_table', 1),
(23, '2026_06_22_000007_create_student_answers_table', 1),
(24, '2026_06_22_000008_create_questionnaires_table', 1),
(25, '2026_06_22_000009_create_questionnaire_questions_table', 1),
(26, '2026_06_22_000010_create_questionnaire_responses_table', 1),
(27, '2026_06_22_000011_create_grade_configs_table', 1),
(28, '2026_06_22_160213_create_academic_calendars_table', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `questionnaires`
--

CREATE TABLE `questionnaires` (
  `id_questionnaire` bigint(20) UNSIGNED NOT NULL,
  `judul` varchar(255) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `tipe` enum('GURU_MAPEL','WALI_KELAS') NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `questionnaire_questions`
--

CREATE TABLE `questionnaire_questions` (
  `id_q_question` bigint(20) UNSIGNED NOT NULL,
  `id_questionnaire` bigint(20) UNSIGNED NOT NULL,
  `pertanyaan` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `questionnaire_responses`
--

CREATE TABLE `questionnaire_responses` (
  `id_response` bigint(20) UNSIGNED NOT NULL,
  `id_questionnaire` bigint(20) UNSIGNED NOT NULL,
  `id_siswa` bigint(20) UNSIGNED NOT NULL,
  `id_guru_target` bigint(20) UNSIGNED NOT NULL,
  `id_q_question` bigint(20) UNSIGNED NOT NULL,
  `rating_score` int(11) NOT NULL DEFAULT 0,
  `komentar` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `questions`
--

CREATE TABLE `questions` (
  `id_question` bigint(20) UNSIGNED NOT NULL,
  `id_bank` bigint(20) UNSIGNED NOT NULL,
  `pertanyaan` text NOT NULL,
  `opsi_a` text NOT NULL,
  `opsi_b` text NOT NULL,
  `opsi_c` text NOT NULL,
  `opsi_d` text NOT NULL,
  `opsi_e` text NOT NULL,
  `jawaban_benar` enum('A','B','C','D','E') NOT NULL,
  `pembahasan` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `question_banks`
--

CREATE TABLE `question_banks` (
  `id_bank` bigint(20) UNSIGNED NOT NULL,
  `id_guru` bigint(20) UNSIGNED NOT NULL,
  `id_mapel` bigint(20) UNSIGNED NOT NULL,
  `judul` varchar(255) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `report_cards`
--

CREATE TABLE `report_cards` (
  `id_rapor` bigint(20) UNSIGNED NOT NULL,
  `id_siswa` bigint(20) UNSIGNED NOT NULL,
  `id_class_subject` bigint(20) UNSIGNED NOT NULL,
  `nilai_sas` int(11) NOT NULL DEFAULT 0,
  `nilai_akhir` int(11) NOT NULL DEFAULT 0,
  `deskripsi_capaian` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('27VtzORa3oZNbKdfYdtTfITB77WymPdZlOSQck0f', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoibVdBeW1zTlYxRUw0YTAzTHpEQjZ1TnhLMmRGRU1EeGxMZVoyOWREYiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782110862),
('2BEM5IsXCNkjDlrggvF91VxgBUaIL1M6co51y5tT', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWHd4MUF0aVFzVlA4eGtSQTNHYnJBRHVKcGpPeE5mdGdMM0RCOGpjaiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6MTU6ImFkbWluLmRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782111300),
('3RmUrUq3QP6l0cCjPEzoc74SDO5KCfBIZFetHcWb', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiM0NPb1pBNUVCSU1rOXI5R3hURTNGMzVCdVE3UFp3Z2N4OE16dkFSRSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782113129),
('3UUkzNEZ6JfRFg8m3EvhXCttOI8U7nWMdesoWTNk', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiQVlpVTJnYkVWTkwwWFZacjFjNVBEOWhtSUR3RlJMVHJJVDNRakJrOSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112846),
('6jUCBC9hh95o5fAMvTvV81nSb7fAzcplYMzeg9GB', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiYWt0d1JheTdNcVNYSzFsd2ppS0tnUERYY1VPWUZ2RXFRejkxSzNJViI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782113471),
('7cxuUCTJCwdv76d4PhNLpq5nKPEJRiFsfPUcYTLU', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSnRpMDNDbDRvdEpHMGFpWlJXcER5ZE54OHpobGltQnQ5V25YdGdsViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9ldmVudHMiO3M6NToicm91dGUiO3M6MTg6ImFkbWluLmV2ZW50cy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782112796),
('8HmHay4p5XPGQruzLLg9rA9PxK0sERDT80X59FWn', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWTFUZDFSanQwQzVuWFZXZTY1bHA2bk5nd2pYUkZXc3UwN0NGZ1pRTSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi90aW1lbGluZSI7czo1OiJyb3V0ZSI7czoxNDoiYWRtaW4udGltZWxpbmUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1782113468),
('8wLHtAPAQyX9xq6DRFgd6iQhGiiRG0UZFeQT9XVw', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUXpKbkswUFRqVVk0a0VEY3ZadHZKWEFuaXhOUUZmYzNBM1JDSVlCaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi93YWxpLWtlbGFzIjtzOjU6InJvdXRlIjtzOjE2OiJhZG1pbi53YWxpLWtlbGFzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782111147),
('9M7R4d06mqjiJFXSRqfvEifC5bqMNPYc6SgloSbv', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNEt0VEZjUkI5Ym1pcXVJRThoeXpMOU9hQzhWRXhxQnByZTgxblNKUyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi93YWxpLWtlbGFzIjtzOjU6InJvdXRlIjtzOjE2OiJhZG1pbi53YWxpLWtlbGFzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782111013),
('a6ehXCnWWk85f4ODKa2V6imh84F4PkWBHONXGCmG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVFpvbVRxdlFWdklLbUQyNDBUVnpPbjQ3cmhVNmpjN0QwOTB4Y01tbyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi90aW1lbGluZSI7czo1OiJyb3V0ZSI7czoxNDoiYWRtaW4udGltZWxpbmUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1782113468),
('AqXiJxDsW82wVvBtIucvgSOcjW3CujNIBmxUgoX4', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYW0wbGRVY0JaSWtad0ozYUVzN0lpN2FMNnFDSlU5ZGY2QVZnM0NUbCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi90aW1lbGluZSI7czo1OiJyb3V0ZSI7czoxNDoiYWRtaW4udGltZWxpbmUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1782112850),
('AtMLwaRnCNqJdxhpdDJ3dy1t8tVv9TPoQGs1mx64', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid2daR2dpcGRlaHc5OTUzWkMyUnRKNHM5OUhjMUNUbXdHQmNWc0oyVyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6MTU6ImFkbWluLmRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782112854),
('bKAePQJVl9ikLCAawZraNnGsJy8XRhVUvWaW7s0y', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid3VhN09Mb1JGeEJvZXYwcFZra1lXd2FqSWFWUnVOS1VVQTlTN3ZpMyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi90aW1lbGluZSI7czo1OiJyb3V0ZSI7czoxNDoiYWRtaW4udGltZWxpbmUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1782113140),
('BlgXg66ZNUtGLPmziuwnOYDY0WI0tcFP7Q69rEv8', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoicU9Edmt1cTRYQTJxeGc0U3N5N3U2aW0yNlFlR1JveENBamYzbjZLUCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112953),
('bLUoDhaWpj1qlEh8Aa70AvAa87nfgXeqAAUkJ2SI', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS20yb3lOVHhvcjM5UTl3SjVNeW5rUFVzbUc0SUU4SDdEUlZzRHRvcCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9qYWR3YWwtanAiO3M6NToicm91dGUiO3M6MTU6ImFkbWluLmphZHdhbC1qcCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782111901),
('bTkxm3Ta9bxZCmae1TLM81dnacq5bONuAjLP5Keg', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMWx4VGxJREVEOXJ2MXl6VVROOGNrMjVRQWpIb1daTGkzVFBSMThCeCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi90aW1lbGluZSI7czo1OiJyb3V0ZSI7czoxNDoiYWRtaW4udGltZWxpbmUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1782113469),
('C0VI1Y21QBfrW0xCQIees6jI4bzcRUVqnTlVx2tL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiejBNV0lGNFpqaTlVblNOTUtwYlo2bGc0SHo4SkZpOUFUUTNLb0o0SyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi90aW1lbGluZSI7czo1OiJyb3V0ZSI7czoxNDoiYWRtaW4udGltZWxpbmUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1782112902),
('cuM3czH2urfRt1dMcWoe7VHA2coACaxOvgMkliwT', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoidXgycnRZNkVPUVhHQlpsQmhkaXlGdmxDRHUwRDJlYXoyODJXQ3B1RyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782113384),
('D4YW2zd7uz9zkcvFY22rOZKwHKDN2NW54ZfNP7I6', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiYXJBcGZMeHRoQWRwT0ZZQ1UzbUtpdGpWNHZmSDhMTm1sa0luUzFKYSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782110707),
('Ds98ccDwrDawfmN0e9rN7gJJhlMoPl2pamWTUWnh', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiSjFpdnF5UUpoZ284RXBZTnJLbkQwSTZ3SkFkb2hNQ1ZvZmRiRmdKOSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782113474),
('DvMfXkyPjPAXeO6SstCRCg3eqJiYIH2zeTsonqov', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOHBYcTVGTEkwWkJrelZvUlB6YlF1QkdVNTdGMXp3dEZtb2lyZ0xzdyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9ldmVudHMiO3M6NToicm91dGUiO3M6MTg6ImFkbWluLmV2ZW50cy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782112682),
('EjBxRWiXZYZQQDpr2vEV1qABId3HeWSd8LDA0qHn', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiOFVBS2V1blp0RG13ZlNINnczWVFLNkU5ZE9DdWVCWUhTWWVnazkwbiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782110705),
('GfyhkvEebocLL5ZM65KCbwVhsfzRgr2s6S0OxF1f', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoid0NjdmZmQjRXNjJCa3l1ODNCRUVXOWk0STNIa2ttTlF3OVRQSGpydiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782113448),
('gm7Y4IkVdc7X1DMhYm43dWuUX243qLTaTCnW4CrG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieUZROFVJS3JkMmJYNXNPb2tUQkc4U0ZOUUtHSW9ESEFxa0NoR1JDeiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6MTU6ImFkbWluLmRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782111376),
('I8rgl2MhD1nfR1MozreQaxk0XiOLIPjK2BuCalSf', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiSHBCekV1S29GVzQ5bUJXMWFxRnprb2VHeWZ1WGt1S1RuVmZ3OTJxWSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112147),
('IqgHWvc0hUWMRXn9oCYWBE6jITcFaNM7rGNwl747', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZnp3SFk4UFo0TVJ1T0JSNER3NE4zalJaSHUwSURQTENIMGx6c29hSSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112055),
('JsJEGtWl1A30c6vEacIsKNAC0grN0darPq3j5x04', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiODdodkRIWXFtT2d1UVhnaFdWenFVTkZnQzlXSEtCRUJLUzhwMWNVaCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112142),
('kbssyAB0fMcFNft9jec0ZudMXcXuERZD729nWiVU', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZldHWnVqS3FUVG9LWGxCN0ZheVR3S0sxbnVuYkZrU0xweWJ1dVJ3YyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782111892),
('m4LVRILuSR4AHLFgIrWeB6SdrY3lW0gPA4QY4ptF', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia1hpdGV5YVQybk5XNnZNdFRJU0hKNDNtYWpES1VJMzI3eWUwelhyaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi93YWxpLWtlbGFzIjtzOjU6InJvdXRlIjtzOjE2OiJhZG1pbi53YWxpLWtlbGFzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782113445),
('MJSP0P4rjln0zqHT9SR3OODalZfhQ6E7nvC00R9l', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQnhpanN1OUVEOVpJWnhPalJKN1ZvYllERURmODRoN0VNd056Q2lhdCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6MTU6ImFkbWluLmRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782111442),
('n7bgqLVDO7DdhkOxj7H1XYfnGkaRpUK0iY5cf0B6', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoidEI3RFI1WVFXRGFGbHFUSU5QenhBQ1NaVWkyTDVMdjdaRnJjazBqUSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112865),
('n7sp8JI77qOZefereorRWr4iCMa8yWjx2JKQcPB2', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMHZzekVSVk9rVFdMV2hqcEU4MzJxWUdkSmZSdUpIYU9UVklOYTBDNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6MTU6ImFkbWluLmRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782111358),
('nra9MeF1YFFfDawg82vCC3QpYTc9XnhQPHge6tIx', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiOWJHakhTcWhjYjRpaUd5dHltRXJ3UXB4djZTQ1lvNENjT3dFMUpnZCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112955),
('nrtUXXbGTbTExGWqr28XoMykpgU5yCoejTjtnZvB', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicWZCWk1PdUpOMkM1QmEwYXJBQTdqaHU0T0JVN3VQOUhMNjROSmNnMSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9ldmVudHMiO3M6NToicm91dGUiO3M6MTg6ImFkbWluLmV2ZW50cy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782112713),
('oYAHpcZE7unAtHVmRXcOYKmrdV5FXPrNBq8OwhzG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiamVWbkhFVVYwdWZGRERpcTVRQUJxdzhETXN4T0hjbzEwb3RzVGdJaCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782111007),
('p1sh7VLNbeOFu1huImFG2tvPvEb3ZuB1TLTrqW2A', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiY05WRm5QeTRWNjExc3pTanU1OU9iY0NyRjNGOWY1Y1MyRE9vY2Y3MSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782110880),
('pbUS8rKC5HKhh5wXdfFXaMSv6H9zpbur30oXqQQ5', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUndBam0wYnV3eXlnUFZ6WndhSmhJU3lqamoySjF2M21IZ3laak1oWSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782113133),
('Pn8jxaLmde7Q3BJgnNJBFyTCiwLxaRnqdoLBipnJ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiRjRYWTc5dzYwR0g4UzZqSmlCNlp6a3RRcGlHTFFSRWV2cW8wSTVHbCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112841),
('PVWIB0PsYKxGr0JMcwKqJ0cvGbQZ1ZFlX0ewNM5d', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieE84bnBkUVlacUJMbHpNa1JJVG1JUW9OWklRcm1CSkRObG5oTGthTiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6MTU6ImFkbWluLmRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782111384),
('qaf73A3j6FvPAMzt9H4YqCG9HOrAEPYvxbdt8vgK', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidkVUb0hUdWhIN3RGOWpJV3pZTzdJd1dmMHFQazMxT0t1cVBDa2VPMCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9ldmVudHMiO3M6NToicm91dGUiO3M6MTg6ImFkbWluLmV2ZW50cy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782112694),
('qPd3vbfNR2wqdUzjI8iN8ybBjjJEcWbZigqiwIgO', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMFlqQWdWd2pITDVnQ2hvYVVocUNJY2tENVc4UEJIdllxeTF5bDZUSyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6MTU6ImFkbWluLmRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782111184),
('RCGkBPI8JBAGeiA6tYRIv8kdciW5xjpTSc4cB8bu', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiSUtFeDQ1TGpOa2ZnVXMzMFJ5bVB1V0hXcGpkdjlUT29ZZzhQY2k2byI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782113476),
('rs87TqH7NJmVrcNpE56MaB1nvGfbxF7Qb8QphLfm', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTk1RWFpKOWNBcGdGV1BKN1ZiM3BITnhSNkZ6NHV5UTVseUJUUTcyTSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9ldmVudHMiO3M6NToicm91dGUiO3M6MTg6ImFkbWluLmV2ZW50cy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782112724),
('sWUCEeDRT24cU3O4cgeJ6vF0HNGSp8D0FvMtHPdF', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiVTJKQ1YxMHBFQThuMGR4cWhPaElMSTY4SmNZQWI4NmFwVVJRcnhBSCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112078),
('SYyR2v2flmKOk95gDpYqydKEVUHdmGNBjnfGWdKI', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM1FENGFmWnhUaUd3REM5cFhXYjRGc1ZSd3RZUnFSaElCV2lrY29rRSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9ldmVudHMiO3M6NToicm91dGUiO3M6MTg6ImFkbWluLmV2ZW50cy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782112839),
('t1q16qDtKfgmzqiqOh2of1dJMowGNYORIVZ9GP6r', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibWlBTUcyY2tKN0hHS2hwbmsxaEttd2UxWkh0dTRNWUlOYVpwUzk4ZSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbi9hZG1pbiI7czo1OiJyb3V0ZSI7czoxMToibG9naW4uYWRtaW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1782110694),
('tQrFw5pfTaRgvyVuUychAF8uhHJq0FEAI1sUDGy0', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiWlNlOWtXVnNZOHhoVFJNZTNYZXA3ZzBaTkdzc29kSGZqa25RNnowTCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782113470),
('u6BmC4Q0lsQRDmLkYR8CvKEid3y5cW2b4NLSnOc2', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiejdiMlFVOHMwQnhubUZ5amh0UEFlcDRtcVREcnJ4MTlFd0wxcms0biI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782111183),
('uDVAqTLh1Mg1FDhBN063UyVonzAPFq5LneYAwBTd', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiM2Q3OW5PRkYyVzJ6MU5YblBxMDZ4b1FtbDlYMjd5OVFoRUhVQ2V2aSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782113144),
('v0atgr73hyEO7RR3EgzfeKFbIV2Bc9fNniwHf33D', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiTDFLZHltSGpVWWp3NTdCQndaZ20ybHhuNm84ODczZkFvWWVmNjcyRCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782113470),
('VBbIupHXjr9Lg46zTA451haGi7pxWCTT6k9h2Nij', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiQkx4RWpCd0dObm0xUFdna0RHejVIWlZqUkpHVXRpR3p6UmlJR1BsRSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782110999),
('wYOlWPwJF0lanjO8PBde5oLjGU2e8wRrQBPAlB1H', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiSmY0alJjMDA2RjlsSDh0OU9BYmxpb1N1Uktpa0doSmFhS0x2MHNBbiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112153),
('x0qF926HV6eYMMUfMYpw2VuGXztitFrFf31WSXwJ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ3JuVDdaVVJ2WUpxSTlOYXVFY2JTNE9NUUJhZXZTZk1JUzZsb1hYRSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9qYWR3YWwtanAiO3M6NToicm91dGUiO3M6MTU6ImFkbWluLmphZHdhbC1qcCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782111896),
('XukLl4CktJSjyo3kgay9yVtg3opgpNR8TkJIVwKI', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiaEE5WDhPUVBrUFNhb1pBZFpHWnRrdHVuOFBjeEtpdlJGTmdnR2M2QiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112144),
('xVC3mngqeckKLwKQGxXsREKZLLW4EsjOfdcCgmBn', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoieUhBTzh4eG1majB1ZVh4dXlveVk5c2ZHWFJtcHd1VDZVTG5IQlptTCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782110713),
('y3fk9WdbuveqIlOUo6OtI81A08hlkDlXB4h6f8wc', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiajVqOEVqOVVCNVhOUmZ5WkdEcFdzc2lFeUxuMExoblNVdm1qbjlhTiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6MTU6ImFkbWluLmRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782112842),
('YJ7wN2E7sm855ojkX3fLTkXxLkB3VgkP4qMva7iv', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTTBUejJlaUxKM2kyOFdDVURZWkhaS29aWXdTcUNGaU9UeExidUxaNCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6MTU6ImFkbWluLmRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1782111658),
('Z4sPCf2k6SmGTCFRKhOfkaPpoHtlCf0azVM6tp79', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiMmRkZUc4d0cxT3haS1B4T2hnN2VMNW5PZ3JucGFkWWw5YW9mYjFmVCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782111954),
('z8tq6uooMh5NTIc6WAPrA0KsCzqMdTWM98Oc26gL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoidGhLTk4xYTNjYXhyNE1hcUlwREdmUjZ3UjNWTjA5SzZFdkR5UVBsMCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112125),
('zoLPaiaLp8qeq4H0kuuijVGiYljMHJ6siJCylQOY', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZ1NTUFFxdnc5WnBEYlRVY2hiWUsyajZuaGhhWktlcG9jUk05ZUtibiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1782112863);

-- --------------------------------------------------------

--
-- Struktur dari tabel `students`
--

CREATE TABLE `students` (
  `id_siswa` bigint(20) UNSIGNED NOT NULL,
  `nis` varchar(20) NOT NULL,
  `nisn` varchar(20) DEFAULT NULL,
  `nama_siswa` varchar(255) NOT NULL,
  `id_kelas` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `students`
--

INSERT INTO `students` (`id_siswa`, `nis`, `nisn`, `nama_siswa`, `id_kelas`, `created_at`, `updated_at`) VALUES
(1, '20260001', '0097229989', 'Latif Caket Simbolon', 1, '2026-06-21 23:46:32', '2026-06-21 23:46:32'),
(2, '20260002', '0076193545', 'Marsito Asmianto Siregar', 1, '2026-06-21 23:46:33', '2026-06-21 23:46:33'),
(3, '20260003', '0039429119', 'Niyaga Lazuardi', 1, '2026-06-21 23:46:33', '2026-06-21 23:46:33'),
(4, '20260004', '0035969804', 'Agus Galih Winarno', 1, '2026-06-21 23:46:33', '2026-06-21 23:46:33'),
(5, '20260005', '0068321981', 'Banawa Mahendra', 1, '2026-06-21 23:46:33', '2026-06-21 23:46:33'),
(6, '20260006', '0037844120', 'Bakianto Thamrin S.Pd', 2, '2026-06-21 23:46:33', '2026-06-21 23:46:33'),
(7, '20260007', '0094316690', 'Oskar Sirait M.Pd', 2, '2026-06-21 23:46:34', '2026-06-21 23:46:34'),
(8, '20260008', '0067431798', 'Padma Lestari', 2, '2026-06-21 23:46:34', '2026-06-21 23:46:34'),
(9, '20260009', '0095261142', 'Cinthia Aryani', 2, '2026-06-21 23:46:34', '2026-06-21 23:46:34'),
(10, '20260010', '0002375654', 'Ratih Mardhiyah', 2, '2026-06-21 23:46:34', '2026-06-21 23:46:34'),
(11, '20260011', '0066240048', 'Okto Iswahyudi', 3, '2026-06-21 23:46:35', '2026-06-21 23:46:35'),
(12, '20260012', '0052234092', 'Chelsea Hartati', 3, '2026-06-21 23:46:35', '2026-06-21 23:46:35'),
(13, '20260013', '0032488817', 'Bakianto Mustofa', 3, '2026-06-21 23:46:35', '2026-06-21 23:46:35'),
(14, '20260014', '0098589609', 'Estiawan Yahya Hidayanto S.Pt', 3, '2026-06-21 23:46:35', '2026-06-21 23:46:35'),
(15, '20260015', '0036547598', 'Patricia Hassanah', 3, '2026-06-21 23:46:35', '2026-06-21 23:46:35'),
(16, '20260016', '0006594832', 'Rini Hasanah S.T.', 4, '2026-06-21 23:46:36', '2026-06-21 23:46:36'),
(17, '20260017', '0040435060', 'Kenzie Garang Wijaya S.Psi', 4, '2026-06-21 23:46:36', '2026-06-21 23:46:36'),
(18, '20260018', '0096361041', 'Rahman Prakasa', 4, '2026-06-21 23:46:36', '2026-06-21 23:46:36'),
(19, '20260019', '0026505221', 'Gada Manullang', 4, '2026-06-21 23:46:36', '2026-06-21 23:46:36'),
(20, '20260020', '0085344295', 'Bella Nurdiyanti M.TI.', 4, '2026-06-21 23:46:36', '2026-06-21 23:46:36'),
(21, '20260021', '0011930017', 'Jasmin Prastuti', 5, '2026-06-21 23:46:37', '2026-06-21 23:46:37'),
(22, '20260022', '0075257250', 'Dartono Utama', 5, '2026-06-21 23:46:37', '2026-06-21 23:46:37'),
(23, '20260023', '0061408655', 'Hendri Caket Sihombing', 5, '2026-06-21 23:46:37', '2026-06-21 23:46:37'),
(24, '20260024', '0030574702', 'Yuni Rahmi Yuliarti S.Kom', 5, '2026-06-21 23:46:37', '2026-06-21 23:46:37'),
(25, '20260025', '0009118063', 'Gatot Pradana', 5, '2026-06-21 23:46:37', '2026-06-21 23:46:37'),
(26, '20260026', '0054352318', 'Queen Mila Yuliarti S.Ked', 6, '2026-06-21 23:46:38', '2026-06-21 23:46:38'),
(27, '20260027', '0048993558', 'Bahuraksa Permadi', 6, '2026-06-21 23:46:38', '2026-06-21 23:46:38'),
(28, '20260028', '0059862333', 'Victoria Andriani S.I.Kom', 6, '2026-06-21 23:46:38', '2026-06-21 23:46:38'),
(29, '20260029', '0088605280', 'Pranawa Hidayat', 6, '2026-06-21 23:46:38', '2026-06-21 23:46:38'),
(30, '20260030', '0072409200', 'Edison Tamba', 6, '2026-06-21 23:46:38', '2026-06-21 23:46:38'),
(31, '20260031', '0059168496', 'Zulfa Nurdiyanti', 7, '2026-06-21 23:46:39', '2026-06-21 23:46:39'),
(32, '20260032', '0028162089', 'Nurul Sudiati', 7, '2026-06-21 23:46:39', '2026-06-21 23:46:39'),
(33, '20260033', '0065977362', 'Bagas Pratama S.Pt', 7, '2026-06-21 23:46:39', '2026-06-21 23:46:39'),
(34, '20260034', '0024334029', 'Titin Gawati Yolanda', 7, '2026-06-21 23:46:39', '2026-06-21 23:46:39'),
(35, '20260035', '0063456708', 'Keisha Hariyah S.Sos', 7, '2026-06-21 23:46:39', '2026-06-21 23:46:39'),
(36, '20260036', '0080975064', 'Jaiman Latupono S.T.', 8, '2026-06-21 23:46:40', '2026-06-21 23:46:40'),
(37, '20260037', '0051887803', 'Prasetya Sitorus M.Kom.', 8, '2026-06-21 23:46:40', '2026-06-21 23:46:40'),
(38, '20260038', '0077678099', 'Halim Catur Marbun', 8, '2026-06-21 23:46:40', '2026-06-21 23:46:40'),
(39, '20260039', '0024051643', 'Paramita Yessi Padmasari S.I.Kom', 8, '2026-06-21 23:46:40', '2026-06-21 23:46:40'),
(40, '20260040', '0035734544', 'Cemani Sirait', 8, '2026-06-21 23:46:41', '2026-06-21 23:46:41'),
(41, '20260041', '0015828003', 'Laila Usada', 9, '2026-06-21 23:46:41', '2026-06-21 23:46:41'),
(42, '20260042', '0062100396', 'Kardi Hutapea', 9, '2026-06-21 23:46:41', '2026-06-21 23:46:41'),
(43, '20260043', '0052841872', 'Elisa Salimah Padmasari S.T.', 9, '2026-06-21 23:46:41', '2026-06-21 23:46:41'),
(44, '20260044', '0050214441', 'Wirda Namaga', 9, '2026-06-21 23:46:41', '2026-06-21 23:46:41'),
(45, '20260045', '0026803064', 'Wulan Hassanah S.H.', 9, '2026-06-21 23:46:42', '2026-06-21 23:46:42'),
(46, '20260046', '0067068892', 'Kariman Jati Mandala', 10, '2026-06-21 23:46:42', '2026-06-21 23:46:42'),
(47, '20260047', '0051228009', 'Hani Yuniar M.M.', 10, '2026-06-21 23:46:42', '2026-06-21 23:46:42'),
(48, '20260048', '0061221246', 'Hairyanto Halim S.E.', 10, '2026-06-21 23:46:42', '2026-06-21 23:46:42'),
(49, '20260049', '0080304596', 'Teddy Pranata Thamrin M.Farm', 10, '2026-06-21 23:46:42', '2026-06-21 23:46:42'),
(50, '20260050', '0093136002', 'Elvina Iriana Pudjiastuti S.E.', 10, '2026-06-21 23:46:43', '2026-06-21 23:46:43'),
(51, '20260051', '0042775456', 'Sidiq Marpaung', 11, '2026-06-21 23:46:43', '2026-06-21 23:46:43'),
(52, '20260052', '0055307126', 'Farah Laras Hasanah S.H.', 11, '2026-06-21 23:46:43', '2026-06-21 23:46:43'),
(53, '20260053', '0003414204', 'Gaman Maheswara', 11, '2026-06-21 23:46:43', '2026-06-21 23:46:43'),
(54, '20260054', '0092823242', 'Hesti Wastuti', 11, '2026-06-21 23:46:44', '2026-06-21 23:46:44'),
(55, '20260055', '0019495809', 'Prasetya Sirait', 11, '2026-06-21 23:46:44', '2026-06-21 23:46:44'),
(56, '20260056', '0023508285', 'Purwa Kurnia Wijaya S.I.Kom', 12, '2026-06-21 23:46:44', '2026-06-21 23:46:44'),
(57, '20260057', '0065305863', 'Pardi Rosman Zulkarnain', 12, '2026-06-21 23:46:44', '2026-06-21 23:46:44'),
(58, '20260058', '0099385021', 'Teguh Usman Waskita S.T.', 12, '2026-06-21 23:46:44', '2026-06-21 23:46:44'),
(59, '20260059', '0014234761', 'Eko Pratama S.I.Kom', 12, '2026-06-21 23:46:45', '2026-06-21 23:46:45'),
(60, '20260060', '0080240722', 'Vega Sinaga', 12, '2026-06-21 23:46:45', '2026-06-21 23:46:45'),
(61, '20260061', '0000688977', 'Hilda Rika Puspasari S.Ked', 13, '2026-06-21 23:46:45', '2026-06-21 23:46:45'),
(62, '20260062', '0027313183', 'Sakura Hartati', 13, '2026-06-21 23:46:45', '2026-06-21 23:46:45'),
(63, '20260063', '0033045995', 'Bahuwarna Kurniawan', 13, '2026-06-21 23:46:45', '2026-06-21 23:46:45'),
(64, '20260064', '0009349324', 'Cakrabuana Budiman S.T.', 13, '2026-06-21 23:46:46', '2026-06-21 23:46:46'),
(65, '20260065', '0036746780', 'Halima Fathonah Melani S.Farm', 13, '2026-06-21 23:46:46', '2026-06-21 23:46:46'),
(66, '20260066', '0015440688', 'Emong Hutapea', 14, '2026-06-21 23:46:46', '2026-06-21 23:46:46'),
(67, '20260067', '0022465482', 'Mulya Gaman Mangunsong', 14, '2026-06-21 23:46:46', '2026-06-21 23:46:46'),
(68, '20260068', '0028184469', 'Ganep Hidayat', 14, '2026-06-21 23:46:46', '2026-06-21 23:46:46'),
(69, '20260069', '0015170225', 'Maya Puspasari', 14, '2026-06-21 23:46:47', '2026-06-21 23:46:47'),
(70, '20260070', '0003776630', 'Limar Latupono', 14, '2026-06-21 23:46:47', '2026-06-21 23:46:47'),
(71, '20260071', '0042155506', 'Joko Sabar Suwarno M.TI.', 15, '2026-06-21 23:46:47', '2026-06-21 23:46:47'),
(72, '20260072', '0021831401', 'Usyi Safitri', 15, '2026-06-21 23:46:47', '2026-06-21 23:46:47'),
(73, '20260073', '0042246568', 'Najwa Nasyidah', 15, '2026-06-21 23:46:47', '2026-06-21 23:46:47'),
(74, '20260074', '0024014337', 'Harsanto Prayogo Hutasoit M.M.', 15, '2026-06-21 23:46:48', '2026-06-21 23:46:48'),
(75, '20260075', '0031371304', 'Pandu Sirait', 15, '2026-06-21 23:46:48', '2026-06-21 23:46:48'),
(76, '20260076', '0077490639', 'Enteng Wijaya', 16, '2026-06-21 23:46:48', '2026-06-21 23:46:48'),
(77, '20260077', '0084178292', 'Puti Suryatmi', 16, '2026-06-21 23:46:48', '2026-06-21 23:46:48'),
(78, '20260078', '0039915181', 'Panca Kajen Nainggolan M.Kom.', 16, '2026-06-21 23:46:49', '2026-06-21 23:46:49'),
(79, '20260079', '0084041817', 'Umaya Nababan', 16, '2026-06-21 23:46:49', '2026-06-21 23:46:49'),
(80, '20260080', '0074514242', 'Natalia Rahayu', 16, '2026-06-21 23:46:49', '2026-06-21 23:46:49'),
(81, '20260081', '0005914787', 'Akarsana Maheswara S.Kom', 17, '2026-06-21 23:46:49', '2026-06-21 23:46:49'),
(82, '20260082', '0071233177', 'Ilsa Sudiati', 17, '2026-06-21 23:46:49', '2026-06-21 23:46:49'),
(83, '20260083', '0025401934', 'Qori Rahmawati', 17, '2026-06-21 23:46:50', '2026-06-21 23:46:50'),
(84, '20260084', '0053340198', 'Kamidin Sihotang', 17, '2026-06-21 23:46:50', '2026-06-21 23:46:50'),
(85, '20260085', '0032749034', 'Tirta Sihotang', 17, '2026-06-21 23:46:50', '2026-06-21 23:46:50'),
(86, '20260086', '0037878685', 'Cawisono Wira Permadi', 18, '2026-06-21 23:46:50', '2026-06-21 23:46:50'),
(87, '20260087', '0088579201', 'Kairav Among Hidayat', 18, '2026-06-21 23:46:50', '2026-06-21 23:46:50'),
(88, '20260088', '0059013982', 'Narji Nugroho M.Kom.', 18, '2026-06-21 23:46:51', '2026-06-21 23:46:51'),
(89, '20260089', '0049632586', 'Umay Umar Mangunsong S.E.I', 18, '2026-06-21 23:46:51', '2026-06-21 23:46:51'),
(90, '20260090', '0085327685', 'Narji Saputra', 18, '2026-06-21 23:46:51', '2026-06-21 23:46:51'),
(91, '20260091', '0087278676', 'Gara Prakasa', 19, '2026-06-21 23:46:51', '2026-06-21 23:46:51'),
(92, '20260092', '0002360589', 'Jaswadi Marpaung', 19, '2026-06-21 23:46:51', '2026-06-21 23:46:51'),
(93, '20260093', '0045938468', 'Lamar Saefullah', 19, '2026-06-21 23:46:52', '2026-06-21 23:46:52'),
(94, '20260094', '0058960467', 'Harjasa Suryono M.Kom.', 19, '2026-06-21 23:46:52', '2026-06-21 23:46:52'),
(95, '20260095', '0005080023', 'Oskar Wijaya S.IP', 19, '2026-06-21 23:46:52', '2026-06-21 23:46:52'),
(96, '20260096', '0038690110', 'Eko Pratama', 20, '2026-06-21 23:46:52', '2026-06-21 23:46:52'),
(97, '20260097', '0095559955', 'Vanya Raina Astuti', 20, '2026-06-21 23:46:52', '2026-06-21 23:46:52'),
(98, '20260098', '0079702541', 'Lurhur Maulana', 20, '2026-06-21 23:46:53', '2026-06-21 23:46:53'),
(99, '20260099', '0088982051', 'Lega Capa Mandala', 20, '2026-06-21 23:46:53', '2026-06-21 23:46:53'),
(100, '20260100', '0060832047', 'Zelaya Astuti', 20, '2026-06-21 23:46:53', '2026-06-21 23:46:53'),
(101, '20260101', '0027456845', 'Legawa Ramadan', 21, '2026-06-21 23:46:53', '2026-06-21 23:46:53'),
(102, '20260102', '0032710946', 'Edi Halim', 21, '2026-06-21 23:46:54', '2026-06-21 23:46:54'),
(103, '20260103', '0018941667', 'Elma Halimah', 21, '2026-06-21 23:46:54', '2026-06-21 23:46:54'),
(104, '20260104', '0029821005', 'Safina Mandasari', 21, '2026-06-21 23:46:54', '2026-06-21 23:46:54'),
(105, '20260105', '0046984080', 'Pandu Umar Napitupulu S.I.Kom', 21, '2026-06-21 23:46:54', '2026-06-21 23:46:54'),
(106, '20260106', '0021312875', 'Natalia Patricia Zulaika S.Farm', 22, '2026-06-21 23:46:54', '2026-06-21 23:46:54'),
(107, '20260107', '0039236176', 'Timbul Taswir Narpati', 22, '2026-06-21 23:46:55', '2026-06-21 23:46:55'),
(108, '20260108', '0064528074', 'Jumari Wijaya M.M.', 22, '2026-06-21 23:46:55', '2026-06-21 23:46:55'),
(109, '20260109', '0074641171', 'Wardi Sinaga S.IP', 22, '2026-06-21 23:46:55', '2026-06-21 23:46:55'),
(110, '20260110', '0054329172', 'Violet Kuswandari', 22, '2026-06-21 23:46:55', '2026-06-21 23:46:55'),
(111, '20260111', '0052464324', 'Sari Sudiati', 23, '2026-06-21 23:46:55', '2026-06-21 23:46:55'),
(112, '20260112', '0040705894', 'Melinda Hilda Haryanti', 23, '2026-06-21 23:46:56', '2026-06-21 23:46:56'),
(113, '20260113', '0091785097', 'Natalia Sadina Pudjiastuti', 23, '2026-06-21 23:46:56', '2026-06-21 23:46:56'),
(114, '20260114', '0011154196', 'Victoria Aryani S.H.', 23, '2026-06-21 23:46:56', '2026-06-21 23:46:56'),
(115, '20260115', '0099054177', 'Opung Dongoran', 23, '2026-06-21 23:46:56', '2026-06-21 23:46:56'),
(116, '20260116', '0031627786', 'Mahdi Caraka Kusumo', 24, '2026-06-21 23:46:57', '2026-06-21 23:46:57'),
(117, '20260117', '0006002964', 'Jane Yulianti', 24, '2026-06-21 23:46:57', '2026-06-21 23:46:57'),
(118, '20260118', '0074512786', 'Catur Malik Hakim S.Psi', 24, '2026-06-21 23:46:57', '2026-06-21 23:46:57'),
(119, '20260119', '0012343022', 'Purwanto Permadi', 24, '2026-06-21 23:46:57', '2026-06-21 23:46:57'),
(120, '20260120', '0026323688', 'Sari Indah Kusmawati S.Sos', 24, '2026-06-21 23:46:57', '2026-06-21 23:46:57'),
(121, '20260121', '0077563957', 'Lasmanto Budiman', 25, '2026-06-21 23:46:58', '2026-06-21 23:46:58'),
(122, '20260122', '0095742848', 'Irnanto Suwarno S.E.I', 25, '2026-06-21 23:46:58', '2026-06-21 23:46:58'),
(123, '20260123', '0065858572', 'Laras Maria Mayasari S.T.', 25, '2026-06-21 23:46:58', '2026-06-21 23:46:58'),
(124, '20260124', '0094313869', 'Lantar Hutapea S.I.Kom', 25, '2026-06-21 23:46:58', '2026-06-21 23:46:58'),
(125, '20260125', '0080932057', 'Mahmud Cawuk Jailani', 25, '2026-06-21 23:46:58', '2026-06-21 23:46:58'),
(126, '20260126', '0066443264', 'Rachel Palastri', 26, '2026-06-21 23:46:59', '2026-06-21 23:46:59'),
(127, '20260127', '0083107953', 'Yani Ika Fujiati', 26, '2026-06-21 23:46:59', '2026-06-21 23:46:59'),
(128, '20260128', '0089972582', 'Eka Jinawi Santoso', 26, '2026-06-21 23:46:59', '2026-06-21 23:46:59'),
(129, '20260129', '0008480733', 'Jefri Hidayat', 26, '2026-06-21 23:46:59', '2026-06-21 23:46:59'),
(130, '20260130', '0077758207', 'Cakrawangsa Mandala', 26, '2026-06-21 23:46:59', '2026-06-21 23:46:59'),
(131, '20260131', '0020153775', 'Mutia Raina Puspasari S.Sos', 27, '2026-06-21 23:47:00', '2026-06-21 23:47:00'),
(132, '20260132', '0004444743', 'Rahmi Elma Aryani', 27, '2026-06-21 23:47:00', '2026-06-21 23:47:00'),
(133, '20260133', '0020326782', 'Vivi Mayasari S.Sos', 27, '2026-06-21 23:47:00', '2026-06-21 23:47:00'),
(134, '20260134', '0026742621', 'Cornelia Agustina', 27, '2026-06-21 23:47:00', '2026-06-21 23:47:00'),
(135, '20260135', '0082579041', 'Emin Simbolon', 27, '2026-06-21 23:47:00', '2026-06-21 23:47:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `student_answers`
--

CREATE TABLE `student_answers` (
  `id_answer` bigint(20) UNSIGNED NOT NULL,
  `id_exam` bigint(20) UNSIGNED NOT NULL,
  `id_siswa` bigint(20) UNSIGNED NOT NULL,
  `id_question` bigint(20) UNSIGNED NOT NULL,
  `jawaban_siswa` enum('A','B','C','D','E') DEFAULT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `student_grades`
--

CREATE TABLE `student_grades` (
  `id_grade` bigint(20) UNSIGNED NOT NULL,
  `id_siswa` bigint(20) UNSIGNED NOT NULL,
  `id_tp` bigint(20) UNSIGNED NOT NULL,
  `nilai` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `subjects`
--

CREATE TABLE `subjects` (
  `id_mapel` bigint(20) UNSIGNED NOT NULL,
  `nama_mapel` varchar(255) NOT NULL,
  `kategori_mapel` varchar(255) NOT NULL,
  `tingkat` varchar(255) DEFAULT NULL,
  `jurusan` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `subjects`
--

INSERT INTO `subjects` (`id_mapel`, `nama_mapel`, `kategori_mapel`, `tingkat`, `jurusan`, `created_at`, `updated_at`) VALUES
(1, 'Adm Pajak', 'Kelompok C (Peminatan) - Paket Keahlian Akuntansi', NULL, 'AK', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(2, 'Adm Sistem Jaringan', 'Kelompok C (Peminatan) - Paket Keahlian Teknik Komputer dan Jaringan', NULL, 'TKJ', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(3, 'Administrasi Infrastruktur Jaringan', 'Kelompok C (Peminatan) - Paket Keahlian Teknik Komputer dan Jaringan', 'XII', 'TKJ', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(4, 'Administrasi Umum', 'Dasar Program Keahlian - Paket Keahlian Administrasi Perkantoran', 'X', 'OTKP', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(5, 'AK Keuangan', 'Kelompok C (Peminatan) - Paket Keahlian Akuntansi', NULL, 'AK', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(6, 'AK Lembaga', 'Kelompok C (Peminatan) - Paket Keahlian Akuntansi', NULL, 'AK', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(7, 'AK Manufaktur', 'Kelompok C (Peminatan) - Paket Keahlian Akuntansi', NULL, 'AK', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(8, 'Akuntansi Dasar', 'Dasar Program Keahlian - Paket Keahlian Akuntansi', 'X', 'AK', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(9, 'Aplikasi Pengolah Angka / Spreadsheet', 'Dasar Program Keahlian - Paket Keahlian Akuntansi', 'X', 'AK', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(10, 'Bahasa Indonesia', 'Mata Pelajaran Umum', NULL, NULL, '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(11, 'Bahasa Inggris', 'Mata Pelajaran Kejuruan', NULL, NULL, '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(12, 'Bisnis Teknologi Informasi', 'Dasar Program Keahlian - Paket Keahlian Teknik Komputer dan Jaringan', 'X', 'TKJ', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(13, 'Dasar Jaringan Komputer', 'Dasar Program Keahlian - Paket Keahlian Teknik Komputer dan Jaringan', 'X', 'TKJ', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(14, 'Ekonomi Bisnis', 'Kelompok C (Peminatan) - Paket Keahlian Akuntansi', 'XI', 'AK', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(15, 'Etika Profesi', 'Dasar Program Keahlian - Paket Keahlian Akuntansi', 'X', 'AK', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(16, 'Gambar Teknik', 'Dasar Program Keahlian - Paket Keahlian Teknik Kend. Ringan dan Teknik Sepeda Motor', 'X', NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(17, 'Informatika', 'Mata Pelajaran Kejuruan', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(18, 'IPAS', 'Mata Pelajaran Kejuruan', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(19, 'K3LH', 'Dasar Program Keahlian - Paket Keahlian Teknik Kend. Ringan dan Teknik Sepeda Motor', 'X', NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(20, 'Kearsipan', 'Kelompok C (Peminatan) - Paket Keahlian Administrasi Perkantoran', 'XI', 'OTKP', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(21, 'Kelistrikan Kendaraan Ringan', 'PRODUKTIF', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(22, 'Kelistrikan Sepeda Motor', 'PRODUKTIF', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(23, 'KKA / Coding', 'PRODUKTIF', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(24, 'Komputer Akuntansi', 'Kelompok C (Peminatan) - Paket Keahlian Akuntansi', NULL, 'AK', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(25, 'Korespondensi', 'Dasar Program Keahlian - Paket Keahlian Administrasi Perkantoran', 'X', 'OTKP', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(26, 'Main. Mesin Kendaraan', 'PRODUKTIF', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(27, 'Main. Mesin Sepeda Motor', 'Kelompok C (Peminatan) - Paket Keahlian Teknik dan Bisnis Sepeda Motor', NULL, 'TSM', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(28, 'Main. Sasis Kendaraan', 'Kelompok C (Peminatan) - Paket Keahlian Teknik Kendaraan Ringan', NULL, 'TKR', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(29, 'Main. Sasis Sepeda Motor', 'Kelompok C (Peminatan) - Paket Keahlian Teknik dan Bisnis Sepeda Motor', NULL, 'TSM', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(30, 'Matematika', 'Mata Pelajaran Kejuruan', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(31, 'OTK Humas (X)', 'Dasar Program Keahlian - Paket Keahlian Administrasi Perkantoran', 'X', 'OTKP', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(32, 'OTK Humas (XI)', 'Kelompok C (Peminatan) - Paket Keahlian Administrasi Perkantoran', 'XI', 'OTKP', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(33, 'OTK Humas (XII)', 'Kelompok C (Peminatan) - Paket Keahlian Administrasi Perkantoran', 'XII', 'OTKP', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(34, 'OTK Kepegawaian (XI)', 'Kelompok C (Peminatan) - Paket Keahlian Administrasi Perkantoran', 'XI', 'OTKP', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(35, 'OTK Kepegawaian (XII)', 'Kelompok C (Peminatan) - Paket Keahlian Administrasi Perkantoran', 'XII', 'OTKP', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(36, 'OTK Keuangan (XI)', 'Kelompok C (Peminatan) - Paket Keahlian Administrasi Perkantoran', 'XI', 'OTKP', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(37, 'OTK Keuangan (XII)', 'Kelompok C (Peminatan) - Paket Keahlian Administrasi Perkantoran', 'XII', 'OTKP', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(38, 'OTK Sarpras (XI)', 'Kelompok C (Peminatan) - Paket Keahlian Administrasi Perkantoran', 'XI', 'OTKP', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(39, 'OTK Sarpras (XII)', 'Kelompok C (Peminatan) - Paket Keahlian Administrasi Perkantoran', 'XII', 'OTKP', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(40, 'PDTO', 'Dasar Program Keahlian - Paket Keahlian Teknik Kend. Ringan dan Teknik Sepeda Motor', 'X', NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(41, 'Pemeliharaan Mesin Kendaraan Ringan', 'Kelompok C (Peminatan) - Paket Keahlian Teknik Kendaraan Ringan', NULL, 'TKR', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(42, 'Pendidikan Agama dan Budi Pekerti', 'Mata Pelajaran Umum', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(43, 'Penjasorkes', 'Mata Pelajaran Umum', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(44, 'Perbankan Dasar', 'Dasar Program Keahlian - Paket Keahlian Akuntansi', 'X', 'AK', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(45, 'PKK', 'Kelompok C (Peminatan) - Paket Keahlian Teknik dan Bisnis Sepeda Motor', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(46, 'PPKn', 'Mata Pelajaran Umum', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(47, 'Sejarah Indonesia', 'Mata Pelajaran Umum', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(48, 'Seni Budaya', 'Mata Pelajaran Umum', NULL, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(49, 'TDO', 'Dasar Program Keahlian - Paket Keahlian Teknik Kend. Ringan dan Teknik Sepeda Motor', 'X', NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(50, 'Tek Insfrs Jaringan', 'Kelompok C (Peminatan) - Paket Keahlian Teknik Komputer dan Jaringan', 'XI', 'TKJ', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(51, 'Tek Layanan Jaringan', 'Kelompok C (Peminatan) - Paket Keahlian Teknik Komputer dan Jaringan', NULL, 'TKJ', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(52, 'Teknologi Jaringan Komputer', 'Dasar Program Keahlian - Paket Keahlian Teknik Komputer dan Jaringan', 'X', 'TKJ', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(53, 'Teknologi Perkantoran', 'Dasar Program Keahlian - Paket Keahlian Administrasi Perkantoran', 'X', 'OTKP', '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(54, 'Wide Area Network (WAN)', 'Kelompok C (Peminatan) - Paket Keahlian Teknik Komputer dan Jaringan', NULL, 'TKJ', '2026-06-22 07:58:13', '2026-06-22 07:58:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `teachers`
--

CREATE TABLE `teachers` (
  `id_guru` bigint(20) UNSIGNED NOT NULL,
  `nama_guru` varchar(255) NOT NULL,
  `kode_guru` int(11) NOT NULL,
  `hari_tersedia` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`hari_tersedia`)),
  `shift_pagi` tinyint(1) NOT NULL DEFAULT 1,
  `shift_siang` tinyint(1) NOT NULL DEFAULT 1,
  `hari_tersedia_pagi` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`hari_tersedia_pagi`)),
  `hari_tersedia_siang` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`hari_tersedia_siang`)),
  `min_jp` int(11) NOT NULL DEFAULT 2,
  `max_jp` int(11) NOT NULL DEFAULT 60,
  `allowed_jp_pagi` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`allowed_jp_pagi`)),
  `allowed_jp_siang` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`allowed_jp_siang`)),
  `no_wa` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `teachers`
--

INSERT INTO `teachers` (`id_guru`, `nama_guru`, `kode_guru`, `hari_tersedia`, `shift_pagi`, `shift_siang`, `hari_tersedia_pagi`, `hari_tersedia_siang`, `min_jp`, `max_jp`, `allowed_jp_pagi`, `allowed_jp_siang`, `no_wa`, `created_at`, `updated_at`) VALUES
(1, 'AGUNG AINUL HAKIM, S.Pd', 25, '[\"SENIN\",\"SELASA\",\"KAMIS\",\"JUMAT\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"KAMIS\",\"JUMAT\"]', '[\"SENIN\",\"SELASA\",\"KAMIS\",\"JUMAT\"]', 3, 60, NULL, NULL, '08123456725', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(2, 'AHMAD HUSEN NASUTION, SS', 5, '[\"SENIN\",\"KAMIS\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"KAMIS\",\"SABTU\"]', '[\"SENIN\",\"KAMIS\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456705', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(3, 'ARIEF AKBAR FATAHIILLAH', 24, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456724', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(4, 'ASTRI WULANDARI, S.Ak', 23, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', 3, 70, NULL, NULL, '08123456723', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(5, 'CATUR WULANDARI, A.Md', 30, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 3, 60, '{\"SENIN\":[4,5,6,7],\"SELASA\":[4,5,6,7],\"RABU\":[4,5,6,7],\"KAMIS\":[4,5,6,7],\"JUMAT\":[4,5,6,7]}', NULL, '08123456730', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(6, 'CHRISTIN SIREGAR, S.Pd', 17, '[\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', 1, 1, '[\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', '[\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', 2, 60, NULL, NULL, '08123456717', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(7, 'DEDE HIDAYATULLAH', 15, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 2, 80, NULL, NULL, '08123456715', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(8, 'DELA AMELIA PUTRI, S.Pd', 35, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', 3, 60, NULL, NULL, '08123456735', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(9, 'DERA ISMAWATI, A.Md', 8, '[\"SELASA\",\"RABU\"]', 1, 1, '[\"SELASA\",\"RABU\"]', '[\"SELASA\",\"RABU\"]', 3, 60, NULL, NULL, '08123456708', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(10, 'DRA. SRI CHANDRI YANI', 20, '[\"KAMIS\",\"JUMAT\"]', 1, 1, '[\"KAMIS\",\"JUMAT\"]', '[\"KAMIS\",\"JUMAT\"]', 3, 20, NULL, NULL, '08123456720', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(11, 'DWIANA RIKASARI, S.AP', 31, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456731', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(12, 'ENDANG KURNIAWAN, S.T', 37, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456737', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(13, 'EUIS SUPRIHATIN, S.Pd', 11, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 3, 60, NULL, NULL, '08123456711', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(14, 'FITRI MULYANI, S.Pd', 7, '[\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', 1, 1, '[\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', '[\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', 3, 52, NULL, NULL, '08123456707', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(15, 'IDAYATUL MUSTAFIDAH, S.E', 32, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456732', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(16, 'KOKO, S.T', 16, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456716', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(17, 'KUAT SUPARTO, S.T', 22, '[\"SENIN\",\"SELASA\",\"RABU\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456722', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(18, 'LUTHFI AHMAD NAZHIF, S.Pd', 13, '[\"JUMAT\",\"KAMIS\"]', 1, 1, '[\"JUMAT\"]', '[\"KAMIS\",\"JUMAT\"]', 2, 60, NULL, NULL, '08123456713', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(19, 'MUHAMMAD ALBAR SAPIN, S.M', 27, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456727', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(20, 'MUHAMMAD ANDIKA PRAWIRA, S.Kom', 19, '[\"SENIN\",\"RABU\",\"JUMAT\"]', 1, 1, '[\"SENIN\",\"RABU\",\"JUMAT\"]', '[\"SENIN\",\"RABU\",\"JUMAT\"]', 2, 60, NULL, NULL, '08123456719', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(21, 'MUHAMMAD SYAFE\'I, S.Pd', 18, '[\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SENIN\",\"SABTU\"]', 1, 1, '[\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 3, 60, NULL, NULL, '08123456718', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(22, 'OKTARI QOMIMIS SYATUN, S.Pd', 29, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 3, 50, NULL, NULL, '08123456729', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(23, 'REZA PATRIOTA PUTRA, S.Kom', 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 2, 60, NULL, NULL, NULL, '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(24, 'RISKA AMELIA, S.M', 33, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456733', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(25, 'SAMSUL HUDA, S.Pd', 4, '[\"SELASA\",\"RABU\"]', 1, 1, '[\"SELASA\",\"RABU\"]', '[\"SELASA\",\"RABU\"]', 2, 30, NULL, NULL, '08123456704', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(26, 'SISTER NINDA PUTRI, S.Pd', 34, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 3, 60, NULL, NULL, '08123456734', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(27, 'SRI TITA MULYATI', 10, '[\"SENIN\",\"SELASA\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"JUMAT\",\"SABTU\"]', 2, 42, NULL, NULL, '08123456710', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(28, 'SUHARNO, S.Pdi', 3, '[\"SELASA\"]', 1, 1, '[\"SELASA\"]', '[\"SELASA\"]', 2, 30, NULL, NULL, '08123456703', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(29, 'SUTRISNO', 26, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 3, 40, NULL, NULL, '08123456726', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(30, 'TAMAN SASTRA DIKARNA, S.Pd', 2, '[\"SENIN\",\"RABU\",\"KAMIS\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"RABU\",\"KAMIS\",\"SABTU\"]', '[\"SENIN\",\"RABU\",\"KAMIS\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456702', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(31, 'TIARA SHANTI HARTONO, S.Sos', 28, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456728', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(32, 'WIDA HARTANI, S.Pd', 12, '[\"SABTU\",\"JUMAT\"]', 1, 1, '[\"SABTU\"]', '[\"JUMAT\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456712', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(33, 'WIDJAYANTI, S.Sos', 14, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 3, 60, NULL, NULL, '08123456714', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(34, 'WIDONI SANTOSO, S.Pd', 9, '[\"SENIN\",\"RABU\",\"KAMIS\"]', 1, 1, '[\"SENIN\",\"RABU\",\"KAMIS\"]', '[\"SENIN\",\"RABU\",\"KAMIS\"]', 2, 60, NULL, NULL, '08123456709', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(35, 'WISNU NARA UTAMA, S.Pd', 6, '[\"SELASA\",\"KAMIS\",\"SABTU\"]', 1, 1, '[\"SELASA\",\"KAMIS\",\"SABTU\"]', '[\"SELASA\",\"KAMIS\",\"SABTU\"]', 3, 35, NULL, NULL, '08123456706', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(36, 'WIWIK UMAYAH, S.Pd', 36, '[\"SELASA\",\"RABU\",\"KAMIS\"]', 1, 1, '[\"SELASA\",\"RABU\",\"KAMIS\"]', '[\"SELASA\",\"RABU\",\"KAMIS\"]', 3, 50, NULL, NULL, '08123456736', '2026-06-22 07:58:12', '2026-06-22 07:58:12'),
(37, 'YULISTIO HARDIYANTO, S.T', 21, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 1, 1, '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', '[\"SENIN\",\"SELASA\",\"RABU\",\"KAMIS\",\"JUMAT\",\"SABTU\"]', 2, 60, NULL, NULL, '08123456721', '2026-06-22 07:58:12', '2026-06-22 07:58:12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `teacher_subjects`
--

CREATE TABLE `teacher_subjects` (
  `id_teacher_subject` bigint(20) UNSIGNED NOT NULL,
  `id_guru` bigint(20) UNSIGNED NOT NULL,
  `id_mapel` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `teacher_subjects`
--

INSERT INTO `teacher_subjects` (`id_teacher_subject`, `id_guru`, `id_mapel`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(2, 1, 13, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(3, 1, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(4, 1, 50, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(5, 1, 51, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(6, 1, 54, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(7, 2, 46, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(8, 3, 42, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(9, 4, 5, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(10, 4, 9, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(11, 4, 10, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(12, 5, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(13, 5, 18, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(14, 6, 11, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(15, 7, 30, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(16, 8, 30, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(17, 9, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(18, 9, 25, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(19, 9, 31, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(20, 9, 32, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(21, 9, 33, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(22, 9, 35, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(23, 9, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(24, 9, 39, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(25, 10, 47, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(26, 11, 46, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(27, 12, 19, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(28, 12, 26, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(29, 12, 28, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(30, 12, 40, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(31, 12, 41, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(32, 12, 49, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(33, 13, 15, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(34, 13, 44, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(35, 13, 45, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(36, 13, 47, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(37, 14, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(38, 14, 5, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(39, 14, 6, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(40, 14, 7, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(41, 14, 8, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(42, 14, 9, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(43, 14, 14, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(44, 14, 36, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(45, 14, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(46, 15, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(47, 15, 5, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(48, 15, 6, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(49, 15, 9, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(50, 15, 24, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(51, 15, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(52, 16, 22, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(53, 16, 27, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(54, 16, 29, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(55, 16, 40, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(56, 16, 49, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(57, 17, 16, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(58, 17, 19, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(59, 17, 40, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(60, 17, 49, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(61, 18, 10, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(62, 19, 4, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(63, 19, 20, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(64, 19, 31, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(65, 19, 32, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(66, 19, 35, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(67, 19, 37, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(68, 19, 38, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(69, 19, 39, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(70, 19, 53, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(71, 20, 2, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(72, 20, 3, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(73, 20, 23, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(74, 20, 50, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(75, 20, 51, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(76, 21, 42, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(77, 22, 46, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(78, 22, 47, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(79, 24, 48, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(80, 25, 30, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(81, 26, 11, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(82, 27, 43, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(83, 28, 43, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(84, 29, 12, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(85, 29, 17, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(86, 29, 51, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(87, 29, 52, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(88, 29, 54, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(89, 30, 30, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(90, 31, 11, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(91, 32, 46, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(92, 33, 1, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(93, 33, 34, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(94, 34, 43, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(95, 35, 45, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(96, 36, 10, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(97, 37, 21, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(98, 37, 26, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(99, 37, 28, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(100, 37, 40, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(101, 37, 41, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(102, 37, 49, '2026-06-22 07:58:13', '2026-06-22 07:58:13');

-- --------------------------------------------------------

--
-- Struktur dari tabel `timetable`
--

CREATE TABLE `timetable` (
  `id_timetable` bigint(20) UNSIGNED NOT NULL,
  `id_class_subject` bigint(20) UNSIGNED NOT NULL,
  `hari` varchar(255) NOT NULL,
  `jam_ke` int(11) NOT NULL,
  `id_guru` bigint(20) UNSIGNED DEFAULT NULL,
  `is_fallback` tinyint(1) NOT NULL DEFAULT 0,
  `original_guru_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `timetable`
--

INSERT INTO `timetable` (`id_timetable`, `id_class_subject`, `hari`, `jam_ke`, `id_guru`, `is_fallback`, `original_guru_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'JUMAT', 1, 14, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(2, 13, 'JUMAT', 2, 13, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(3, 13, 'JUMAT', 3, 13, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(4, 15, 'JUMAT', 4, 13, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(5, 11, 'JUMAT', 5, 3, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(6, 11, 'JUMAT', 6, 3, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(7, 3, 'KAMIS', 1, 36, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(8, 3, 'KAMIS', 2, 36, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(9, 3, 'KAMIS', 3, 36, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(10, 4, 'KAMIS', 4, 26, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(11, 4, 'KAMIS', 5, 26, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(12, 4, 'KAMIS', 6, 26, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(13, 4, 'KAMIS', 7, 26, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(14, 6, 'RABU', 1, 29, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(15, 6, 'RABU', 2, 29, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(16, 6, 'RABU', 3, 29, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(17, 2, 'RABU', 4, 4, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(18, 2, 'RABU', 5, 4, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(19, 10, 'RABU', 6, 8, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(20, 10, 'RABU', 7, 8, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(21, 7, 'SABTU', 1, 5, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(22, 7, 'SABTU', 2, 5, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(23, 15, 'SABTU', 3, 13, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(24, 14, 'SABTU', 4, 22, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(25, 14, 'SABTU', 5, 22, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(26, 8, 'SABTU', 6, 17, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(27, 8, 'SABTU', 7, 17, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(28, 1, 'SELASA', 1, 14, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(29, 1, 'SELASA', 2, 14, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(30, 12, 'SELASA', 3, 27, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(31, 12, 'SELASA', 4, 27, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(32, 10, 'SELASA', 5, 8, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(33, 10, 'SELASA', 6, 8, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(34, 10, 'SELASA', 7, 8, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(35, 5, 'SENIN', 2, 13, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(36, 5, 'SENIN', 3, 13, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(37, 16, 'SENIN', 4, 24, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(38, 16, 'SENIN', 5, 24, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(39, 9, 'SENIN', 6, 15, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(40, 9, 'SENIN', 7, 15, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(41, 29, 'JUMAT', 1, 10, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(42, 29, 'JUMAT', 2, 10, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(43, 28, 'JUMAT', 3, 11, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(44, 28, 'JUMAT', 4, 11, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(45, 31, 'JUMAT', 5, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(46, 31, 'JUMAT', 6, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(47, 17, 'KAMIS', 1, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(48, 17, 'KAMIS', 2, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(49, 27, 'KAMIS', 3, 34, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(50, 27, 'KAMIS', 4, 34, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(51, 18, 'KAMIS', 5, 4, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(52, 18, 'KAMIS', 6, 4, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(53, 18, 'KAMIS', 7, 4, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(54, 23, 'RABU', 1, 9, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(55, 23, 'RABU', 2, 9, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(56, 23, 'RABU', 3, 9, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(57, 30, 'RABU', 4, 24, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(58, 30, 'RABU', 5, 24, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(59, 25, 'RABU', 6, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(60, 25, 'RABU', 7, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(61, 19, 'SABTU', 1, 26, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(62, 19, 'SABTU', 2, 26, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(63, 19, 'SABTU', 3, 26, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(64, 31, 'SABTU', 4, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(65, 20, 'SABTU', 5, 29, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(66, 20, 'SABTU', 6, 29, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(67, 20, 'SABTU', 7, 29, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(68, 25, 'SELASA', 1, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(69, 22, 'SELASA', 2, 17, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(70, 22, 'SELASA', 3, 17, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(71, 26, 'SELASA', 4, 21, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(72, 26, 'SELASA', 5, 21, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(73, 21, 'SELASA', 6, 5, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(74, 21, 'SELASA', 7, 5, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(75, 19, 'SENIN', 2, 26, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(76, 24, 'SENIN', 3, 8, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(77, 24, 'SENIN', 4, 8, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(78, 24, 'SENIN', 5, 8, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(79, 24, 'SENIN', 6, 8, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(80, 24, 'SENIN', 7, 8, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(81, 44, 'JUMAT', 1, 13, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(82, 32, 'JUMAT', 2, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(83, 32, 'JUMAT', 3, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(84, 40, 'JUMAT', 4, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(85, 40, 'JUMAT', 5, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(86, 40, 'JUMAT', 6, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(87, 42, 'KAMIS', 1, 34, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(88, 42, 'KAMIS', 2, 34, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(89, 33, 'KAMIS', 3, 36, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(90, 33, 'KAMIS', 4, 36, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(91, 34, 'KAMIS', 5, 26, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(92, 34, 'KAMIS', 6, 26, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(93, 34, 'KAMIS', 7, 26, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(94, 38, 'RABU', 1, 9, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(95, 38, 'RABU', 2, 9, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(96, 38, 'RABU', 3, 9, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(97, 44, 'RABU', 4, 13, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(98, 39, 'RABU', 5, 7, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(99, 39, 'RABU', 6, 7, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(100, 33, 'RABU', 7, 36, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(101, 34, 'SABTU', 1, 26, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(102, 35, 'SABTU', 2, 29, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(103, 35, 'SABTU', 3, 29, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(104, 35, 'SABTU', 4, 29, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(105, 41, 'SABTU', 5, 3, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(106, 41, 'SABTU', 6, 3, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(107, 46, 'SELASA', 1, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(108, 46, 'SELASA', 2, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(109, 46, 'SELASA', 3, 19, 0, NULL, '2026-06-22 07:58:13', '2026-06-22 07:58:13'),
(110, 37, 'SELASA', 4, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(111, 39, 'SELASA', 5, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(112, 39, 'SELASA', 6, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(113, 39, 'SELASA', 7, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(114, 43, 'SENIN', 1, 11, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(115, 43, 'SENIN', 2, 11, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(116, 36, 'SENIN', 3, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(117, 36, 'SENIN', 4, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(118, 37, 'SENIN', 5, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(119, 45, 'SENIN', 6, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(120, 45, 'SENIN', 7, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(121, 55, 'JUMAT', 1, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(122, 55, 'JUMAT', 2, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(123, 51, 'JUMAT', 3, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(124, 51, 'JUMAT', 4, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(125, 49, 'JUMAT', 5, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(126, 49, 'JUMAT', 6, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(127, 53, 'KAMIS', 1, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(128, 50, 'KAMIS', 2, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(129, 50, 'KAMIS', 3, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(130, 50, 'KAMIS', 4, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(131, 50, 'KAMIS', 5, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(132, 53, 'KAMIS', 6, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(133, 53, 'KAMIS', 7, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(134, 47, 'RABU', 1, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(135, 48, 'RABU', 2, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(136, 48, 'RABU', 3, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(137, 48, 'RABU', 4, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(138, 48, 'RABU', 5, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(139, 47, 'RABU', 6, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(140, 60, 'RABU', 7, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(141, 56, 'SABTU', 1, 27, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(142, 56, 'SABTU', 2, 27, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(143, 60, 'SABTU', 3, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(144, 60, 'SABTU', 4, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(145, 57, 'SABTU', 5, 2, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(146, 52, 'SABTU', 6, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(147, 52, 'SABTU', 7, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(148, 59, 'SELASA', 1, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(149, 59, 'SELASA', 2, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(150, 54, 'SELASA', 3, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(151, 54, 'SELASA', 4, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(152, 54, 'SELASA', 5, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(153, 54, 'SELASA', 6, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(154, 54, 'SELASA', 7, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(155, 58, 'SENIN', 2, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(156, 58, 'SENIN', 3, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(157, 57, 'SENIN', 4, 2, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(158, 49, 'SENIN', 5, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(159, 47, 'SENIN', 6, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(160, 51, 'SENIN', 7, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(161, 62, 'JUMAT', 1, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(162, 63, 'JUMAT', 2, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(163, 63, 'JUMAT', 3, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(164, 63, 'JUMAT', 4, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(165, 64, 'JUMAT', 5, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(166, 64, 'JUMAT', 6, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(167, 68, 'KAMIS', 1, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(168, 68, 'KAMIS', 2, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(169, 68, 'KAMIS', 3, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(170, 64, 'KAMIS', 4, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(171, 74, 'KAMIS', 5, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(172, 74, 'KAMIS', 6, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(173, 74, 'KAMIS', 7, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(174, 65, 'RABU', 1, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(175, 65, 'RABU', 2, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(176, 65, 'RABU', 3, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(177, 68, 'RABU', 4, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(178, 69, 'RABU', 5, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(179, 69, 'RABU', 6, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(180, 66, 'RABU', 7, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(181, 66, 'SABTU', 1, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(182, 70, 'SABTU', 2, 27, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(183, 70, 'SABTU', 3, 27, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(184, 72, 'SABTU', 4, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(185, 72, 'SABTU', 5, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(186, 62, 'SABTU', 6, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(187, 67, 'SELASA', 1, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(188, 67, 'SELASA', 2, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(189, 67, 'SELASA', 3, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(190, 64, 'SELASA', 4, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(191, 61, 'SELASA', 5, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(192, 61, 'SELASA', 6, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(193, 61, 'SELASA', 7, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(194, 62, 'SENIN', 1, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(195, 62, 'SENIN', 2, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(196, 73, 'SENIN', 3, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(197, 73, 'SENIN', 4, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(198, 71, 'SENIN', 5, 11, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(199, 71, 'SENIN', 6, 11, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(200, 68, 'SENIN', 7, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(201, 86, 'JUMAT', 1, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(202, 86, 'JUMAT', 2, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(203, 83, 'JUMAT', 3, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(204, 81, 'JUMAT', 4, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(205, 81, 'JUMAT', 5, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(206, 75, 'JUMAT', 6, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(207, 75, 'KAMIS', 1, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(208, 75, 'KAMIS', 2, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(209, 87, 'KAMIS', 3, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(210, 85, 'KAMIS', 4, 11, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(211, 85, 'KAMIS', 5, 11, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(212, 79, 'KAMIS', 6, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(213, 79, 'KAMIS', 7, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(214, 76, 'RABU', 1, 31, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(215, 76, 'RABU', 2, 31, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(216, 84, 'RABU', 3, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(217, 84, 'RABU', 4, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(218, 77, 'RABU', 5, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(219, 77, 'RABU', 6, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(220, 77, 'RABU', 7, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(221, 82, 'SABTU', 1, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(222, 83, 'SABTU', 2, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(223, 88, 'SABTU', 3, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(224, 88, 'SABTU', 4, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(225, 88, 'SABTU', 5, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(226, 76, 'SABTU', 6, 31, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(227, 76, 'SABTU', 7, 31, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(228, 80, 'SELASA', 1, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(229, 78, 'SELASA', 2, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(230, 78, 'SELASA', 3, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(231, 81, 'SELASA', 4, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(232, 81, 'SELASA', 5, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(233, 81, 'SELASA', 6, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(234, 88, 'SELASA', 7, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(235, 87, 'SENIN', 2, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(236, 78, 'SENIN', 3, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(237, 80, 'SENIN', 4, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(238, 82, 'SENIN', 5, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(239, 82, 'SENIN', 6, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(240, 82, 'SENIN', 7, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(241, 95, 'JUMAT', 1, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(242, 95, 'JUMAT', 2, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(243, 95, 'JUMAT', 3, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(244, 95, 'JUMAT', 4, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(245, 95, 'JUMAT', 5, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(246, 89, 'JUMAT', 6, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(247, 89, 'KAMIS', 1, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(248, 92, 'KAMIS', 2, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(249, 92, 'KAMIS', 3, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(250, 89, 'KAMIS', 4, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(251, 96, 'KAMIS', 5, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(252, 96, 'KAMIS', 6, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(253, 96, 'KAMIS', 7, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(254, 94, 'RABU', 1, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(255, 94, 'RABU', 2, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(256, 99, 'RABU', 3, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(257, 99, 'RABU', 4, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(258, 98, 'RABU', 5, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(259, 98, 'RABU', 6, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(260, 100, 'RABU', 7, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(261, 100, 'SABTU', 1, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(262, 101, 'SABTU', 2, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(263, 101, 'SABTU', 3, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(264, 102, 'SABTU', 4, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(265, 102, 'SABTU', 5, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(266, 102, 'SABTU', 6, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(267, 97, 'SELASA', 1, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(268, 97, 'SELASA', 2, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(269, 93, 'SELASA', 3, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(270, 93, 'SELASA', 4, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(271, 91, 'SELASA', 5, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(272, 92, 'SELASA', 6, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(273, 96, 'SELASA', 7, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(274, 91, 'SENIN', 1, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(275, 91, 'SENIN', 2, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(276, 90, 'SENIN', 3, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(277, 90, 'SENIN', 4, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(278, 90, 'SENIN', 5, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(279, 90, 'SENIN', 6, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(280, 102, 'SENIN', 7, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(281, 104, 'JUMAT', 1, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(282, 104, 'JUMAT', 2, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(283, 103, 'JUMAT', 3, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(284, 103, 'JUMAT', 4, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(285, 103, 'JUMAT', 5, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(286, 106, 'JUMAT', 6, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(287, 115, 'KAMIS', 1, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(288, 115, 'KAMIS', 2, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(289, 116, 'KAMIS', 3, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(290, 116, 'KAMIS', 4, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(291, 114, 'KAMIS', 5, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(292, 114, 'KAMIS', 6, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(293, 106, 'KAMIS', 7, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(294, 111, 'RABU', 1, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(295, 111, 'RABU', 2, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(296, 105, 'RABU', 3, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(297, 109, 'RABU', 4, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(298, 109, 'RABU', 5, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(299, 109, 'RABU', 6, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(300, 109, 'RABU', 7, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(301, 105, 'SABTU', 1, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(302, 105, 'SABTU', 2, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(303, 116, 'SABTU', 3, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(304, 116, 'SABTU', 4, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(305, 110, 'SABTU', 5, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(306, 110, 'SABTU', 6, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(307, 110, 'SABTU', 7, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(308, 106, 'SELASA', 1, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(309, 110, 'SELASA', 2, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(310, 109, 'SELASA', 3, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(311, 108, 'SELASA', 4, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(312, 108, 'SELASA', 5, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(313, 104, 'SELASA', 6, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(314, 104, 'SELASA', 7, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(315, 112, 'SENIN', 2, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(316, 112, 'SENIN', 3, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(317, 113, 'SENIN', 4, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(318, 113, 'SENIN', 5, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(319, 107, 'SENIN', 6, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(320, 107, 'SENIN', 7, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(321, 121, 'JUMAT', 1, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(322, 129, 'JUMAT', 2, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(323, 129, 'JUMAT', 3, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(324, 117, 'JUMAT', 4, 18, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(325, 117, 'JUMAT', 5, 18, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(326, 117, 'JUMAT', 6, 18, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(327, 120, 'KAMIS', 1, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(328, 121, 'KAMIS', 2, 5, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(329, 118, 'KAMIS', 3, 31, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(330, 118, 'KAMIS', 4, 31, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(331, 120, 'KAMIS', 5, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(332, 118, 'KAMIS', 6, 31, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(333, 118, 'KAMIS', 7, 31, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(334, 123, 'RABU', 1, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(335, 123, 'RABU', 2, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(336, 123, 'RABU', 3, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(337, 122, 'RABU', 4, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(338, 122, 'RABU', 5, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(339, 130, 'RABU', 6, 16, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(340, 130, 'RABU', 7, 16, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(341, 119, 'SABTU', 1, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(342, 124, 'SABTU', 2, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(343, 124, 'SABTU', 3, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(344, 127, 'SABTU', 4, 2, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(345, 127, 'SABTU', 5, 2, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(346, 123, 'SABTU', 6, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(347, 123, 'SELASA', 1, 7, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(348, 125, 'SELASA', 2, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(349, 125, 'SELASA', 3, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(350, 130, 'SELASA', 4, 16, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(351, 130, 'SELASA', 5, 16, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(352, 124, 'SELASA', 6, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(353, 124, 'SELASA', 7, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(354, 126, 'SENIN', 1, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(355, 126, 'SENIN', 2, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(356, 119, 'SENIN', 3, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(357, 119, 'SENIN', 4, 17, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(358, 120, 'SENIN', 5, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(359, 128, 'SENIN', 6, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(360, 128, 'SENIN', 7, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(361, 145, 'JUMAT', 1, 32, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(362, 145, 'JUMAT', 2, 32, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(363, 139, 'JUMAT', 3, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(364, 139, 'JUMAT', 4, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(365, 134, 'JUMAT', 5, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(366, 134, 'JUMAT', 6, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(367, 147, 'KAMIS', 1, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(368, 147, 'KAMIS', 2, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(369, 140, 'KAMIS', 3, 15, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(370, 132, 'KAMIS', 4, 19, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(371, 132, 'KAMIS', 5, 19, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(372, 137, 'KAMIS', 6, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(373, 137, 'KAMIS', 7, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(374, 140, 'RABU', 1, 15, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(375, 136, 'RABU', 2, 36, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(376, 136, 'RABU', 3, 36, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(377, 138, 'RABU', 4, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(378, 138, 'RABU', 5, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(379, 141, 'RABU', 6, 8, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(380, 141, 'RABU', 7, 8, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(381, 144, 'SABTU', 1, 35, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(382, 144, 'SABTU', 2, 35, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(383, 144, 'SABTU', 3, 35, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(384, 142, 'SABTU', 4, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(385, 131, 'SABTU', 5, 33, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(386, 131, 'SABTU', 6, 33, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(387, 143, 'SELASA', 1, 28, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(388, 143, 'SELASA', 2, 28, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(389, 135, 'SELASA', 3, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(390, 135, 'SELASA', 4, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(391, 135, 'SELASA', 5, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(392, 137, 'SELASA', 6, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(393, 137, 'SELASA', 7, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(394, 146, 'SENIN', 1, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(395, 146, 'SENIN', 2, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(396, 141, 'SENIN', 3, 8, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(397, 141, 'SENIN', 4, 8, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(398, 133, 'SENIN', 5, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(399, 133, 'SENIN', 6, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(400, 142, 'SENIN', 7, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(401, 161, 'JUMAT', 1, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(402, 161, 'JUMAT', 2, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(403, 155, 'JUMAT', 3, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(404, 155, 'JUMAT', 4, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(405, 162, 'JUMAT', 5, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(406, 162, 'JUMAT', 6, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(407, 149, 'KAMIS', 1, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(408, 149, 'KAMIS', 2, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(409, 149, 'KAMIS', 3, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(410, 149, 'KAMIS', 4, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(411, 157, 'KAMIS', 5, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(412, 157, 'KAMIS', 6, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(413, 155, 'KAMIS', 7, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(414, 152, 'RABU', 1, 8, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(415, 152, 'RABU', 2, 8, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(416, 152, 'RABU', 3, 8, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(417, 151, 'RABU', 4, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(418, 148, 'RABU', 5, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(419, 148, 'RABU', 6, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(420, 148, 'RABU', 7, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(421, 160, 'SABTU', 1, 32, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(422, 160, 'SABTU', 2, 32, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(423, 154, 'SABTU', 3, 33, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(424, 154, 'SABTU', 4, 33, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(425, 159, 'SABTU', 5, 35, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(426, 159, 'SABTU', 6, 35, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(427, 153, 'SELASA', 1, 9, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(428, 153, 'SELASA', 2, 9, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(429, 158, 'SELASA', 3, 28, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(430, 158, 'SELASA', 4, 28, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(431, 153, 'SELASA', 5, 9, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(432, 153, 'SELASA', 6, 9, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(433, 159, 'SELASA', 7, 35, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(434, 156, 'SENIN', 1, 19, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(435, 156, 'SENIN', 2, 19, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(436, 150, 'SENIN', 3, 19, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(437, 150, 'SENIN', 4, 19, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(438, 152, 'SENIN', 5, 8, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(439, 152, 'SENIN', 6, 8, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(440, 151, 'SENIN', 7, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(441, 164, 'JUMAT', 1, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(442, 164, 'JUMAT', 2, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(443, 173, 'JUMAT', 3, 27, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(444, 173, 'JUMAT', 4, 27, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(445, 175, 'JUMAT', 5, 11, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(446, 175, 'JUMAT', 6, 11, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(447, 170, 'KAMIS', 1, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(448, 170, 'KAMIS', 2, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(449, 170, 'KAMIS', 3, 14, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(450, 177, 'KAMIS', 4, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(451, 177, 'KAMIS', 5, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(452, 176, 'KAMIS', 6, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(453, 176, 'KAMIS', 7, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(454, 166, 'RABU', 1, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(455, 167, 'RABU', 2, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(456, 164, 'RABU', 3, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(457, 164, 'RABU', 4, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(458, 168, 'RABU', 5, 9, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(459, 168, 'RABU', 6, 9, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(460, 168, 'RABU', 7, 9, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(461, 172, 'SABTU', 1, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(462, 172, 'SABTU', 2, 3, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(463, 165, 'SABTU', 3, 19, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(464, 165, 'SABTU', 4, 19, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(465, 171, 'SABTU', 5, 19, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(466, 171, 'SABTU', 6, 19, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(467, 174, 'SELASA', 1, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(468, 163, 'SELASA', 2, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(469, 168, 'SELASA', 3, 9, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(470, 167, 'SELASA', 4, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(471, 167, 'SELASA', 5, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(472, 167, 'SELASA', 6, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(473, 167, 'SELASA', 7, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(474, 163, 'SENIN', 1, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(475, 163, 'SENIN', 2, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(476, 166, 'SENIN', 3, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(477, 169, 'SENIN', 4, 33, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(478, 169, 'SENIN', 5, 33, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(479, 174, 'SENIN', 6, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(480, 174, 'SENIN', 7, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(481, 181, 'JUMAT', 1, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(482, 186, 'JUMAT', 2, 11, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(483, 186, 'JUMAT', 3, 11, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(484, 180, 'JUMAT', 4, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(485, 180, 'JUMAT', 5, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(486, 180, 'JUMAT', 6, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(487, 191, 'KAMIS', 1, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(488, 191, 'KAMIS', 2, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(489, 191, 'KAMIS', 3, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(490, 183, 'KAMIS', 4, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(491, 183, 'KAMIS', 5, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(492, 178, 'KAMIS', 6, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(493, 178, 'KAMIS', 7, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(494, 188, 'RABU', 1, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(495, 179, 'RABU', 2, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(496, 179, 'RABU', 3, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(497, 179, 'RABU', 4, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(498, 190, 'RABU', 5, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(499, 190, 'RABU', 6, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(500, 190, 'RABU', 7, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(501, 188, 'SABTU', 1, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(502, 180, 'SABTU', 2, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(503, 182, 'SABTU', 3, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(504, 182, 'SABTU', 4, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(505, 182, 'SABTU', 5, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(506, 182, 'SABTU', 6, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(507, 178, 'SELASA', 1, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(508, 178, 'SELASA', 2, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(509, 185, 'SELASA', 3, 35, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(510, 185, 'SELASA', 4, 35, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(511, 185, 'SELASA', 5, 35, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(512, 187, 'SELASA', 6, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(513, 187, 'SELASA', 7, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(514, 189, 'SENIN', 1, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(515, 189, 'SENIN', 2, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(516, 189, 'SENIN', 3, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(517, 181, 'SENIN', 4, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(518, 182, 'SENIN', 5, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(519, 184, 'SENIN', 6, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(520, 184, 'SENIN', 7, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(521, 192, 'JUMAT', 1, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(522, 192, 'JUMAT', 2, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(523, 192, 'JUMAT', 3, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(524, 192, 'JUMAT', 4, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(525, 205, 'JUMAT', 5, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(526, 205, 'JUMAT', 6, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(527, 199, 'KAMIS', 1, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(528, 201, 'KAMIS', 2, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(529, 201, 'KAMIS', 3, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(530, 204, 'KAMIS', 4, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(531, 198, 'KAMIS', 5, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(532, 198, 'KAMIS', 6, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(533, 193, 'KAMIS', 7, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(534, 200, 'RABU', 1, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(535, 200, 'RABU', 2, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(536, 196, 'RABU', 3, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(537, 205, 'RABU', 4, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(538, 195, 'RABU', 5, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(539, 196, 'RABU', 6, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(540, 196, 'RABU', 7, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(541, 196, 'SABTU', 1, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(542, 196, 'SABTU', 2, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(543, 197, 'SABTU', 3, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(544, 197, 'SABTU', 4, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(545, 204, 'SABTU', 5, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(546, 204, 'SABTU', 6, 29, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(547, 194, 'SELASA', 1, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(548, 194, 'SELASA', 2, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(549, 194, 'SELASA', 3, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(550, 194, 'SELASA', 4, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(551, 203, 'SELASA', 5, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(552, 202, 'SELASA', 6, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(553, 202, 'SELASA', 7, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(554, 199, 'SENIN', 1, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(555, 195, 'SENIN', 2, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(556, 193, 'SENIN', 3, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(557, 193, 'SENIN', 4, 4, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(558, 199, 'SENIN', 5, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(559, 203, 'SENIN', 6, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(560, 203, 'SENIN', 7, 1, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(561, 210, 'JUMAT', 1, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(562, 210, 'JUMAT', 2, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(563, 207, 'JUMAT', 3, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(564, 207, 'JUMAT', 4, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(565, 207, 'JUMAT', 5, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(566, 207, 'JUMAT', 6, 6, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(567, 210, 'KAMIS', 1, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(568, 217, 'KAMIS', 2, 10, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(569, 217, 'KAMIS', 3, 10, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(570, 212, 'KAMIS', 4, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(571, 212, 'KAMIS', 5, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(572, 212, 'KAMIS', 6, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(573, 212, 'KAMIS', 7, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(574, 210, 'RABU', 1, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(575, 213, 'RABU', 2, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(576, 213, 'RABU', 3, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(577, 216, 'RABU', 4, 11, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(578, 216, 'RABU', 5, 11, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(579, 218, 'RABU', 6, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(580, 218, 'RABU', 7, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(581, 208, 'SABTU', 1, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(582, 208, 'SABTU', 2, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(583, 208, 'SABTU', 3, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(584, 208, 'SABTU', 4, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(585, 214, 'SABTU', 5, 27, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(586, 214, 'SABTU', 6, 27, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(587, 211, 'SELASA', 1, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(588, 211, 'SELASA', 2, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(589, 211, 'SELASA', 3, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(590, 211, 'SELASA', 4, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(591, 206, 'SELASA', 5, 36, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(592, 206, 'SELASA', 6, 36, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(593, 206, 'SELASA', 7, 36, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(594, 210, 'SENIN', 1, 12, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(595, 215, 'SENIN', 2, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(596, 215, 'SENIN', 3, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(597, 215, 'SENIN', 4, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(598, 209, 'SENIN', 5, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(599, 209, 'SENIN', 6, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(600, 212, 'SENIN', 7, 30, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(601, 224, 'JUMAT', 1, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(602, 224, 'JUMAT', 2, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(603, 224, 'JUMAT', 3, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(604, 224, 'JUMAT', 4, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(605, 222, 'JUMAT', 5, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(606, 222, 'JUMAT', 6, 20, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(607, 220, 'KAMIS', 1, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(608, 220, 'KAMIS', 2, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(609, 220, 'KAMIS', 3, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(610, 220, 'KAMIS', 4, 26, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(611, 219, 'KAMIS', 5, 36, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(612, 219, 'KAMIS', 6, 36, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(613, 219, 'KAMIS', 7, 36, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(614, 221, 'RABU', 1, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(615, 221, 'RABU', 2, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(616, 231, 'RABU', 3, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(617, 231, 'RABU', 4, 24, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(618, 225, 'RABU', 5, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(619, 225, 'RABU', 6, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(620, 225, 'RABU', 7, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(621, 226, 'SABTU', 1, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(622, 228, 'SABTU', 2, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14');
INSERT INTO `timetable` (`id_timetable`, `id_class_subject`, `hari`, `jam_ke`, `id_guru`, `is_fallback`, `original_guru_id`, `created_at`, `updated_at`) VALUES
(623, 228, 'SABTU', 3, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(624, 228, 'SABTU', 4, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(625, 221, 'SABTU', 5, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(626, 221, 'SABTU', 6, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(627, 225, 'SELASA', 1, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(628, 225, 'SELASA', 2, 25, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(629, 230, 'SELASA', 3, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(630, 230, 'SELASA', 4, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(631, 227, 'SELASA', 5, 27, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(632, 227, 'SELASA', 6, 27, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(633, 226, 'SELASA', 7, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(634, 223, 'SENIN', 1, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(635, 223, 'SENIN', 2, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(636, 223, 'SENIN', 3, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(637, 223, 'SENIN', 4, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(638, 223, 'SENIN', 5, 37, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(639, 229, 'SENIN', 6, 2, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(640, 229, 'SENIN', 7, 2, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(641, 233, 'JUMAT', 1, 31, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(642, 233, 'JUMAT', 2, 31, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(643, 239, 'JUMAT', 3, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(644, 239, 'JUMAT', 4, 21, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(645, 241, 'JUMAT', 5, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(646, 241, 'JUMAT', 6, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(647, 243, 'KAMIS', 1, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(648, 243, 'KAMIS', 2, 22, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(649, 240, 'KAMIS', 3, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(650, 240, 'KAMIS', 4, 34, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(651, 241, 'KAMIS', 5, 13, 0, NULL, '2026-06-22 07:58:14', '2026-06-22 07:58:14'),
(652, 236, 'KAMIS', 6, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(653, 236, 'KAMIS', 7, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(654, 237, 'RABU', 1, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(655, 237, 'RABU', 2, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(656, 237, 'RABU', 3, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(657, 234, 'RABU', 4, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(658, 234, 'RABU', 5, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(659, 235, 'RABU', 6, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(660, 235, 'RABU', 7, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(661, 238, 'SABTU', 1, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(662, 238, 'SABTU', 2, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(663, 238, 'SABTU', 3, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(664, 238, 'SABTU', 4, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(665, 238, 'SABTU', 5, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(666, 244, 'SABTU', 6, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(667, 237, 'SELASA', 1, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(668, 232, 'SELASA', 2, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(669, 232, 'SELASA', 3, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(670, 232, 'SELASA', 4, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(671, 244, 'SELASA', 5, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(672, 234, 'SELASA', 6, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(673, 234, 'SELASA', 7, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(674, 233, 'SENIN', 1, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(675, 233, 'SENIN', 2, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(676, 242, 'SENIN', 3, 22, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(677, 242, 'SENIN', 4, 22, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(678, 236, 'SENIN', 5, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(679, 236, 'SENIN', 6, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(680, 236, 'SENIN', 7, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(681, 249, 'JUMAT', 1, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(682, 249, 'JUMAT', 2, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(683, 249, 'JUMAT', 3, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(684, 247, 'JUMAT', 4, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(685, 247, 'JUMAT', 5, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(686, 247, 'JUMAT', 6, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(687, 254, 'KAMIS', 1, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(688, 254, 'KAMIS', 2, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(689, 254, 'KAMIS', 3, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(690, 251, 'KAMIS', 4, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(691, 251, 'KAMIS', 5, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(692, 251, 'KAMIS', 6, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(693, 251, 'KAMIS', 7, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(694, 253, 'RABU', 1, 34, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(695, 253, 'RABU', 2, 34, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(696, 248, 'RABU', 3, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(697, 245, 'RABU', 4, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(698, 245, 'RABU', 5, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(699, 245, 'RABU', 6, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(700, 251, 'RABU', 7, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(701, 249, 'SABTU', 1, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(702, 249, 'SABTU', 2, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(703, 250, 'SABTU', 3, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(704, 250, 'SABTU', 4, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(705, 250, 'SABTU', 5, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(706, 250, 'SABTU', 6, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(707, 257, 'SELASA', 1, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(708, 257, 'SELASA', 2, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(709, 247, 'SELASA', 3, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(710, 255, 'SELASA', 4, 11, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(711, 255, 'SELASA', 5, 11, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(712, 256, 'SELASA', 6, 22, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(713, 256, 'SELASA', 7, 22, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(714, 248, 'SENIN', 1, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(715, 252, 'SENIN', 2, 3, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(716, 252, 'SENIN', 3, 3, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(717, 246, 'SENIN', 4, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(718, 246, 'SENIN', 5, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(719, 246, 'SENIN', 6, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(720, 246, 'SENIN', 7, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(721, 262, 'JUMAT', 1, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(722, 263, 'JUMAT', 2, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(723, 263, 'JUMAT', 3, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(724, 260, 'JUMAT', 4, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(725, 260, 'JUMAT', 5, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(726, 260, 'JUMAT', 6, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(727, 265, 'KAMIS', 1, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(728, 265, 'KAMIS', 2, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(729, 265, 'KAMIS', 3, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(730, 269, 'KAMIS', 4, 2, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(731, 269, 'KAMIS', 5, 2, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(732, 258, 'KAMIS', 6, 33, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(733, 258, 'KAMIS', 7, 33, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(734, 261, 'RABU', 1, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(735, 261, 'RABU', 2, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(736, 261, 'RABU', 3, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(737, 261, 'RABU', 4, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(738, 267, 'RABU', 5, 34, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(739, 267, 'RABU', 6, 34, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(740, 259, 'RABU', 7, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(741, 268, 'SABTU', 1, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(742, 268, 'SABTU', 2, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(743, 264, 'SABTU', 3, 15, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(744, 264, 'SABTU', 4, 15, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(745, 264, 'SABTU', 5, 15, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(746, 271, 'SABTU', 6, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(747, 271, 'SABTU', 7, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(748, 263, 'SELASA', 1, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(749, 263, 'SELASA', 2, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(750, 268, 'SELASA', 3, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(751, 259, 'SELASA', 4, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(752, 259, 'SELASA', 5, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(753, 270, 'SELASA', 6, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(754, 270, 'SELASA', 7, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(755, 265, 'SENIN', 2, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(756, 265, 'SENIN', 3, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(757, 262, 'SENIN', 4, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(758, 266, 'SENIN', 5, 3, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(759, 266, 'SENIN', 6, 3, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(760, 262, 'SENIN', 7, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(761, 273, 'JUMAT', 1, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(762, 284, 'JUMAT', 2, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(763, 284, 'JUMAT', 3, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(764, 273, 'JUMAT', 4, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(765, 273, 'JUMAT', 5, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(766, 273, 'JUMAT', 6, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(767, 274, 'KAMIS', 1, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(768, 274, 'KAMIS', 2, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(769, 274, 'KAMIS', 3, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(770, 274, 'KAMIS', 4, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(771, 277, 'KAMIS', 5, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(772, 277, 'KAMIS', 6, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(773, 277, 'KAMIS', 7, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(774, 280, 'RABU', 1, 34, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(775, 280, 'RABU', 2, 34, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(776, 283, 'RABU', 3, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(777, 283, 'RABU', 4, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(778, 272, 'RABU', 5, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(779, 272, 'RABU', 6, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(780, 272, 'RABU', 7, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(781, 276, 'SABTU', 1, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(782, 276, 'SABTU', 2, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(783, 276, 'SABTU', 3, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(784, 281, 'SABTU', 4, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(785, 281, 'SABTU', 5, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(786, 281, 'SABTU', 6, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(787, 274, 'SABTU', 7, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(788, 275, 'SELASA', 1, 9, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(789, 275, 'SELASA', 2, 9, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(790, 275, 'SELASA', 3, 9, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(791, 275, 'SELASA', 4, 9, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(792, 275, 'SELASA', 5, 9, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(793, 279, 'SELASA', 6, 21, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(794, 279, 'SELASA', 7, 21, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(795, 282, 'SENIN', 2, 11, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(796, 282, 'SENIN', 3, 11, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(797, 278, 'SENIN', 4, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(798, 278, 'SENIN', 5, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(799, 278, 'SENIN', 6, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(800, 278, 'SENIN', 7, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(801, 286, 'JUMAT', 1, 6, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(802, 286, 'JUMAT', 2, 6, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(803, 290, 'JUMAT', 3, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(804, 286, 'JUMAT', 4, 6, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(805, 286, 'JUMAT', 5, 6, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(806, 294, 'JUMAT', 6, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(807, 296, 'KAMIS', 1, 10, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(808, 296, 'KAMIS', 2, 10, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(809, 290, 'KAMIS', 3, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(810, 290, 'KAMIS', 4, 14, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(811, 291, 'KAMIS', 5, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(812, 293, 'KAMIS', 6, 34, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(813, 293, 'KAMIS', 7, 34, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(814, 297, 'RABU', 1, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(815, 295, 'RABU', 2, 11, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(816, 295, 'RABU', 3, 11, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(817, 285, 'RABU', 4, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(818, 288, 'RABU', 5, 9, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(819, 288, 'RABU', 6, 9, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(820, 288, 'RABU', 7, 9, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(821, 287, 'SABTU', 1, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(822, 287, 'SABTU', 2, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(823, 287, 'SABTU', 3, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(824, 297, 'SABTU', 4, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(825, 292, 'SABTU', 5, 3, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(826, 292, 'SABTU', 6, 3, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(827, 291, 'SABTU', 7, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(828, 285, 'SELASA', 1, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(829, 285, 'SELASA', 2, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(830, 289, 'SELASA', 3, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(831, 289, 'SELASA', 4, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(832, 289, 'SELASA', 5, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(833, 288, 'SELASA', 6, 9, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(834, 288, 'SELASA', 7, 9, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(835, 291, 'SENIN', 2, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(836, 291, 'SENIN', 3, 19, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(837, 287, 'SENIN', 4, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(838, 287, 'SENIN', 5, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(839, 294, 'SENIN', 6, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(840, 294, 'SENIN', 7, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(841, 302, 'JUMAT', 1, 3, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(842, 302, 'JUMAT', 2, 3, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(843, 309, 'JUMAT', 3, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(844, 298, 'JUMAT', 4, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(845, 298, 'JUMAT', 5, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(846, 300, 'JUMAT', 6, 26, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(847, 300, 'KAMIS', 1, 26, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(848, 300, 'KAMIS', 2, 26, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(849, 300, 'KAMIS', 3, 26, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(850, 301, 'KAMIS', 4, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(851, 301, 'KAMIS', 5, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(852, 301, 'KAMIS', 6, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(853, 301, 'KAMIS', 7, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(854, 299, 'RABU', 1, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(855, 299, 'RABU', 2, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(856, 299, 'RABU', 3, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(857, 308, 'RABU', 4, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(858, 308, 'RABU', 5, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(859, 309, 'RABU', 6, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(860, 309, 'RABU', 7, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(861, 306, 'SABTU', 1, 22, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(862, 306, 'SABTU', 2, 22, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(863, 307, 'SABTU', 3, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(864, 301, 'SABTU', 4, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(865, 305, 'SABTU', 5, 32, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(866, 305, 'SABTU', 6, 32, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(867, 304, 'SABTU', 7, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(868, 303, 'SELASA', 1, 27, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(869, 303, 'SELASA', 2, 27, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(870, 304, 'SELASA', 3, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(871, 304, 'SELASA', 4, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(872, 310, 'SELASA', 5, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(873, 310, 'SELASA', 6, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(874, 310, 'SELASA', 7, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(875, 309, 'SENIN', 2, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(876, 307, 'SENIN', 3, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(877, 298, 'SENIN', 4, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(878, 298, 'SENIN', 5, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(879, 308, 'SENIN', 6, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(880, 308, 'SENIN', 7, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(881, 322, 'JUMAT', 1, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(882, 323, 'JUMAT', 2, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(883, 323, 'JUMAT', 3, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(884, 321, 'JUMAT', 4, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(885, 316, 'JUMAT', 5, 27, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(886, 316, 'JUMAT', 6, 27, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(887, 323, 'KAMIS', 1, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(888, 313, 'KAMIS', 2, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(889, 313, 'KAMIS', 3, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(890, 313, 'KAMIS', 4, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(891, 313, 'KAMIS', 5, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(892, 311, 'KAMIS', 6, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(893, 315, 'KAMIS', 7, 3, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(894, 322, 'RABU', 1, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(895, 322, 'RABU', 2, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(896, 322, 'RABU', 3, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(897, 319, 'RABU', 4, 22, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(898, 319, 'RABU', 5, 22, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(899, 320, 'RABU', 6, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(900, 320, 'RABU', 7, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(901, 315, 'SABTU', 1, 3, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(902, 317, 'SABTU', 2, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(903, 318, 'SABTU', 3, 32, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(904, 318, 'SABTU', 4, 32, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(905, 314, 'SABTU', 5, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(906, 314, 'SABTU', 6, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(907, 314, 'SABTU', 7, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(908, 314, 'SELASA', 1, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(909, 314, 'SELASA', 2, 7, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(910, 312, 'SELASA', 3, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(911, 312, 'SELASA', 4, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(912, 312, 'SELASA', 5, 36, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(913, 317, 'SELASA', 6, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(914, 317, 'SELASA', 7, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(915, 311, 'SENIN', 2, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(916, 321, 'SENIN', 3, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(917, 321, 'SENIN', 4, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(918, 321, 'SENIN', 5, 20, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(919, 311, 'SENIN', 6, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(920, 311, 'SENIN', 7, 1, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(921, 334, 'JUMAT', 1, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(922, 324, 'JUMAT', 2, 18, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(923, 324, 'JUMAT', 3, 18, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(924, 324, 'JUMAT', 4, 18, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(925, 330, 'JUMAT', 5, 21, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(926, 330, 'JUMAT', 6, 21, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(927, 332, 'KAMIS', 1, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(928, 326, 'KAMIS', 2, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(929, 334, 'KAMIS', 3, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(930, 335, 'KAMIS', 4, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(931, 335, 'KAMIS', 5, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(932, 325, 'KAMIS', 6, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(933, 325, 'KAMIS', 7, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(934, 327, 'RABU', 1, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(935, 327, 'RABU', 2, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(936, 327, 'RABU', 3, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(937, 327, 'RABU', 4, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(938, 327, 'RABU', 5, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(939, 326, 'RABU', 6, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(940, 326, 'RABU', 7, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(941, 333, 'SABTU', 1, 32, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(942, 333, 'SABTU', 2, 32, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(943, 325, 'SABTU', 3, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(944, 325, 'SABTU', 4, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(945, 329, 'SABTU', 5, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(946, 331, 'SABTU', 6, 27, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(947, 331, 'SABTU', 7, 27, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(948, 332, 'SELASA', 1, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(949, 332, 'SELASA', 2, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(950, 328, 'SELASA', 3, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(951, 328, 'SELASA', 4, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(952, 328, 'SELASA', 5, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(953, 328, 'SELASA', 6, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(954, 328, 'SELASA', 7, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(955, 326, 'SENIN', 2, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(956, 326, 'SENIN', 3, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(957, 329, 'SENIN', 4, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(958, 329, 'SENIN', 5, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(959, 329, 'SENIN', 6, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(960, 329, 'SENIN', 7, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(961, 347, 'JUMAT', 1, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(962, 338, 'JUMAT', 2, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(963, 338, 'JUMAT', 3, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(964, 338, 'JUMAT', 4, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(965, 338, 'JUMAT', 5, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(966, 338, 'JUMAT', 6, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(967, 340, 'KAMIS', 1, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(968, 344, 'KAMIS', 2, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(969, 344, 'KAMIS', 3, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(970, 342, 'KAMIS', 4, 21, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(971, 339, 'KAMIS', 5, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(972, 339, 'KAMIS', 6, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(973, 339, 'KAMIS', 7, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(974, 342, 'RABU', 1, 21, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(975, 336, 'RABU', 2, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(976, 336, 'RABU', 3, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(977, 345, 'RABU', 4, 11, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(978, 345, 'RABU', 5, 11, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(979, 346, 'RABU', 6, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(980, 346, 'RABU', 7, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(981, 344, 'SABTU', 1, 35, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(982, 341, 'SABTU', 2, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(983, 341, 'SABTU', 3, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(984, 341, 'SABTU', 4, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(985, 340, 'SABTU', 5, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(986, 340, 'SABTU', 6, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(987, 340, 'SABTU', 7, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(988, 339, 'SELASA', 1, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(989, 339, 'SELASA', 2, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(990, 337, 'SELASA', 3, 26, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(991, 337, 'SELASA', 4, 26, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(992, 347, 'SELASA', 5, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(993, 343, 'SELASA', 6, 28, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(994, 343, 'SELASA', 7, 28, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(995, 341, 'SENIN', 2, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(996, 341, 'SENIN', 3, 30, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(997, 340, 'SENIN', 4, 37, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(998, 336, 'SENIN', 5, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(999, 337, 'SENIN', 6, 26, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1000, 337, 'SENIN', 7, 26, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1001, 357, 'JUMAT', 1, 11, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1002, 350, 'JUMAT', 2, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1003, 355, 'JUMAT', 3, 27, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1004, 355, 'JUMAT', 4, 27, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1005, 356, 'JUMAT', 5, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1006, 351, 'JUMAT', 6, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1007, 356, 'KAMIS', 1, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1008, 356, 'KAMIS', 2, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1009, 349, 'KAMIS', 3, 6, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1010, 349, 'KAMIS', 4, 6, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1011, 349, 'KAMIS', 5, 6, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1012, 358, 'KAMIS', 6, 22, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1013, 358, 'KAMIS', 7, 22, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1014, 353, 'RABU', 1, 25, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1015, 354, 'RABU', 2, 21, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1016, 354, 'RABU', 3, 21, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1017, 353, 'RABU', 4, 25, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1018, 353, 'RABU', 5, 25, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1019, 352, 'RABU', 6, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1020, 352, 'RABU', 7, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1021, 359, 'SABTU', 1, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1022, 359, 'SABTU', 2, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1023, 357, 'SABTU', 3, 11, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1024, 351, 'SABTU', 4, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1025, 351, 'SABTU', 5, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1026, 351, 'SABTU', 6, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1027, 351, 'SABTU', 7, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1028, 353, 'SELASA', 1, 25, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1029, 353, 'SELASA', 2, 25, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1030, 349, 'SELASA', 3, 6, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1031, 352, 'SELASA', 4, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1032, 352, 'SELASA', 5, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1033, 352, 'SELASA', 6, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1034, 348, 'SELASA', 7, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1035, 348, 'SENIN', 2, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1036, 348, 'SENIN', 3, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1037, 350, 'SENIN', 4, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1038, 350, 'SENIN', 5, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1039, 350, 'SENIN', 6, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1040, 350, 'SENIN', 7, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1041, 365, 'JUMAT', 1, 8, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1042, 360, 'JUMAT', 2, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1043, 364, 'JUMAT', 3, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1044, 364, 'JUMAT', 4, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1045, 371, 'JUMAT', 5, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1046, 371, 'JUMAT', 6, 24, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1047, 363, 'KAMIS', 1, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1048, 363, 'KAMIS', 2, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1049, 363, 'KAMIS', 3, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1050, 363, 'KAMIS', 4, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1051, 363, 'KAMIS', 5, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1052, 365, 'KAMIS', 6, 8, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1053, 365, 'KAMIS', 7, 8, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1054, 365, 'RABU', 1, 8, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1055, 365, 'RABU', 2, 8, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1056, 364, 'RABU', 3, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1057, 364, 'RABU', 4, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1058, 364, 'RABU', 5, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1059, 361, 'RABU', 6, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1060, 361, 'RABU', 7, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1061, 362, 'SABTU', 1, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1062, 362, 'SABTU', 2, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1063, 362, 'SABTU', 3, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1064, 370, 'SABTU', 4, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1065, 370, 'SABTU', 5, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1066, 369, 'SABTU', 6, 11, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1067, 369, 'SABTU', 7, 11, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1068, 368, 'SELASA', 1, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1069, 360, 'SELASA', 2, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1070, 360, 'SELASA', 3, 4, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1071, 361, 'SELASA', 4, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1072, 361, 'SELASA', 5, 31, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1073, 366, 'SELASA', 6, 3, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1074, 366, 'SELASA', 7, 3, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1075, 362, 'SENIN', 2, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1076, 362, 'SENIN', 3, 16, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1077, 368, 'SENIN', 4, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1078, 368, 'SENIN', 5, 13, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1079, 367, 'SENIN', 6, 27, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15'),
(1080, 367, 'SENIN', 7, 27, 0, NULL, '2026-06-22 07:58:15', '2026-06-22 07:58:15');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('ADMIN','TEACHER','STUDENT') NOT NULL DEFAULT 'STUDENT',
  `id_guru` bigint(20) UNSIGNED DEFAULT NULL,
  `id_siswa` bigint(20) UNSIGNED DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `id_guru`, `id_siswa`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin Kurikulum', 'admin@smk11maret.sch.id', NULL, '$2y$12$HCiDhiJvTL/5qRYpjlwSyOZmt.lJrQNFN2EBQ3BZySf1VHa7/9NQC', 'ADMIN', NULL, NULL, NULL, '2026-06-22 08:24:35', '2026-06-22 08:26:15'),
(2, 'Latif Caket Simbolon', '0097229989@student.smk11maret.sch.id', NULL, '$2y$12$vJlkBY/mhnckTMqUk0vMJ.xGyZILGAVaPkN6sweXM.ULo7gETBX2G', 'STUDENT', NULL, 1, NULL, '2026-06-21 23:46:33', '2026-06-21 23:46:33'),
(3, 'Marsito Asmianto Siregar', '0076193545@student.smk11maret.sch.id', NULL, '$2y$12$VZaUa6E42dD.bM6LUrAYl.Fnp4pgnH7I6AjsdS0XuhW/Xnbhvfg0O', 'STUDENT', NULL, 2, NULL, '2026-06-21 23:46:33', '2026-06-21 23:46:33'),
(4, 'Niyaga Lazuardi', '0039429119@student.smk11maret.sch.id', NULL, '$2y$12$J/6FVVqWqaUht34LIKYqROgs1Z1ymGdU71v7ybtgVnchpaEgSnd5e', 'STUDENT', NULL, 3, NULL, '2026-06-21 23:46:33', '2026-06-21 23:46:33'),
(5, 'Agus Galih Winarno', '0035969804@student.smk11maret.sch.id', NULL, '$2y$12$Hn/ynHRYVZjoX9Min9mKme30CLWIyrEJwWbL6TROnfnIhHwgi/W5y', 'STUDENT', NULL, 4, NULL, '2026-06-21 23:46:33', '2026-06-21 23:46:33'),
(6, 'Banawa Mahendra', '0068321981@student.smk11maret.sch.id', NULL, '$2y$12$ev5TDkJzYY87b6D2ihLJTugt8yK2.SWsJDend0KYiaBIGk8b853bG', 'STUDENT', NULL, 5, NULL, '2026-06-21 23:46:33', '2026-06-21 23:46:33'),
(7, 'Bakianto Thamrin S.Pd', '0037844120@student.smk11maret.sch.id', NULL, '$2y$12$TlVdJlauHCQB1qqEQVIOvOlITdeuu0.7lWVKPfRBvuoS.lDH0UVtK', 'STUDENT', NULL, 6, NULL, '2026-06-21 23:46:34', '2026-06-21 23:46:34'),
(8, 'Oskar Sirait M.Pd', '0094316690@student.smk11maret.sch.id', NULL, '$2y$12$x/8Dj.cIVhGXy7XS4jZ2QOVUVRBrMvrNUU63UWjK./c/6ZrFrafPy', 'STUDENT', NULL, 7, NULL, '2026-06-21 23:46:34', '2026-06-21 23:46:34'),
(9, 'Padma Lestari', '0067431798@student.smk11maret.sch.id', NULL, '$2y$12$YgsdkGK92gOWepQ6jEi9/eqD49OKrHNMWGj.w8FOEy66T5AUrRw3G', 'STUDENT', NULL, 8, NULL, '2026-06-21 23:46:34', '2026-06-21 23:46:34'),
(10, 'Cinthia Aryani', '0095261142@student.smk11maret.sch.id', NULL, '$2y$12$ZSJ1mhycA6a1dCsOvk7rTegnoYL35L/GKhRmwuobreRTcJ/sELNQi', 'STUDENT', NULL, 9, NULL, '2026-06-21 23:46:34', '2026-06-21 23:46:34'),
(11, 'Ratih Mardhiyah', '0002375654@student.smk11maret.sch.id', NULL, '$2y$12$DvLNZh53hhHkL7PMLdj8VuP99SktTtBHbB7bMtLgTWuKtrku2Cc4u', 'STUDENT', NULL, 10, NULL, '2026-06-21 23:46:35', '2026-06-21 23:46:35'),
(12, 'Okto Iswahyudi', '0066240048@student.smk11maret.sch.id', NULL, '$2y$12$SaUgDRLxgWYMBwaoR.0Z/ekFmVgXvJ95vtsiUIyDDzjumGaUFZog6', 'STUDENT', NULL, 11, NULL, '2026-06-21 23:46:35', '2026-06-21 23:46:35'),
(13, 'Chelsea Hartati', '0052234092@student.smk11maret.sch.id', NULL, '$2y$12$2bYpoTAgX4pn8Ifzo5Y5v.IJ7KR39vxRCATsPgWFu0yPS.GCeHobq', 'STUDENT', NULL, 12, NULL, '2026-06-21 23:46:35', '2026-06-21 23:46:35'),
(14, 'Bakianto Mustofa', '0032488817@student.smk11maret.sch.id', NULL, '$2y$12$OmYPH3IF861UjJ0yw.o/tOW6HczUEe/bj0TEFVvoOEQffAbCLxmmS', 'STUDENT', NULL, 13, NULL, '2026-06-21 23:46:35', '2026-06-21 23:46:35'),
(15, 'Estiawan Yahya Hidayanto S.Pt', '0098589609@student.smk11maret.sch.id', NULL, '$2y$12$x6RwSpERR3paD9SSx2snXO28uCuwaA/eW6vZOR1swhfMBOxOEG7vy', 'STUDENT', NULL, 14, NULL, '2026-06-21 23:46:35', '2026-06-21 23:46:35'),
(16, 'Patricia Hassanah', '0036547598@student.smk11maret.sch.id', NULL, '$2y$12$/UpVCFh8TPsTYLbGXCTZI.4IJs.X3ikiAHwl5FN6xs3fyD8Xuj1ym', 'STUDENT', NULL, 15, NULL, '2026-06-21 23:46:36', '2026-06-21 23:46:36'),
(17, 'Rini Hasanah S.T.', '0006594832@student.smk11maret.sch.id', NULL, '$2y$12$6QilXbbBQoFhwQHgb8pAc.E6xWPYAwrFDBIp0/hxMVnY4gV1oanD2', 'STUDENT', NULL, 16, NULL, '2026-06-21 23:46:36', '2026-06-21 23:46:36'),
(18, 'Kenzie Garang Wijaya S.Psi', '0040435060@student.smk11maret.sch.id', NULL, '$2y$12$ayQYxECV.A17FUbLpWcLmuBsgYcEN0Ul.h6yQSZ9T3A.BsFYF/.TW', 'STUDENT', NULL, 17, NULL, '2026-06-21 23:46:36', '2026-06-21 23:46:36'),
(19, 'Rahman Prakasa', '0096361041@student.smk11maret.sch.id', NULL, '$2y$12$C8xXpWig.xVy4Xtid.86m.gIv5zxuv31TZL1ccvuR56l2adIrV.U2', 'STUDENT', NULL, 18, NULL, '2026-06-21 23:46:36', '2026-06-21 23:46:36'),
(20, 'Gada Manullang', '0026505221@student.smk11maret.sch.id', NULL, '$2y$12$ypkjQJV5B8952acj2k4XxOEeSvj/3HYlryi3l9iUdFY6ciBnuDrNm', 'STUDENT', NULL, 19, NULL, '2026-06-21 23:46:36', '2026-06-21 23:46:36'),
(21, 'Bella Nurdiyanti M.TI.', '0085344295@student.smk11maret.sch.id', NULL, '$2y$12$AxCg4T1USR6j5Aooj.lgbumbzNRlZ.9W0OsQX/bcg5Pg.j8Grbu3K', 'STUDENT', NULL, 20, NULL, '2026-06-21 23:46:37', '2026-06-21 23:46:37'),
(22, 'Jasmin Prastuti', '0011930017@student.smk11maret.sch.id', NULL, '$2y$12$rZ9Pon04ofDquyggZBYL4Oy.npgr/.JAM/ULMHDKhnfqrreee6EJ.', 'STUDENT', NULL, 21, NULL, '2026-06-21 23:46:37', '2026-06-21 23:46:37'),
(23, 'Dartono Utama', '0075257250@student.smk11maret.sch.id', NULL, '$2y$12$Xi/6psLijKHqe1hW0oEegOAIiaTgvS/VuqLmlIowFZ9Q7JzYCae5G', 'STUDENT', NULL, 22, NULL, '2026-06-21 23:46:37', '2026-06-21 23:46:37'),
(24, 'Hendri Caket Sihombing', '0061408655@student.smk11maret.sch.id', NULL, '$2y$12$ezIZjEDgiQQ2T5p3pWPx2uv4IA1Lqs2jWQ/3nCnTJK.1106iUs3kG', 'STUDENT', NULL, 23, NULL, '2026-06-21 23:46:37', '2026-06-21 23:46:37'),
(25, 'Yuni Rahmi Yuliarti S.Kom', '0030574702@student.smk11maret.sch.id', NULL, '$2y$12$uh85GzlkN431ndTmrztPDOIOGQMSWs0WwHKXQtxXC5BcQtCryD.Wy', 'STUDENT', NULL, 24, NULL, '2026-06-21 23:46:37', '2026-06-21 23:46:37'),
(26, 'Gatot Pradana', '0009118063@student.smk11maret.sch.id', NULL, '$2y$12$VeMIAR4fm0LfOY1Wsh7l9uJQ5twat3i8x7O6kYb6oYBOVkZ2xWgKS', 'STUDENT', NULL, 25, NULL, '2026-06-21 23:46:38', '2026-06-21 23:46:38'),
(27, 'Queen Mila Yuliarti S.Ked', '0054352318@student.smk11maret.sch.id', NULL, '$2y$12$NZFmt2hOd5DeiYaBnNRKmOTAdkh48S0OkaMP2nAOPeC4SOfJfXe7e', 'STUDENT', NULL, 26, NULL, '2026-06-21 23:46:38', '2026-06-21 23:46:38'),
(28, 'Bahuraksa Permadi', '0048993558@student.smk11maret.sch.id', NULL, '$2y$12$W3R2Qv1.5kGxnD4TAUmZxeUXWHyiT/cANK/LL41yXKDjkS7S1uNce', 'STUDENT', NULL, 27, NULL, '2026-06-21 23:46:38', '2026-06-21 23:46:38'),
(29, 'Victoria Andriani S.I.Kom', '0059862333@student.smk11maret.sch.id', NULL, '$2y$12$Fyrg4FVr2h3IH7JsjnuMIuX4owNlzh9tieLZ.QOzJRE2.mQfZbbcq', 'STUDENT', NULL, 28, NULL, '2026-06-21 23:46:38', '2026-06-21 23:46:38'),
(30, 'Pranawa Hidayat', '0088605280@student.smk11maret.sch.id', NULL, '$2y$12$64bP8K1U7C5OAWVQHcY7nuDlX0jqR.kF8WSrrVi2GDr1mSv3heOoK', 'STUDENT', NULL, 29, NULL, '2026-06-21 23:46:38', '2026-06-21 23:46:38'),
(31, 'Edison Tamba', '0072409200@student.smk11maret.sch.id', NULL, '$2y$12$uoQdd5HiL8n2Dxtnhr3UZu5jR6CNT3jx8BPAZPLT9fs7TjU.LLuIS', 'STUDENT', NULL, 30, NULL, '2026-06-21 23:46:39', '2026-06-21 23:46:39'),
(32, 'Zulfa Nurdiyanti', '0059168496@student.smk11maret.sch.id', NULL, '$2y$12$9z3TsE8Y3EfaRc1v6KuBV.KptOxD5UHuq13nLHK1SCPP8bcO6AUb6', 'STUDENT', NULL, 31, NULL, '2026-06-21 23:46:39', '2026-06-21 23:46:39'),
(33, 'Nurul Sudiati', '0028162089@student.smk11maret.sch.id', NULL, '$2y$12$mQyrmVp72kwb0o4UG4QMhunCKzswtwETb08tO8Nnvwk2PoD0khkMK', 'STUDENT', NULL, 32, NULL, '2026-06-21 23:46:39', '2026-06-21 23:46:39'),
(34, 'Bagas Pratama S.Pt', '0065977362@student.smk11maret.sch.id', NULL, '$2y$12$WOCV/X/VVu08GafFgjixIeeZ9DpGXbAvEQOsRoLEu76/L93vrzNjG', 'STUDENT', NULL, 33, NULL, '2026-06-21 23:46:39', '2026-06-21 23:46:39'),
(35, 'Titin Gawati Yolanda', '0024334029@student.smk11maret.sch.id', NULL, '$2y$12$KMPdBUVepsAinjafHerzyemw6qmWMW80f2fUtu/ftZUD7D8QtH/V.', 'STUDENT', NULL, 34, NULL, '2026-06-21 23:46:39', '2026-06-21 23:46:39'),
(36, 'Keisha Hariyah S.Sos', '0063456708@student.smk11maret.sch.id', NULL, '$2y$12$ayofrA4htL8KeivHHV.8HeoL9g/.b2bGnNhEG8HecWW.dICai5vDm', 'STUDENT', NULL, 35, NULL, '2026-06-21 23:46:40', '2026-06-21 23:46:40'),
(37, 'Jaiman Latupono S.T.', '0080975064@student.smk11maret.sch.id', NULL, '$2y$12$pEFpNwuNk7bjRCe03WazJ.wm.9jBVnwW7iPHU3GY5QdkVof0Q3zui', 'STUDENT', NULL, 36, NULL, '2026-06-21 23:46:40', '2026-06-21 23:46:40'),
(38, 'Prasetya Sitorus M.Kom.', '0051887803@student.smk11maret.sch.id', NULL, '$2y$12$9Pa7W56Gr8y17gtcg/7D/uEith6nSQ/Jysm9OLRk2njHLqaX/Nf/q', 'STUDENT', NULL, 37, NULL, '2026-06-21 23:46:40', '2026-06-21 23:46:40'),
(39, 'Halim Catur Marbun', '0077678099@student.smk11maret.sch.id', NULL, '$2y$12$P7cQKHlvnZl8ss8RiC363uxWPufJ7YbvXtk9Dk810cE7QgvkYryjW', 'STUDENT', NULL, 38, NULL, '2026-06-21 23:46:40', '2026-06-21 23:46:40'),
(40, 'Paramita Yessi Padmasari S.I.Kom', '0024051643@student.smk11maret.sch.id', NULL, '$2y$12$/yaEAvWw6VopplcZZycpIOrFdL/DqRkshwFsL5o9m8hlBErNLdQlm', 'STUDENT', NULL, 39, NULL, '2026-06-21 23:46:41', '2026-06-21 23:46:41'),
(41, 'Cemani Sirait', '0035734544@student.smk11maret.sch.id', NULL, '$2y$12$cifny8OcVcyyRGLrUPGGxurIf1wKD1g3wQN2ewwbOIrsgbCUine9a', 'STUDENT', NULL, 40, NULL, '2026-06-21 23:46:41', '2026-06-21 23:46:41'),
(42, 'Laila Usada', '0015828003@student.smk11maret.sch.id', NULL, '$2y$12$/.5I1.UREzLNJEuGFKAiGONE4T77lbnyvvOi.T7sdDaaywriXR8Mm', 'STUDENT', NULL, 41, NULL, '2026-06-21 23:46:41', '2026-06-21 23:46:41'),
(43, 'Kardi Hutapea', '0062100396@student.smk11maret.sch.id', NULL, '$2y$12$kJ8St8HYt32iWZXon5jm0uERLwz1ktwa68JHMZgXeFIGEUBXAZTj.', 'STUDENT', NULL, 42, NULL, '2026-06-21 23:46:41', '2026-06-21 23:46:41'),
(44, 'Elisa Salimah Padmasari S.T.', '0052841872@student.smk11maret.sch.id', NULL, '$2y$12$4IUzc3pWlaevARyvCT7NK.Tstsq5VjYnK9TePsuxfHWkpVHADSIhG', 'STUDENT', NULL, 43, NULL, '2026-06-21 23:46:41', '2026-06-21 23:46:41'),
(45, 'Wirda Namaga', '0050214441@student.smk11maret.sch.id', NULL, '$2y$12$IARhrs01ZF4PEZasKybW8.tDJZxi8pehcHbMrWUrBgF3LdxLfuOTe', 'STUDENT', NULL, 44, NULL, '2026-06-21 23:46:42', '2026-06-21 23:46:42'),
(46, 'Wulan Hassanah S.H.', '0026803064@student.smk11maret.sch.id', NULL, '$2y$12$B05Y/u5WXbvKr0lJ.nIvYuDI5WioGleZJs5i1KULBmR0YN3d4IgOy', 'STUDENT', NULL, 45, NULL, '2026-06-21 23:46:42', '2026-06-21 23:46:42'),
(47, 'Kariman Jati Mandala', '0067068892@student.smk11maret.sch.id', NULL, '$2y$12$CXFo5KFset0PTx9xx3MLRe9WOKHVpHhMnof83RYrzTy5BnVr4u96G', 'STUDENT', NULL, 46, NULL, '2026-06-21 23:46:42', '2026-06-21 23:46:42'),
(48, 'Hani Yuniar M.M.', '0051228009@student.smk11maret.sch.id', NULL, '$2y$12$71sml5u5PX070.TNo0MWHOZn/5omlJIhD4IjGU/R.1QFxx.h7igHi', 'STUDENT', NULL, 47, NULL, '2026-06-21 23:46:42', '2026-06-21 23:46:42'),
(49, 'Hairyanto Halim S.E.', '0061221246@student.smk11maret.sch.id', NULL, '$2y$12$6CwB8OJ7frXTDYhtcFwAoO/TUw6SoYuHzPmlFZbykbtL.7Np1X9Ca', 'STUDENT', NULL, 48, NULL, '2026-06-21 23:46:42', '2026-06-21 23:46:42'),
(50, 'Teddy Pranata Thamrin M.Farm', '0080304596@student.smk11maret.sch.id', NULL, '$2y$12$g66gTPloseG0HFpFmXjJnuyHIUm/WHkLPZ41q9ty8KzQPCpLtldhG', 'STUDENT', NULL, 49, NULL, '2026-06-21 23:46:43', '2026-06-21 23:46:43'),
(51, 'Elvina Iriana Pudjiastuti S.E.', '0093136002@student.smk11maret.sch.id', NULL, '$2y$12$auTlB/O6N3MQ/088jDqsTeHF9Sr2q07627GBwRFDnxD8HwLVSp8BO', 'STUDENT', NULL, 50, NULL, '2026-06-21 23:46:43', '2026-06-21 23:46:43'),
(52, 'Sidiq Marpaung', '0042775456@student.smk11maret.sch.id', NULL, '$2y$12$FMgoHuMTitKaGoSi8Xg6VeNVfCGNXVOygvxSuQXgkTwBACY10mJ82', 'STUDENT', NULL, 51, NULL, '2026-06-21 23:46:43', '2026-06-21 23:46:43'),
(53, 'Farah Laras Hasanah S.H.', '0055307126@student.smk11maret.sch.id', NULL, '$2y$12$RBc38TalL.1yDyIOTrC/bOAfmX5bYwE8AQMmt9qETLP5lr4jzrjVK', 'STUDENT', NULL, 52, NULL, '2026-06-21 23:46:43', '2026-06-21 23:46:43'),
(54, 'Gaman Maheswara', '0003414204@student.smk11maret.sch.id', NULL, '$2y$12$VzWsbfXjtIAqV7w3HOhfBOe58CvU9VNMhaTZriGodENMxNB3U1Fje', 'STUDENT', NULL, 53, NULL, '2026-06-21 23:46:44', '2026-06-21 23:46:44'),
(55, 'Hesti Wastuti', '0092823242@student.smk11maret.sch.id', NULL, '$2y$12$UtsmP0kp7FGoY/n4a5h73exNHtIijlsZprHf2nn1zdY4ONtxbY9r2', 'STUDENT', NULL, 54, NULL, '2026-06-21 23:46:44', '2026-06-21 23:46:44'),
(56, 'Prasetya Sirait', '0019495809@student.smk11maret.sch.id', NULL, '$2y$12$qskkikeEjrZJR1w8PsCz8.6hcRsKKZKXgsi7/zPhYO/9PrZDXL83e', 'STUDENT', NULL, 55, NULL, '2026-06-21 23:46:44', '2026-06-21 23:46:44'),
(57, 'Purwa Kurnia Wijaya S.I.Kom', '0023508285@student.smk11maret.sch.id', NULL, '$2y$12$XVT3SXbzr2HRzNlZsIqWNOGBP9xWLFjXOIpZ6vsR6aeMiBE0OEHcu', 'STUDENT', NULL, 56, NULL, '2026-06-21 23:46:44', '2026-06-21 23:46:44'),
(58, 'Pardi Rosman Zulkarnain', '0065305863@student.smk11maret.sch.id', NULL, '$2y$12$k8tp99/3r5y64DgrHH4dX.ulciKimYU.gF6VV7k43IaowLUkbwf1W', 'STUDENT', NULL, 57, NULL, '2026-06-21 23:46:44', '2026-06-21 23:46:44'),
(59, 'Teguh Usman Waskita S.T.', '0099385021@student.smk11maret.sch.id', NULL, '$2y$12$0YT5Z9UuHrspfJttRU8Xoehm5z6poBxSlzVeQhOxE3mdR3vXLD0pK', 'STUDENT', NULL, 58, NULL, '2026-06-21 23:46:45', '2026-06-21 23:46:45'),
(60, 'Eko Pratama S.I.Kom', '0014234761@student.smk11maret.sch.id', NULL, '$2y$12$9D3SI0qI5WuTgO8g9jl1DuKJNwFa.oc/LmLt2r225qdoYaj6VUl1O', 'STUDENT', NULL, 59, NULL, '2026-06-21 23:46:45', '2026-06-21 23:46:45'),
(61, 'Vega Sinaga', '0080240722@student.smk11maret.sch.id', NULL, '$2y$12$eeO/cVKjGCSj/120EExdUeQ14saomuyvqO9t.2rNXW7.xNpuBrG2y', 'STUDENT', NULL, 60, NULL, '2026-06-21 23:46:45', '2026-06-21 23:46:45'),
(62, 'Hilda Rika Puspasari S.Ked', '0000688977@student.smk11maret.sch.id', NULL, '$2y$12$lFsejv/2ELwyOnx14Yd4W.Ah6OM/F/styuHnyJE27jcBBdQ5vUjTO', 'STUDENT', NULL, 61, NULL, '2026-06-21 23:46:45', '2026-06-21 23:46:45'),
(63, 'Sakura Hartati', '0027313183@student.smk11maret.sch.id', NULL, '$2y$12$O2giJ6/3/etFtos0X03siesKsvTDALV73Rjt57Ajq8ww3zbzUfClu', 'STUDENT', NULL, 62, NULL, '2026-06-21 23:46:45', '2026-06-21 23:46:45'),
(64, 'Bahuwarna Kurniawan', '0033045995@student.smk11maret.sch.id', NULL, '$2y$12$Qa4LZ8SXZ0KwC1Wc2jvmaewBTpl2pQWuNzNz49vhqqLihWKAUirs6', 'STUDENT', NULL, 63, NULL, '2026-06-21 23:46:46', '2026-06-21 23:46:46'),
(65, 'Cakrabuana Budiman S.T.', '0009349324@student.smk11maret.sch.id', NULL, '$2y$12$AfzNH//Wv/o2JDE8fS45lOGCMKvBjgSi7yZ6fTBF3D/4GCl818D5S', 'STUDENT', NULL, 64, NULL, '2026-06-21 23:46:46', '2026-06-21 23:46:46'),
(66, 'Halima Fathonah Melani S.Farm', '0036746780@student.smk11maret.sch.id', NULL, '$2y$12$jRuSpFa0zGEmJ6WoXHwSVuwKCKLHw6DcZ3LFg6KzBDXqC018KEP3.', 'STUDENT', NULL, 65, NULL, '2026-06-21 23:46:46', '2026-06-21 23:46:46'),
(67, 'Emong Hutapea', '0015440688@student.smk11maret.sch.id', NULL, '$2y$12$JTXQAHAulf1ype867QGHmutbDPUXhOZW14g8Gsil/9oCHwXtHUusi', 'STUDENT', NULL, 66, NULL, '2026-06-21 23:46:46', '2026-06-21 23:46:46'),
(68, 'Mulya Gaman Mangunsong', '0022465482@student.smk11maret.sch.id', NULL, '$2y$12$.CcGF8Q7dD1linyWDxF4key.A/AOc9qNIuB.D4Uf0ScckL.sxmhp6', 'STUDENT', NULL, 67, NULL, '2026-06-21 23:46:46', '2026-06-21 23:46:46'),
(69, 'Ganep Hidayat', '0028184469@student.smk11maret.sch.id', NULL, '$2y$12$pF8CKT6yEghmvxS/NlCONOCRD6.1q4AcdMyIfLck67BiXQokxNKSy', 'STUDENT', NULL, 68, NULL, '2026-06-21 23:46:47', '2026-06-21 23:46:47'),
(70, 'Maya Puspasari', '0015170225@student.smk11maret.sch.id', NULL, '$2y$12$pbd6tbPZulb1Ov3BEgc5lep095eqG/DnZZ2qtaFOvrxY8rZ.gate2', 'STUDENT', NULL, 69, NULL, '2026-06-21 23:46:47', '2026-06-21 23:46:47'),
(71, 'Limar Latupono', '0003776630@student.smk11maret.sch.id', NULL, '$2y$12$ecH9dFJglZMa/Wup2Gfs7eghXYNBb2OUHpnsqdSus75N44B36hNsq', 'STUDENT', NULL, 70, NULL, '2026-06-21 23:46:47', '2026-06-21 23:46:47'),
(72, 'Joko Sabar Suwarno M.TI.', '0042155506@student.smk11maret.sch.id', NULL, '$2y$12$JABTVko3xt0J3LBRt029V.AOBq2qTKJa9oJVFx5OF698oa9/HSJPe', 'STUDENT', NULL, 71, NULL, '2026-06-21 23:46:47', '2026-06-21 23:46:47'),
(73, 'Usyi Safitri', '0021831401@student.smk11maret.sch.id', NULL, '$2y$12$tedCyLbmDrU.2xHB7oBuE.ySOExOZQ68LRNJGzwYOZ/VE5issYR7G', 'STUDENT', NULL, 72, NULL, '2026-06-21 23:46:47', '2026-06-21 23:46:47'),
(74, 'Najwa Nasyidah', '0042246568@student.smk11maret.sch.id', NULL, '$2y$12$n6WRSBjLbLxbHCzVwAazYOMzDVXR3/2a4FRY.bC4wxXbO18ZtDSIe', 'STUDENT', NULL, 73, NULL, '2026-06-21 23:46:48', '2026-06-21 23:46:48'),
(75, 'Harsanto Prayogo Hutasoit M.M.', '0024014337@student.smk11maret.sch.id', NULL, '$2y$12$T0deOMHMNIAIj06g4h1jSuOzEcSidPBesSIpQ5vACmhn/Kg7Gu7ie', 'STUDENT', NULL, 74, NULL, '2026-06-21 23:46:48', '2026-06-21 23:46:48'),
(76, 'Pandu Sirait', '0031371304@student.smk11maret.sch.id', NULL, '$2y$12$1p39SsMuGC7yCXZ9T0iBe.ovbL25VHjPYMswfcmFtVPpUyPGqyMsC', 'STUDENT', NULL, 75, NULL, '2026-06-21 23:46:48', '2026-06-21 23:46:48'),
(77, 'Enteng Wijaya', '0077490639@student.smk11maret.sch.id', NULL, '$2y$12$a7EAlgT3Vm2H1tDL5hq9Qe6I.n3nZXSS13Iycj5.//WRUkLq0w0Au', 'STUDENT', NULL, 76, NULL, '2026-06-21 23:46:48', '2026-06-21 23:46:48'),
(78, 'Puti Suryatmi', '0084178292@student.smk11maret.sch.id', NULL, '$2y$12$zGcwgkMveKgcyrndwiFkl.cRIIrgrm45TXARTKhqvw2De81nfXPNG', 'STUDENT', NULL, 77, NULL, '2026-06-21 23:46:49', '2026-06-21 23:46:49'),
(79, 'Panca Kajen Nainggolan M.Kom.', '0039915181@student.smk11maret.sch.id', NULL, '$2y$12$bWeNZqyyvP4/TUU3hclxG.wM6w/5/pussJ1yIQljdcsikiqHvvLmG', 'STUDENT', NULL, 78, NULL, '2026-06-21 23:46:49', '2026-06-21 23:46:49'),
(80, 'Umaya Nababan', '0084041817@student.smk11maret.sch.id', NULL, '$2y$12$Hbfu0kLzT5OHFGNl0K4R3uqOrFHf0k2ELWHxwzeF2igYmD9WFJrAS', 'STUDENT', NULL, 79, NULL, '2026-06-21 23:46:49', '2026-06-21 23:46:49'),
(81, 'Natalia Rahayu', '0074514242@student.smk11maret.sch.id', NULL, '$2y$12$mjK.CFJ7FTD5V0DbCZtyIeXTT1fQZ8zjsB5LP.Q12b2Px9RmNaBeK', 'STUDENT', NULL, 80, NULL, '2026-06-21 23:46:49', '2026-06-21 23:46:49'),
(82, 'Akarsana Maheswara S.Kom', '0005914787@student.smk11maret.sch.id', NULL, '$2y$12$I913pGhT3QFyYHjOxatDAu7MX4Xs51Grs7h491wB5SMx5nEJZ/QGC', 'STUDENT', NULL, 81, NULL, '2026-06-21 23:46:49', '2026-06-21 23:46:49'),
(83, 'Ilsa Sudiati', '0071233177@student.smk11maret.sch.id', NULL, '$2y$12$6NT4TXSKb0WP1f0gEhpxW.GzwIVN5mZ6gTTcTpC9JDpGyrmk7GuD2', 'STUDENT', NULL, 82, NULL, '2026-06-21 23:46:50', '2026-06-21 23:46:50'),
(84, 'Qori Rahmawati', '0025401934@student.smk11maret.sch.id', NULL, '$2y$12$pcOA8vGK5/xWOt4Xr.CqTOiQfefRzJ2kneGy7OQ76dTThEkjra3ea', 'STUDENT', NULL, 83, NULL, '2026-06-21 23:46:50', '2026-06-21 23:46:50'),
(85, 'Kamidin Sihotang', '0053340198@student.smk11maret.sch.id', NULL, '$2y$12$dbVRWxeM1eH/UuRMJFUnF.RKu0LNA1yng.9SMUNSz1Vzq27VAwiEC', 'STUDENT', NULL, 84, NULL, '2026-06-21 23:46:50', '2026-06-21 23:46:50'),
(86, 'Tirta Sihotang', '0032749034@student.smk11maret.sch.id', NULL, '$2y$12$NRgrVCbI8JqvfvfE.RPlnuT/bk4UvgBuP7bml14cc0K37ADFZGT4C', 'STUDENT', NULL, 85, NULL, '2026-06-21 23:46:50', '2026-06-21 23:46:50'),
(87, 'Cawisono Wira Permadi', '0037878685@student.smk11maret.sch.id', NULL, '$2y$12$FKa5b98cP2b9d7CeUNE4UeYM.ZcuhL8JB6Tm4vsXi8O9fpm4kNURS', 'STUDENT', NULL, 86, NULL, '2026-06-21 23:46:50', '2026-06-21 23:46:50'),
(88, 'Kairav Among Hidayat', '0088579201@student.smk11maret.sch.id', NULL, '$2y$12$S..7/Ch6Phm.uzGNtMTcCO72rh6kP4x4IMSqJhTOk0tdEU8jFdrpy', 'STUDENT', NULL, 87, NULL, '2026-06-21 23:46:51', '2026-06-21 23:46:51'),
(89, 'Narji Nugroho M.Kom.', '0059013982@student.smk11maret.sch.id', NULL, '$2y$12$axPXODFPOB.Hgmzpy2DhIeWrkhmKYcv2no4.96noh00uG2rRD2LpC', 'STUDENT', NULL, 88, NULL, '2026-06-21 23:46:51', '2026-06-21 23:46:51'),
(90, 'Umay Umar Mangunsong S.E.I', '0049632586@student.smk11maret.sch.id', NULL, '$2y$12$LeMgKncArQprO18xSYNUkOrR4KMzBtgLtShOayosG.7hDhTqO/FLy', 'STUDENT', NULL, 89, NULL, '2026-06-21 23:46:51', '2026-06-21 23:46:51'),
(91, 'Narji Saputra', '0085327685@student.smk11maret.sch.id', NULL, '$2y$12$nqxreVfOI4gQnyHO8wjHX.rNvRgWNHzAHWNfjX3.KpARZD8vydJsK', 'STUDENT', NULL, 90, NULL, '2026-06-21 23:46:51', '2026-06-21 23:46:51'),
(92, 'Gara Prakasa', '0087278676@student.smk11maret.sch.id', NULL, '$2y$12$jpG9d9EAMbPVpp4OzKlMU.17fR4A47EPXrGnjms/C.soch4t9ycUW', 'STUDENT', NULL, 91, NULL, '2026-06-21 23:46:51', '2026-06-21 23:46:51'),
(93, 'Jaswadi Marpaung', '0002360589@student.smk11maret.sch.id', NULL, '$2y$12$NIpgNvY4jYYsIrum.WHouunP1xNPQHlLfMXc/hwSy9QpBBVhb5HtG', 'STUDENT', NULL, 92, NULL, '2026-06-21 23:46:52', '2026-06-21 23:46:52'),
(94, 'Lamar Saefullah', '0045938468@student.smk11maret.sch.id', NULL, '$2y$12$KR0NkpeiQutAt4KLU.DpsuqRI5cExkjosXaQ1/SV8KWN6AIHxzeky', 'STUDENT', NULL, 93, NULL, '2026-06-21 23:46:52', '2026-06-21 23:46:52'),
(95, 'Harjasa Suryono M.Kom.', '0058960467@student.smk11maret.sch.id', NULL, '$2y$12$Mej.NcIm.DPWhmv2MrYfBOTdZk7HX1Z/173iYhXemM35QK51IbRwS', 'STUDENT', NULL, 94, NULL, '2026-06-21 23:46:52', '2026-06-21 23:46:52'),
(96, 'Oskar Wijaya S.IP', '0005080023@student.smk11maret.sch.id', NULL, '$2y$12$fWYIUJuKqEMp4syHT6Xra.J0DZI0FVa68hRb/IIXZb3syKFHjOxBG', 'STUDENT', NULL, 95, NULL, '2026-06-21 23:46:52', '2026-06-21 23:46:52'),
(97, 'Eko Pratama', '0038690110@student.smk11maret.sch.id', NULL, '$2y$12$acPcm5w4vdj3dgDZQelDuukFb/ESjBikgrC1oY53uDFuCu.h6z6wi', 'STUDENT', NULL, 96, NULL, '2026-06-21 23:46:52', '2026-06-21 23:46:52'),
(98, 'Vanya Raina Astuti', '0095559955@student.smk11maret.sch.id', NULL, '$2y$12$B5zgwKB8F6QhM7XmuSN.b.IpoFR5Gz6w96OFvPsGmlm/LudNOMDvG', 'STUDENT', NULL, 97, NULL, '2026-06-21 23:46:53', '2026-06-21 23:46:53'),
(99, 'Lurhur Maulana', '0079702541@student.smk11maret.sch.id', NULL, '$2y$12$rHYFqab8w5LXA9QKm0QYX.IexLy4ezJ9XBd6tGqfFoWvN8V9a.aPq', 'STUDENT', NULL, 98, NULL, '2026-06-21 23:46:53', '2026-06-21 23:46:53'),
(100, 'Lega Capa Mandala', '0088982051@student.smk11maret.sch.id', NULL, '$2y$12$GnogscuQiyz2b4nf263L9.AU4ZDhxe9F2dPEqJGwAJnAibl2h9zFS', 'STUDENT', NULL, 99, NULL, '2026-06-21 23:46:53', '2026-06-21 23:46:53'),
(101, 'Zelaya Astuti', '0060832047@student.smk11maret.sch.id', NULL, '$2y$12$2VfyhhlnxX0l9kqqb5Nt7.zVgUh50K1MpFNLIxzsyHEumtjSqzJ3G', 'STUDENT', NULL, 100, NULL, '2026-06-21 23:46:53', '2026-06-21 23:46:53'),
(102, 'Legawa Ramadan', '0027456845@student.smk11maret.sch.id', NULL, '$2y$12$V/bBAr8S8hPnDZxvkVctNeA4KlaiejA4Xf6vhTbsZs8UdiqXGG8eG', 'STUDENT', NULL, 101, NULL, '2026-06-21 23:46:54', '2026-06-21 23:46:54'),
(103, 'Edi Halim', '0032710946@student.smk11maret.sch.id', NULL, '$2y$12$3ZOgjKsK26i.QavF.uQkXObdVwAUAfDQ1wpz4Wuw42vRabWgnyY9.', 'STUDENT', NULL, 102, NULL, '2026-06-21 23:46:54', '2026-06-21 23:46:54'),
(104, 'Elma Halimah', '0018941667@student.smk11maret.sch.id', NULL, '$2y$12$4lmy6UVgzlbdWQjI8vE5wu8CJAUyJqhUNCAt4MibXW2kkz6SsiS.m', 'STUDENT', NULL, 103, NULL, '2026-06-21 23:46:54', '2026-06-21 23:46:54'),
(105, 'Safina Mandasari', '0029821005@student.smk11maret.sch.id', NULL, '$2y$12$WdWfabJnjvrW59qaB9t.ZO9piMlqy3xROO9..FaSoFTjAzBD26VEi', 'STUDENT', NULL, 104, NULL, '2026-06-21 23:46:54', '2026-06-21 23:46:54'),
(106, 'Pandu Umar Napitupulu S.I.Kom', '0046984080@student.smk11maret.sch.id', NULL, '$2y$12$Bq6WI5cUd0oYupydwhK9jOQsRap7CwXJQ4qGqL7NWKdj6cUE3Go86', 'STUDENT', NULL, 105, NULL, '2026-06-21 23:46:54', '2026-06-21 23:46:54'),
(107, 'Natalia Patricia Zulaika S.Farm', '0021312875@student.smk11maret.sch.id', NULL, '$2y$12$61mwxZxJ94MKwye.1WD.meWBfMU43fdOrCFt7ATc69Okx0Yqlw0DO', 'STUDENT', NULL, 106, NULL, '2026-06-21 23:46:55', '2026-06-21 23:46:55'),
(108, 'Timbul Taswir Narpati', '0039236176@student.smk11maret.sch.id', NULL, '$2y$12$7SJJZA3Mk.IszSEx6RLXouj4WrKbjiA4p8BFvHD1OBenGxeFG8taS', 'STUDENT', NULL, 107, NULL, '2026-06-21 23:46:55', '2026-06-21 23:46:55'),
(109, 'Jumari Wijaya M.M.', '0064528074@student.smk11maret.sch.id', NULL, '$2y$12$/JYiIn9IbYyWSuSGvm2AzO.qzJ9.fBWHrfIznUvlgDsIl6oPxmGTS', 'STUDENT', NULL, 108, NULL, '2026-06-21 23:46:55', '2026-06-21 23:46:55'),
(110, 'Wardi Sinaga S.IP', '0074641171@student.smk11maret.sch.id', NULL, '$2y$12$QxoU4e3tCwTmr0WoKAITPOLvOva3/CXqVox6T0vH2MWjYQNudJr6m', 'STUDENT', NULL, 109, NULL, '2026-06-21 23:46:55', '2026-06-21 23:46:55'),
(111, 'Violet Kuswandari', '0054329172@student.smk11maret.sch.id', NULL, '$2y$12$iiDfa14LAYReWJmICkJsieFenSIcyYkJsLJauF0NtPxUUSs.glIaK', 'STUDENT', NULL, 110, NULL, '2026-06-21 23:46:55', '2026-06-21 23:46:55'),
(112, 'Sari Sudiati', '0052464324@student.smk11maret.sch.id', NULL, '$2y$12$AlaLCiBHi1tB/T7Aokjste6gfcSuV9EgcVEBt9Lf7uWnUddjVa9Ma', 'STUDENT', NULL, 111, NULL, '2026-06-21 23:46:56', '2026-06-21 23:46:56'),
(113, 'Melinda Hilda Haryanti', '0040705894@student.smk11maret.sch.id', NULL, '$2y$12$VMQqlrma.365WM183GZITerUkykMKld5287eyOZyDVPTkEf7fVRui', 'STUDENT', NULL, 112, NULL, '2026-06-21 23:46:56', '2026-06-21 23:46:56'),
(114, 'Natalia Sadina Pudjiastuti', '0091785097@student.smk11maret.sch.id', NULL, '$2y$12$H0SP68yk3symZQAXQ/oFgeJPKxX9dtD1Unq/vWNVX8kENLoXpXzfu', 'STUDENT', NULL, 113, NULL, '2026-06-21 23:46:56', '2026-06-21 23:46:56'),
(115, 'Victoria Aryani S.H.', '0011154196@student.smk11maret.sch.id', NULL, '$2y$12$KcHY.luG/FMyiTgGD0FLleF9moopq5/rNUC27u4hwBJ30g5idsXxi', 'STUDENT', NULL, 114, NULL, '2026-06-21 23:46:56', '2026-06-21 23:46:56'),
(116, 'Opung Dongoran', '0099054177@student.smk11maret.sch.id', NULL, '$2y$12$uVne.BuIvlYizr7g8lLfYeNBbqWDiz4mADhPWHgrqGd0QJJRiwV1i', 'STUDENT', NULL, 115, NULL, '2026-06-21 23:46:56', '2026-06-21 23:46:56'),
(117, 'Mahdi Caraka Kusumo', '0031627786@student.smk11maret.sch.id', NULL, '$2y$12$WrUGH41KgZkabI644PBswOmp2J7h8YRVhCKEX5N7MYz0Rud02aPna', 'STUDENT', NULL, 116, NULL, '2026-06-21 23:46:57', '2026-06-21 23:46:57'),
(118, 'Jane Yulianti', '0006002964@student.smk11maret.sch.id', NULL, '$2y$12$vJ629466vTZSFHFYIxMawOlgAobEEk.kyCgXSctEFZjuzUgawh/NW', 'STUDENT', NULL, 117, NULL, '2026-06-21 23:46:57', '2026-06-21 23:46:57'),
(119, 'Catur Malik Hakim S.Psi', '0074512786@student.smk11maret.sch.id', NULL, '$2y$12$gIHtN5Ve6epsi0/BBCVJXO7vWH5FKrwdHVM/aGbrnAb0pWfCDJ4ky', 'STUDENT', NULL, 118, NULL, '2026-06-21 23:46:57', '2026-06-21 23:46:57'),
(120, 'Purwanto Permadi', '0012343022@student.smk11maret.sch.id', NULL, '$2y$12$NMfRvEJoCSVfaz/45YdR2et/aGufzHZfSb8e46hgspU/0QLhItcVu', 'STUDENT', NULL, 119, NULL, '2026-06-21 23:46:57', '2026-06-21 23:46:57'),
(121, 'Sari Indah Kusmawati S.Sos', '0026323688@student.smk11maret.sch.id', NULL, '$2y$12$6HblnOq/zgcbOiluIC5ZDOsq.hbuCiF0atx.hWVIrS4ANwzc/V/dS', 'STUDENT', NULL, 120, NULL, '2026-06-21 23:46:58', '2026-06-21 23:46:58'),
(122, 'Lasmanto Budiman', '0077563957@student.smk11maret.sch.id', NULL, '$2y$12$EMPbcsApVYTjnG77Qz3VAu2uvumhEmwDCowio05.4i03A5lxwA21a', 'STUDENT', NULL, 121, NULL, '2026-06-21 23:46:58', '2026-06-21 23:46:58'),
(123, 'Irnanto Suwarno S.E.I', '0095742848@student.smk11maret.sch.id', NULL, '$2y$12$PCeNxt2RTCHIAUMM5DVK..vp1FQJKPz6h/XBsZFGpV1gExorLS5zO', 'STUDENT', NULL, 122, NULL, '2026-06-21 23:46:58', '2026-06-21 23:46:58'),
(124, 'Laras Maria Mayasari S.T.', '0065858572@student.smk11maret.sch.id', NULL, '$2y$12$7U08Ee2Q8UlaCfzzO6lPPunKRHI4pADgAE0WJpSvoXrMDf9aY.pRO', 'STUDENT', NULL, 123, NULL, '2026-06-21 23:46:58', '2026-06-21 23:46:58'),
(125, 'Lantar Hutapea S.I.Kom', '0094313869@student.smk11maret.sch.id', NULL, '$2y$12$2JQHuNx9lcBM2dmlz.XeoOqMvOr.0Z/64uDTI/.FTqXMBATqI5SFu', 'STUDENT', NULL, 124, NULL, '2026-06-21 23:46:58', '2026-06-21 23:46:58'),
(126, 'Mahmud Cawuk Jailani', '0080932057@student.smk11maret.sch.id', NULL, '$2y$12$AAma1BautcHHZ279bO1vJ.fFsBOqjYCmkk03z/eEtndq9kkoZlhlS', 'STUDENT', NULL, 125, NULL, '2026-06-21 23:46:59', '2026-06-21 23:46:59'),
(127, 'Rachel Palastri', '0066443264@student.smk11maret.sch.id', NULL, '$2y$12$BIUwYTdK4ifZ.QRzoWKAku9wJQpUvqqojEdhS2.TBzMbmKTWfICbi', 'STUDENT', NULL, 126, NULL, '2026-06-21 23:46:59', '2026-06-21 23:46:59'),
(128, 'Yani Ika Fujiati', '0083107953@student.smk11maret.sch.id', NULL, '$2y$12$ReTaYi25qjGwU8Rch2ztAOXr6eNmUomUGr0W2QLQu5GSnlNaaCJLW', 'STUDENT', NULL, 127, NULL, '2026-06-21 23:46:59', '2026-06-21 23:46:59'),
(129, 'Eka Jinawi Santoso', '0089972582@student.smk11maret.sch.id', NULL, '$2y$12$1f2.Am2HYIGM5qAA8H./6eVzFHSuiC07MWnMfcR664.3x4F1q1ZMS', 'STUDENT', NULL, 128, NULL, '2026-06-21 23:46:59', '2026-06-21 23:46:59'),
(130, 'Jefri Hidayat', '0008480733@student.smk11maret.sch.id', NULL, '$2y$12$YSsX4N.cAud7IG5AIf24AuDKx3V0jHD8nBIs9CMmZ3Y9TgwCmhAnS', 'STUDENT', NULL, 129, NULL, '2026-06-21 23:46:59', '2026-06-21 23:46:59'),
(131, 'Cakrawangsa Mandala', '0077758207@student.smk11maret.sch.id', NULL, '$2y$12$8Xi3eYaEJA0e6jDNRmZwZO2Iw3H6g18TlarOPzVJ.8rIDiwva1zZi', 'STUDENT', NULL, 130, NULL, '2026-06-21 23:47:00', '2026-06-21 23:47:00'),
(132, 'Mutia Raina Puspasari S.Sos', '0020153775@student.smk11maret.sch.id', NULL, '$2y$12$JpzXiL3O79dAbKSpLjz.QuVeLbv3IuGABH/GWF8uIxSisF9IIpivW', 'STUDENT', NULL, 131, NULL, '2026-06-21 23:47:00', '2026-06-21 23:47:00'),
(133, 'Rahmi Elma Aryani', '0004444743@student.smk11maret.sch.id', NULL, '$2y$12$xFJoFZjgWECvmvjAY9i79.TRdqtq9QIzPaWbtcVIYboQAL9sYdaNa', 'STUDENT', NULL, 132, NULL, '2026-06-21 23:47:00', '2026-06-21 23:47:00'),
(134, 'Vivi Mayasari S.Sos', '0020326782@student.smk11maret.sch.id', NULL, '$2y$12$bDbmouaRPyfmaswB.U.55OGiIQTFM4j0tNBEOjYoYCSzCQIW5dtwC', 'STUDENT', NULL, 133, NULL, '2026-06-21 23:47:00', '2026-06-21 23:47:00'),
(135, 'Cornelia Agustina', '0026742621@student.smk11maret.sch.id', NULL, '$2y$12$VebNOjeIoWLPqzpGAWOMA.hgvWc2uqXD5bl8KyyCeYjiE0BkuQNxS', 'STUDENT', NULL, 134, NULL, '2026-06-21 23:47:00', '2026-06-21 23:47:00'),
(136, 'Emin Simbolon', '0082579041@student.smk11maret.sch.id', NULL, '$2y$12$/byZXk8eDOTwWUcDfvpL9.fTRyOx6wCEdbHtxs7In2KUXINNnMuGy', 'STUDENT', NULL, 135, NULL, '2026-06-21 23:47:01', '2026-06-21 23:47:01');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `academic_calendars`
--
ALTER TABLE `academic_calendars`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indeks untuk tabel `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id_kelas`),
  ADD UNIQUE KEY `classes_nama_kelas_unique` (`nama_kelas`),
  ADD KEY `classes_id_guru_wali_foreign` (`id_guru_wali`);

--
-- Indeks untuk tabel `class_subjects`
--
ALTER TABLE `class_subjects`
  ADD PRIMARY KEY (`id_class_subject`),
  ADD UNIQUE KEY `class_subjects_id_kelas_id_mapel_unique` (`id_kelas`,`id_mapel`),
  ADD KEY `class_subjects_id_mapel_foreign` (`id_mapel`),
  ADD KEY `class_subjects_id_guru_mutlak_foreign` (`id_guru_mutlak`);

--
-- Indeks untuk tabel `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `grade_configs`
--
ALTER TABLE `grade_configs`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `jp_schedules`
--
ALTER TABLE `jp_schedules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `jp_schedules_shift_hari_waktu_mulai_unique` (`shift`,`hari`,`waktu_mulai`);

--
-- Indeks untuk tabel `kbm_sessions`
--
ALTER TABLE `kbm_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kbm_sessions_tanggal_id_kelas_jam_ke_unique` (`tanggal`,`id_kelas`,`jam_ke`),
  ADD KEY `kbm_sessions_id_timetable_foreign` (`id_timetable`),
  ADD KEY `kbm_sessions_id_guru_aktual_foreign` (`id_guru_aktual`);

--
-- Indeks untuk tabel `learning_objectives`
--
ALTER TABLE `learning_objectives`
  ADD PRIMARY KEY (`id_tp`),
  ADD KEY `learning_objectives_id_guru_foreign` (`id_guru`),
  ADD KEY `learning_objectives_id_mapel_foreign` (`id_mapel`);

--
-- Indeks untuk tabel `live_exams`
--
ALTER TABLE `live_exams`
  ADD PRIMARY KEY (`id_exam`),
  ADD KEY `live_exams_id_kbm_session_foreign` (`id_kbm_session`),
  ADD KEY `live_exams_id_bank_foreign` (`id_bank`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indeks untuk tabel `questionnaires`
--
ALTER TABLE `questionnaires`
  ADD PRIMARY KEY (`id_questionnaire`);

--
-- Indeks untuk tabel `questionnaire_questions`
--
ALTER TABLE `questionnaire_questions`
  ADD PRIMARY KEY (`id_q_question`),
  ADD KEY `questionnaire_questions_id_questionnaire_foreign` (`id_questionnaire`);

--
-- Indeks untuk tabel `questionnaire_responses`
--
ALTER TABLE `questionnaire_responses`
  ADD PRIMARY KEY (`id_response`),
  ADD UNIQUE KEY `unique_response` (`id_questionnaire`,`id_siswa`,`id_guru_target`,`id_q_question`),
  ADD KEY `questionnaire_responses_id_siswa_foreign` (`id_siswa`),
  ADD KEY `questionnaire_responses_id_guru_target_foreign` (`id_guru_target`),
  ADD KEY `questionnaire_responses_id_q_question_foreign` (`id_q_question`);

--
-- Indeks untuk tabel `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id_question`),
  ADD KEY `questions_id_bank_foreign` (`id_bank`);

--
-- Indeks untuk tabel `question_banks`
--
ALTER TABLE `question_banks`
  ADD PRIMARY KEY (`id_bank`),
  ADD KEY `question_banks_id_guru_foreign` (`id_guru`),
  ADD KEY `question_banks_id_mapel_foreign` (`id_mapel`);

--
-- Indeks untuk tabel `report_cards`
--
ALTER TABLE `report_cards`
  ADD PRIMARY KEY (`id_rapor`),
  ADD KEY `report_cards_id_siswa_foreign` (`id_siswa`),
  ADD KEY `report_cards_id_class_subject_foreign` (`id_class_subject`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id_siswa`),
  ADD UNIQUE KEY `students_nis_unique` (`nis`),
  ADD UNIQUE KEY `students_nisn_unique` (`nisn`),
  ADD KEY `students_id_kelas_foreign` (`id_kelas`);

--
-- Indeks untuk tabel `student_answers`
--
ALTER TABLE `student_answers`
  ADD PRIMARY KEY (`id_answer`),
  ADD UNIQUE KEY `student_answers_id_exam_id_siswa_id_question_unique` (`id_exam`,`id_siswa`,`id_question`),
  ADD KEY `student_answers_id_siswa_foreign` (`id_siswa`),
  ADD KEY `student_answers_id_question_foreign` (`id_question`);

--
-- Indeks untuk tabel `student_grades`
--
ALTER TABLE `student_grades`
  ADD PRIMARY KEY (`id_grade`),
  ADD KEY `student_grades_id_siswa_foreign` (`id_siswa`),
  ADD KEY `student_grades_id_tp_foreign` (`id_tp`);

--
-- Indeks untuk tabel `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id_mapel`),
  ADD UNIQUE KEY `subjects_nama_mapel_unique` (`nama_mapel`);

--
-- Indeks untuk tabel `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id_guru`),
  ADD UNIQUE KEY `teachers_kode_guru_unique` (`kode_guru`);

--
-- Indeks untuk tabel `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD PRIMARY KEY (`id_teacher_subject`),
  ADD UNIQUE KEY `teacher_subjects_id_guru_id_mapel_unique` (`id_guru`,`id_mapel`),
  ADD KEY `teacher_subjects_id_mapel_foreign` (`id_mapel`);

--
-- Indeks untuk tabel `timetable`
--
ALTER TABLE `timetable`
  ADD PRIMARY KEY (`id_timetable`),
  ADD KEY `timetable_id_class_subject_foreign` (`id_class_subject`),
  ADD KEY `timetable_id_guru_foreign` (`id_guru`),
  ADD KEY `timetable_original_guru_id_foreign` (`original_guru_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_id_guru_foreign` (`id_guru`),
  ADD KEY `users_id_siswa_foreign` (`id_siswa`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `academic_calendars`
--
ALTER TABLE `academic_calendars`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `classes`
--
ALTER TABLE `classes`
  MODIFY `id_kelas` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT untuk tabel `class_subjects`
--
ALTER TABLE `class_subjects`
  MODIFY `id_class_subject` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=372;

--
-- AUTO_INCREMENT untuk tabel `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `grade_configs`
--
ALTER TABLE `grade_configs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jp_schedules`
--
ALTER TABLE `jp_schedules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT untuk tabel `kbm_sessions`
--
ALTER TABLE `kbm_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=176;

--
-- AUTO_INCREMENT untuk tabel `learning_objectives`
--
ALTER TABLE `learning_objectives`
  MODIFY `id_tp` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `live_exams`
--
ALTER TABLE `live_exams`
  MODIFY `id_exam` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `questionnaires`
--
ALTER TABLE `questionnaires`
  MODIFY `id_questionnaire` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `questionnaire_questions`
--
ALTER TABLE `questionnaire_questions`
  MODIFY `id_q_question` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `questionnaire_responses`
--
ALTER TABLE `questionnaire_responses`
  MODIFY `id_response` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `questions`
--
ALTER TABLE `questions`
  MODIFY `id_question` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `question_banks`
--
ALTER TABLE `question_banks`
  MODIFY `id_bank` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `report_cards`
--
ALTER TABLE `report_cards`
  MODIFY `id_rapor` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `students`
--
ALTER TABLE `students`
  MODIFY `id_siswa` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT untuk tabel `student_answers`
--
ALTER TABLE `student_answers`
  MODIFY `id_answer` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `student_grades`
--
ALTER TABLE `student_grades`
  MODIFY `id_grade` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id_mapel` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT untuk tabel `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id_guru` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  MODIFY `id_teacher_subject` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT untuk tabel `timetable`
--
ALTER TABLE `timetable`
  MODIFY `id_timetable` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1081;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_id_guru_wali_foreign` FOREIGN KEY (`id_guru_wali`) REFERENCES `teachers` (`id_guru`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `class_subjects`
--
ALTER TABLE `class_subjects`
  ADD CONSTRAINT `class_subjects_id_guru_mutlak_foreign` FOREIGN KEY (`id_guru_mutlak`) REFERENCES `teachers` (`id_guru`) ON DELETE SET NULL,
  ADD CONSTRAINT `class_subjects_id_kelas_foreign` FOREIGN KEY (`id_kelas`) REFERENCES `classes` (`id_kelas`) ON DELETE CASCADE,
  ADD CONSTRAINT `class_subjects_id_mapel_foreign` FOREIGN KEY (`id_mapel`) REFERENCES `subjects` (`id_mapel`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `kbm_sessions`
--
ALTER TABLE `kbm_sessions`
  ADD CONSTRAINT `kbm_sessions_id_guru_aktual_foreign` FOREIGN KEY (`id_guru_aktual`) REFERENCES `teachers` (`id_guru`) ON DELETE SET NULL,
  ADD CONSTRAINT `kbm_sessions_id_timetable_foreign` FOREIGN KEY (`id_timetable`) REFERENCES `timetable` (`id_timetable`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `learning_objectives`
--
ALTER TABLE `learning_objectives`
  ADD CONSTRAINT `learning_objectives_id_guru_foreign` FOREIGN KEY (`id_guru`) REFERENCES `teachers` (`id_guru`) ON DELETE CASCADE,
  ADD CONSTRAINT `learning_objectives_id_mapel_foreign` FOREIGN KEY (`id_mapel`) REFERENCES `subjects` (`id_mapel`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `live_exams`
--
ALTER TABLE `live_exams`
  ADD CONSTRAINT `live_exams_id_bank_foreign` FOREIGN KEY (`id_bank`) REFERENCES `question_banks` (`id_bank`) ON DELETE CASCADE,
  ADD CONSTRAINT `live_exams_id_kbm_session_foreign` FOREIGN KEY (`id_kbm_session`) REFERENCES `kbm_sessions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `questionnaire_questions`
--
ALTER TABLE `questionnaire_questions`
  ADD CONSTRAINT `questionnaire_questions_id_questionnaire_foreign` FOREIGN KEY (`id_questionnaire`) REFERENCES `questionnaires` (`id_questionnaire`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `questionnaire_responses`
--
ALTER TABLE `questionnaire_responses`
  ADD CONSTRAINT `questionnaire_responses_id_guru_target_foreign` FOREIGN KEY (`id_guru_target`) REFERENCES `teachers` (`id_guru`) ON DELETE CASCADE,
  ADD CONSTRAINT `questionnaire_responses_id_q_question_foreign` FOREIGN KEY (`id_q_question`) REFERENCES `questionnaire_questions` (`id_q_question`) ON DELETE CASCADE,
  ADD CONSTRAINT `questionnaire_responses_id_questionnaire_foreign` FOREIGN KEY (`id_questionnaire`) REFERENCES `questionnaires` (`id_questionnaire`) ON DELETE CASCADE,
  ADD CONSTRAINT `questionnaire_responses_id_siswa_foreign` FOREIGN KEY (`id_siswa`) REFERENCES `students` (`id_siswa`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_id_bank_foreign` FOREIGN KEY (`id_bank`) REFERENCES `question_banks` (`id_bank`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `question_banks`
--
ALTER TABLE `question_banks`
  ADD CONSTRAINT `question_banks_id_guru_foreign` FOREIGN KEY (`id_guru`) REFERENCES `teachers` (`id_guru`) ON DELETE CASCADE,
  ADD CONSTRAINT `question_banks_id_mapel_foreign` FOREIGN KEY (`id_mapel`) REFERENCES `subjects` (`id_mapel`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `report_cards`
--
ALTER TABLE `report_cards`
  ADD CONSTRAINT `report_cards_id_class_subject_foreign` FOREIGN KEY (`id_class_subject`) REFERENCES `class_subjects` (`id_class_subject`) ON DELETE CASCADE,
  ADD CONSTRAINT `report_cards_id_siswa_foreign` FOREIGN KEY (`id_siswa`) REFERENCES `students` (`id_siswa`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_id_kelas_foreign` FOREIGN KEY (`id_kelas`) REFERENCES `classes` (`id_kelas`);

--
-- Ketidakleluasaan untuk tabel `student_answers`
--
ALTER TABLE `student_answers`
  ADD CONSTRAINT `student_answers_id_exam_foreign` FOREIGN KEY (`id_exam`) REFERENCES `live_exams` (`id_exam`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_answers_id_question_foreign` FOREIGN KEY (`id_question`) REFERENCES `questions` (`id_question`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_answers_id_siswa_foreign` FOREIGN KEY (`id_siswa`) REFERENCES `students` (`id_siswa`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `student_grades`
--
ALTER TABLE `student_grades`
  ADD CONSTRAINT `student_grades_id_siswa_foreign` FOREIGN KEY (`id_siswa`) REFERENCES `students` (`id_siswa`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_grades_id_tp_foreign` FOREIGN KEY (`id_tp`) REFERENCES `learning_objectives` (`id_tp`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD CONSTRAINT `teacher_subjects_id_guru_foreign` FOREIGN KEY (`id_guru`) REFERENCES `teachers` (`id_guru`) ON DELETE CASCADE,
  ADD CONSTRAINT `teacher_subjects_id_mapel_foreign` FOREIGN KEY (`id_mapel`) REFERENCES `subjects` (`id_mapel`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `timetable`
--
ALTER TABLE `timetable`
  ADD CONSTRAINT `timetable_id_class_subject_foreign` FOREIGN KEY (`id_class_subject`) REFERENCES `class_subjects` (`id_class_subject`) ON DELETE CASCADE,
  ADD CONSTRAINT `timetable_id_guru_foreign` FOREIGN KEY (`id_guru`) REFERENCES `teachers` (`id_guru`) ON DELETE SET NULL,
  ADD CONSTRAINT `timetable_original_guru_id_foreign` FOREIGN KEY (`original_guru_id`) REFERENCES `teachers` (`id_guru`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_id_guru_foreign` FOREIGN KEY (`id_guru`) REFERENCES `teachers` (`id_guru`) ON DELETE SET NULL,
  ADD CONSTRAINT `users_id_siswa_foreign` FOREIGN KEY (`id_siswa`) REFERENCES `students` (`id_siswa`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
