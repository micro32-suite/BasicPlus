# Tandas T1 — las placas conducidas

## Tanda 2026-11-22 11:51:40

- manifiesto: `bpgenvm-c\tools\tanda_v9.json` (10 pruebas listadas)
- oraculo: jar `toolchain\lexer-java\target\basicplus-frontend.jar` (2026-11-22 11:17:40) - exe `bpgenvm-c\build\bpgenvm-c.exe` (2026-11-22 11:19:10) - sabor `v2-gui1-lvgl0`
- placas conectadas: 1 (rp2350a@COM22)

### Oraculo por prueba (PC)

| prueba | modulo | crc .mod | tamano | compilacion | host rc | ms host | lineas salida |
|---|---|---|---|---|---|---|---|
| MathRango | MathRango | 2270c82e | 1611 | ok | 0 | 12 | 29 |
| ThrowSinAtrapar | ThrowSinAtrapar | 9b053410 | 295 | ok | 1 | 11 | 1 |
| ThreadTrasMain | ThreadTrasMain | 97dd1bb5 | 532 | ok | 0 | 320 | 3 |
| MachineId | MachineId | 42a7e155 | 452 | ok | 0 | 12 | 3 |
| GuiWinJson | GuiWinJson | 40187a88 | 2041 | ok | 0 | 76 | 17 |
| GuiShot | GuiShot | f886ec4b | 1347 | ok | 0 | 401 | 8 |
| DatosGrandes | DatosGrandes | 822e223a | 34291 | ok | 0 | 11 | 11 |
| DatosAnchos | DatosAnchos | e70ef4fb | 71917 | ok | 0 | 12 | 12 |
| HeapInfo | HeapInfo | 53946845 | 1228 | ok | 0 | 11 | 10 |
| HeapCompact | HeapCompact | 3e213ca1 | 3560 | ok | 0 | 18 | 17 |

### Placa rp2350a - 46CED5A69C399BD2

- sello: boardName=`rp2350a` uniqueId=`46CED5A69C399BD2` serverName=`bpvm-pico` serverBuild=`Nov 22 2026 11:45:57` imageCrc=`ed681266` capacidades=["META", "FILES", "TERMINAL", "DEBUG", "PACKS", "BOOTSEL"]
- imagen: la COMPILADA en el PC: bpgenvm-c/pico/build/bpvm_pico.elf (22-11 11:46)
- imagen: arch=40 variant=A cpuFreqHz=150000000 resetReason=power-on/run uptimeMs=206456 fs=397312/1048576 B vmHeapBytes=295240
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM22
- pantalla: no (INFO sin screenW/screenH: la imagen no lleva LVGL)
- inventario /lib+/app: 44 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 25 | 12 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 288 | 11 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 310 | 320 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 9 | 12 | EXITED OK exit=0 |
| GuiWinJson | **SALTADA** | - | 76 | necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL) |
| GuiShot | **SALTADA** | - | 401 | necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL) |
| DatosGrandes | **IDENTICO** | 21 | 11 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 24 | 12 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 40 | 11 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 448 | 18 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=207400 fsUsed=401408 vmHeapBytes=295240 pila libre: run=13428 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras ThrowSinAtrapar: uptimeMs=208364 fsUsed=401408 vmHeapBytes=295240 pila libre: run=14120 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras ThreadTrasMain: uptimeMs=209180 fsUsed=401408 vmHeapBytes=295240 pila libre: run=13292 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras MachineId: uptimeMs=209862 fsUsed=401408 vmHeapBytes=295240 pila libre: run=13464 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras DatosGrandes: uptimeMs=211060 fsUsed=434176 vmHeapBytes=295240 pila libre: run=13292 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras DatosAnchos: uptimeMs=213047 fsUsed=471040 vmHeapBytes=295240 pila libre: run=13392 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras HeapInfo: uptimeMs=213694 fsUsed=401408 vmHeapBytes=295240 pila libre: run=12460 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras HeapCompact: uptimeMs=215098 fsUsed=401408 vmHeapBytes=295240 pila libre: run=12460 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- ejecutadas (con EXITED) 8 de 10 listadas; no terminaron 0; saltadas 2; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/DatosGrandes.mod | bpgenvm-c\build\tanda\DatosGrandes\DatosGrandes.mod | 34291 | 822e223a | ok (por trozos) |
| /app/DatosAnchos.mod | bpgenvm-c\build\tanda\DatosAnchos\DatosAnchos.mod | 71917 | e70ef4fb | ok (por trozos) |
| /app/HeapInfo.mod | bpgenvm-c\build\tanda\HeapInfo\HeapInfo.mod | 1228 | 53946845 | ok |
| /app/HeapCompact.mod | bpgenvm-c\build\tanda\HeapCompact\HeapCompact.mod | 3560 | 3e213ca1 | ok |

notas de dependencias:

- dependencia Core: en la zona de packs (pack:Stdlib/Core.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Math: en la zona de packs (pack:Stdlib/Math.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Machine: en la zona de packs (pack:Stdlib/Machine.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Matriz pruebas x placas

| prueba | rp2350a@COM22 |
|---|---|
| MathRango | IDENTICO |
| ThrowSinAtrapar | IDENTICO |
| ThreadTrasMain | IDENTICO |
| MachineId | NO-PETA |
| GuiWinJson | SALTADA |
| GuiShot | SALTADA |
| DatosGrandes | IDENTICO |
| DatosAnchos | IDENTICO |
| HeapInfo | IDENTICO |
| HeapCompact | IDENTICO |

SALTADA: GuiWinJson en rp2350a@COM22: necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL)  
SALTADA: GuiShot en rp2350a@COM22: necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL)  


## Tanda 2026-11-22 11:52:04

- manifiesto: `bpgenvm-c\tools\tanda_v9.json` (10 pruebas listadas)
- oraculo: jar `toolchain\lexer-java\target\basicplus-frontend.jar` (2026-11-22 11:17:40) - exe `bpgenvm-c\build\bpgenvm-c.exe` (2026-11-22 11:19:10) - sabor `v2-gui1-lvgl0`
- placas conectadas: 1 (esp32p4@COM15)

### Oraculo por prueba (PC)

| prueba | modulo | crc .mod | tamano | compilacion | host rc | ms host | lineas salida |
|---|---|---|---|---|---|---|---|
| MathRango | MathRango | 2270c82e | 1611 | ok | 0 | 11 | 29 |
| ThrowSinAtrapar | ThrowSinAtrapar | 9b053410 | 295 | ok | 1 | 11 | 1 |
| ThreadTrasMain | ThreadTrasMain | 97dd1bb5 | 532 | ok | 0 | 332 | 3 |
| MachineId | MachineId | 42a7e155 | 452 | ok | 0 | 11 | 3 |
| GuiWinJson | GuiWinJson | 40187a88 | 2041 | ok | 0 | 62 | 17 |
| GuiShot | GuiShot | f886ec4b | 1347 | ok | 0 | 386 | 8 |
| DatosGrandes | DatosGrandes | 822e223a | 34291 | ok | 0 | 12 | 11 |
| DatosAnchos | DatosAnchos | e70ef4fb | 71917 | ok | 0 | 12 | 12 |
| HeapInfo | HeapInfo | 53946845 | 1228 | ok | 0 | 12 | 10 |
| HeapCompact | HeapCompact | 3e213ca1 | 3560 | ok | 0 | 19 | 17 |

### Placa esp32p4 - E8F60AE0B380

- sello: boardName=`esp32p4` uniqueId=`E8F60AE0B380` serverName=`bpvm-esp32p4` serverBuild=`Nov 22 2026 11:47:03` imageCrc=`37483af3` capacidades=["META", "FILES", "TERMINAL", "DEBUG", "PACKS"]
- imagen: la COMPILADA en el PC: bpgenvm-c/esp32p4/build/bpvm_esp32p4.bin (22-11 11:47)
- imagen: arch=243 variant=None cpuFreqHz=360000000 resetReason=software uptimeMs=103521 fs=278528/16777216 B vmHeapBytes=25145344
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM15
- pantalla: si (INFO screenW x screenH = 480x800)
- inventario /lib+/app: 8 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 193 | 11 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 11 | 11 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 314 | 332 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 20 | 11 | EXITED OK exit=0 |
| GuiWinJson | **IDENTICO** | 739 | 67 | EXITED OK exit=0; host rc=0 |
| GuiShot | **NO-PETA** | 651 | 395 | EXITED OK exit=0 |
| DatosGrandes | **IDENTICO** | 68 | 12 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 74 | 12 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 77 | 12 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 232 | 19 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=105133 fsUsed=282624 vmHeapBytes=25145344 pila libre: run=13560 io=25748 tareaREPL=25748 heap del sistema, minimo libre=156352
- tras ThrowSinAtrapar: uptimeMs=105818 fsUsed=282624 vmHeapBytes=25145344 pila libre: run=13560 io=25748 tareaREPL=25748 heap del sistema, minimo libre=156352
- tras ThreadTrasMain: uptimeMs=106912 fsUsed=282624 vmHeapBytes=25145344 pila libre: run=13472 io=25748 tareaREPL=25748 heap del sistema, minimo libre=156208
- tras MachineId: uptimeMs=107674 fsUsed=282624 vmHeapBytes=25145344 pila libre: run=13528 io=25748 tareaREPL=25748 heap del sistema, minimo libre=156032
- tras GuiWinJson: uptimeMs=110676 fsUsed=286720 vmHeapBytes=25145344 pila libre: run=13252 io=25528 tareaREPL=25528 heap del sistema, minimo libre=146596
- tras GuiShot: uptimeMs=113622 fsUsed=294912 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=146480
- artefacto GuiShot.shot de GuiShot: bajado a `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32p4_E8F60AE0B380\GuiShot.shot` (8243 B, crc cde419d3) -> PNG `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32p4_E8F60AE0B380\GuiShot.png`; antes del RUN: no existia
- tras DatosGrandes: uptimeMs=119098 fsUsed=327680 vmHeapBytes=25145344 pila libre: run=13156 io=25528 tareaREPL=25528 heap del sistema, minimo libre=146480
- tras DatosAnchos: uptimeMs=127153 fsUsed=364544 vmHeapBytes=25145344 pila libre: run=11224 io=25528 tareaREPL=25528 heap del sistema, minimo libre=146480
- tras HeapInfo: uptimeMs=128298 fsUsed=294912 vmHeapBytes=25145344 pila libre: run=12140 io=25528 tareaREPL=25528 heap del sistema, minimo libre=146480
- tras HeapCompact: uptimeMs=130105 fsUsed=294912 vmHeapBytes=25145344 pila libre: run=12124 io=25528 tareaREPL=25528 heap del sistema, minimo libre=146480
- ejecutadas (con EXITED) 10 de 10 listadas; no terminaron 0; saltadas 0; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/main.win | samples\formdemo\resources\main.win | 390 | 548edd67 | ok |
| /app/GuiWinJson.mod | bpgenvm-c\build\tanda\GuiWinJson\GuiWinJson.mod | 2041 | 40187a88 | ok |
| /app/GuiShot.mod | bpgenvm-c\build\tanda\GuiShot\GuiShot.mod | 1347 | f886ec4b | ok |
| /app/DatosGrandes.mod | bpgenvm-c\build\tanda\DatosGrandes\DatosGrandes.mod | 34291 | 822e223a | ok (por trozos) |
| /app/DatosAnchos.mod | bpgenvm-c\build\tanda\DatosAnchos\DatosAnchos.mod | 71917 | e70ef4fb | ok (por trozos) |
| /app/HeapInfo.mod | bpgenvm-c\build\tanda\HeapInfo\HeapInfo.mod | 1228 | 53946845 | ok |
| /app/HeapCompact.mod | bpgenvm-c\build\tanda\HeapCompact\HeapCompact.mod | 3560 | 3e213ca1 | ok |

notas de dependencias:

- dependencia Core: en la zona de packs (pack:Stdlib/Core.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Math: en la zona de packs (pack:Stdlib/Math.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Machine: en la zona de packs (pack:Stdlib/Machine.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Gui: en la zona de packs (pack:Stdlib/Gui.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Json: en la zona de packs (pack:Stdlib/Json.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Collections: en la zona de packs (pack:Stdlib/Collections.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Str: en la zona de packs (pack:Stdlib/Str.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Matriz pruebas x placas

| prueba | esp32p4@COM15 |
|---|---|
| MathRango | IDENTICO |
| ThrowSinAtrapar | IDENTICO |
| ThreadTrasMain | IDENTICO |
| MachineId | NO-PETA |
| GuiWinJson | IDENTICO |
| GuiShot | NO-PETA |
| DatosGrandes | IDENTICO |
| DatosAnchos | IDENTICO |
| HeapInfo | IDENTICO |
| HeapCompact | IDENTICO |

NECESITA OJOS: GuiShot en esp32p4@COM15: C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32p4_E8F60AE0B380\GuiShot.png  

