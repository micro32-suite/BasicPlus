@echo off
rem El IDE del REPO (la version en curso). Arranca desde la raiz del repo para que el
rem BpVM.cfg que vea sea el del repo, no el de la carpeta desde la que se invoque.
rem V9 #873: los argumentos, al IDE (--ia o --ia=<carpeta>: la IA pide manejar el IDE). Por este cd, una
rem carpeta relativa seria desde la raiz del repo: con --ia, la ruta absoluta.
cd /d C:\lenguajes\pm
java -jar C:\lenguajes\pm\toolchain\BpIde\target\BpIde-8.1.jar %*
