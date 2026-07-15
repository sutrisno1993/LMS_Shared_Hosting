@echo off
title Hubungkan LMS ke Hotspot HP
echo.
echo ========================================================
echo   MENJALANKAN SERVER LMS UNTUK DIAKSES DARI HP
echo ========================================================
echo.

:: Get Wi-Fi IP using PowerShell
for /f "usebackq tokens=*" %%i in (`powershell -NoProfile -Command "(Get-NetIPAddress -InterfaceAlias 'Wi-Fi' -AddressFamily IPv4).IPAddress"`) do (
    set IP_ADDRESS=%%i
)

if "%IP_ADDRESS%"=="" (
    echo [ERR] Tidak dapat menemukan IP Address Wi-Fi.
    echo Pastikan komputer sudah tersambung ke Hotspot HP Anda.
    pause
    exit /b
)

echo Komputer Anda terhubung ke Hotspot HP dengan IP: %IP_ADDRESS%
echo.
echo Silakan salin link berikut dan kirimkan ke WhatsApp Anda:
echo.
echo ========================================================
echo http://%IP_ADDRESS%:8000
echo ========================================================
echo.
echo Menjalankan server Laravel (C:\xampp\php\php.exe artisan serve)...
echo Jangan tutup jendela ini selama Anda mengakses dari HP.
echo Tekan Ctrl + C untuk menghentikan server.
echo.

C:\xampp\php\php.exe artisan serve --host 0.0.0.0 --port 8000
pause
