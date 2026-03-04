:: Script para limpeza automatizada de cache do Microsoft Teams
:: Criado para otimizar troubleshooting no suporte técnico

@echo off
echo Limpando cache do Microsoft Teams...
echo.

echo [1/3] Fechando Microsoft Teams...
taskkill /f /im ms-teams.exe 2>nul
taskkill /f /im Teams.exe 2>nul
timeout /t 2 >nul

echo [2/3] Removendo cache...
set "CACHE_PATH=%localappdata%\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams"

:: Pausa antes de apagar
timeout /t 2 /nobreak >nul

:: Apagar tudo (pastas e arquivos)
rmdir /s /q "%CACHE_PATH%" 2>nul

:: Pausa depois de apagar
timeout /t 2 /nobreak >nul
echo OK
echo.

echo [3/3] Reiniciando Microsoft Teams...
timeout /t 1 /nobreak >nul

:: TENTAR ABRIR DE 3 FORMAS DIFERENTES

:: Método 1: Protocolo 
start "" "ms-teams:" >nul 2>&1
timeout /t 1 >nul

:: Método 2: Executável da Microsoft Store
if exist "%localappdata%\Microsoft\WindowsApps\ms-teams.exe" (
    start "" "%localappdata%\Microsoft\WindowsApps\ms-teams.exe"
    timeout /t 1 >nul
)

:: Método 3: Teams Clássico
if exist "%ProgramFiles%\Microsoft\Teams\current\Teams.exe" (
    start "" "%ProgramFiles%\Microsoft\Teams\current\Teams.exe"
)

echo Cache limpo e Teams reiniciado
timeout /t 1 /nobreak >nul