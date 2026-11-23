@echo off
rem bp: las herramientas de BasicPlus por linea de ordenes ("bp help"). V9 #853.
rem Plantilla: scripts/montar-zip.sh pone el nombre del jar (@JAR@) y los finales de linea de Windows.
rem La consola, en UTF-8 mientras dura (los mensajes llevan acentos); al acabar, como estaba.
setlocal
for /f "tokens=2 delims=:." %%a in ('chcp') do set "BP_CP=%%a"
chcp 65001 >nul
java -Dfile.encoding=UTF-8 -cp "%~dp0@JAR@" basicplus.bp.Bp %*
set "BP_RC=%ERRORLEVEL%"
if defined BP_CP chcp %BP_CP% >nul
exit /b %BP_RC%
