#!/usr/bin/env bash
# ============================================================================
# montar-zip.sh — arma el ZIP de distribución de la suite (Micro32 Suite: BasicPlus y JC,
# el IDE, las dos VMs y el firmware) para Windows. Hasta V8.0 se llamaba BasicPlus-X-win.
#
# POR QUÉ UN SCRIPT Y NO A MANO: el ZIP es lo que se prueba en H13 y lo que se
# publica, y tiene que ser el MISMO. Montarlo a mano una vez para probar y otra
# para publicar es exactamente la forma de que difieran sin que nadie lo note.
# Aquí se monta una vez, se sella, y de ahí salen las dos cosas.
#
# La ESTRUCTURA no es un gusto mío: sale de lo que el código busca.
#   packs/       IdePrefs.installSubdir("packs")      → biblioteca de packs
#   guiones/     IdePrefs.installSubdir("guiones")    → los guiones del IDE (V9 #891)
#   bin/         SimRunner.locateExe                  → micro simulado + SDL2
#                FrmMain (Run Window), Bp.laVmC        → la VM-C con ventana (V9 #853)
#   bp, bp.bat   (la documentación: `bp build`, `bp run`) → la línea de órdenes (V9 #853)
#   bpgenvm-c/   AotBuild.autodetectBpgenvm           → include/ + src/ del AOT
#   docs/        IdePrefs.docsDir()                   → la ayuda (F1)
#   firmware/    (no lo busca nadie: es para el usuario)
# Si alguien cambia esas rutas en el código, este script deja de servir — y se
# nota en la prueba de instalación (bloque J del guión), que es su red.
#
#   bash scripts/montar-zip.sh
# ============================================================================
set -euo pipefail

RAIZ="$(cd "$(dirname "$0")/.." && pwd)"
VER="$(sed -n "s@.*<version>\(.*\)</version>.*@\1@p" "$RAIZ/toolchain/BpIde/pom.xml" | head -1)"
# V9 #853 — la etiqueta del ZIP: la versión, o la de MONTAR_ETIQUETA para uno de prueba (el jar sigue siendo el de VER).
ETIQUETA="${MONTAR_ETIQUETA:-$VER}"
NOMBRE="Micro32-Suite-${ETIQUETA}-win"     # V8.1 (#802): el nombre de la suite (hasta V8.0, BasicPlus-X-win)
OUT="$RAIZ/dist/$NOMBRE"
JAR="$RAIZ/toolchain/BpIde/target/BpIde-${VER}.jar"

echo "== Micro32 Suite $ETIQUETA =="

# V9 #853 — UN ZIP PUBLICADO NO SE PISA: es lo que se bajó la gente y el oráculo de «¿lo he roto yo hoy?», y esto
# empieza con un `rm -rf` de su carpeta. Publicado = su .sha256 está en git (se sube al publicar). Con la versión de
# uno publicado en el pom (entre dos versiones, el pom sigue en la última), un ZIP de prueba lleva otra etiqueta.
if git -C "$RAIZ" ls-files --error-unmatch "dist/$NOMBRE.zip.sha256" >/dev/null 2>&1; then
    echo "dist/$NOMBRE.zip está PUBLICADO (su .sha256 está en git): no se pisa."
    echo "Para un ZIP de prueba:  MONTAR_ETIQUETA=${VER}-prueba bash scripts/montar-zip.sh"
    exit 1
fi

# El jar manda: si no está, no hay nada que empaquetar (y la versión sale del pom,
# así que un jar viejo con otro nombre se detecta aquí y no en la release).
[ -f "$JAR" ] || { echo "FALTA $JAR — 'mvn package' en BpIde primero"; exit 1; }

# #679 (10-oct, el D1 de V7) — LOS PACKS, LOS DE LA COMPILACIÓN. `packs/` no está en el repo (son
# artefactos: .gitignore) y nadie lo rellena solo: V7 iba a publicarse SIN los packs de la GUI —sin
# los que ninguna placa con pantalla pinta, porque LVGL ya no va en las imágenes— y con un
# SQLite.pack del 27-sep, con las copias de la stdlib que #623 quitó. Aquí se exige que estén los
# cinco y que cada uno sea, byte a byte, el que sale de su .bpbuild.
for par in "Stdlib.pack:bpstdlib/out/Stdlib.pack" \
           "SQLite.pack:bpstdlib/sqlite/out/SQLite.pack" \
           "Gui.pack:bpstdlib/gui/out/Gui.pack" \
           "GuiMini.pack:bpstdlib/gui/mini/out/GuiMini.pack" \
           "DriverSpi.pack:bpstdlib/gui/drivers/spi/out/DriverSpi.pack"; do
    pk="${par%%:*}"; src="${par#*:}"
    if [ ! -f "$RAIZ/$src" ]; then
        echo "FALTA $src — compila su .bpbuild (packs/README.md) antes de montar el ZIP"; exit 1
    fi
    if [ ! -f "$RAIZ/packs/$pk" ] || ! cmp -s "$RAIZ/packs/$pk" "$RAIZ/$src"; then
        echo "packs/$pk FALTA o NO es el de la compilación — cp $src packs/"; exit 1
    fi
done

rm -rf "$OUT"; mkdir -p "$OUT"/{bin,packs,guiones,docs,firmware,bpstdlib,bpdevices,samples}

# --- el IDE -----------------------------------------------------------------
cp "$JAR" "$OUT/"
printf '@echo off\r\njava -jar "%%~dp0BpIde-%s.jar" %%*\r\n' "$VER" > "$OUT/bpide.bat"

# --- bp: la línea de órdenes (V9 #853) ----------------------------------------
# La documentación manda teclear `bp build` y `bp run`; hasta V9 mandaba `java -jar basicplus-frontend.jar` y
# `java -jar bpgenvm.jar`, que no van en el ZIP. Los dos lanzadores, sobre el jar del IDE (lleva el compilador y la VM
# Java): bp.bat para cmd y PowerShell, y bp para bash. Las plantillas, en scripts/zip/: aquí se les pone el nombre del
# jar, y al .bat los finales de línea de Windows (cmd los quiere así; la plantilla puede salir del disco con LF).
sed -e 's/\r$//' -e "s/@JAR@/BpIde-${VER}.jar/" -e 's/$/\r/' "$RAIZ/scripts/zip/bp.bat" > "$OUT/bp.bat"
sed -e 's/\r$//' -e "s/@JAR@/BpIde-${VER}.jar/" "$RAIZ/scripts/zip/bp" > "$OUT/bp"
chmod +x "$OUT/bp"

# --- la guía para IA (V9 H1.3, #854) ------------------------------------------
# AGENTS.md, el nombre que buscan los agentes, y un CLAUDE.md de una línea que la incluye: Claude Code lee AGENTS.md sólo
# si no hay ningún CLAUDE.md en la carpeta de trabajo ni por encima (su documentación, «memory»), y con el import la lee
# siempre. La plantilla, en scripts/zip/ (la misma que el IDE deja en cada proyecto, con la ruta de la instalación); aquí,
# en la raíz, las rutas relativas.
sed -e 's/\r$//' -e 's#@INSTALACION@##g' "$RAIZ/scripts/zip/AGENTS.md" > "$OUT/AGENTS.md"
printf '@AGENTS.md\n' > "$OUT/CLAUDE.md"
if grep -q '@INSTALACION@' "$OUT/AGENTS.md"; then echo "AGENTS.md: quedan marcas @INSTALACION@ sin poner"; exit 1; fi

# --- BpVM.cfg: cómo encuentra el compilador la stdlib -----------------------
# SIN esto el paquete no compila NADA que importe la stdlib. El ZIP lleva los
# .mod en bpstdlib/, pero `locateImportMod` sólo mira fromPath, outDir, el dir
# del fuente y `dependencyPaths` — y dependencyPaths se rellena leyendo este
# fichero. Sin él, `import Core` no resuelve, el compilador lo OMITE y los
# errores salen luego en el código del usuario (H13, Pico: ExcCatchTest daba 4
# errores que no eran suyos).
#
# Las rutas van RELATIVAS a propósito: VmConfig.resolveRelativo las resuelve
# contra el directorio de ESTE fichero, no contra el directorio de trabajo. Así
# la instalación se puede mover de sitio y arrancar desde donde sea.
# `packsDir` (12-sep, F1 de V6): el IDE encuentra `packs/` solo (IdePrefs.installSubdir),
# pero el compilador por linea de comandos —el que viaja dentro del jar— resuelve
# `import SQLite` leyendo `packsDir` de ESTE fichero (Main.dirsDePacks). Sin la linea,
# desde la carpeta desplegada `SqlDemo.bp` no compilaba («no se localizo .bp ni .bpi
# para import 'SQLite'; se omitira») y el IDE si: la misma instalacion, dos respuestas.
cat > "$OUT/BpVM.cfg" <<'CFG'
{
  "stdlibDir":  "./bpstdlib",
  "devicesDir": "./bpdevices",
  "packsDir":   "./packs"
}
CFG

# --- micro simulado (el IDE lo busca en bin/) --------------------------------
# ⚠️ EL SIM TIENE QUE LLEVAR GRAFICOS, y hay que COMPROBARLO (22-ago).
#    `make sim` a secas lo construye SIN LVGL —el valor por defecto es LVGL=0— y
#    el binario resultante arranca igual, sirve ficheros, ejecuta programas y
#    habla wire. Lo unico que NO hace es PINTAR: dice "panel sin pantalla" y las
#    demos graficas no van. Se publico asi en el ZIP del 20-ago sin que nadie lo
#    notara, con el SDL2.dll al lado sin usar, y lo encontro Eduardo probando el
#    IDE recien instalado.
#    Se construye con:   make LVGL=1 sim
#    Y se distingue por el import de SDL2.dll: el de sin graficos no lo tiene.
if ! strings "$RAIZ/bpgenvm-c/build/bpvm-sim.exe" 2>/dev/null | grep -qx "SDL2.dll"; then
    echo "ERROR: bpvm-sim.exe esta construido SIN LVGL (no importa SDL2.dll)." >&2
    echo "       Las demos graficas no funcionarian en el micro simulado." >&2
    echo "       Reconstruyelo con:  cd bpgenvm-c && make LVGL=1 sim" >&2
    exit 1
fi
cp "$RAIZ/bpgenvm-c/build/bpvm-sim.exe" "$OUT/bin/"
cp "$RAIZ/bpgenvm-c/build/SDL2.dll"     "$OUT/bin/"

# --- la VM-C, con su ventana: la de «Run Window» y `bp run --c` (V9 #853) ------
# Hasta V9 no iba en el ZIP, y Run Window la buscaba en bpgenvm-c/build subiendo desde el .bp: con el ZIP, nunca.
# Como el simulado, CON LVGL y comprobado: sin él ejecuta igual, pero una GUI no abre ventana. Va junto a SDL2.dll.
#    Se construye con:   make LVGL=1
if ! strings "$RAIZ/bpgenvm-c/build/bpgenvm-c.exe" 2>/dev/null | grep -qx "SDL2.dll"; then
    echo "ERROR: bpgenvm-c.exe esta construido SIN LVGL (no importa SDL2.dll)." >&2
    echo "       Run Window no abriria ventana." >&2
    echo "       Reconstruyelo con:  cd bpgenvm-c && make LVGL=1" >&2
    exit 1
fi
cp "$RAIZ/bpgenvm-c/build/bpgenvm-c.exe" "$OUT/bin/"

# --- AOT: sólo include/ + src/, que es lo que comprueba looksLikeBpgenvm ------
mkdir -p "$OUT/bpgenvm-c"
cp -r "$RAIZ/bpgenvm-c/include" "$OUT/bpgenvm-c/"
cp -r "$RAIZ/bpgenvm-c/src"     "$OUT/bpgenvm-c/"

# --- biblioteca + stdlib ----------------------------------------------------
cp "$RAIZ/packs/"*.pack        "$OUT/packs/"
python -I -X utf8 "$RAIZ/scripts/guiones_doc.py" || exit 1   # V9 #891: sus valores, los de la instalación
cp "$RAIZ/guiones/"*.guion     "$OUT/guiones/"
cp "$RAIZ/bpstdlib/"*.mod      "$OUT/bpstdlib/"
cp "$RAIZ/bpdevices/"*.mod     "$OUT/bpdevices/"

# Los FUENTES de la stdlib también (hallazgo 28, 4-ago). No es un extra para
# curiosos: el IDE resuelve las dependencias del device de forma TRANSITIVA, y
# descubre los imports de cada módulo LEYENDO SU .bp (resolveDeviceDeps →
# parseImports). Sin los fuentes, `Gui` no delata que importa `Json` → Json no
# se sube → en un dispositivo VIRGEN no arranca NINGUNA demo gráfica. En el repo
# nunca se vio porque ahí los .bp están; se destapó en la P4 Waveshare recién
# particionada, la única placa de la campaña con /lib vacío.
cp "$RAIZ/bpstdlib/"*.bp       "$OUT/bpstdlib/"
cp "$RAIZ/bpdevices/"*.bp      "$OUT/bpdevices/" 2>/dev/null || true

# --- documentación: los volúmenes + sus imágenes + los anexos que enlazan ----
#
# SOLO-WEB: hay HTML que vive en docs/ para que lo sirva GitHub Pages pero que
# NO viaja en el paquete. Hoy sólo la guía rápida: es una hoja para IMPRIMIR o
# tener abierta al lado, y su sitio es una URL que se abre en un segundo — no
# enterrada en un ZIP de 9 MB (criterio de Eduardo, 6-ago-2026). La ayuda la
# enlaza con su URL absoluta, así que desde la instalación también se llega.
SOLO_WEB="cheatsheet.html"
for f in "$RAIZ/docs/"*.html; do
    case " $SOLO_WEB " in *" $(basename "$f") "*) continue;; esac
    cp "$f" "$OUT/docs/"
done
cp -r "$RAIZ/docs/img" "$OUT/docs/"
mkdir -p "$OUT/docs/en" && cp "$RAIZ/docs/en/"*.html "$OUT/docs/en/"
# V9 #854 — la plantilla anotada de un proyecto: la referencia (§16) la nombra, y no es un .md (no la saca el barrido
# de abajo). Un resto de #853: la documentación la mandaba leer y el ZIP no la traía.
cp "$RAIZ/docs/BpBuild.example" "$OUT/docs/"

# Los anexos .md NO se eligen a mano: se sacan de lo que la ayuda enlaza. En docs/
# hay 44 .md y la mayoría son notas internas de desarrollo; elegir a ojo cuáles se
# publican es la forma de dejarse uno y que F1 dé un 404 en la instalación — que es
# exactamente lo que arregló #363.
for f in $(grep -ho 'href="[^"]*\.md"' "$RAIZ/docs/"*.html | sed 's/href="//;s/"//' | sort -u); do
    cp "$RAIZ/docs/$f" "$OUT/docs/"
done
for f in $(grep -ho 'href="[^"]*\.md"' "$RAIZ/docs/en/"*.html | sed 's/href="//;s/"//' | sort -u); do
    case "$f" in
        ../*) cp "$RAIZ/docs/${f#../}" "$OUT/docs/"    ;;
        *)    cp "$RAIZ/docs/en/$f"    "$OUT/docs/en/" ;;
    esac
done

# V9 H1.7 (#858 b): la documentación en Markdown, sacada de su HTML por scripts/docs_md.py, para leerla con una
# herramienta —una IA—: el código, sin el troceo del coloreado. La de las páginas en inglés y la de la chuleta (cuyo
# HTML sigue sólo en la web). Antes, que esté al día: si no, el ZIP llevaría otra cosa que su HTML.
if ! python -I -X utf8 "$RAIZ/scripts/docs_md.py" --comprobar; then
    echo "ERROR: la documentación en Markdown no está al día: python -I -X utf8 scripts/docs_md.py" >&2
    exit 1
fi
cp "$RAIZ/docs/cheatsheet.html.md" "$OUT/docs/"
cp "$RAIZ/docs/en/"*.html.md "$OUT/docs/en/"

# --- firmware: las imágenes SELLADAS, no las de los directorios de compilación
cp "$RAIZ/dist/firmware/"*.uf2 "$RAIZ/dist/firmware/"*.bin \
   "$RAIZ/dist/firmware/SHA256SUMS.txt" "$OUT/firmware/"
# V9 #910 — y que sean las de esta stdlib (una imagen repone en cada arranque su I2c, su Gpio…, delante del Stdlib.pack) y
# de esta versión (#907: la dicen al conectar, y el IDE la compara con la suya).
# En un ZIP de prueba (MONTAR_ETIQUETA), sólo se dice: las imágenes se rehacen al publicar.
if ! python -I -X utf8 "$RAIZ/bpgenvm-c/scripts/check_mods_embebidos.py" --imagenes "$OUT/firmware" > "$OUT/../imagenes.txt"; then
    echo "  AVISO: imágenes que no son las de hoy:" >&2
    grep FALLO "$OUT/../imagenes.txt" | sed 's/^/    /' >&2
    if [ -z "${MONTAR_ETIQUETA:-}" ]; then
        echo "  ERROR: no se publica con ellas: se rehacen (y dist/firmware, con ellas)" >&2
        rm -f "$OUT/../imagenes.txt"; rm -rf "$OUT"; exit 1
    fi
fi
rm -f "$OUT/../imagenes.txt"
# El README de dist/firmware es la nota INTERNA (habla de H13, PUBLICAR.md, «ayer»):
# al usuario le vale INSTALAR_FIRMWARE.md, que viaja en docs/. Un LEEME corto apunta.
cat > "$OUT/firmware/LEEME.md" <<'LEEME'
# firmware/ — las nueve imágenes de BasicPlus

| fichero | placas |
|---|---|
| `bpvm_pico.uf2` | Raspberry Pi Pico 2 · Adafruit Metro RP2350 |
| `bpvm_esp32_merged.bin` | ESP32-S3 |
| `bpvm_esp32c3_merged.bin` | ESP32-C3 |
| `bpvm_esp32c5_merged.bin` | ESP32-C5 (Waveshare ESP32-C5-Touch-LCD-2.8) |
| `bpvm_esp32c6_merged.bin` | ESP32-C6 (y la Waveshare ESP32-C6-LCD-1.3, con su pantalla por packs) |
| `bpvm_esp32p4_merged.bin` | ESP32-P4-Function-EV · Waveshare ESP32-P4 4.3" (la P4 de la revisión v1.x) |
| `bpvm_esp32p4x_merged.bin` | ESP32-P4X-Function-EV (la P4 de la revisión v3.x) |
| `bpvm_stm32_nucleo.bin` | Nucleo-U575ZI-Q |
| `bpvm_stm32_dk2.bin` | Discovery STM32U5G9J-DK2 |

Y uno más, que no es de BasicPlus: `p4_c6_esp_hosted_3.0.9_merged.bin`, el firmware
de la ESP32-C6 que pone la WiFi y el Bluetooth en la P4 de Waveshare (de Espressif,
ESP-Hosted, con licencia Apache 2.0).

Cómo se graba cada uno: `docs/INSTALAR_FIRMWARE.md` (`docs/en/INSTALAR_FIRMWARE.md`).
Los `_merged.bin` van al **offset 0** (bootloader + particiones + aplicación en un
solo fichero). `SHA256SUMS.txt` sella los diez: `sha256sum -c SHA256SUMS.txt`.

**La pantalla no va en las imágenes**: en las placas con pantalla (la C5, la C6, las
P4 y la DK2) hay que grabar además el pack de la GUI, que está en `packs/` junto con
los demás (Stdlib, SQLite, Gui, GuiMini y DriverSpi). Qué pack lleva cada placa y cómo
se graba desde el IDE: `docs/INSTALAR_FIRMWARE.md`, «Los packs de la placa».
`boards/` trae las plantillas de `/sys/board.json` del RP2350 (la Metro lo necesita
para su nombre y su NeoPixel; la Pico 2 no).
LEEME
# Las plantillas de /sys/board.json (RP2350): INSTALAR_FIRMWARE y QUICKSTART mandan
# subir la de la Metro y no viajaban (lo vio el verificador del ZIP, 12-sep).
mkdir -p "$OUT/firmware/boards"
cp "$RAIZ/bpgenvm-c/pico/boards/"*.json "$OUT/firmware/boards/"

# --- samples: los del REPO, no los de mi copia de trabajo --------------------
# `git ls-files` y no `samples/*.bp`: en la copia de trabajo viven los ficheros de
# depuración del día (NB2P0.bp, FsMinC30.bp, Hola.bp...), que no pintan nada en una
# publicación. Lo que está en el repo es lo que se ha revisado; lo demás es mío.
# OJO con el patrón entre comillas: es pathspec de git, no glob del shell, y ahí el
# `*` SÍ atraviesa `/` — sin el filtro se traía los .bp de los proyectos y los
# aplanaba aquí, pisando ficheros distintos con el mismo nombre.
# 1) LO SUELTO DE LA RAIZ — y ya no solo los .bp. El patron era 'samples/*.bp',
#    asi que un sample que se apoya en un asset a su lado viajaba MANCO: eso es
#    el hallazgo 25 (GuiImageDemo pide testimg.png, que se quedaba en el repo y
#    daba pantalla en blanco desde la instalacion). Ahora viaja todo lo que este
#    EN GIT en la raiz de samples/ — los .bp y lo que necesiten.
(cd "$RAIZ" && git ls-files -z -- 'samples/*') | while IFS= read -r -d '' f; do
    case "${f#samples/}" in */*) continue ;; esac
    cp "$RAIZ/$f" "$OUT/samples/"
done

# 2) LAS SUBCARPETAS. Antes habia aqui un `case ... */*) continue` que DESCARTABA
#    en silencio todo lo que viviera en un subdirectorio, mas tres proyectos
#    copiados a mano. Consecuencia (hallazgo 35): `samples/benchmarks/` entero se
#    quedaba fuera y con el `Bench.bp` — o sea que el AOT, el hito grande de V4,
#    se publicaba SIN UN SOLO EJEMPLO. Y `aottest/`, que es el proyecto que
#    genera el .mdn, tampoco salia.
#
#    El arreglo NO es copiarlo todo: aqui dentro hay material interno que no
#    pinta nada en una publicacion (reproducciones minimas, diagnostico de GC).
#    Hace falta ELEGIR. Lo que no puede ser es que olvidarse sea SILENCIOSO —
#    por eso, debajo, el guardian.
PUBLICAR_DIRS="benchmarks errores external formdemo imageproject overlay packlib plugins pruebas sampleproject"
#    pruebas/ entra en V9 (23-nov, #859): un proyecto con sus pruebas (bp test, Assert y una GUI que se prueba
#    sola), que citan la referencia §16 y la guía gráfica §24.4, en los dos idiomas.
#    overlay/ entra en V8 (20-nov): el ejemplo de los overlays (H9, #786), que el
#    manual cita en los dos idiomas («Un ejemplo completo, en samples/overlay»).
#    packlib/ entra en V5 (decidido el 20-ago): es el caso MINIMO de un pack
#    ejecutable (#365), y los packs son una de las cabeceras de esta version.
#    La referencia los documenta entera (§15) y quien lea eso quiere el ejemplo.
#    external/ y plugins/ no son demos: son las DEPENDENCIAS de tres samples de
#    la raiz que importan por ruta (appwithfromimpl -> plugins/filelogger.mod,
#    frompathtest -> external/helper.mod). Sin ellas esos tres no compilan desde
#    la instalacion. Misma familia que el hallazgo 6.
INTERNAS_DIRS="aottest formev formmin guipack holes resources pendientes"
#    guipack/       = la SONDA del pack de la GUI (V7/H6, #623): un programa de prueba que habla con
#                     la LVGL de la imagen y con la del pack a la vez; necesita una placa con el pack
#                     grabado (Eduardo, 8-oct: «Gui2 lo puedes dejar como programa de test»). Decidido
#                     en el F1 de V7 (12-oct), al pararse el script por ella.
#    pendientes/    = ejemplos que DEBERIAN funcionar y hoy no, por un fallo nuestro.
#                     Se quedan en el repo porque son la prueba de regresion —el dia
#                     que compilen, esta arreglado— pero NO se publican: un ejemplo
#                     roto en el paquete es peor que no tenerlo. Entro el 22-ago con
#                     appv1lsp/appv2 (la sustitucion de Liskov entre interfaces de
#                     modulo, que el compilador rechaza aunque su propio codigo diga
#                     que debe valer). OJO: NO van a errores/, que es para los que
#                     fallan A PROPOSITO — mezclarlos camuflaria el bug entre los
#                     fallos por diseno, que es justo lo que esa carpeta evita.
#    aottest/       = banco de pruebas del AOT POR PROYECTO, no un ejemplo. Nacio
#                     en H12, cuando la arquitectura del .mdn habia que escribirla
#                     a mano en el .bpbuild ("target": "arm"). En H11 eso cambio:
#                     EL TARGET LO DICE LA PLACA, y un .bp SUELTO compila su .mdn
#                     igual — samples/benchmarks/Bench.bp lo demuestra (105x
#                     medidos el 6-ago desde la instalacion limpia).
#                     Al ser proyecto es el UNICO caso que todavia puede apagarse
#                     solo (si el .bpbuild pierde aot.enabled) o apuntar a la ISA
#                     equivocada — y eso ULTIMO PASO DE VERDAD: el IDE reescribio
#                     el fichero con "riscv" tras una prueba en el P4, y asi se
#                     colo en un ZIP. En una Pico o una STM32 ese ejemplo habria
#                     intentado compilar RISC-V para una placa ARM.
#                     El AOT lo ensena Bench, que es suelto y coge el target de
#                     la placa. Decision de Eduardo, 6-ago.
#    formev/formmin  = reproducciones minimas de Forms, andamio de depuracion.
#    holes/          = diagnostico de agujeros de GC (21 ficheros).
#    resources/      = copia duplicada de testimg.png; el bueno es el de la raiz.

for p in $PUBLICAR_DIRS; do
    [ -d "$RAIZ/samples/$p" ] || continue
    cp -r "$RAIZ/samples/$p" "$OUT/samples/"
    # Y FUERA su out/. Un proyecto se publica con sus FUENTES; el .mod/.pack lo
    # hace `Build Project` en la máquina del usuario. Copiarlo tal cual metía en
    # el ZIP el out/ de mi copia de trabajo: en formdemo/out/ vivían 26 .mod v5
    # —los 23 demos de Gui y L2Lib, los mismos que se colaron en bpstdlib— y de
    # ahí salían. Ojo: esto NO lo arregla .gitignore, porque aquí se copia del
    # disco, no del índice de git.
    # A CUALQUIER profundidad, no sólo en la raíz del proyecto: en formdemo había
    # además un src/out/ de una compilación antigua. Ir quitándolos de uno en uno
    # es cómo se te escapa el siguiente.
    find "$OUT/samples/$p" -type d -name out -prune -exec rm -rf {} +
done

# 3) EL GUARDIAN — esto es el arreglo de verdad del hallazgo 35. Las dos listas
#    de arriba hay que mantenerlas a mano (elegir que ve el usuario es una
#    DECISION, no se puede automatizar), pero olvidarse ya no sale gratis: si
#    aparece en samples/ una subcarpeta CON FICHEROS EN GIT que no este en
#    ninguna de las dos, el paquete NO SE MONTA.
#    Sin esto, `benchmarks/` llevaba meses cayendose del ZIP sin que nadie lo
#    notara — y no se noto hasta que Eduardo fue a buscar el Bench en la
#    instalacion y no estaba.
#    Filtro "con ficheros en git": las carpetas de build (out/) y la basura de un
#    comando mal escrito no tienen nada versionado y no molestan.
DESCONOCIDAS=""
for d in "$RAIZ"/samples/*/; do
    n="$(basename "$d")"
    [ -n "$(cd "$RAIZ" && git ls-files -- "samples/$n")" ] || continue
    case " $PUBLICAR_DIRS $INTERNAS_DIRS " in
        *" $n "*) ;;
        *) DESCONOCIDAS="$DESCONOCIDAS $n" ;;
    esac
done
if [ -n "$DESCONOCIDAS" ]; then
    echo "  ERROR: subcarpeta(s) de samples/ sin decidir:$DESCONOCIDAS"
    echo "  Anadelas a PUBLICAR_DIRS (van al ZIP) o a INTERNAS_DIRS (se quedan),"
    echo "  en scripts/montar-zip.sh. Que este script NO decida por ti es aposta."
    exit 1
fi

# --- samplesJC: los ejemplos de JC (V8), los del REPO, como los de samples/ ----
# Eduardo (20-nov): «Sí, en el ZIP». El volumen de JC cita samplesJC/JsonDemo.jc,
# probado en placa; sin esto, el ZIP no lo llevaba. Sólo lo que está en git.
mkdir -p "$OUT/samplesJC"
(cd "$RAIZ" && git ls-files -z -- 'samplesJC/*') | while IFS= read -r -d '' f; do
    case "${f#samplesJC/}" in */*) continue ;; esac
    cp "$RAIZ/$f" "$OUT/samplesJC/"
done
if [ -z "$(ls "$OUT/samplesJC" 2>/dev/null)" ]; then
    echo "  ERROR: samplesJC/ salió vacío (el volumen de JC cita samplesJC/JsonDemo.jc)"; exit 1
fi


# --- red: ni un solo .mod caducado dentro del paquete ------------------------
# En H13 (a1 Pico) el IDE subió a la placa un L2Lib.mod v5 y el sample l2app murió
# con exit 3. No era el compilador: dentro de bpstdlib/ vivían 24 .mod rancios que
# nadie había puesto ahí a propósito —23 demos de Gui y L2Lib, restos de una
# compilación vieja—, y `resolveDeviceDeps` da prioridad de stdlib a CUALQUIER
# módulo presente en stdlibDir. O sea que el intruso no era adorno: mandaba sobre
# el módulo recién generado.
#
# La regla es una y no hay lista que mantener: si un .mod del paquete no es del
# formato ACTUAL, el paquete no sale. Vale igual para un intruso que para una
# stdlib que se quede atrás en la próxima subida de formato. El formato actual es
# MOD9 (V7/H2 `#523`: el enlace tardío, la cadena entera en MOD9 desde el 17-sep;
# docs/MOD_FORMAT.md §13) — la VM aún carga MOD7 y MOD8, pero uno de ésos en el
# paquete es un .mod que nadie recompiló, y eso es justo lo que esta guarda caza
# (el 12-sep cazó… a sí misma: decía MOD6; y el 24-sep, al cerrar H2, seguía en MOD7
# — habría parado el paquete de V7). Al subir de formato se tocan LAS DOS líneas.
MOD_ACTUAL="MOD9"
MOD_VIEJOS='MOD[5-8]'   # los que se buscan DENTRO de los packs (abajo)
# Y el invariante de bpstdlib/, que es donde vivían los intrusos: un módulo de la
# librería estándar TIENE su fuente al lado. Un .mod suelto ahí no es stdlib —
# y no es inocuo: `resolveDeviceDeps` da prioridad de stdlib a cualquier módulo
# presente en stdlibDir, así que taparía al recién compilado. Esto no se puede
# poner en .gitignore (los .mod buenos SÍ se versionan): tiene que ser un check.
INTRUSOS=""
for m in "$RAIZ"/bpstdlib/*.mod; do
    b="$(basename "$m" .mod)"
    [ -f "$RAIZ/bpstdlib/$b.bp" ] || INTRUSOS="$INTRUSOS $b.mod"
done
if [ -n "$INTRUSOS" ]; then
    echo "  INTRUSOS en bpstdlib/ (.mod sin su .bp al lado):$INTRUSOS"
    echo "  Un .mod ahí manda sobre el que acabas de compilar. Sácalo de bpstdlib."
    rm -rf "$OUT"; exit 1
fi

# El MISMO invariante, pero sobre el PAQUETE MONTADO (hallazgo 28). El de arriba
# mira el repo; éste mira lo que se va a publicar, que es donde estaba roto: el
# ZIP llevaba 26 .mod y CERO .bp, y con eso la resolución transitiva del IDE se
# queda muda (descubre los imports leyendo el .bp de cada módulo). Consecuencia
# real medida en placa: en un device virgen no arranca ninguna demo gráfica,
# porque nadie sube Json y Gui depende de él.
# Es la 3ª vez en la campaña que algo funciona en el repo y está roto desde el
# ZIP (hallazgos 6, 25 y 28) — por eso el check va aquí y no en la confianza.
FALTAN=""
for m in "$OUT"/bpstdlib/*.mod; do
    b="$(basename "$m" .mod)"
    [ -f "$OUT/bpstdlib/$b.bp" ] || FALTAN="$FALTAN $b.bp"
done
if [ -n "$FALTAN" ]; then
    echo "  El PAQUETE no lleva los fuentes de la stdlib:$FALTAN"
    echo "  Sin ellos el IDE no resuelve las deps transitivas y las demos"
    echo "  gráficas no arrancan en un dispositivo virgen (hallazgo 28)."
    rm -rf "$OUT"; exit 1
fi

MALOS=""
while IFS= read -r m; do
    [ "$(head -c4 "$m")" = "$MOD_ACTUAL" ] || MALOS="$MALOS
  $(printf '%-6s %s' "$(head -c4 "$m")" "${m#$OUT/}")"
done < <(find "$OUT" -name '*.mod')
# Y DENTRO de los packs (12-sep): packs/Stdlib.pack llevaba 27 .mod MOD6 del
# 20-ago —la stdlib de V5— y viajó en el ZIP montado esa tarde sin que esta guarda
# lo viera, porque un pack es un solo fichero. Un pack se graba en la zona de packs
# y en el P4 ESA zona gana a /lib (#493): un Stdlib.pack rancio tapa la stdlib del
# firmware a todos los programas. Se buscan los magics antiguos dentro de cada .pack
# (24-sep: era sólo MOD6, escrito a mano; con MOD9 se escapaban un MOD7 y un MOD8).
for pk in "$OUT"/packs/*.pack; do
    [ -f "$pk" ] || continue
    # #688 (12-oct, el F1 de V7) — sin NINGÚN .mod viejo dentro (lo bueno, desde #623), grep devuelve 1 y con
    # `pipefail` el script moría aquí EN SILENCIO, tras el título: «ninguno» no es un error.
    viejos="$( { grep -a -o -E "$MOD_VIEJOS" "$pk" || true; } | wc -l)"
    if [ "$viejos" -gt 0 ]; then
        MALOS="$MALOS
  $(printf '%-6s %s  (lleva %s modulos de un formato anterior dentro: %s)' "PACK" "${pk#$OUT/}" "$viejos" "$(grep -a -o -E "$MOD_VIEJOS" "$pk" | sort -u | tr '\n' ' ')")"
    fi
done
if [ -n "$MALOS" ]; then
    echo "  .mod CADUCADOS en el paquete (se esperaba $MOD_ACTUAL):$MALOS"
    echo "  Un .mod que la VM rechaza no se publica. Regenéralo o quítalo."
    rm -rf "$OUT"; exit 1
fi
# Y que Stdlib.pack SEA la stdlib que viaja en el paquete (#537, 23-sep): la guarda
# de arriba sólo ve un magic viejo, y el pack del 18-sep era MOD9 — al día de
# formato pero de OTRA stdlib (sin las clases del lenguaje en Core: LINK_ERROR en el
# micro simulado con un StringBuilder). Byte a byte contra los bpstdlib/*.mod.
if ! bash "$RAIZ/compat/stdlib_pack.sh" "$OUT/packs/Stdlib.pack"; then
    echo "  El Stdlib.pack del paquete no es la stdlib que lleva: no se publica."
    rm -rf "$OUT"; exit 1
fi

# --- red: ningún enlace de la ayuda puede quedar roto DENTRO del paquete -----
# Se comprueba sobre el árbol YA MONTADO, que es lo que va a ver el usuario: el
# repo puede tener el fichero y el ZIP no llevarlo (pasó con los 10 anexos .md).
# Los enlaces externos (http:, mailto:) no se tocan: no son cosa del paquete.
roto=0
for html in "$OUT/docs/"*.html "$OUT/docs/en/"*.html; do
    dir="$(dirname "$html")"
    for ref in $(grep -ho 'href="[^"#][^"]*"\|src="[^"#][^"]*"' "$html" \
                 | sed 's/^[a-z]*="//;s/"$//;s/#.*//' | grep -v '^[a-z][a-z]*:' | sort -u); do
        [ -e "$dir/$ref" ] || { echo "  ENLACE ROTO  ${html#$OUT/} -> $ref"; roto=1; }
    done
done
[ "$roto" -eq 0 ] || { echo "La ayuda tiene enlaces rotos en el paquete — no se monta el ZIP"; exit 1; }

# --- el ZIP + su sello ------------------------------------------------------
cd "$RAIZ/dist"
rm -f "$NOMBRE.zip"
# NO se usa Compress-Archive de PowerShell: escribe los nombres con `\` (bug conocido
# de ZipFile en .NET Framework, que es lo que trae PS 5.1). El estándar ZIP manda `/`.
# Windows lo tolera, pero quien lo descomprima en Linux o Mac —para leer los docs o
# coger las imágenes de firmware— se encuentra ficheros llamados "BasicPlus-4.0-win\bin\
# bpvm-sim.exe", todos en el mismo montón. El `jar` del JDK siempre escribe `/`, y el
# JDK está garantizado: sin él no hay IDE que empaquetar.
if command -v zip >/dev/null 2>&1; then
    zip -qr "$NOMBRE.zip" "$NOMBRE"
else
    jar cfM "$NOMBRE.zip" "$NOMBRE"
fi

# Guardián de lo anterior: un solo `\` dentro de un nombre y el paquete no vale.
if jar tf "$NOMBRE.zip" | grep -q '\\'; then
    echo "El ZIP lleva '\\' en los nombres — se descomprime mal fuera de Windows"; exit 1
fi

# --- red: el paquete tiene que COMPILAR, no sólo tener los ficheros ---------
# El bloque J comprobaba que el IDE ENCUENTRA sus carpetas; nunca compiló nada
# de verdad desde una instalación, y por eso se coló que faltaba BpVM.cfg: el
# ZIP llevaba bpstdlib/ pero el compilador no sabía dónde estaba, omitía el
# `import Core` y los errores salían en el código del usuario (H13, Pico).
#
# Se hace sobre el ZIP EXTRAÍDO EN UN TEMPORAL, no sobre dist/: el árbol montado
# vive dentro del repo, y VmConfig sube directorios buscando BpVM.cfg — o sea que
# encontraba el del checkout y la comprobación pasaba SIEMPRE. Un guardián con la
# red de seguridad puesta no comprueba nada.
echo "-- comprobando que el paquete compila con su propia stdlib --"
PRUEBA="$(mktemp -d)"
( cd "$PRUEBA" && jar xf "$RAIZ/dist/$NOMBRE.zip" ) || { echo "  no se pudo extraer"; exit 1; }
CASO="$PRUEBA/$NOMBRE/samples/ExcCatchTest.bp"     # importa Core + un módulo propio
if ! ( cd / && java -cp "$PRUEBA/$NOMBRE/BpIde-$VER.jar" basicplus.frontend.Main \
         "$CASO" --compile "$PRUEBA/out" --backend=mivm > "$PRUEBA/log" 2>&1 ) \
   || [ -z "$(ls "$PRUEBA/out"/*.mod 2>/dev/null)" ]; then
    echo "  EL PAQUETE NO COMPILA un programa con stdlib:"
    grep -E '^\[[0-9]+:|no se localiz|sin interfaz' "$PRUEBA/log" | head -5 | sed 's/^/    /'
    rm -rf "$PRUEBA" "$NOMBRE.zip"; exit 1
fi

# --- y `bp` (V9 #853): lo que manda teclear la documentación, desde FUERA de la instalación --------------------------
# Un fuente en una carpeta sin BpVM.cfg (la de quien usa el ZIP, o la de una IA): `bp run` con las dos VMs tiene que
# compilarlo con la stdlib de la instalación y ejecutarlo; con --c, la VM-C de bin/ (y su SDL2.dll).
echo "-- comprobando bp run, con las dos VMs, desde una carpeta sin BpVM.cfg --"
mkdir -p "$PRUEBA/fuera" && cp "$PRUEBA/$NOMBRE/samples/blink.bp" "$PRUEBA/fuera/"
for VM in "" "--c"; do
    if ! ( cd "$PRUEBA/fuera" && sh "$PRUEBA/$NOMBRE/bp" run $VM blink.bp > "$PRUEBA/log_bp" 2>&1 ) \
       || ! grep -q "Blink terminado" "$PRUEBA/log_bp"; then
        echo "  bp run $VM NO EJECUTA samples/blink.bp desde fuera de la instalación:"
        tail -5 "$PRUEBA/log_bp" | sed 's/^/    /'
        rm -rf "$PRUEBA" "$NOMBRE.zip"; exit 1
    fi
done

# ------------------------------------------------------------------
# GUARDIAN de los ficheros de PROYECTO (hallazgo 42, 6-ago-2026).
#
# El ZIP publicado llevaba un samples/sampleproject/App.bpproject con
# «"out": pack» — sin coma y sin comillas. No es JSON, y el proyecto que
# abre quien acaba de descomprimir NO CARGABA. Entró porque era una
# modificación del árbol de trabajo sin commitear y este script copia del
# DISCO, no de git.
#
# Se escapó a la puerta final de H13 porque sus 4 pruebas ejecutaban
# programas SUELTOS: ninguna abría un proyecto. Un camino no ejecutado no
# está probado.
#
# El guardián sólo mira que el fichero esté BIEN FORMADO: se le pasa al
# cargador de verdad y se falla si contesta con un error de sintaxis
# (los nuestros llevan `fichero:línea:columna:`). Que además no compile o
# le falte el .mod es otra cosa — y no es asunto de este guardián.
echo "-- comprobando que los proyectos de ejemplo ABREN --"
malos=0
set +e   # los códigos se miran uno a uno
for p in $(find "$PRUEBA/$NOMBRE" \( -name '*.bpproject' -o -name '*.bpbuild' \) | sort); do
    rel="${p#$PRUEBA/$NOMBRE/}"
    case "$rel" in
      *.bpbuild)   # lo compila `bp build`, como quien lo usa (V9, 25-nov: antes, el compilador a secas, que desde una
                   # carpeta del ZIP no encuentra la stdlib; sus errores no se miraban —sólo un JSON mal formado— y
                   # desde #856 llevan la forma que se buscaba, fichero:línea:columna)
        ( cd "$(dirname "$p")" && "$PRUEBA/$NOMBRE/bp" build "$(basename "$p")" ) > "$PRUEBA/plog" 2>&1
        mal=$? ;;
      *)           # .bpproject lo abre la VM
        java -cp "$PRUEBA/$NOMBRE/BpIde-$VER.jar" edu.bpgenvm.Main "$p" \
            > "$PRUEBA/plog" 2>&1 || true
        mal=0; grep -qE ':[0-9]+:[0-9]+: ' "$PRUEBA/plog" && mal=1 ;;
    esac
    if [ "$mal" -ne 0 ]; then
        echo "  NO ABRE: $rel"
        head -3 "$PRUEBA/plog" | sed 's/^/    /'
        malos=$((malos+1))
    fi
done
set -e
if [ "$malos" -gt 0 ]; then
    echo "  $malos fichero(s) de proyecto no abren — no se monta el ZIP"
    rm -rf "$PRUEBA" "$NOMBRE.zip"; exit 1
fi

# V9 #900 — y las pruebas de ejemplo, con las dos VMs del propio ZIP. La red usa una VM-C sin ventana, y la del ZIP la
# lleva: la suya escribía sus avisos por la salida estándar, y toda prueba con una GUI fallaba en `bp test`.
echo "-- las pruebas de ejemplo (bp test), con las VMs del ZIP --"
if ! ( cd "$PRUEBA/$NOMBRE/samples/pruebas" && "$PRUEBA/$NOMBRE/bp" test ); then
    echo "  no pasan — no se monta el ZIP"
    rm -rf "$PRUEBA" "$NOMBRE.zip"; exit 1
fi

rm -rf "$PRUEBA"

sha256sum "$NOMBRE.zip" > "$NOMBRE.zip.sha256"

echo
echo "  $NOMBRE.zip  —  $(du -h "$NOMBRE.zip" | cut -f1)"
cat "$NOMBRE.zip.sha256"
