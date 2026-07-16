@echo off
title LMS 11 Maret - Dev Server Starter
color 0A
echo.
echo =======================================================================
echo              STARTING LMS 11 MARET DEVELOPMENT SERVER
echo =======================================================================
echo.

:: Get IP Address (Exclude 169.254.x.x APIPA addresses)
set IP_ADDRESS=127.0.0.1
for /f "usebackq tokens=*" %%i in (`powershell -NoProfile -Command "$ip = (Get-NetIPAddress -InterfaceAlias 'Wi-Fi' -AddressFamily IPv4 -ErrorAction SilentlyContinue | Where-Object { $_.IPAddress -notlike '169.254.*' }).IPAddress; if (-not $ip) { $ip = (Get-NetIPAddress -InterfaceAlias 'Ethernet' -AddressFamily IPv4 -ErrorAction SilentlyContinue | Where-Object { $_.IPAddress -notlike '169.254.*' }).IPAddress }; if (-not $ip) { $ip = (Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue | Where-Object { $_.IPAddress -ne '127.0.0.1' -and $_.IPAddress -notlike '169.254.*' -and $_.InterfaceAlias -notmatch 'Loopback' }).IPAddress }; if ($ip) { if ($ip -is [array]) { write-host $ip[0] } else { write-host $ip } } else { write-host '127.0.0.1' }"`) do (
    set IP_ADDRESS=%%i
)

:: Define PHP Path (Default to XAMPP, fallback to system PATH)
set PHP_PATH=C:\xampp\php\php.exe
if not exist "%PHP_PATH%" (
    set PHP_PATH=php
)

:: Determine Vite host parameter
if "%IP_ADDRESS%"=="127.0.0.1" (
    set VITE_HOST=localhost
) else (
    set VITE_HOST=%IP_ADDRESS%
)

echo [+] IP Address Terdeteksi: %IP_ADDRESS%
echo [+] Executable PHP: %PHP_PATH%
echo [+] Vite Host: %VITE_HOST%
echo.
echo -----------------------------------------------------------------------
echo  1. Menjalankan Laravel Backend (Port 8000)...
echo -----------------------------------------------------------------------
:: Run Laravel serve in a new command window
start "LMS - Laravel Backend" cmd /k ""%PHP_PATH%" artisan serve --host 0.0.0.0 --port 8000"

echo.
echo -----------------------------------------------------------------------
echo  2. Menjalankan Vite Frontend (npm run dev)...
echo -----------------------------------------------------------------------
:: Run npm run dev with specific host IP so public/hot uses a resolvable address
start "LMS - Vite Frontend" cmd /k "npm run dev -- --host %VITE_HOST%"

echo.
echo =======================================================================
echo  KEDUA SERVER SUDAH BERJALAN!
echo =======================================================================
echo  * Akses dari Komputer Lokal:
echo    http://localhost:8000
echo.
if not "%IP_ADDRESS%"=="127.0.0.1" (
    echo  * Akses dari HP (Pastikan Satu Jaringan Wi-Fi/Hotspot):
    echo    http://%IP_ADDRESS%:8000
    echo =======================================================================
)
echo  Catatan:
echo  - Pastikan Apache ^& MySQL di XAMPP Control Panel sudah AKTIF.
echo  - Jangan tutup 2 jendela Command Prompt baru yang terbuka.
echo  - Anda aman menutup jendela ini sekarang.
echo =======================================================================
echo.
pause
