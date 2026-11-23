@echo off
rem bp: las herramientas de BasicPlus por linea de ordenes ("bp help"), en el REPOSITORIO. V9 #853 y #854.
rem El del ZIP va sobre el jar del IDE; este, sobre el del compilador, que lleva bp, el compilador y la VM Java
rem (hay que haberlo construido: mvn -f toolchain/lexer-java/pom.xml install). La VM-C de "bp run --c", la de
rem bpgenvm-c/build (make; con ventana, make LVGL=1).
rem La consola, en UTF-8 mientras dura (los mensajes llevan acentos); al acabar, como estaba.
setlocal
for /f "tokens=2 delims=:." %%a in ('chcp') do set "BP_CP=%%a"
chcp 65001 >nul
java -Dfile.encoding=UTF-8 -cp "%~dp0toolchain\lexer-java\target\basicplus-frontend.jar" basicplus.bp.Bp %*
set "BP_RC=%ERRORLEVEL%"
if defined BP_CP chcp %BP_CP% >nul
exit /b %BP_RC%
