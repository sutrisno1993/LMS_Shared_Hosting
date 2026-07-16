@echo off
title LMS 11 Maret - Build Assets
color 0B
echo.
echo =======================================================================
echo              BUILDING FRONTEND ASSETS FOR PRODUCTION
echo =======================================================================
echo.
echo Menjalankan npm run build...
echo.
call npm run build
echo.
echo =======================================================================
echo  BUILD SELESAI!
echo =======================================================================
echo.
pause
