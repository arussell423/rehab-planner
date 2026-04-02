@echo off
title Rehab Planner - Local Server
echo ============================================
echo   Rehab Planner - Starting Local Server
echo ============================================
echo.

:: Try Python 3 first
python --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Server starting on http://localhost:8080
    echo.
    echo To access from your phone:
    echo   1. Make sure phone is on the same WiFi
    echo   2. Find your PC's IP address (shown below)
    echo   3. Open on phone: http://YOUR-PC-IP:8080
    echo.
    for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4"') do (
        set IP=%%a
        echo Your PC IP address: %%a
    )
    echo.
    echo Press Ctrl+C to stop the server
    echo.
    cd /d "%~dp0"
    python -m http.server 8080
    goto end
)

:: Try Python launcher
py --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    cd /d "%~dp0"
    py -m http.server 8080
    goto end
)

echo Python not found.
echo.
echo ALTERNATIVE - Open directly in browser:
echo   File: %~dp0index.html
echo.
echo For phone access, you need Python installed:
echo   https://www.python.org/downloads/
echo.
pause
:end
