# Tandas T1 — las placas conducidas

## Tanda 2026-11-27 17:22:23

- manifiesto: `..\..\Users\Eduardo\AppData\Local\Temp\claude\2cbf9ff7f3759075\576fc834-e260-4649-ba6c-131c549812a9\scratchpad\lote85\lista_lote85.json` (28 pruebas listadas)
- oraculo: jar `toolchain\lexer-java\target\basicplus-frontend.jar` (2026-11-25 18:51:06) - exe `bpgenvm-c\build\bpgenvm-c.exe` (2026-11-27 17:01:29) - sabor `v2-gui1-lvgl0`
- placas conectadas: 4 (rp2350a@COM22, rp2350b@COM4, stm32u5g9@COM12, esp32c6@COM3)

### Oraculo por prueba (PC)

| prueba | modulo | crc .mod | tamano | compilacion | host rc | ms host | lineas salida |
|---|---|---|---|---|---|---|---|
| MathRango | MathRango | 2270c82e | 1611 | ok | 0 | 10 | 29 |
| ThrowSinAtrapar | ThrowSinAtrapar | 9b053410 | 295 | ok | 1 | 9 | 1 |
| ThreadTrasMain | ThreadTrasMain | 97dd1bb5 | 532 | ok | 0 | 333 | 3 |
| MachineId | MachineId | 42a7e155 | 452 | ok | 0 | 11 | 3 |
| GuiWinJson | GuiWinJson | ea106f91 | 2041 | ok | 0 | 65 | 17 |
| GuiShot | GuiShot | f794de7d | 1347 | ok | 0 | 389 | 8 |
| BorraCarpetaFichero | BorraCarpetaFichero | be28edf2 | 2271 | ok | 0 | 15 | 9 |
| RutaFueraFlash | RutaFueraFlash | 79cbf8d4 | 3213 | ok | 0 | 14 | 39 |
| FlashCarpetas | FlashCarpetas | c21b2696 | 733 | ok | 0 | 16 | 7 |
| GcHuecoPila | GcHuecoPila | 3304c6f0 | 1190 | ok | 0 | 14 | 3 |
| RefCaducadaBuiltin | RefCaducadaBuiltin | 845498b8 | 1688 | ok | 0 | 12 | 6 |
| DivBordes | DivBordes | 70f63a2f | 798 | ok | 0 | 13 | 10 |
| ListaBorde | ListaBorde | e6ddaaf1 | 2918 | ok | 0 | 22 | 26 |
| IndiceObjeto | IndiceObjeto | 80c280cb | 12474 | ok | 0 | 24 | 36 |
| GenericosOrden | GenericosOrden | 52134d69 | 8456 | ok | 0 | 26 | 30 |
| SobrecargaEspecifica | SobrecargaEspecifica | 555c6ff1 | 1358 | ok | 0 | 10 | 9 |
| SobrecargaVisible | SobrecargaVisible | d3797df1 | 1999 | ok | 0 | 12 | 4 |
| BoolBits | BoolBits | 7b87929a | 876 | ok | 0 | 10 | 15 |
| ArrayNuevo | ArrayNuevo | 2feee85e | 2393 | ok | 0 | 39 | 17 |
| BucleConNombre | BucleConNombre | 6c35f20c | 1734 | ok | 0 | 11 | 12 |
| ErroresConTipo | ErroresConTipo | 7d9c7755 | 11493 | ok | 0 | 26 | 48 |
| IgualdadRefs | IgualdadRefs | 4a34e551 | 883 | ok | 0 | 10 | 8 |
| VarParam | VarParam | 1024398c | 3481 | ok | 0 | 11 | 12 |
| StrNulo | StrNulo | 4572ae05 | 2784 | ok | 0 | 13 | 14 |
| DatosGrandes | DatosGrandes | 822e223a | 34291 | ok | 0 | 10 | 11 |
| DatosAnchos | DatosAnchos | e70ef4fb | 71917 | ok | 0 | 12 | 12 |
| HeapInfo | HeapInfo | 53946845 | 1228 | ok | 0 | 10 | 10 |
| HeapCompact | HeapCompact | 3e213ca1 | 3560 | ok | 0 | 19 | 17 |

### Placa rp2350a - 46CED5A69C399BD2

- sello: boardName=`rp2350a` uniqueId=`46CED5A69C399BD2` serverName=`bpvm-pico` serverBuild=`Nov 25 2026 17:27:25` version=`8.5` imageCrc=`18c2653c` capacidades=["META", "FILES", "TERMINAL", "DEBUG", "PACKS", "BOOTSEL"]
- imagen: la COMPILADA en el PC: bpgenvm-c/pico/build/bpvm_pico.elf (26-11 19:19)
- imagen: arch=40 variant=A cpuFreqHz=150000000 resetReason=power-on/run uptimeMs=1164542 fs=208896/1048576 B vmHeapBytes=295232
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM22
- pantalla: no (INFO sin screenW/screenH: la imagen no lleva LVGL)
- inventario /lib+/app: 8 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 24 | 10 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 294 | 9 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 310 | 333 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 9 | 11 | EXITED OK exit=0 |
| GuiWinJson | **SALTADA** | - | 65 | necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL) |
| GuiShot | **SALTADA** | - | 389 | necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL) |
| BorraCarpetaFichero | **IDENTICO** | 230 | 15 | EXITED OK exit=0; host rc=0 |
| RutaFueraFlash | **DIFIERE** | 111 | 14 | texto distinto |
| FlashCarpetas | **IDENTICO** | 116 | 16 | EXITED OK exit=0; host rc=0 |
| GcHuecoPila | **IDENTICO** | 101 | 14 | EXITED OK exit=0; host rc=0 |
| RefCaducadaBuiltin | **IDENTICO** | 445 | 12 | EXITED OK exit=0; host rc=0 |
| DivBordes | **IDENTICO** | 15 | 13 | EXITED OK exit=0; host rc=0 |
| ListaBorde | **IDENTICO** | 78 | 22 | EXITED OK exit=0; host rc=0 |
| IndiceObjeto | **IDENTICO** | 106 | 24 | EXITED OK exit=0; host rc=0 |
| GenericosOrden | **IDENTICO** | 93 | 26 | EXITED OK exit=0; host rc=0 |
| SobrecargaEspecifica | **IDENTICO** | 18 | 10 | EXITED OK exit=0; host rc=0 |
| SobrecargaVisible | **IDENTICO** | 14 | 12 | EXITED OK exit=0; host rc=0 |
| BoolBits | **IDENTICO** | 19 | 10 | EXITED OK exit=0; host rc=0 |
| ArrayNuevo | **IDENTICO** | 28 | 39 | EXITED OK exit=0; host rc=0 |
| BucleConNombre | **IDENTICO** | 17 | 11 | EXITED OK exit=0; host rc=0 |
| ErroresConTipo | **DIFIERE** | 240 | 26 | texto distinto |
| IgualdadRefs | **IDENTICO** | 15 | 10 | EXITED OK exit=0; host rc=0 |
| VarParam | **IDENTICO** | 29 | 11 | EXITED OK exit=0; host rc=0 |
| StrNulo | **IDENTICO** | 27 | 13 | EXITED OK exit=0; host rc=0 |
| DatosGrandes | **IDENTICO** | 21 | 10 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 24 | 12 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 47 | 10 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 506 | 19 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=1165427 fsUsed=212992 vmHeapBytes=295232 pila libre: run=13424 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras ThrowSinAtrapar: uptimeMs=1166428 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12764 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras ThreadTrasMain: uptimeMs=1167210 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12764 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras MachineId: uptimeMs=1167741 fsUsed=212992 vmHeapBytes=295232 pila libre: run=13248 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras BorraCarpetaFichero: uptimeMs=1168544 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12164 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras RutaFueraFlash: uptimeMs=1169425 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12164 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
<details><summary>RutaFueraFlash: cola del stderr del host</summary>

```
throw: ATRAPADA por un catch del programa
[bpvm] throw: "appendFile('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "readFileBytes('/../x810'): no se pudo abrir"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "writeFileBytes('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] pila: el main llegó a 244 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>RutaFueraFlash: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -13,7 +13,7 @@
 rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
 copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
 fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
-lastModified -> IOError: lastModified('/../x810'): no se pudo leer
+lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
 File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
 File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
...
```

oraculo (host):

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no se pudo leer
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no se pudo leer
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```

placa:

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```
</details>

- tras FlashCarpetas: uptimeMs=1170058 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12180 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras GcHuecoPila: uptimeMs=1170638 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12180 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras RefCaducadaBuiltin: uptimeMs=1171573 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12384 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras DivBordes: uptimeMs=1172045 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12180 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras ListaBorde: uptimeMs=1173094 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12384 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras IndiceObjeto: uptimeMs=1174287 fsUsed=225280 vmHeapBytes=295232 pila libre: run=12180 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras GenericosOrden: uptimeMs=1175483 fsUsed=221184 vmHeapBytes=295232 pila libre: run=12384 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras SobrecargaEspecifica: uptimeMs=1175983 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12180 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras SobrecargaVisible: uptimeMs=1176484 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12384 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras BoolBits: uptimeMs=1176944 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12180 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras ArrayNuevo: uptimeMs=1177496 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12384 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras BucleConNombre: uptimeMs=1177948 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12180 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras ErroresConTipo: uptimeMs=1179144 fsUsed=221184 vmHeapBytes=295232 pila libre: run=12160 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
<details><summary>ErroresConTipo: cola del stderr del host</summary>

```
its ALTOS: un bpref_t de 64b gu
[bpvm] UAF: idx=178  gen del handle=0  gen del slot=1  (slots en uso=180)
[bpvm]   gen 0 con el slot en 1: o una referencia CADUCADA al PRIMER objeto de ese slot (nace con gen 0: el programa lo libero y lo siguio usando), o un TRUNCAMIENTO (el handle perdio sus 32 bits ALTOS: un bpref_t de 64b gu
[bpvm] pila: el main llegó a 500 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] mutex: 1 creados, la tabla llegó a 1
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>ErroresConTipo: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -19,7 +19,7 @@
 ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
 ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
 ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
-ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
+ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
 ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
 ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
...
```

oraculo (host):

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```

placa:

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```
</details>

- tras IgualdadRefs: uptimeMs=1179629 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12180 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras VarParam: uptimeMs=1180536 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12160 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras StrNulo: uptimeMs=1181129 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12180 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras DatosGrandes: uptimeMs=1182306 fsUsed=245760 vmHeapBytes=295232 pila libre: run=12160 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras DatosAnchos: uptimeMs=1184260 fsUsed=282624 vmHeapBytes=295232 pila libre: run=12160 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras HeapInfo: uptimeMs=1184806 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12180 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- tras HeapCompact: uptimeMs=1185958 fsUsed=212992 vmHeapBytes=295232 pila libre: run=12160 io=9648 tareaREPL=9648 heap del sistema, minimo libre=6632
- ejecutadas (con EXITED) 26 de 28 listadas; no terminaron 0; saltadas 2; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/BorraCarpetaFichero.mod | bpgenvm-c\build\tanda\BorraCarpetaFichero\BorraCarpetaFichero.mod | 2271 | be28edf2 | ok |
| /app/RutaFueraFlash.mod | bpgenvm-c\build\tanda\RutaFueraFlash\RutaFueraFlash.mod | 3213 | 79cbf8d4 | ok |
| /app/FlashCarpetas.mod | bpgenvm-c\build\tanda\FlashCarpetas\FlashCarpetas.mod | 733 | c21b2696 | ok |
| /app/GcHuecoPila.mod | bpgenvm-c\build\tanda\GcHuecoPila\GcHuecoPila.mod | 1190 | 3304c6f0 | ok |
| /app/RefCaducadaBuiltin.mod | bpgenvm-c\build\tanda\RefCaducadaBuiltin\RefCaducadaBuiltin.mod | 1688 | 845498b8 | ok |
| /app/DivBordes.mod | bpgenvm-c\build\tanda\DivBordes\DivBordes.mod | 798 | 70f63a2f | ok |
| /app/ListaBorde.mod | bpgenvm-c\build\tanda\ListaBorde\ListaBorde.mod | 2918 | e6ddaaf1 | ok |
| /app/IndiceObjeto.mod | bpgenvm-c\build\tanda\IndiceObjeto\IndiceObjeto.mod | 12474 | 80c280cb | ok (por trozos) |
| /app/GenericosOrden.mod | bpgenvm-c\build\tanda\GenericosOrden\GenericosOrden.mod | 8456 | 52134d69 | ok (por trozos) |
| /app/SobrecargaEspecifica.mod | bpgenvm-c\build\tanda\SobrecargaEspecifica\SobrecargaEspecifica.mod | 1358 | 555c6ff1 | ok |
| /app/SobrecargaVisible.mod | bpgenvm-c\build\tanda\SobrecargaVisible\SobrecargaVisible.mod | 1999 | d3797df1 | ok |
| /app/BoolBits.mod | bpgenvm-c\build\tanda\BoolBits\BoolBits.mod | 876 | 7b87929a | ok |
| /app/ArrayNuevo.mod | bpgenvm-c\build\tanda\ArrayNuevo\ArrayNuevo.mod | 2393 | 2feee85e | ok |
| /app/BucleConNombre.mod | bpgenvm-c\build\tanda\BucleConNombre\BucleConNombre.mod | 1734 | 6c35f20c | ok |
| /app/ErroresConTipo.mod | bpgenvm-c\build\tanda\ErroresConTipo\ErroresConTipo.mod | 11493 | 7d9c7755 | ok (por trozos) |
| /app/IgualdadRefs.mod | bpgenvm-c\build\tanda\IgualdadRefs\IgualdadRefs.mod | 883 | 4a34e551 | ok |
| /app/VarParam.mod | bpgenvm-c\build\tanda\VarParam\VarParam.mod | 3481 | 1024398c | ok |
| /app/StrNulo.mod | bpgenvm-c\build\tanda\StrNulo\StrNulo.mod | 2784 | 4572ae05 | ok |
| /app/DatosGrandes.mod | bpgenvm-c\build\tanda\DatosGrandes\DatosGrandes.mod | 34291 | 822e223a | ok (por trozos) |
| /app/DatosAnchos.mod | bpgenvm-c\build\tanda\DatosAnchos\DatosAnchos.mod | 71917 | e70ef4fb | ok (por trozos) |
| /app/HeapInfo.mod | bpgenvm-c\build\tanda\HeapInfo\HeapInfo.mod | 1228 | 53946845 | ok |
| /app/HeapCompact.mod | bpgenvm-c\build\tanda\HeapCompact\HeapCompact.mod | 3560 | 3e213ca1 | ok |

notas de dependencias:

- dependencia Core: en la zona de packs (pack:Stdlib/Core.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Math: en la zona de packs (pack:Stdlib/Math.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Machine: en la zona de packs (pack:Stdlib/Machine.mod, crc igual): se ejecuta XIP, no se sube
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Collections: en la zona de packs (pack:Stdlib/Collections.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Str: en la zona de packs (pack:Stdlib/Str.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Placa rp2350b - 4CE219E14C8F8E1C

- sello: boardName=`rp2350b` uniqueId=`4CE219E14C8F8E1C` serverName=`bpvm-pico` serverBuild=`Nov 25 2026 17:27:28` version=`8.5` imageCrc=`0e952811` capacidades=["META", "FILES", "TERMINAL", "DEBUG", "PACKS", "BOOTSEL"]
- imagen: la COMPILADA en el PC: bpgenvm-c/pico/build/bpvm_pico_m.elf (26-11 19:19)
- imagen: arch=40 variant=B cpuFreqHz=150000000 resetReason=reinicio pedido uptimeMs=884942 fs=532480/10248192 B vmHeapBytes=6275072
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM4
- pantalla: no (INFO sin screenW/screenH: la imagen no lleva LVGL)
- inventario /lib+/app: 69 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 21 | 10 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 271 | 9 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 316 | 333 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 16 | 11 | EXITED OK exit=0 |
| GuiWinJson | **SALTADA** | - | 65 | necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL) |
| GuiShot | **SALTADA** | - | 389 | necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL) |
| BorraCarpetaFichero | **IDENTICO** | 221 | 15 | EXITED OK exit=0; host rc=0 |
| RutaFueraFlash | **DIFIERE** | 61 | 14 | texto distinto |
| FlashCarpetas | **IDENTICO** | 192 | 16 | EXITED OK exit=0; host rc=0 |
| GcHuecoPila | **IDENTICO** | 103 | 14 | EXITED OK exit=0; host rc=0 |
| RefCaducadaBuiltin | **IDENTICO** | 414 | 12 | EXITED OK exit=0; host rc=0 |
| DivBordes | **IDENTICO** | 18 | 13 | EXITED OK exit=0; host rc=0 |
| ListaBorde | **IDENTICO** | 46 | 22 | EXITED OK exit=0; host rc=0 |
| IndiceObjeto | **IDENTICO** | 71 | 24 | EXITED OK exit=0; host rc=0 |
| GenericosOrden | **IDENTICO** | 60 | 26 | EXITED OK exit=0; host rc=0 |
| SobrecargaEspecifica | **IDENTICO** | 20 | 10 | EXITED OK exit=0; host rc=0 |
| SobrecargaVisible | **IDENTICO** | 18 | 12 | EXITED OK exit=0; host rc=0 |
| BoolBits | **IDENTICO** | 19 | 10 | EXITED OK exit=0; host rc=0 |
| ArrayNuevo | **IDENTICO** | 23 | 39 | EXITED OK exit=0; host rc=0 |
| BucleConNombre | **IDENTICO** | 18 | 11 | EXITED OK exit=0; host rc=0 |
| ErroresConTipo | **DIFIERE** | 163 | 26 | texto distinto |
| IgualdadRefs | **IDENTICO** | 17 | 10 | EXITED OK exit=0; host rc=0 |
| VarParam | **IDENTICO** | 22 | 11 | EXITED OK exit=0; host rc=0 |
| StrNulo | **IDENTICO** | 21 | 13 | EXITED OK exit=0; host rc=0 |
| DatosGrandes | **IDENTICO** | 23 | 10 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 25 | 12 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 39 | 10 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 266 | 19 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=885896 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=13424 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras ThrowSinAtrapar: uptimeMs=887006 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12844 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras ThreadTrasMain: uptimeMs=888062 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=13288 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras MachineId: uptimeMs=888605 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12844 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras BorraCarpetaFichero: uptimeMs=889423 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12088 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras RutaFueraFlash: uptimeMs=890347 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12088 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
<details><summary>RutaFueraFlash: cola del stderr del host</summary>

```
throw: ATRAPADA por un catch del programa
[bpvm] throw: "appendFile('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "readFileBytes('/../x810'): no se pudo abrir"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "writeFileBytes('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] pila: el main llegó a 244 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>RutaFueraFlash: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -13,7 +13,7 @@
 rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
 copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
 fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
-lastModified -> IOError: lastModified('/../x810'): no se pudo leer
+lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
 File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
 File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
...
```

oraculo (host):

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no se pudo leer
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no se pudo leer
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```

placa:

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```
</details>

- tras FlashCarpetas: uptimeMs=891363 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12164 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras GcHuecoPila: uptimeMs=891967 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12164 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras RefCaducadaBuiltin: uptimeMs=892971 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12088 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras DivBordes: uptimeMs=893440 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12164 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras ListaBorde: uptimeMs=894422 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12088 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras IndiceObjeto: uptimeMs=895765 fsUsed=548864 vmHeapBytes=6275072 pila libre: run=12164 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras GenericosOrden: uptimeMs=896852 fsUsed=544768 vmHeapBytes=6275072 pila libre: run=12088 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras SobrecargaEspecifica: uptimeMs=897603 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12164 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras SobrecargaVisible: uptimeMs=898460 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12088 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras BoolBits: uptimeMs=898969 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12164 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras ArrayNuevo: uptimeMs=899515 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12164 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras BucleConNombre: uptimeMs=900044 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12088 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras ErroresConTipo: uptimeMs=901128 fsUsed=544768 vmHeapBytes=6275072 pila libre: run=12100 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
<details><summary>ErroresConTipo: cola del stderr del host</summary>

```
its ALTOS: un bpref_t de 64b gu
[bpvm] UAF: idx=178  gen del handle=0  gen del slot=1  (slots en uso=180)
[bpvm]   gen 0 con el slot en 1: o una referencia CADUCADA al PRIMER objeto de ese slot (nace con gen 0: el programa lo libero y lo siguio usando), o un TRUNCAMIENTO (el handle perdio sus 32 bits ALTOS: un bpref_t de 64b gu
[bpvm] pila: el main llegó a 500 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] mutex: 1 creados, la tabla llegó a 1
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>ErroresConTipo: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -19,7 +19,7 @@
 ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
 ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
 ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
-ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
+ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
 ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
 ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
...
```

oraculo (host):

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```

placa:

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```
</details>

- tras IgualdadRefs: uptimeMs=901591 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12088 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras VarParam: uptimeMs=902466 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12100 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras StrNulo: uptimeMs=903356 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12088 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras DatosGrandes: uptimeMs=904563 fsUsed=569344 vmHeapBytes=6275072 pila libre: run=12100 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras DatosAnchos: uptimeMs=906618 fsUsed=606208 vmHeapBytes=6275072 pila libre: run=12088 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras HeapInfo: uptimeMs=907164 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12100 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- tras HeapCompact: uptimeMs=908103 fsUsed=536576 vmHeapBytes=6275072 pila libre: run=12088 io=9696 tareaREPL=9696 heap del sistema, minimo libre=6632
- ejecutadas (con EXITED) 26 de 28 listadas; no terminaron 0; saltadas 2; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/BorraCarpetaFichero.mod | bpgenvm-c\build\tanda\BorraCarpetaFichero\BorraCarpetaFichero.mod | 2271 | be28edf2 | ok |
| /app/RutaFueraFlash.mod | bpgenvm-c\build\tanda\RutaFueraFlash\RutaFueraFlash.mod | 3213 | 79cbf8d4 | ok |
| /app/FlashCarpetas.mod | bpgenvm-c\build\tanda\FlashCarpetas\FlashCarpetas.mod | 733 | c21b2696 | ok |
| /app/GcHuecoPila.mod | bpgenvm-c\build\tanda\GcHuecoPila\GcHuecoPila.mod | 1190 | 3304c6f0 | ok |
| /app/RefCaducadaBuiltin.mod | bpgenvm-c\build\tanda\RefCaducadaBuiltin\RefCaducadaBuiltin.mod | 1688 | 845498b8 | ok |
| /app/DivBordes.mod | bpgenvm-c\build\tanda\DivBordes\DivBordes.mod | 798 | 70f63a2f | ok |
| /app/ListaBorde.mod | bpgenvm-c\build\tanda\ListaBorde\ListaBorde.mod | 2918 | e6ddaaf1 | ok |
| /app/IndiceObjeto.mod | bpgenvm-c\build\tanda\IndiceObjeto\IndiceObjeto.mod | 12474 | 80c280cb | ok (por trozos) |
| /app/GenericosOrden.mod | bpgenvm-c\build\tanda\GenericosOrden\GenericosOrden.mod | 8456 | 52134d69 | ok (por trozos) |
| /app/SobrecargaEspecifica.mod | bpgenvm-c\build\tanda\SobrecargaEspecifica\SobrecargaEspecifica.mod | 1358 | 555c6ff1 | ok |
| /app/SobrecargaVisible.mod | bpgenvm-c\build\tanda\SobrecargaVisible\SobrecargaVisible.mod | 1999 | d3797df1 | ok |
| /app/BoolBits.mod | bpgenvm-c\build\tanda\BoolBits\BoolBits.mod | 876 | 7b87929a | ok |
| /app/ArrayNuevo.mod | bpgenvm-c\build\tanda\ArrayNuevo\ArrayNuevo.mod | 2393 | 2feee85e | ok |
| /app/BucleConNombre.mod | bpgenvm-c\build\tanda\BucleConNombre\BucleConNombre.mod | 1734 | 6c35f20c | ok |
| /app/ErroresConTipo.mod | bpgenvm-c\build\tanda\ErroresConTipo\ErroresConTipo.mod | 11493 | 7d9c7755 | ok (por trozos) |
| /app/IgualdadRefs.mod | bpgenvm-c\build\tanda\IgualdadRefs\IgualdadRefs.mod | 883 | 4a34e551 | ok |
| /app/VarParam.mod | bpgenvm-c\build\tanda\VarParam\VarParam.mod | 3481 | 1024398c | ok |
| /app/StrNulo.mod | bpgenvm-c\build\tanda\StrNulo\StrNulo.mod | 2784 | 4572ae05 | ok |
| /app/DatosGrandes.mod | bpgenvm-c\build\tanda\DatosGrandes\DatosGrandes.mod | 34291 | 822e223a | ok (por trozos) |
| /app/DatosAnchos.mod | bpgenvm-c\build\tanda\DatosAnchos\DatosAnchos.mod | 71917 | e70ef4fb | ok (por trozos) |
| /app/HeapInfo.mod | bpgenvm-c\build\tanda\HeapInfo\HeapInfo.mod | 1228 | 53946845 | ok |
| /app/HeapCompact.mod | bpgenvm-c\build\tanda\HeapCompact\HeapCompact.mod | 3560 | 3e213ca1 | ok |

notas de dependencias:

- dependencia Core: en la zona de packs (pack:Stdlib/Core.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Math: en la zona de packs (pack:Stdlib/Math.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Machine: en la zona de packs (pack:Stdlib/Machine.mod, crc igual): se ejecuta XIP, no se sube
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Collections: en la zona de packs (pack:Stdlib/Collections.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Str: en la zona de packs (pack:Stdlib/Str.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Placa stm32u5g9 - 20353850553250040015002D

- sello: boardName=`stm32u5g9` uniqueId=`20353850553250040015002D` serverName=`bpvm-stm32` serverBuild=`Nov 26 2026 19:20:09` version=`8.5` imageCrc=`f4846741` capacidades=["META", "FILES", "TERMINAL", "PACKS"]
- imagen: la COMPILADA en el PC: bpgenvm-c/stm32/Discovery_u5g9j/Discovery_u5g9j/Debug/Discovery_u5g9j.elf (26-11 19:20)
- imagen: arch=40 variant=None cpuFreqHz=160000000 resetReason=software uptimeMs=644305 fs=253952/1032192 B vmHeapBytes=1032192
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM12
- pantalla: si (INFO screenW x screenH = 800x480)
- inventario /lib+/app: 16 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 196 | 10 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 8 | 9 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 311 | 333 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 23 | 11 | EXITED OK exit=0 |
| GuiWinJson | **IDENTICO** | 639 | 62 | EXITED OK exit=0; host rc=0 |
| GuiShot | **NO-PETA** | 676 | 378 | EXITED OK exit=0 |
| BorraCarpetaFichero | **IDENTICO** | 150 | 15 | EXITED OK exit=0; host rc=0 |
| RutaFueraFlash | **DIFIERE** | 429 | 14 | texto distinto |
| FlashCarpetas | **IDENTICO** | 93 | 16 | EXITED OK exit=0; host rc=0 |
| GcHuecoPila | **IDENTICO** | 49 | 14 | EXITED OK exit=0; host rc=0 |
| RefCaducadaBuiltin | **IDENTICO** | 56 | 12 | EXITED OK exit=0; host rc=0 |
| DivBordes | **IDENTICO** | 65 | 13 | EXITED OK exit=0; host rc=0 |
| ListaBorde | **IDENTICO** | 242 | 22 | EXITED OK exit=0; host rc=0 |
| IndiceObjeto | **IDENTICO** | 287 | 24 | EXITED OK exit=0; host rc=0 |
| GenericosOrden | **IDENTICO** | 241 | 26 | EXITED OK exit=0; host rc=0 |
| SobrecargaEspecifica | **IDENTICO** | 59 | 10 | EXITED OK exit=0; host rc=0 |
| SobrecargaVisible | **IDENTICO** | 31 | 12 | EXITED OK exit=0; host rc=0 |
| BoolBits | **IDENTICO** | 87 | 10 | EXITED OK exit=0; host rc=0 |
| ArrayNuevo | **IDENTICO** | 101 | 39 | EXITED OK exit=0; host rc=0 |
| BucleConNombre | **IDENTICO** | 68 | 11 | EXITED OK exit=0; host rc=0 |
| ErroresConTipo | **DIFIERE** | 666 | 26 | texto distinto |
| IgualdadRefs | **IDENTICO** | 63 | 10 | EXITED OK exit=0; host rc=0 |
| VarParam | **IDENTICO** | 100 | 11 | EXITED OK exit=0; host rc=0 |
| StrNulo | **IDENTICO** | 114 | 13 | EXITED OK exit=0; host rc=0 |
| DatosGrandes | **IDENTICO** | 71 | 10 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 77 | 12 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 82 | 10 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 279 | 19 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=645440 fsUsed=262144 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras ThrowSinAtrapar: uptimeMs=646099 fsUsed=262144 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras ThreadTrasMain: uptimeMs=647080 fsUsed=262144 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras MachineId: uptimeMs=647605 fsUsed=262144 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras GuiWinJson: uptimeMs=649981 fsUsed=270336 vmHeapBytes=1032192 pila libre: run=-1 io=3216 tareaREPL=None heap del sistema, minimo libre=None
- tras GuiShot: uptimeMs=652350 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- artefacto GuiShot.shot de GuiShot: bajado a `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\stm32u5g9_203538505532\GuiShot.shot` (8718 B, crc d9978987) -> PNG `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\stm32u5g9_203538505532\GuiShot.png`; antes del RUN: existia: /GuiShot.shot (borrado)
- tras BorraCarpetaFichero: uptimeMs=654179 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras RutaFueraFlash: uptimeMs=655390 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
<details><summary>RutaFueraFlash: cola del stderr del host</summary>

```
throw: ATRAPADA por un catch del programa
[bpvm] throw: "appendFile('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "readFileBytes('/../x810'): no se pudo abrir"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "writeFileBytes('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] pila: el main llegó a 244 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>RutaFueraFlash: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -13,7 +13,7 @@
 rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
 copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
 fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
-lastModified -> IOError: lastModified('/../x810'): no se pudo leer
+lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
 File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
 File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
...
```

oraculo (host):

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no se pudo leer
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no se pudo leer
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```

placa:

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```
</details>

- tras FlashCarpetas: uptimeMs=655985 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras GcHuecoPila: uptimeMs=656617 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras RefCaducadaBuiltin: uptimeMs=657291 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras DivBordes: uptimeMs=657855 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras ListaBorde: uptimeMs=658974 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras IndiceObjeto: uptimeMs=661500 fsUsed=262144 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras GenericosOrden: uptimeMs=663687 fsUsed=262144 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras SobrecargaEspecifica: uptimeMs=664356 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras SobrecargaVisible: uptimeMs=665086 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras BoolBits: uptimeMs=665724 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras ArrayNuevo: uptimeMs=666563 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras BucleConNombre: uptimeMs=667255 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras ErroresConTipo: uptimeMs=670011 fsUsed=262144 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
<details><summary>ErroresConTipo: cola del stderr del host</summary>

```
its ALTOS: un bpref_t de 64b gu
[bpvm] UAF: idx=178  gen del handle=0  gen del slot=1  (slots en uso=180)
[bpvm]   gen 0 con el slot en 1: o una referencia CADUCADA al PRIMER objeto de ese slot (nace con gen 0: el programa lo libero y lo siguio usando), o un TRUNCAMIENTO (el handle perdio sus 32 bits ALTOS: un bpref_t de 64b gu
[bpvm] pila: el main llegó a 500 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] mutex: 1 creados, la tabla llegó a 1
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>ErroresConTipo: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -19,7 +19,7 @@
 ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
 ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
 ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
-ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
+ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
 ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
 ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
...
```

oraculo (host):

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```

placa:

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```
</details>

- tras IgualdadRefs: uptimeMs=670527 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras VarParam: uptimeMs=671434 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras StrNulo: uptimeMs=672237 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras DatosGrandes: uptimeMs=676072 fsUsed=286720 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras DatosAnchos: uptimeMs=683616 fsUsed=319488 vmHeapBytes=1032192 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras HeapInfo: uptimeMs=684256 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3216 tareaREPL=None heap del sistema, minimo libre=None
- tras HeapCompact: uptimeMs=685403 fsUsed=253952 vmHeapBytes=1032192 pila libre: run=-1 io=3240 tareaREPL=None heap del sistema, minimo libre=None
- ejecutadas (con EXITED) 28 de 28 listadas; no terminaron 0; saltadas 0; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/main.win | samples\formdemo\resources\main.win | 390 | 548edd67 | ok |
| /app/GuiWinJson.mod | bpgenvm-c\build\tanda\GuiWinJson\GuiWinJson.mod | 2041 | ea106f91 | ok |
| /app/GuiShot.mod | bpgenvm-c\build\tanda\GuiShot\GuiShot.mod | 1347 | f794de7d | ok |
| /app/BorraCarpetaFichero.mod | bpgenvm-c\build\tanda\BorraCarpetaFichero\BorraCarpetaFichero.mod | 2271 | be28edf2 | ok |
| /app/RutaFueraFlash.mod | bpgenvm-c\build\tanda\RutaFueraFlash\RutaFueraFlash.mod | 3213 | 79cbf8d4 | ok |
| /app/FlashCarpetas.mod | bpgenvm-c\build\tanda\FlashCarpetas\FlashCarpetas.mod | 733 | c21b2696 | ok |
| /app/GcHuecoPila.mod | bpgenvm-c\build\tanda\GcHuecoPila\GcHuecoPila.mod | 1190 | 3304c6f0 | ok |
| /app/RefCaducadaBuiltin.mod | bpgenvm-c\build\tanda\RefCaducadaBuiltin\RefCaducadaBuiltin.mod | 1688 | 845498b8 | ok |
| /app/DivBordes.mod | bpgenvm-c\build\tanda\DivBordes\DivBordes.mod | 798 | 70f63a2f | ok |
| /app/ListaBorde.mod | bpgenvm-c\build\tanda\ListaBorde\ListaBorde.mod | 2918 | e6ddaaf1 | ok |
| /app/IndiceObjeto.mod | bpgenvm-c\build\tanda\IndiceObjeto\IndiceObjeto.mod | 12474 | 80c280cb | ok (por trozos) |
| /app/GenericosOrden.mod | bpgenvm-c\build\tanda\GenericosOrden\GenericosOrden.mod | 8456 | 52134d69 | ok (por trozos) |
| /app/SobrecargaEspecifica.mod | bpgenvm-c\build\tanda\SobrecargaEspecifica\SobrecargaEspecifica.mod | 1358 | 555c6ff1 | ok |
| /app/SobrecargaVisible.mod | bpgenvm-c\build\tanda\SobrecargaVisible\SobrecargaVisible.mod | 1999 | d3797df1 | ok |
| /app/BoolBits.mod | bpgenvm-c\build\tanda\BoolBits\BoolBits.mod | 876 | 7b87929a | ok |
| /app/ArrayNuevo.mod | bpgenvm-c\build\tanda\ArrayNuevo\ArrayNuevo.mod | 2393 | 2feee85e | ok |
| /app/BucleConNombre.mod | bpgenvm-c\build\tanda\BucleConNombre\BucleConNombre.mod | 1734 | 6c35f20c | ok |
| /app/ErroresConTipo.mod | bpgenvm-c\build\tanda\ErroresConTipo\ErroresConTipo.mod | 11493 | 7d9c7755 | ok (por trozos) |
| /app/IgualdadRefs.mod | bpgenvm-c\build\tanda\IgualdadRefs\IgualdadRefs.mod | 883 | 4a34e551 | ok |
| /app/VarParam.mod | bpgenvm-c\build\tanda\VarParam\VarParam.mod | 3481 | 1024398c | ok |
| /app/StrNulo.mod | bpgenvm-c\build\tanda\StrNulo\StrNulo.mod | 2784 | 4572ae05 | ok |
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
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Placa esp32c6 - 58E6C5FFFEF9

- sello: boardName=`esp32c6` uniqueId=`58E6C5FFFEF9` serverName=`bpvm-esp32c6` serverBuild=`Nov 25 2026 16:20:27` version=`8.5` imageCrc=`a4ba200d` capacidades=["META", "FILES", "TERMINAL", "DEBUG", "PACKS"]
- imagen: la COMPILADA en el PC: bpgenvm-c/esp32c6/build/bpvm_esp32c6.bin (26-11 19:21)
- imagen: arch=243 variant=None cpuFreqHz=160000000 resetReason=software uptimeMs=392025 fs=176128/1261568 B vmHeapBytes=114688
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM3
- pantalla: si (INFO screenW x screenH = 240x240)
- inventario /lib+/app: 6 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 7 | 10 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 5 | 9 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 308 | 333 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 5 | 11 | EXITED OK exit=0 |
| GuiWinJson | **IDENTICO** | 1096 | 62 | EXITED OK exit=0; host rc=0 |
| GuiShot | **NO-PETA** | 580 | 394 | EXITED OK exit=0 |
| BorraCarpetaFichero | **IDENTICO** | 260 | 15 | EXITED OK exit=0; host rc=0 |
| RutaFueraFlash | **DIFIERE** | 76 | 14 | texto distinto |
| FlashCarpetas | **IDENTICO** | 150 | 16 | EXITED OK exit=0; host rc=0 |
| GcHuecoPila | **IDENTICO** | 121 | 14 | EXITED OK exit=0; host rc=0 |
| RefCaducadaBuiltin | **IDENTICO** | 9 | 12 | EXITED OK exit=0; host rc=0 |
| DivBordes | **IDENTICO** | 5 | 13 | EXITED OK exit=0; host rc=0 |
| ListaBorde | **IDENTICO** | 40 | 22 | EXITED OK exit=0; host rc=0 |
| IndiceObjeto | **IDENTICO** | 67 | 24 | EXITED OK exit=0; host rc=0 |
| GenericosOrden | **IDENTICO** | 55 | 26 | EXITED OK exit=0; host rc=0 |
| SobrecargaEspecifica | **IDENTICO** | 8 | 10 | EXITED OK exit=0; host rc=0 |
| SobrecargaVisible | **IDENTICO** | 7 | 12 | EXITED OK exit=0; host rc=0 |
| BoolBits | **IDENTICO** | 7 | 10 | EXITED OK exit=0; host rc=0 |
| ArrayNuevo | **IDENTICO** | 11 | 39 | EXITED OK exit=0; host rc=0 |
| BucleConNombre | **IDENTICO** | 6 | 11 | EXITED OK exit=0; host rc=0 |
| ErroresConTipo | **DIFIERE** | 175 | 26 | texto distinto |
| IgualdadRefs | **IDENTICO** | 7 | 10 | EXITED OK exit=0; host rc=0 |
| VarParam | **IDENTICO** | 13 | 11 | EXITED OK exit=0; host rc=0 |
| StrNulo | **IDENTICO** | 10 | 13 | EXITED OK exit=0; host rc=0 |
| DatosGrandes | **IDENTICO** | 9 | 10 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 11 | 12 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 29 | 10 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 469 | 19 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=392789 fsUsed=180224 vmHeapBytes=114688 pila libre: run=5824 io=5776 tareaREPL=5776 heap del sistema, minimo libre=60236
- tras ThrowSinAtrapar: uptimeMs=393217 fsUsed=180224 vmHeapBytes=114688 pila libre: run=5824 io=5776 tareaREPL=5776 heap del sistema, minimo libre=60236
- tras ThreadTrasMain: uptimeMs=394008 fsUsed=180224 vmHeapBytes=114688 pila libre: run=5824 io=5776 tareaREPL=5776 heap del sistema, minimo libre=60236
- tras MachineId: uptimeMs=394557 fsUsed=180224 vmHeapBytes=114688 pila libre: run=5824 io=5776 tareaREPL=5776 heap del sistema, minimo libre=60236
- tras GuiWinJson: uptimeMs=397858 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5824 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras GuiShot: uptimeMs=399982 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- artefacto GuiShot.shot de GuiShot: bajado a `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32c6_58E6C5FFFEF9\GuiShot.shot` (3038 B, crc 7459129a) -> PNG `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32c6_58E6C5FFFEF9\GuiShot.png`; antes del RUN: no existia
- tras BorraCarpetaFichero: uptimeMs=401000 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras RutaFueraFlash: uptimeMs=401913 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
<details><summary>RutaFueraFlash: cola del stderr del host</summary>

```
throw: ATRAPADA por un catch del programa
[bpvm] throw: "appendFile('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "readFileBytes('/../x810'): no se pudo abrir"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "writeFileBytes('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] pila: el main llegó a 244 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>RutaFueraFlash: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -13,7 +13,7 @@
 rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
 copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
 fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
-lastModified -> IOError: lastModified('/../x810'): no se pudo leer
+lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
 File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
 File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
...
```

oraculo (host):

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no se pudo leer
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no se pudo leer
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```

placa:

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```
</details>

- tras FlashCarpetas: uptimeMs=402629 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras GcHuecoPila: uptimeMs=403486 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras RefCaducadaBuiltin: uptimeMs=403968 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras DivBordes: uptimeMs=404395 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras ListaBorde: uptimeMs=405394 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras IndiceObjeto: uptimeMs=407297 fsUsed=196608 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras GenericosOrden: uptimeMs=408455 fsUsed=192512 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras SobrecargaEspecifica: uptimeMs=408902 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras SobrecargaVisible: uptimeMs=409406 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras BoolBits: uptimeMs=409838 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras ArrayNuevo: uptimeMs=410388 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras BucleConNombre: uptimeMs=411055 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras ErroresConTipo: uptimeMs=412411 fsUsed=192512 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
<details><summary>ErroresConTipo: cola del stderr del host</summary>

```
its ALTOS: un bpref_t de 64b gu
[bpvm] UAF: idx=178  gen del handle=0  gen del slot=1  (slots en uso=180)
[bpvm]   gen 0 con el slot en 1: o una referencia CADUCADA al PRIMER objeto de ese slot (nace con gen 0: el programa lo libero y lo siguio usando), o un TRUNCAMIENTO (el handle perdio sus 32 bits ALTOS: un bpref_t de 64b gu
[bpvm] pila: el main llegó a 500 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] mutex: 1 creados, la tabla llegó a 1
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>ErroresConTipo: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -19,7 +19,7 @@
 ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
 ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
 ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
-ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
+ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
 ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
 ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
...
```

oraculo (host):

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```

placa:

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```
</details>

- tras IgualdadRefs: uptimeMs=412839 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras VarParam: uptimeMs=413843 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras StrNulo: uptimeMs=414699 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras DatosGrandes: uptimeMs=415646 fsUsed=217088 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras DatosAnchos: uptimeMs=417263 fsUsed=253952 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras HeapInfo: uptimeMs=417793 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- tras HeapCompact: uptimeMs=419094 fsUsed=184320 vmHeapBytes=114688 pila libre: run=5284 io=5580 tareaREPL=5580 heap del sistema, minimo libre=29972
- ejecutadas (con EXITED) 28 de 28 listadas; no terminaron 0; saltadas 0; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/main.win | samples\formdemo\resources\main.win | 390 | 548edd67 | ok |
| /app/GuiWinJson.mod | bpgenvm-c\build\tanda\GuiWinJson\GuiWinJson.mod | 2041 | ea106f91 | ok |
| /app/GuiShot.mod | bpgenvm-c\build\tanda\GuiShot\GuiShot.mod | 1347 | f794de7d | ok |
| /app/BorraCarpetaFichero.mod | bpgenvm-c\build\tanda\BorraCarpetaFichero\BorraCarpetaFichero.mod | 2271 | be28edf2 | ok |
| /app/RutaFueraFlash.mod | bpgenvm-c\build\tanda\RutaFueraFlash\RutaFueraFlash.mod | 3213 | 79cbf8d4 | ok |
| /app/FlashCarpetas.mod | bpgenvm-c\build\tanda\FlashCarpetas\FlashCarpetas.mod | 733 | c21b2696 | ok |
| /app/GcHuecoPila.mod | bpgenvm-c\build\tanda\GcHuecoPila\GcHuecoPila.mod | 1190 | 3304c6f0 | ok |
| /app/RefCaducadaBuiltin.mod | bpgenvm-c\build\tanda\RefCaducadaBuiltin\RefCaducadaBuiltin.mod | 1688 | 845498b8 | ok |
| /app/DivBordes.mod | bpgenvm-c\build\tanda\DivBordes\DivBordes.mod | 798 | 70f63a2f | ok |
| /app/ListaBorde.mod | bpgenvm-c\build\tanda\ListaBorde\ListaBorde.mod | 2918 | e6ddaaf1 | ok |
| /app/IndiceObjeto.mod | bpgenvm-c\build\tanda\IndiceObjeto\IndiceObjeto.mod | 12474 | 80c280cb | ok (por trozos) |
| /app/GenericosOrden.mod | bpgenvm-c\build\tanda\GenericosOrden\GenericosOrden.mod | 8456 | 52134d69 | ok (por trozos) |
| /app/SobrecargaEspecifica.mod | bpgenvm-c\build\tanda\SobrecargaEspecifica\SobrecargaEspecifica.mod | 1358 | 555c6ff1 | ok |
| /app/SobrecargaVisible.mod | bpgenvm-c\build\tanda\SobrecargaVisible\SobrecargaVisible.mod | 1999 | d3797df1 | ok |
| /app/BoolBits.mod | bpgenvm-c\build\tanda\BoolBits\BoolBits.mod | 876 | 7b87929a | ok |
| /app/ArrayNuevo.mod | bpgenvm-c\build\tanda\ArrayNuevo\ArrayNuevo.mod | 2393 | 2feee85e | ok |
| /app/BucleConNombre.mod | bpgenvm-c\build\tanda\BucleConNombre\BucleConNombre.mod | 1734 | 6c35f20c | ok |
| /app/ErroresConTipo.mod | bpgenvm-c\build\tanda\ErroresConTipo\ErroresConTipo.mod | 11493 | 7d9c7755 | ok (por trozos) |
| /app/IgualdadRefs.mod | bpgenvm-c\build\tanda\IgualdadRefs\IgualdadRefs.mod | 883 | 4a34e551 | ok |
| /app/VarParam.mod | bpgenvm-c\build\tanda\VarParam\VarParam.mod | 3481 | 1024398c | ok |
| /app/StrNulo.mod | bpgenvm-c\build\tanda\StrNulo\StrNulo.mod | 2784 | 4572ae05 | ok |
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
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Matriz pruebas x placas

| prueba | rp2350a@COM22 | rp2350b@COM4 | stm32u5g9@COM12 | esp32c6@COM3 |
|---|---|---|---|---|
| MathRango | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| ThrowSinAtrapar | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| ThreadTrasMain | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| MachineId | NO-PETA | NO-PETA | NO-PETA | NO-PETA |
| GuiWinJson | SALTADA | SALTADA | IDENTICO | IDENTICO |
| GuiShot | SALTADA | SALTADA | NO-PETA | NO-PETA |
| BorraCarpetaFichero | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| RutaFueraFlash | DIFIERE | DIFIERE | DIFIERE | DIFIERE |
| FlashCarpetas | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| GcHuecoPila | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| RefCaducadaBuiltin | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| DivBordes | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| ListaBorde | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| IndiceObjeto | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| GenericosOrden | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| SobrecargaEspecifica | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| SobrecargaVisible | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| BoolBits | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| ArrayNuevo | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| BucleConNombre | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| ErroresConTipo | DIFIERE | DIFIERE | DIFIERE | DIFIERE |
| IgualdadRefs | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| VarParam | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| StrNulo | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| DatosGrandes | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| DatosAnchos | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| HeapInfo | IDENTICO | IDENTICO | IDENTICO | IDENTICO |
| HeapCompact | IDENTICO | IDENTICO | IDENTICO | IDENTICO |

SALTADA: GuiWinJson en rp2350a@COM22: necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL)  
SALTADA: GuiShot en rp2350a@COM22: necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL)  
SALTADA: GuiWinJson en rp2350b@COM4: necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL)  
SALTADA: GuiShot en rp2350b@COM4: necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL)  
NECESITA OJOS: GuiShot en stm32u5g9@COM12: C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\stm32u5g9_203538505532\GuiShot.png  
NECESITA OJOS: GuiShot en esp32c6@COM3: C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32c6_58E6C5FFFEF9\GuiShot.png  


## Tanda 2026-11-27 17:33:37

- manifiesto: `..\..\Users\Eduardo\AppData\Local\Temp\claude\2cbf9ff7f3759075\576fc834-e260-4649-ba6c-131c549812a9\scratchpad\lote85\lista_lote85.json` (28 pruebas listadas)
- oraculo: jar `toolchain\lexer-java\target\basicplus-frontend.jar` (2026-11-25 18:51:06) - exe `bpgenvm-c\build\bpgenvm-c.exe` (2026-11-27 17:01:29) - sabor `v2-gui1-lvgl0`
- placas conectadas: 3 (esp32c3@COM3, esp32c5@COM6, stm32u575@COM5)

### Oraculo por prueba (PC)

| prueba | modulo | crc .mod | tamano | compilacion | host rc | ms host | lineas salida |
|---|---|---|---|---|---|---|---|
| MathRango | MathRango | 2270c82e | 1611 | ok | 0 | 17 | 29 |
| ThrowSinAtrapar | ThrowSinAtrapar | 9b053410 | 295 | ok | 1 | 12 | 1 |
| ThreadTrasMain | ThreadTrasMain | 97dd1bb5 | 532 | ok | 0 | 338 | 3 |
| MachineId | MachineId | 42a7e155 | 452 | ok | 0 | 13 | 3 |
| GuiWinJson | GuiWinJson | ea106f91 | 2041 | ok | 0 | 81 | 17 |
| GuiShot | GuiShot | f794de7d | 1347 | ok | 0 | 389 | 8 |
| BorraCarpetaFichero | BorraCarpetaFichero | be28edf2 | 2271 | ok | 0 | 18 | 9 |
| RutaFueraFlash | RutaFueraFlash | 79cbf8d4 | 3213 | ok | 0 | 14 | 39 |
| FlashCarpetas | FlashCarpetas | c21b2696 | 733 | ok | 0 | 25 | 7 |
| GcHuecoPila | GcHuecoPila | 3304c6f0 | 1190 | ok | 0 | 13 | 3 |
| RefCaducadaBuiltin | RefCaducadaBuiltin | 845498b8 | 1688 | ok | 0 | 13 | 6 |
| DivBordes | DivBordes | 70f63a2f | 798 | ok | 0 | 11 | 10 |
| ListaBorde | ListaBorde | e6ddaaf1 | 2918 | ok | 0 | 21 | 26 |
| IndiceObjeto | IndiceObjeto | 80c280cb | 12474 | ok | 0 | 25 | 36 |
| GenericosOrden | GenericosOrden | 52134d69 | 8456 | ok | 0 | 23 | 30 |
| SobrecargaEspecifica | SobrecargaEspecifica | 555c6ff1 | 1358 | ok | 0 | 10 | 9 |
| SobrecargaVisible | SobrecargaVisible | d3797df1 | 1999 | ok | 0 | 11 | 4 |
| BoolBits | BoolBits | 7b87929a | 876 | ok | 0 | 12 | 15 |
| ArrayNuevo | ArrayNuevo | 2feee85e | 2393 | ok | 0 | 37 | 17 |
| BucleConNombre | BucleConNombre | 6c35f20c | 1734 | ok | 0 | 10 | 12 |
| ErroresConTipo | ErroresConTipo | 7d9c7755 | 11493 | ok | 0 | 26 | 48 |
| IgualdadRefs | IgualdadRefs | 4a34e551 | 883 | ok | 0 | 10 | 8 |
| VarParam | VarParam | 1024398c | 3481 | ok | 0 | 12 | 12 |
| StrNulo | StrNulo | 4572ae05 | 2784 | ok | 0 | 10 | 14 |
| DatosGrandes | DatosGrandes | 822e223a | 34291 | ok | 0 | 10 | 11 |
| DatosAnchos | DatosAnchos | e70ef4fb | 71917 | ok | 0 | 11 | 12 |
| HeapInfo | HeapInfo | 53946845 | 1228 | ok | 0 | 12 | 10 |
| HeapCompact | HeapCompact | 3e213ca1 | 3560 | ok | 0 | 16 | 17 |

### Placa esp32c3 - E072A1214078

- sello: boardName=`esp32c3` uniqueId=`E072A1214078` serverName=`bpvm-esp32c3` serverBuild=`Nov 25 2026 16:19:16` version=`8.5` imageCrc=`6810ee3c` capacidades=["META", "FILES", "TERMINAL", "DEBUG", "PACKS"]
- imagen: la COMPILADA en el PC: bpgenvm-c/esp32c3/build/bpvm_esp32c3.bin (26-11 19:20)
- imagen: arch=243 variant=None cpuFreqHz=160000000 resetReason=USB uptimeMs=382840 fs=94208/1523712 B vmHeapBytes=98304
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM3
- pantalla: no (INFO sin screenW/screenH: la imagen no lleva LVGL)
- inventario /lib+/app: 5 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 7 | 17 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 6 | 12 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 312 | 338 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 5 | 13 | EXITED OK exit=0 |
| GuiWinJson | **SALTADA** | - | 81 | necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL) |
| GuiShot | **SALTADA** | - | 389 | necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL) |
| BorraCarpetaFichero | **IDENTICO** | 180 | 18 | EXITED OK exit=0; host rc=0 |
| RutaFueraFlash | **DIFIERE** | 83 | 14 | texto distinto |
| FlashCarpetas | **IDENTICO** | 90 | 25 | EXITED OK exit=0; host rc=0 |
| GcHuecoPila | **IDENTICO** | 63 | 13 | EXITED OK exit=0; host rc=0 |
| RefCaducadaBuiltin | **IDENTICO** | 12 | 13 | EXITED OK exit=0; host rc=0 |
| DivBordes | **IDENTICO** | 8 | 11 | EXITED OK exit=0; host rc=0 |
| ListaBorde | **IDENTICO** | 52 | 21 | EXITED OK exit=0; host rc=0 |
| IndiceObjeto | **IDENTICO** | 81 | 25 | EXITED OK exit=0; host rc=0 |
| GenericosOrden | **IDENTICO** | 69 | 23 | EXITED OK exit=0; host rc=0 |
| SobrecargaEspecifica | **IDENTICO** | 8 | 10 | EXITED OK exit=0; host rc=0 |
| SobrecargaVisible | **IDENTICO** | 8 | 11 | EXITED OK exit=0; host rc=0 |
| BoolBits | **IDENTICO** | 7 | 12 | EXITED OK exit=0; host rc=0 |
| ArrayNuevo | **IDENTICO** | 18 | 37 | EXITED OK exit=0; host rc=0 |
| BucleConNombre | **IDENTICO** | 8 | 10 | EXITED OK exit=0; host rc=0 |
| ErroresConTipo | **DIFIERE** | 213 | 26 | texto distinto |
| IgualdadRefs | **IDENTICO** | 8 | 10 | EXITED OK exit=0; host rc=0 |
| VarParam | **IDENTICO** | 18 | 12 | EXITED OK exit=0; host rc=0 |
| StrNulo | **IDENTICO** | 13 | 10 | EXITED OK exit=0; host rc=0 |
| DatosGrandes | **IDENTICO** | 11 | 10 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 14 | 11 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 32 | 12 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 663 | 16 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=383526 fsUsed=98304 vmHeapBytes=98304 pila libre: run=8272 io=9888 tareaREPL=9888 heap del sistema, minimo libre=83916
- tras ThrowSinAtrapar: uptimeMs=384057 fsUsed=98304 vmHeapBytes=98304 pila libre: run=8272 io=9888 tareaREPL=9888 heap del sistema, minimo libre=83916
- tras ThreadTrasMain: uptimeMs=384919 fsUsed=98304 vmHeapBytes=98304 pila libre: run=8272 io=9888 tareaREPL=9888 heap del sistema, minimo libre=83916
- tras MachineId: uptimeMs=385510 fsUsed=98304 vmHeapBytes=98304 pila libre: run=8272 io=9888 tareaREPL=9888 heap del sistema, minimo libre=83916
- tras BorraCarpetaFichero: uptimeMs=386131 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9888 tareaREPL=9888 heap del sistema, minimo libre=83916
- tras RutaFueraFlash: uptimeMs=386562 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9888 tareaREPL=9888 heap del sistema, minimo libre=83916
<details><summary>RutaFueraFlash: cola del stderr del host</summary>

```
throw: ATRAPADA por un catch del programa
[bpvm] throw: "appendFile('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "readFileBytes('/../x810'): no se pudo abrir"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "writeFileBytes('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] pila: el main llegó a 244 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>RutaFueraFlash: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -13,7 +13,7 @@
 rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
 copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
 fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
-lastModified -> IOError: lastModified('/../x810'): no se pudo leer
+lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
 File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
 File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
...
```

oraculo (host):

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no se pudo leer
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no se pudo leer
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```

placa:

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```
</details>

- tras FlashCarpetas: uptimeMs=386978 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9888 tareaREPL=9888 heap del sistema, minimo libre=83916
- tras GcHuecoPila: uptimeMs=387412 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=83916
- tras RefCaducadaBuiltin: uptimeMs=387880 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=83916
- tras DivBordes: uptimeMs=388280 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=83916
- tras ListaBorde: uptimeMs=389266 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=83916
- tras IndiceObjeto: uptimeMs=390717 fsUsed=110592 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=80356
- tras GenericosOrden: uptimeMs=392032 fsUsed=106496 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=80356
- tras SobrecargaEspecifica: uptimeMs=392499 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=80356
- tras SobrecargaVisible: uptimeMs=392999 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=80356
- tras BoolBits: uptimeMs=393452 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=80356
- tras ArrayNuevo: uptimeMs=393884 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=80356
- tras BucleConNombre: uptimeMs=394446 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=80356
- tras ErroresConTipo: uptimeMs=395850 fsUsed=106496 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=79940
<details><summary>ErroresConTipo: cola del stderr del host</summary>

```
its ALTOS: un bpref_t de 64b gu
[bpvm] UAF: idx=178  gen del handle=0  gen del slot=1  (slots en uso=180)
[bpvm]   gen 0 con el slot en 1: o una referencia CADUCADA al PRIMER objeto de ese slot (nace con gen 0: el programa lo libero y lo siguio usando), o un TRUNCAMIENTO (el handle perdio sus 32 bits ALTOS: un bpref_t de 64b gu
[bpvm] pila: el main llegó a 500 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] mutex: 1 creados, la tabla llegó a 1
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>ErroresConTipo: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -19,7 +19,7 @@
 ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
 ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
 ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
-ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
+ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
 ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
 ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
...
```

oraculo (host):

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```

placa:

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```
</details>

- tras IgualdadRefs: uptimeMs=396241 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=79940
- tras VarParam: uptimeMs=397168 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=79940
- tras StrNulo: uptimeMs=397722 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=79940
- tras DatosGrandes: uptimeMs=398457 fsUsed=131072 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=79940
- tras DatosAnchos: uptimeMs=399707 fsUsed=167936 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=79940
- tras HeapInfo: uptimeMs=400220 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=79940
- tras HeapCompact: uptimeMs=401891 fsUsed=98304 vmHeapBytes=98304 pila libre: run=7756 io=9848 tareaREPL=9848 heap del sistema, minimo libre=79940
- ejecutadas (con EXITED) 26 de 28 listadas; no terminaron 0; saltadas 2; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/BorraCarpetaFichero.mod | bpgenvm-c\build\tanda\BorraCarpetaFichero\BorraCarpetaFichero.mod | 2271 | be28edf2 | ok |
| /app/RutaFueraFlash.mod | bpgenvm-c\build\tanda\RutaFueraFlash\RutaFueraFlash.mod | 3213 | 79cbf8d4 | ok |
| /app/FlashCarpetas.mod | bpgenvm-c\build\tanda\FlashCarpetas\FlashCarpetas.mod | 733 | c21b2696 | ok |
| /app/GcHuecoPila.mod | bpgenvm-c\build\tanda\GcHuecoPila\GcHuecoPila.mod | 1190 | 3304c6f0 | ok |
| /app/RefCaducadaBuiltin.mod | bpgenvm-c\build\tanda\RefCaducadaBuiltin\RefCaducadaBuiltin.mod | 1688 | 845498b8 | ok |
| /app/DivBordes.mod | bpgenvm-c\build\tanda\DivBordes\DivBordes.mod | 798 | 70f63a2f | ok |
| /app/ListaBorde.mod | bpgenvm-c\build\tanda\ListaBorde\ListaBorde.mod | 2918 | e6ddaaf1 | ok |
| /app/IndiceObjeto.mod | bpgenvm-c\build\tanda\IndiceObjeto\IndiceObjeto.mod | 12474 | 80c280cb | ok (por trozos) |
| /app/GenericosOrden.mod | bpgenvm-c\build\tanda\GenericosOrden\GenericosOrden.mod | 8456 | 52134d69 | ok (por trozos) |
| /app/SobrecargaEspecifica.mod | bpgenvm-c\build\tanda\SobrecargaEspecifica\SobrecargaEspecifica.mod | 1358 | 555c6ff1 | ok |
| /app/SobrecargaVisible.mod | bpgenvm-c\build\tanda\SobrecargaVisible\SobrecargaVisible.mod | 1999 | d3797df1 | ok |
| /app/BoolBits.mod | bpgenvm-c\build\tanda\BoolBits\BoolBits.mod | 876 | 7b87929a | ok |
| /app/ArrayNuevo.mod | bpgenvm-c\build\tanda\ArrayNuevo\ArrayNuevo.mod | 2393 | 2feee85e | ok |
| /app/BucleConNombre.mod | bpgenvm-c\build\tanda\BucleConNombre\BucleConNombre.mod | 1734 | 6c35f20c | ok |
| /app/ErroresConTipo.mod | bpgenvm-c\build\tanda\ErroresConTipo\ErroresConTipo.mod | 11493 | 7d9c7755 | ok (por trozos) |
| /app/IgualdadRefs.mod | bpgenvm-c\build\tanda\IgualdadRefs\IgualdadRefs.mod | 883 | 4a34e551 | ok |
| /app/VarParam.mod | bpgenvm-c\build\tanda\VarParam\VarParam.mod | 3481 | 1024398c | ok |
| /app/StrNulo.mod | bpgenvm-c\build\tanda\StrNulo\StrNulo.mod | 2784 | 4572ae05 | ok |
| /app/DatosGrandes.mod | bpgenvm-c\build\tanda\DatosGrandes\DatosGrandes.mod | 34291 | 822e223a | ok (por trozos) |
| /app/DatosAnchos.mod | bpgenvm-c\build\tanda\DatosAnchos\DatosAnchos.mod | 71917 | e70ef4fb | ok (por trozos) |
| /app/HeapInfo.mod | bpgenvm-c\build\tanda\HeapInfo\HeapInfo.mod | 1228 | 53946845 | ok |
| /app/HeapCompact.mod | bpgenvm-c\build\tanda\HeapCompact\HeapCompact.mod | 3560 | 3e213ca1 | ok |

notas de dependencias:

- dependencia Core: en la zona de packs (pack:Stdlib/Core.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Math: en la zona de packs (pack:Stdlib/Math.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Machine: en la zona de packs (pack:Stdlib/Machine.mod, crc igual): se ejecuta XIP, no se sube
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Collections: en la zona de packs (pack:Stdlib/Collections.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Str: en la zona de packs (pack:Stdlib/Str.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Placa esp32c5 - 10BDA3FEFFDF

- sello: boardName=`esp32c5` uniqueId=`10BDA3FEFFDF` serverName=`bpvm-esp32c5` serverBuild=`Nov 25 2026 16:19:51` version=`8.5` imageCrc=`90b38453` capacidades=["META", "FILES", "TERMINAL", "DEBUG", "PACKS"]
- imagen: la COMPILADA en el PC: bpgenvm-c/esp32c5/build/bpvm_esp32c5.bin (26-11 19:20)
- imagen: arch=243 variant=None cpuFreqHz=240000000 resetReason=software uptimeMs=189109 fs=217088/16777216 B vmHeapBytes=7320576
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM6
- pantalla: si (INFO screenW x screenH = 240x320)
- inventario /lib+/app: 33 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 15 | 17 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 14 | 12 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 321 | 338 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 13 | 13 | EXITED OK exit=0 |
| GuiWinJson | **IDENTICO** | 991 | 62 | EXITED OK exit=0; host rc=0 |
| GuiShot | **NO-PETA** | 615 | 374 | EXITED OK exit=0 |
| BorraCarpetaFichero | **IDENTICO** | 186 | 18 | EXITED OK exit=0; host rc=0 |
| RutaFueraFlash | **DIFIERE** | 94 | 14 | texto distinto |
| FlashCarpetas | **IDENTICO** | 147 | 25 | EXITED OK exit=0; host rc=0 |
| GcHuecoPila | **IDENTICO** | 169 | 13 | EXITED OK exit=0; host rc=0 |
| RefCaducadaBuiltin | **IDENTICO** | 21 | 13 | EXITED OK exit=0; host rc=0 |
| DivBordes | **IDENTICO** | 15 | 11 | EXITED OK exit=0; host rc=0 |
| ListaBorde | **IDENTICO** | 52 | 21 | EXITED OK exit=0; host rc=0 |
| IndiceObjeto | **IDENTICO** | 73 | 25 | EXITED OK exit=0; host rc=0 |
| GenericosOrden | **IDENTICO** | 63 | 23 | EXITED OK exit=0; host rc=0 |
| SobrecargaEspecifica | **IDENTICO** | 17 | 10 | EXITED OK exit=0; host rc=0 |
| SobrecargaVisible | **IDENTICO** | 16 | 11 | EXITED OK exit=0; host rc=0 |
| BoolBits | **IDENTICO** | 15 | 12 | EXITED OK exit=0; host rc=0 |
| ArrayNuevo | **IDENTICO** | 38 | 37 | EXITED OK exit=0; host rc=0 |
| BucleConNombre | **IDENTICO** | 16 | 10 | EXITED OK exit=0; host rc=0 |
| ErroresConTipo | **DIFIERE** | 162 | 26 | texto distinto |
| IgualdadRefs | **IDENTICO** | 15 | 10 | EXITED OK exit=0; host rc=0 |
| VarParam | **IDENTICO** | 22 | 12 | EXITED OK exit=0; host rc=0 |
| StrNulo | **IDENTICO** | 21 | 10 | EXITED OK exit=0; host rc=0 |
| DatosGrandes | **IDENTICO** | 31 | 10 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 23 | 11 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 56 | 12 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 427 | 16 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=190017 fsUsed=221184 vmHeapBytes=7320576 pila libre: run=13764 io=9864 tareaREPL=9864 heap del sistema, minimo libre=45368
- tras ThrowSinAtrapar: uptimeMs=190453 fsUsed=221184 vmHeapBytes=7320576 pila libre: run=13764 io=9864 tareaREPL=9864 heap del sistema, minimo libre=45368
- tras ThreadTrasMain: uptimeMs=191437 fsUsed=221184 vmHeapBytes=7320576 pila libre: run=13576 io=9864 tareaREPL=9864 heap del sistema, minimo libre=45200
- tras MachineId: uptimeMs=191866 fsUsed=221184 vmHeapBytes=7320576 pila libre: run=13576 io=9864 tareaREPL=9864 heap del sistema, minimo libre=45036
- tras GuiWinJson: uptimeMs=194648 fsUsed=225280 vmHeapBytes=7320576 pila libre: run=12400 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36420
- tras GuiShot: uptimeMs=196737 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- artefacto GuiShot.shot de GuiShot: bajado a `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32c5_10BDA3FEFFDF\GuiShot.shot` (3350 B, crc f0589b1a) -> PNG `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32c5_10BDA3FEFFDF\GuiShot.png`; antes del RUN: existia: /GuiShot.shot (borrado)
- tras BorraCarpetaFichero: uptimeMs=198001 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras RutaFueraFlash: uptimeMs=198822 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
<details><summary>RutaFueraFlash: cola del stderr del host</summary>

```
throw: ATRAPADA por un catch del programa
[bpvm] throw: "appendFile('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "readFileBytes('/../x810'): no se pudo abrir"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "writeFileBytes('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] pila: el main llegó a 244 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>RutaFueraFlash: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -13,7 +13,7 @@
 rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
 copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
 fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
-lastModified -> IOError: lastModified('/../x810'): no se pudo leer
+lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
 File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
 File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
...
```

oraculo (host):

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no se pudo leer
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no se pudo leer
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```

placa:

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```
</details>

- tras FlashCarpetas: uptimeMs=199427 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras GcHuecoPila: uptimeMs=200361 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras RefCaducadaBuiltin: uptimeMs=200975 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras DivBordes: uptimeMs=201359 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras ListaBorde: uptimeMs=202264 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras IndiceObjeto: uptimeMs=203631 fsUsed=229376 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras GenericosOrden: uptimeMs=204751 fsUsed=225280 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras SobrecargaEspecifica: uptimeMs=205183 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras SobrecargaVisible: uptimeMs=205664 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras BoolBits: uptimeMs=206118 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras ArrayNuevo: uptimeMs=206784 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras BucleConNombre: uptimeMs=207368 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras ErroresConTipo: uptimeMs=208702 fsUsed=225280 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
<details><summary>ErroresConTipo: cola del stderr del host</summary>

```
its ALTOS: un bpref_t de 64b gu
[bpvm] UAF: idx=178  gen del handle=0  gen del slot=1  (slots en uso=180)
[bpvm]   gen 0 con el slot en 1: o una referencia CADUCADA al PRIMER objeto de ese slot (nace con gen 0: el programa lo libero y lo siguio usando), o un TRUNCAMIENTO (el handle perdio sus 32 bits ALTOS: un bpref_t de 64b gu
[bpvm] pila: el main llegó a 500 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] mutex: 1 creados, la tabla llegó a 1
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>ErroresConTipo: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -19,7 +19,7 @@
 ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
 ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
 ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
-ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
+ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
 ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
 ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
...
```

oraculo (host):

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```

placa:

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```
</details>

- tras IgualdadRefs: uptimeMs=209123 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras VarParam: uptimeMs=210204 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras StrNulo: uptimeMs=210738 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras DatosGrandes: uptimeMs=211491 fsUsed=249856 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras DatosAnchos: uptimeMs=212806 fsUsed=286720 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras HeapInfo: uptimeMs=213524 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- tras HeapCompact: uptimeMs=214874 fsUsed=217088 vmHeapBytes=7320576 pila libre: run=11428 io=9668 tareaREPL=9668 heap del sistema, minimo libre=36300
- ejecutadas (con EXITED) 28 de 28 listadas; no terminaron 0; saltadas 0; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/main.win | samples\formdemo\resources\main.win | 390 | 548edd67 | ok |
| /app/GuiWinJson.mod | bpgenvm-c\build\tanda\GuiWinJson\GuiWinJson.mod | 2041 | ea106f91 | ok |
| /app/GuiShot.mod | bpgenvm-c\build\tanda\GuiShot\GuiShot.mod | 1347 | f794de7d | ok |
| /app/BorraCarpetaFichero.mod | bpgenvm-c\build\tanda\BorraCarpetaFichero\BorraCarpetaFichero.mod | 2271 | be28edf2 | ok |
| /app/RutaFueraFlash.mod | bpgenvm-c\build\tanda\RutaFueraFlash\RutaFueraFlash.mod | 3213 | 79cbf8d4 | ok |
| /app/FlashCarpetas.mod | bpgenvm-c\build\tanda\FlashCarpetas\FlashCarpetas.mod | 733 | c21b2696 | ok |
| /app/GcHuecoPila.mod | bpgenvm-c\build\tanda\GcHuecoPila\GcHuecoPila.mod | 1190 | 3304c6f0 | ok |
| /app/RefCaducadaBuiltin.mod | bpgenvm-c\build\tanda\RefCaducadaBuiltin\RefCaducadaBuiltin.mod | 1688 | 845498b8 | ok |
| /app/DivBordes.mod | bpgenvm-c\build\tanda\DivBordes\DivBordes.mod | 798 | 70f63a2f | ok |
| /app/ListaBorde.mod | bpgenvm-c\build\tanda\ListaBorde\ListaBorde.mod | 2918 | e6ddaaf1 | ok |
| /app/IndiceObjeto.mod | bpgenvm-c\build\tanda\IndiceObjeto\IndiceObjeto.mod | 12474 | 80c280cb | ok (por trozos) |
| /app/GenericosOrden.mod | bpgenvm-c\build\tanda\GenericosOrden\GenericosOrden.mod | 8456 | 52134d69 | ok (por trozos) |
| /app/SobrecargaEspecifica.mod | bpgenvm-c\build\tanda\SobrecargaEspecifica\SobrecargaEspecifica.mod | 1358 | 555c6ff1 | ok |
| /app/SobrecargaVisible.mod | bpgenvm-c\build\tanda\SobrecargaVisible\SobrecargaVisible.mod | 1999 | d3797df1 | ok |
| /app/BoolBits.mod | bpgenvm-c\build\tanda\BoolBits\BoolBits.mod | 876 | 7b87929a | ok |
| /app/ArrayNuevo.mod | bpgenvm-c\build\tanda\ArrayNuevo\ArrayNuevo.mod | 2393 | 2feee85e | ok |
| /app/BucleConNombre.mod | bpgenvm-c\build\tanda\BucleConNombre\BucleConNombre.mod | 1734 | 6c35f20c | ok |
| /app/ErroresConTipo.mod | bpgenvm-c\build\tanda\ErroresConTipo\ErroresConTipo.mod | 11493 | 7d9c7755 | ok (por trozos) |
| /app/IgualdadRefs.mod | bpgenvm-c\build\tanda\IgualdadRefs\IgualdadRefs.mod | 883 | 4a34e551 | ok |
| /app/VarParam.mod | bpgenvm-c\build\tanda\VarParam\VarParam.mod | 3481 | 1024398c | ok |
| /app/StrNulo.mod | bpgenvm-c\build\tanda\StrNulo\StrNulo.mod | 2784 | 4572ae05 | ok |
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
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Placa stm32u575 - 203436414230500D00350041

- sello: boardName=`stm32u575` uniqueId=`203436414230500D00350041` serverName=`bpvm-stm32` serverBuild=`Nov 26 2026 19:19:44` version=`8.5` imageCrc=`8a7b3cfd` capacidades=["META", "FILES", "TERMINAL", "PACKS"]
- imagen: la COMPILADA en el PC: bpgenvm-c/stm32/Nucleo_u575b/Nucleo_u575b/Debug/Nucleo_u575b.elf (26-11 19:19)
- imagen: arch=40 variant=None cpuFreqHz=160000000 resetReason=software uptimeMs=382668 fs=376832/516096 B vmHeapBytes=507904
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM5
- pantalla: no (INFO sin screenW/screenH: la imagen no lleva LVGL)
- inventario /lib+/app: 24 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 196 | 17 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 8 | 12 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 311 | 338 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 24 | 13 | EXITED OK exit=0 |
| GuiWinJson | **SALTADA** | - | 81 | necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL) |
| GuiShot | **SALTADA** | - | 389 | necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL) |
| BorraCarpetaFichero | **IDENTICO** | 143 | 18 | EXITED OK exit=0; host rc=0 |
| RutaFueraFlash | **DIFIERE** | 426 | 14 | texto distinto |
| FlashCarpetas | **IDENTICO** | 82 | 25 | EXITED OK exit=0; host rc=0 |
| GcHuecoPila | **IDENTICO** | 47 | 13 | EXITED OK exit=0; host rc=0 |
| RefCaducadaBuiltin | **IDENTICO** | 55 | 13 | EXITED OK exit=0; host rc=0 |
| DivBordes | **IDENTICO** | 65 | 11 | EXITED OK exit=0; host rc=0 |
| ListaBorde | **IDENTICO** | 239 | 21 | EXITED OK exit=0; host rc=0 |
| IndiceObjeto | **IDENTICO** | 281 | 25 | EXITED OK exit=0; host rc=0 |
| GenericosOrden | **IDENTICO** | 237 | 23 | EXITED OK exit=0; host rc=0 |
| SobrecargaEspecifica | **IDENTICO** | 59 | 10 | EXITED OK exit=0; host rc=0 |
| SobrecargaVisible | **IDENTICO** | 31 | 11 | EXITED OK exit=0; host rc=0 |
| BoolBits | **IDENTICO** | 88 | 12 | EXITED OK exit=0; host rc=0 |
| ArrayNuevo | **IDENTICO** | 100 | 37 | EXITED OK exit=0; host rc=0 |
| BucleConNombre | **IDENTICO** | 67 | 10 | EXITED OK exit=0; host rc=0 |
| ErroresConTipo | **DIFIERE** | 662 | 26 | texto distinto |
| IgualdadRefs | **IDENTICO** | 63 | 10 | EXITED OK exit=0; host rc=0 |
| VarParam | **IDENTICO** | 100 | 12 | EXITED OK exit=0; host rc=0 |
| StrNulo | **IDENTICO** | 114 | 10 | EXITED OK exit=0; host rc=0 |
| DatosGrandes | **IDENTICO** | 70 | 10 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 78 | 11 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 81 | 12 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 228 | 16 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=383840 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras ThrowSinAtrapar: uptimeMs=384505 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras ThreadTrasMain: uptimeMs=385501 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras MachineId: uptimeMs=386038 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras BorraCarpetaFichero: uptimeMs=386916 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras RutaFueraFlash: uptimeMs=388130 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
<details><summary>RutaFueraFlash: cola del stderr del host</summary>

```
throw: ATRAPADA por un catch del programa
[bpvm] throw: "appendFile('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "readFileBytes('/../x810'): no se pudo abrir"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "writeFileBytes('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] pila: el main llegó a 244 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>RutaFueraFlash: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -13,7 +13,7 @@
 rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
 copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
 fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
-lastModified -> IOError: lastModified('/../x810'): no se pudo leer
+lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
 File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
 File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
...
```

oraculo (host):

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no se pudo leer
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no se pudo leer
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```

placa:

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```
</details>

- tras FlashCarpetas: uptimeMs=388719 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras GcHuecoPila: uptimeMs=389376 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras RefCaducadaBuiltin: uptimeMs=390050 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras DivBordes: uptimeMs=390606 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras ListaBorde: uptimeMs=391865 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3216 tareaREPL=None heap del sistema, minimo libre=None
- tras IndiceObjeto: uptimeMs=394397 fsUsed=393216 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras GenericosOrden: uptimeMs=396584 fsUsed=393216 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras SobrecargaEspecifica: uptimeMs=397261 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras SobrecargaVisible: uptimeMs=397996 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras BoolBits: uptimeMs=398636 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras ArrayNuevo: uptimeMs=399466 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras BucleConNombre: uptimeMs=400167 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras ErroresConTipo: uptimeMs=402933 fsUsed=393216 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
<details><summary>ErroresConTipo: cola del stderr del host</summary>

```
its ALTOS: un bpref_t de 64b gu
[bpvm] UAF: idx=178  gen del handle=0  gen del slot=1  (slots en uso=180)
[bpvm]   gen 0 con el slot en 1: o una referencia CADUCADA al PRIMER objeto de ese slot (nace con gen 0: el programa lo libero y lo siguio usando), o un TRUNCAMIENTO (el handle perdio sus 32 bits ALTOS: un bpref_t de 64b gu
[bpvm] pila: el main llegó a 500 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] mutex: 1 creados, la tabla llegó a 1
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>ErroresConTipo: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -19,7 +19,7 @@
 ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
 ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
 ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
-ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
+ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
 ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
 ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
...
```

oraculo (host):

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```

placa:

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```
</details>

- tras IgualdadRefs: uptimeMs=403462 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras VarParam: uptimeMs=404367 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras StrNulo: uptimeMs=405164 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras DatosGrandes: uptimeMs=409035 fsUsed=417792 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras DatosAnchos: uptimeMs=416643 fsUsed=450560 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras HeapInfo: uptimeMs=417282 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- tras HeapCompact: uptimeMs=418381 fsUsed=385024 vmHeapBytes=507904 pila libre: run=-1 io=3248 tareaREPL=None heap del sistema, minimo libre=None
- ejecutadas (con EXITED) 26 de 28 listadas; no terminaron 0; saltadas 2; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/BorraCarpetaFichero.mod | bpgenvm-c\build\tanda\BorraCarpetaFichero\BorraCarpetaFichero.mod | 2271 | be28edf2 | ok |
| /app/RutaFueraFlash.mod | bpgenvm-c\build\tanda\RutaFueraFlash\RutaFueraFlash.mod | 3213 | 79cbf8d4 | ok |
| /app/FlashCarpetas.mod | bpgenvm-c\build\tanda\FlashCarpetas\FlashCarpetas.mod | 733 | c21b2696 | ok |
| /app/GcHuecoPila.mod | bpgenvm-c\build\tanda\GcHuecoPila\GcHuecoPila.mod | 1190 | 3304c6f0 | ok |
| /app/RefCaducadaBuiltin.mod | bpgenvm-c\build\tanda\RefCaducadaBuiltin\RefCaducadaBuiltin.mod | 1688 | 845498b8 | ok |
| /app/DivBordes.mod | bpgenvm-c\build\tanda\DivBordes\DivBordes.mod | 798 | 70f63a2f | ok |
| /app/ListaBorde.mod | bpgenvm-c\build\tanda\ListaBorde\ListaBorde.mod | 2918 | e6ddaaf1 | ok |
| /app/IndiceObjeto.mod | bpgenvm-c\build\tanda\IndiceObjeto\IndiceObjeto.mod | 12474 | 80c280cb | ok (por trozos) |
| /app/GenericosOrden.mod | bpgenvm-c\build\tanda\GenericosOrden\GenericosOrden.mod | 8456 | 52134d69 | ok (por trozos) |
| /app/SobrecargaEspecifica.mod | bpgenvm-c\build\tanda\SobrecargaEspecifica\SobrecargaEspecifica.mod | 1358 | 555c6ff1 | ok |
| /app/SobrecargaVisible.mod | bpgenvm-c\build\tanda\SobrecargaVisible\SobrecargaVisible.mod | 1999 | d3797df1 | ok |
| /app/BoolBits.mod | bpgenvm-c\build\tanda\BoolBits\BoolBits.mod | 876 | 7b87929a | ok |
| /app/ArrayNuevo.mod | bpgenvm-c\build\tanda\ArrayNuevo\ArrayNuevo.mod | 2393 | 2feee85e | ok |
| /app/BucleConNombre.mod | bpgenvm-c\build\tanda\BucleConNombre\BucleConNombre.mod | 1734 | 6c35f20c | ok |
| /app/ErroresConTipo.mod | bpgenvm-c\build\tanda\ErroresConTipo\ErroresConTipo.mod | 11493 | 7d9c7755 | ok (por trozos) |
| /app/IgualdadRefs.mod | bpgenvm-c\build\tanda\IgualdadRefs\IgualdadRefs.mod | 883 | 4a34e551 | ok |
| /app/VarParam.mod | bpgenvm-c\build\tanda\VarParam\VarParam.mod | 3481 | 1024398c | ok |
| /app/StrNulo.mod | bpgenvm-c\build\tanda\StrNulo\StrNulo.mod | 2784 | 4572ae05 | ok |
| /app/DatosGrandes.mod | bpgenvm-c\build\tanda\DatosGrandes\DatosGrandes.mod | 34291 | 822e223a | ok (por trozos) |
| /app/DatosAnchos.mod | bpgenvm-c\build\tanda\DatosAnchos\DatosAnchos.mod | 71917 | e70ef4fb | ok (por trozos) |
| /app/HeapInfo.mod | bpgenvm-c\build\tanda\HeapInfo\HeapInfo.mod | 1228 | 53946845 | ok |
| /app/HeapCompact.mod | bpgenvm-c\build\tanda\HeapCompact\HeapCompact.mod | 3560 | 3e213ca1 | ok |

notas de dependencias:

- dependencia Core: en la zona de packs (pack:Stdlib/Core.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Math: en la zona de packs (pack:Stdlib/Math.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Machine: en la zona de packs (pack:Stdlib/Machine.mod, crc igual): se ejecuta XIP, no se sube
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Collections: en la zona de packs (pack:Stdlib/Collections.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Str: en la zona de packs (pack:Stdlib/Str.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Matriz pruebas x placas

| prueba | esp32c3@COM3 | esp32c5@COM6 | stm32u575@COM5 |
|---|---|---|---|
| MathRango | IDENTICO | IDENTICO | IDENTICO |
| ThrowSinAtrapar | IDENTICO | IDENTICO | IDENTICO |
| ThreadTrasMain | IDENTICO | IDENTICO | IDENTICO |
| MachineId | NO-PETA | NO-PETA | NO-PETA |
| GuiWinJson | SALTADA | IDENTICO | SALTADA |
| GuiShot | SALTADA | NO-PETA | SALTADA |
| BorraCarpetaFichero | IDENTICO | IDENTICO | IDENTICO |
| RutaFueraFlash | DIFIERE | DIFIERE | DIFIERE |
| FlashCarpetas | IDENTICO | IDENTICO | IDENTICO |
| GcHuecoPila | IDENTICO | IDENTICO | IDENTICO |
| RefCaducadaBuiltin | IDENTICO | IDENTICO | IDENTICO |
| DivBordes | IDENTICO | IDENTICO | IDENTICO |
| ListaBorde | IDENTICO | IDENTICO | IDENTICO |
| IndiceObjeto | IDENTICO | IDENTICO | IDENTICO |
| GenericosOrden | IDENTICO | IDENTICO | IDENTICO |
| SobrecargaEspecifica | IDENTICO | IDENTICO | IDENTICO |
| SobrecargaVisible | IDENTICO | IDENTICO | IDENTICO |
| BoolBits | IDENTICO | IDENTICO | IDENTICO |
| ArrayNuevo | IDENTICO | IDENTICO | IDENTICO |
| BucleConNombre | IDENTICO | IDENTICO | IDENTICO |
| ErroresConTipo | DIFIERE | DIFIERE | DIFIERE |
| IgualdadRefs | IDENTICO | IDENTICO | IDENTICO |
| VarParam | IDENTICO | IDENTICO | IDENTICO |
| StrNulo | IDENTICO | IDENTICO | IDENTICO |
| DatosGrandes | IDENTICO | IDENTICO | IDENTICO |
| DatosAnchos | IDENTICO | IDENTICO | IDENTICO |
| HeapInfo | IDENTICO | IDENTICO | IDENTICO |
| HeapCompact | IDENTICO | IDENTICO | IDENTICO |

SALTADA: GuiWinJson en esp32c3@COM3: necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL)  
SALTADA: GuiShot en esp32c3@COM3: necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL)  
NECESITA OJOS: GuiShot en esp32c5@COM6: C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32c5_10BDA3FEFFDF\GuiShot.png  
SALTADA: GuiWinJson en stm32u575@COM5: necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL)  
SALTADA: GuiShot en stm32u575@COM5: necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL)  


## Tanda 2026-11-27 17:40:28

- manifiesto: `..\..\Users\Eduardo\AppData\Local\Temp\claude\2cbf9ff7f3759075\576fc834-e260-4649-ba6c-131c549812a9\scratchpad\lote85\lista_lote85.json` (28 pruebas listadas)
- oraculo: jar `toolchain\lexer-java\target\basicplus-frontend.jar` (2026-11-25 18:51:06) - exe `bpgenvm-c\build\bpgenvm-c.exe` (2026-11-27 17:01:29) - sabor `v2-gui1-lvgl0`
- placas conectadas: 1 (esp32s3@COM9)

### Oraculo por prueba (PC)

| prueba | modulo | crc .mod | tamano | compilacion | host rc | ms host | lineas salida |
|---|---|---|---|---|---|---|---|
| MathRango | MathRango | 2270c82e | 1611 | ok | 0 | 12 | 29 |
| ThrowSinAtrapar | ThrowSinAtrapar | 9b053410 | 295 | ok | 1 | 10 | 1 |
| ThreadTrasMain | ThreadTrasMain | 97dd1bb5 | 532 | ok | 0 | 332 | 3 |
| MachineId | MachineId | 42a7e155 | 452 | ok | 0 | 10 | 3 |
| GuiWinJson | GuiWinJson | ea106f91 | 2041 | ok | 0 | 61 | 17 |
| GuiShot | GuiShot | f794de7d | 1347 | ok | 0 | 380 | 8 |
| BorraCarpetaFichero | BorraCarpetaFichero | be28edf2 | 2271 | ok | 0 | 15 | 9 |
| RutaFueraFlash | RutaFueraFlash | 79cbf8d4 | 3213 | ok | 0 | 14 | 39 |
| FlashCarpetas | FlashCarpetas | c21b2696 | 733 | ok | 0 | 15 | 7 |
| GcHuecoPila | GcHuecoPila | 3304c6f0 | 1190 | ok | 0 | 13 | 3 |
| RefCaducadaBuiltin | RefCaducadaBuiltin | 845498b8 | 1688 | ok | 0 | 12 | 6 |
| DivBordes | DivBordes | 70f63a2f | 798 | ok | 0 | 12 | 10 |
| ListaBorde | ListaBorde | e6ddaaf1 | 2918 | ok | 0 | 21 | 26 |
| IndiceObjeto | IndiceObjeto | 80c280cb | 12474 | ok | 0 | 25 | 36 |
| GenericosOrden | GenericosOrden | 52134d69 | 8456 | ok | 0 | 23 | 30 |
| SobrecargaEspecifica | SobrecargaEspecifica | 555c6ff1 | 1358 | ok | 0 | 10 | 9 |
| SobrecargaVisible | SobrecargaVisible | d3797df1 | 1999 | ok | 0 | 11 | 4 |
| BoolBits | BoolBits | 7b87929a | 876 | ok | 0 | 12 | 15 |
| ArrayNuevo | ArrayNuevo | 2feee85e | 2393 | ok | 0 | 33 | 17 |
| BucleConNombre | BucleConNombre | 6c35f20c | 1734 | ok | 0 | 14 | 12 |
| ErroresConTipo | ErroresConTipo | 7d9c7755 | 11493 | ok | 0 | 29 | 48 |
| IgualdadRefs | IgualdadRefs | 4a34e551 | 883 | ok | 0 | 11 | 8 |
| VarParam | VarParam | 1024398c | 3481 | ok | 0 | 13 | 12 |
| StrNulo | StrNulo | 4572ae05 | 2784 | ok | 0 | 11 | 14 |
| DatosGrandes | DatosGrandes | 822e223a | 34291 | ok | 0 | 13 | 11 |
| DatosAnchos | DatosAnchos | e70ef4fb | 71917 | ok | 0 | 11 | 12 |
| HeapInfo | HeapInfo | 53946845 | 1228 | ok | 0 | 10 | 10 |
| HeapCompact | HeapCompact | 3e213ca1 | 3560 | ok | 0 | 18 | 17 |

### Placa esp32s3 - 98A316E6EE90

- sello: boardName=`esp32s3` uniqueId=`98A316E6EE90` serverName=`bpvm-esp32` serverBuild=`Nov 25 2026 16:18:39` version=`8.5` imageCrc=`c2ed0805` capacidades=["META", "FILES", "TERMINAL", "DEBUG", "PACKS"]
- imagen: la COMPILADA en el PC: bpgenvm-c/esp32/build/bpvm_esp32.bin (26-11 19:19)
- imagen: arch=94 variant=None cpuFreqHz=160000000 resetReason=power-on uptimeMs=754236 fs=204800/9199616 B vmHeapBytes=7844864
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM9
- pantalla: no (INFO sin screenW/screenH: la imagen no lleva LVGL)
- inventario /lib+/app: 26 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 194 | 12 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 10 | 10 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 319 | 332 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 18 | 10 | EXITED OK exit=0 |
| GuiWinJson | **SALTADA** | - | 61 | necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL) |
| GuiShot | **SALTADA** | - | 380 | necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL) |
| BorraCarpetaFichero | **IDENTICO** | 266 | 15 | EXITED OK exit=0; host rc=0 |
| RutaFueraFlash | **DIFIERE** | 416 | 14 | texto distinto |
| FlashCarpetas | **IDENTICO** | 146 | 15 | EXITED OK exit=0; host rc=0 |
| GcHuecoPila | **IDENTICO** | 90 | 13 | EXITED OK exit=0; host rc=0 |
| RefCaducadaBuiltin | **IDENTICO** | 51 | 12 | EXITED OK exit=0; host rc=0 |
| DivBordes | **IDENTICO** | 59 | 12 | EXITED OK exit=0; host rc=0 |
| ListaBorde | **IDENTICO** | 228 | 21 | EXITED OK exit=0; host rc=0 |
| IndiceObjeto | **IDENTICO** | 267 | 25 | EXITED OK exit=0; host rc=0 |
| GenericosOrden | **IDENTICO** | 226 | 23 | EXITED OK exit=0; host rc=0 |
| SobrecargaEspecifica | **IDENTICO** | 54 | 10 | EXITED OK exit=0; host rc=0 |
| SobrecargaVisible | **IDENTICO** | 26 | 11 | EXITED OK exit=0; host rc=0 |
| BoolBits | **IDENTICO** | 84 | 12 | EXITED OK exit=0; host rc=0 |
| ArrayNuevo | **IDENTICO** | 96 | 33 | EXITED OK exit=0; host rc=0 |
| BucleConNombre | **IDENTICO** | 64 | 14 | EXITED OK exit=0; host rc=0 |
| ErroresConTipo | **DIFIERE** | 656 | 29 | texto distinto |
| IgualdadRefs | **IDENTICO** | 60 | 11 | EXITED OK exit=0; host rc=0 |
| VarParam | **IDENTICO** | 94 | 13 | EXITED OK exit=0; host rc=0 |
| StrNulo | **IDENTICO** | 108 | 11 | EXITED OK exit=0; host rc=0 |
| DatosGrandes | **IDENTICO** | 67 | 13 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 73 | 11 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 76 | 10 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 530 | 18 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=755764 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=12556 io=9280 tareaREPL=9280 heap del sistema, minimo libre=52500
- tras ThrowSinAtrapar: uptimeMs=756360 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=12556 io=9280 tareaREPL=9280 heap del sistema, minimo libre=52500
- tras ThreadTrasMain: uptimeMs=757355 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=12556 io=9280 tareaREPL=9280 heap del sistema, minimo libre=52500
- tras MachineId: uptimeMs=758139 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=12556 io=9280 tareaREPL=9280 heap del sistema, minimo libre=52500
- tras BorraCarpetaFichero: uptimeMs=759607 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11404 io=9280 tareaREPL=9280 heap del sistema, minimo libre=52500
- tras RutaFueraFlash: uptimeMs=761210 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11404 io=9280 tareaREPL=9280 heap del sistema, minimo libre=52500
<details><summary>RutaFueraFlash: cola del stderr del host</summary>

```
throw: ATRAPADA por un catch del programa
[bpvm] throw: "appendFile('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "readFileBytes('/../x810'): no se pudo abrir"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "writeFileBytes('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] pila: el main llegó a 244 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>RutaFueraFlash: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -13,7 +13,7 @@
 rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
 copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
 fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
-lastModified -> IOError: lastModified('/../x810'): no se pudo leer
+lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
 File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
 File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
...
```

oraculo (host):

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no se pudo leer
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no se pudo leer
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```

placa:

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```
</details>

- tras FlashCarpetas: uptimeMs=762253 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11404 io=9280 tareaREPL=9280 heap del sistema, minimo libre=52500
- tras GcHuecoPila: uptimeMs=763393 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11404 io=9280 tareaREPL=9280 heap del sistema, minimo libre=52500
- tras RefCaducadaBuiltin: uptimeMs=764709 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11404 io=9280 tareaREPL=9280 heap del sistema, minimo libre=52500
- tras DivBordes: uptimeMs=765775 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11404 io=9280 tareaREPL=9280 heap del sistema, minimo libre=52500
- tras ListaBorde: uptimeMs=767753 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11404 io=9280 tareaREPL=9280 heap del sistema, minimo libre=52500
- tras IndiceObjeto: uptimeMs=771876 fsUsed=221184 vmHeapBytes=7844864 pila libre: run=11404 io=9280 tareaREPL=9280 heap del sistema, minimo libre=52228
- tras GenericosOrden: uptimeMs=775425 fsUsed=217088 vmHeapBytes=7844864 pila libre: run=11404 io=9264 tareaREPL=9264 heap del sistema, minimo libre=52228
- tras SobrecargaEspecifica: uptimeMs=776883 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11404 io=9264 tareaREPL=9264 heap del sistema, minimo libre=52228
- tras SobrecargaVisible: uptimeMs=778168 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11404 io=9264 tareaREPL=9264 heap del sistema, minimo libre=52228
- tras BoolBits: uptimeMs=779307 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11404 io=9264 tareaREPL=9264 heap del sistema, minimo libre=52228
- tras ArrayNuevo: uptimeMs=780555 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=12580 io=9264 tareaREPL=9264 heap del sistema, minimo libre=52228
- tras BucleConNombre: uptimeMs=781507 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11404 io=9264 tareaREPL=9264 heap del sistema, minimo libre=52228
- tras ErroresConTipo: uptimeMs=785498 fsUsed=217088 vmHeapBytes=7844864 pila libre: run=11276 io=9264 tareaREPL=9264 heap del sistema, minimo libre=51532
<details><summary>ErroresConTipo: cola del stderr del host</summary>

```
its ALTOS: un bpref_t de 64b gu
[bpvm] UAF: idx=178  gen del handle=0  gen del slot=1  (slots en uso=180)
[bpvm]   gen 0 con el slot en 1: o una referencia CADUCADA al PRIMER objeto de ese slot (nace con gen 0: el programa lo libero y lo siguio usando), o un TRUNCAMIENTO (el handle perdio sus 32 bits ALTOS: un bpref_t de 64b gu
[bpvm] pila: el main llegó a 500 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] mutex: 1 creados, la tabla llegó a 1
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>ErroresConTipo: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -19,7 +19,7 @@
 ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
 ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
 ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
-ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
+ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
 ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
 ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
...
```

oraculo (host):

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```

placa:

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```
</details>

- tras IgualdadRefs: uptimeMs=786195 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11276 io=9264 tareaREPL=9264 heap del sistema, minimo libre=51532
- tras VarParam: uptimeMs=787498 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11276 io=9264 tareaREPL=9264 heap del sistema, minimo libre=51532
- tras StrNulo: uptimeMs=788815 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11276 io=9264 tareaREPL=9264 heap del sistema, minimo libre=51532
- tras DatosGrandes: uptimeMs=793116 fsUsed=241664 vmHeapBytes=7844864 pila libre: run=11276 io=9264 tareaREPL=9264 heap del sistema, minimo libre=51532
- tras DatosAnchos: uptimeMs=801129 fsUsed=278528 vmHeapBytes=7844864 pila libre: run=11276 io=9264 tareaREPL=9264 heap del sistema, minimo libre=51532
- tras HeapInfo: uptimeMs=801988 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=11276 io=9264 tareaREPL=9264 heap del sistema, minimo libre=51532
- tras HeapCompact: uptimeMs=804059 fsUsed=208896 vmHeapBytes=7844864 pila libre: run=12212 io=9264 tareaREPL=9264 heap del sistema, minimo libre=51532
- ejecutadas (con EXITED) 26 de 28 listadas; no terminaron 0; saltadas 2; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/BorraCarpetaFichero.mod | bpgenvm-c\build\tanda\BorraCarpetaFichero\BorraCarpetaFichero.mod | 2271 | be28edf2 | ok |
| /app/RutaFueraFlash.mod | bpgenvm-c\build\tanda\RutaFueraFlash\RutaFueraFlash.mod | 3213 | 79cbf8d4 | ok |
| /app/FlashCarpetas.mod | bpgenvm-c\build\tanda\FlashCarpetas\FlashCarpetas.mod | 733 | c21b2696 | ok |
| /app/GcHuecoPila.mod | bpgenvm-c\build\tanda\GcHuecoPila\GcHuecoPila.mod | 1190 | 3304c6f0 | ok |
| /app/RefCaducadaBuiltin.mod | bpgenvm-c\build\tanda\RefCaducadaBuiltin\RefCaducadaBuiltin.mod | 1688 | 845498b8 | ok |
| /app/DivBordes.mod | bpgenvm-c\build\tanda\DivBordes\DivBordes.mod | 798 | 70f63a2f | ok |
| /app/ListaBorde.mod | bpgenvm-c\build\tanda\ListaBorde\ListaBorde.mod | 2918 | e6ddaaf1 | ok |
| /app/IndiceObjeto.mod | bpgenvm-c\build\tanda\IndiceObjeto\IndiceObjeto.mod | 12474 | 80c280cb | ok (por trozos) |
| /app/GenericosOrden.mod | bpgenvm-c\build\tanda\GenericosOrden\GenericosOrden.mod | 8456 | 52134d69 | ok (por trozos) |
| /app/SobrecargaEspecifica.mod | bpgenvm-c\build\tanda\SobrecargaEspecifica\SobrecargaEspecifica.mod | 1358 | 555c6ff1 | ok |
| /app/SobrecargaVisible.mod | bpgenvm-c\build\tanda\SobrecargaVisible\SobrecargaVisible.mod | 1999 | d3797df1 | ok |
| /app/BoolBits.mod | bpgenvm-c\build\tanda\BoolBits\BoolBits.mod | 876 | 7b87929a | ok |
| /app/ArrayNuevo.mod | bpgenvm-c\build\tanda\ArrayNuevo\ArrayNuevo.mod | 2393 | 2feee85e | ok |
| /app/BucleConNombre.mod | bpgenvm-c\build\tanda\BucleConNombre\BucleConNombre.mod | 1734 | 6c35f20c | ok |
| /app/ErroresConTipo.mod | bpgenvm-c\build\tanda\ErroresConTipo\ErroresConTipo.mod | 11493 | 7d9c7755 | ok (por trozos) |
| /app/IgualdadRefs.mod | bpgenvm-c\build\tanda\IgualdadRefs\IgualdadRefs.mod | 883 | 4a34e551 | ok |
| /app/VarParam.mod | bpgenvm-c\build\tanda\VarParam\VarParam.mod | 3481 | 1024398c | ok |
| /app/StrNulo.mod | bpgenvm-c\build\tanda\StrNulo\StrNulo.mod | 2784 | 4572ae05 | ok |
| /app/DatosGrandes.mod | bpgenvm-c\build\tanda\DatosGrandes\DatosGrandes.mod | 34291 | 822e223a | ok (por trozos) |
| /app/DatosAnchos.mod | bpgenvm-c\build\tanda\DatosAnchos\DatosAnchos.mod | 71917 | e70ef4fb | ok (por trozos) |
| /app/HeapInfo.mod | bpgenvm-c\build\tanda\HeapInfo\HeapInfo.mod | 1228 | 53946845 | ok |
| /app/HeapCompact.mod | bpgenvm-c\build\tanda\HeapCompact\HeapCompact.mod | 3560 | 3e213ca1 | ok |

notas de dependencias:

- dependencia Core: en la zona de packs (pack:Stdlib/Core.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Math: en la zona de packs (pack:Stdlib/Math.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Machine: en la zona de packs (pack:Stdlib/Machine.mod, crc igual): se ejecuta XIP, no se sube
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Collections: en la zona de packs (pack:Stdlib/Collections.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Str: en la zona de packs (pack:Stdlib/Str.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Matriz pruebas x placas

| prueba | esp32s3@COM9 |
|---|---|
| MathRango | IDENTICO |
| ThrowSinAtrapar | IDENTICO |
| ThreadTrasMain | IDENTICO |
| MachineId | NO-PETA |
| GuiWinJson | SALTADA |
| GuiShot | SALTADA |
| BorraCarpetaFichero | IDENTICO |
| RutaFueraFlash | DIFIERE |
| FlashCarpetas | IDENTICO |
| GcHuecoPila | IDENTICO |
| RefCaducadaBuiltin | IDENTICO |
| DivBordes | IDENTICO |
| ListaBorde | IDENTICO |
| IndiceObjeto | IDENTICO |
| GenericosOrden | IDENTICO |
| SobrecargaEspecifica | IDENTICO |
| SobrecargaVisible | IDENTICO |
| BoolBits | IDENTICO |
| ArrayNuevo | IDENTICO |
| BucleConNombre | IDENTICO |
| ErroresConTipo | DIFIERE |
| IgualdadRefs | IDENTICO |
| VarParam | IDENTICO |
| StrNulo | IDENTICO |
| DatosGrandes | IDENTICO |
| DatosAnchos | IDENTICO |
| HeapInfo | IDENTICO |
| HeapCompact | IDENTICO |

SALTADA: GuiWinJson en esp32s3@COM9: necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL)  
SALTADA: GuiShot en esp32s3@COM9: necesita pantalla y la placa no la tiene (INFO sin screenW/screenH: la imagen no lleva LVGL)  


## Tanda 2026-11-27 18:01:40

- manifiesto: `..\..\Users\Eduardo\AppData\Local\Temp\claude\2cbf9ff7f3759075\576fc834-e260-4649-ba6c-131c549812a9\scratchpad\lote85\lista_lote85.json` (28 pruebas listadas)
- oraculo: jar `toolchain\lexer-java\target\basicplus-frontend.jar` (2026-11-25 18:51:06) - exe `bpgenvm-c\build\bpgenvm-c.exe` (2026-11-27 17:01:29) - sabor `v2-gui1-lvgl0`
- placas conectadas: 2 (esp32p4@COM14, esp32p4@COM15)

### Oraculo por prueba (PC)

| prueba | modulo | crc .mod | tamano | compilacion | host rc | ms host | lineas salida |
|---|---|---|---|---|---|---|---|
| MathRango | MathRango | 2270c82e | 1611 | ok | 0 | 14 | 29 |
| ThrowSinAtrapar | ThrowSinAtrapar | 9b053410 | 295 | ok | 1 | 13 | 1 |
| ThreadTrasMain | ThreadTrasMain | 97dd1bb5 | 532 | ok | 0 | 322 | 3 |
| MachineId | MachineId | 42a7e155 | 452 | ok | 0 | 11 | 3 |
| GuiWinJson | GuiWinJson | ea106f91 | 2041 | ok | 0 | 65 | 17 |
| GuiShot | GuiShot | f794de7d | 1347 | ok | 0 | 402 | 8 |
| BorraCarpetaFichero | BorraCarpetaFichero | be28edf2 | 2271 | ok | 0 | 23 | 9 |
| RutaFueraFlash | RutaFueraFlash | 79cbf8d4 | 3213 | ok | 0 | 20 | 39 |
| FlashCarpetas | FlashCarpetas | c21b2696 | 733 | ok | 0 | 16 | 7 |
| GcHuecoPila | GcHuecoPila | 3304c6f0 | 1190 | ok | 0 | 16 | 3 |
| RefCaducadaBuiltin | RefCaducadaBuiltin | 845498b8 | 1688 | ok | 0 | 11 | 6 |
| DivBordes | DivBordes | 70f63a2f | 798 | ok | 0 | 9 | 10 |
| ListaBorde | ListaBorde | e6ddaaf1 | 2918 | ok | 0 | 18 | 26 |
| IndiceObjeto | IndiceObjeto | 80c280cb | 12474 | ok | 0 | 27 | 36 |
| GenericosOrden | GenericosOrden | 52134d69 | 8456 | ok | 0 | 23 | 30 |
| SobrecargaEspecifica | SobrecargaEspecifica | 555c6ff1 | 1358 | ok | 0 | 11 | 9 |
| SobrecargaVisible | SobrecargaVisible | d3797df1 | 1999 | ok | 0 | 14 | 4 |
| BoolBits | BoolBits | 7b87929a | 876 | ok | 0 | 11 | 15 |
| ArrayNuevo | ArrayNuevo | 2feee85e | 2393 | ok | 0 | 14 | 17 |
| BucleConNombre | BucleConNombre | 6c35f20c | 1734 | ok | 0 | 10 | 12 |
| ErroresConTipo | ErroresConTipo | 7d9c7755 | 11493 | ok | 0 | 26 | 48 |
| IgualdadRefs | IgualdadRefs | 4a34e551 | 883 | ok | 0 | 13 | 8 |
| VarParam | VarParam | 1024398c | 3481 | ok | 0 | 17 | 12 |
| StrNulo | StrNulo | 4572ae05 | 2784 | ok | 0 | 14 | 14 |
| DatosGrandes | DatosGrandes | 822e223a | 34291 | ok | 0 | 16 | 11 |
| DatosAnchos | DatosAnchos | e70ef4fb | 71917 | ok | 0 | 13 | 12 |
| HeapInfo | HeapInfo | 53946845 | 1228 | ok | 0 | 11 | 10 |
| HeapCompact | HeapCompact | 3e213ca1 | 3560 | ok | 0 | 16 | 17 |

### Placa esp32p4 - 6055F9FB058D

- sello: boardName=`esp32p4` uniqueId=`6055F9FB058D` serverName=`bpvm-esp32p4` serverBuild=`Nov 26 2026 19:01:19` version=`8.5` imageCrc=`883a93a9` capacidades=["META", "FILES", "TERMINAL", "DEBUG", "PACKS"]
- imagen: la COMPILADA en el PC: bpgenvm-c/esp32p4/build/bpvm_esp32p4.bin (26-11 19:21)
- imagen: arch=243 variant=None cpuFreqHz=360000000 resetReason=software uptimeMs=224065 fs=172032/7168000 B vmHeapBytes=25145344
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM14
- pantalla: si (INFO screenW x screenH = 1024x600)
- inventario /lib+/app: 17 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 192 | 14 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 9 | 13 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 312 | 322 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 20 | 11 | EXITED OK exit=0 |
| GuiWinJson | **IDENTICO** | 760 | 66 | EXITED OK exit=0; host rc=0 |
| GuiShot | **NO-PETA** | 729 | 395 | EXITED OK exit=0 |
| BorraCarpetaFichero | **IDENTICO** | 333 | 23 | EXITED OK exit=0; host rc=0 |
| RutaFueraFlash | **DIFIERE** | 414 | 20 | texto distinto |
| FlashCarpetas | **IDENTICO** | 195 | 16 | EXITED OK exit=0; host rc=0 |
| GcHuecoPila | **IDENTICO** | 175 | 16 | EXITED OK exit=0; host rc=0 |
| RefCaducadaBuiltin | **IDENTICO** | 54 | 11 | EXITED OK exit=0; host rc=0 |
| DivBordes | **IDENTICO** | 62 | 9 | EXITED OK exit=0; host rc=0 |
| ListaBorde | **IDENTICO** | 224 | 18 | EXITED OK exit=0; host rc=0 |
| IndiceObjeto | **IDENTICO** | 253 | 27 | EXITED OK exit=0; host rc=0 |
| GenericosOrden | **IDENTICO** | 215 | 23 | EXITED OK exit=0; host rc=0 |
| SobrecargaEspecifica | **IDENTICO** | 55 | 11 | EXITED OK exit=0; host rc=0 |
| SobrecargaVisible | **IDENTICO** | 27 | 14 | EXITED OK exit=0; host rc=0 |
| BoolBits | **IDENTICO** | 85 | 11 | EXITED OK exit=0; host rc=0 |
| ArrayNuevo | **IDENTICO** | 96 | 14 | EXITED OK exit=0; host rc=0 |
| BucleConNombre | **IDENTICO** | 65 | 10 | EXITED OK exit=0; host rc=0 |
| ErroresConTipo | **DIFIERE** | 637 | 26 | texto distinto |
| IgualdadRefs | **IDENTICO** | 60 | 13 | EXITED OK exit=0; host rc=0 |
| VarParam | **IDENTICO** | 97 | 17 | EXITED OK exit=0; host rc=0 |
| StrNulo | **IDENTICO** | 111 | 14 | EXITED OK exit=0; host rc=0 |
| DatosGrandes | **IDENTICO** | 66 | 16 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 75 | 13 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 76 | 11 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 234 | 16 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=225757 fsUsed=176128 vmHeapBytes=25145344 pila libre: run=13552 io=25748 tareaREPL=25748 heap del sistema, minimo libre=225348
- tras ThrowSinAtrapar: uptimeMs=226462 fsUsed=176128 vmHeapBytes=25145344 pila libre: run=14044 io=25748 tareaREPL=25748 heap del sistema, minimo libre=225348
- tras ThreadTrasMain: uptimeMs=227561 fsUsed=176128 vmHeapBytes=25145344 pila libre: run=14044 io=25748 tareaREPL=25748 heap del sistema, minimo libre=225212
- tras MachineId: uptimeMs=228558 fsUsed=176128 vmHeapBytes=25145344 pila libre: run=13472 io=25748 tareaREPL=25748 heap del sistema, minimo libre=225036
- tras GuiWinJson: uptimeMs=231944 fsUsed=180224 vmHeapBytes=25145344 pila libre: run=12496 io=25528 tareaREPL=25528 heap del sistema, minimo libre=216868
- tras GuiShot: uptimeMs=234857 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- artefacto GuiShot.shot de GuiShot: bajado a `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32p4_6055F9FB058D\GuiShot.shot` (12280 B, crc b46c8ec2) -> PNG `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32p4_6055F9FB058D\GuiShot.png`; antes del RUN: no existia
- tras BorraCarpetaFichero: uptimeMs=237786 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11736 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras RutaFueraFlash: uptimeMs=239300 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
<details><summary>RutaFueraFlash: cola del stderr del host</summary>

```
throw: ATRAPADA por un catch del programa
[bpvm] throw: "appendFile('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "readFileBytes('/../x810'): no se pudo abrir"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "writeFileBytes('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] pila: el main llegó a 244 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>RutaFueraFlash: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -13,7 +13,7 @@
 rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
 copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
 fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
-lastModified -> IOError: lastModified('/../x810'): no se pudo leer
+lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
 File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
 File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
...
```

oraculo (host):

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no se pudo leer
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no se pudo leer
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```

placa:

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```
</details>

- tras FlashCarpetas: uptimeMs=240485 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11736 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras GcHuecoPila: uptimeMs=241633 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras RefCaducadaBuiltin: uptimeMs=242748 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11736 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras DivBordes: uptimeMs=243655 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras ListaBorde: uptimeMs=245057 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras IndiceObjeto: uptimeMs=248605 fsUsed=204800 vmHeapBytes=25145344 pila libre: run=11736 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras GenericosOrden: uptimeMs=251319 fsUsed=200704 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras SobrecargaEspecifica: uptimeMs=252387 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11736 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras SobrecargaVisible: uptimeMs=253259 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras BoolBits: uptimeMs=254045 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras ArrayNuevo: uptimeMs=255315 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11224 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras BucleConNombre: uptimeMs=256149 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11224 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras ErroresConTipo: uptimeMs=259518 fsUsed=200704 vmHeapBytes=25145344 pila libre: run=11736 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
<details><summary>ErroresConTipo: cola del stderr del host</summary>

```
its ALTOS: un bpref_t de 64b gu
[bpvm] UAF: idx=178  gen del handle=0  gen del slot=1  (slots en uso=180)
[bpvm]   gen 0 con el slot en 1: o una referencia CADUCADA al PRIMER objeto de ese slot (nace con gen 0: el programa lo libero y lo siguio usando), o un TRUNCAMIENTO (el handle perdio sus 32 bits ALTOS: un bpref_t de 64b gu
[bpvm] pila: el main llegó a 500 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] mutex: 1 creados, la tabla llegó a 1
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>ErroresConTipo: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -19,7 +19,7 @@
 ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
 ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
 ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
-ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
+ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
 ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
 ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
...
```

oraculo (host):

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```

placa:

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```
</details>

- tras IgualdadRefs: uptimeMs=260295 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11224 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras VarParam: uptimeMs=261985 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11736 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras StrNulo: uptimeMs=263210 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11224 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras DatosGrandes: uptimeMs=267924 fsUsed=225280 vmHeapBytes=25145344 pila libre: run=11224 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras DatosAnchos: uptimeMs=276105 fsUsed=262144 vmHeapBytes=25145344 pila libre: run=11224 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras HeapInfo: uptimeMs=277261 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11224 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- tras HeapCompact: uptimeMs=278990 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11604 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215892
- ejecutadas (con EXITED) 28 de 28 listadas; no terminaron 0; saltadas 0; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/main.win | samples\formdemo\resources\main.win | 390 | 548edd67 | ok |
| /app/GuiWinJson.mod | bpgenvm-c\build\tanda\GuiWinJson\GuiWinJson.mod | 2041 | ea106f91 | ok |
| /app/GuiShot.mod | bpgenvm-c\build\tanda\GuiShot\GuiShot.mod | 1347 | f794de7d | ok |
| /app/BorraCarpetaFichero.mod | bpgenvm-c\build\tanda\BorraCarpetaFichero\BorraCarpetaFichero.mod | 2271 | be28edf2 | ok |
| /app/RutaFueraFlash.mod | bpgenvm-c\build\tanda\RutaFueraFlash\RutaFueraFlash.mod | 3213 | 79cbf8d4 | ok |
| /app/FlashCarpetas.mod | bpgenvm-c\build\tanda\FlashCarpetas\FlashCarpetas.mod | 733 | c21b2696 | ok |
| /app/GcHuecoPila.mod | bpgenvm-c\build\tanda\GcHuecoPila\GcHuecoPila.mod | 1190 | 3304c6f0 | ok |
| /app/RefCaducadaBuiltin.mod | bpgenvm-c\build\tanda\RefCaducadaBuiltin\RefCaducadaBuiltin.mod | 1688 | 845498b8 | ok |
| /app/DivBordes.mod | bpgenvm-c\build\tanda\DivBordes\DivBordes.mod | 798 | 70f63a2f | ok |
| /app/ListaBorde.mod | bpgenvm-c\build\tanda\ListaBorde\ListaBorde.mod | 2918 | e6ddaaf1 | ok |
| /app/IndiceObjeto.mod | bpgenvm-c\build\tanda\IndiceObjeto\IndiceObjeto.mod | 12474 | 80c280cb | ok (por trozos) |
| /app/GenericosOrden.mod | bpgenvm-c\build\tanda\GenericosOrden\GenericosOrden.mod | 8456 | 52134d69 | ok (por trozos) |
| /app/SobrecargaEspecifica.mod | bpgenvm-c\build\tanda\SobrecargaEspecifica\SobrecargaEspecifica.mod | 1358 | 555c6ff1 | ok |
| /app/SobrecargaVisible.mod | bpgenvm-c\build\tanda\SobrecargaVisible\SobrecargaVisible.mod | 1999 | d3797df1 | ok |
| /app/BoolBits.mod | bpgenvm-c\build\tanda\BoolBits\BoolBits.mod | 876 | 7b87929a | ok |
| /app/ArrayNuevo.mod | bpgenvm-c\build\tanda\ArrayNuevo\ArrayNuevo.mod | 2393 | 2feee85e | ok |
| /app/BucleConNombre.mod | bpgenvm-c\build\tanda\BucleConNombre\BucleConNombre.mod | 1734 | 6c35f20c | ok |
| /app/ErroresConTipo.mod | bpgenvm-c\build\tanda\ErroresConTipo\ErroresConTipo.mod | 11493 | 7d9c7755 | ok (por trozos) |
| /app/IgualdadRefs.mod | bpgenvm-c\build\tanda\IgualdadRefs\IgualdadRefs.mod | 883 | 4a34e551 | ok |
| /app/VarParam.mod | bpgenvm-c\build\tanda\VarParam\VarParam.mod | 3481 | 1024398c | ok |
| /app/StrNulo.mod | bpgenvm-c\build\tanda\StrNulo\StrNulo.mod | 2784 | 4572ae05 | ok |
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
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Placa esp32p4 - E8F60AE0B380

- sello: boardName=`esp32p4` uniqueId=`E8F60AE0B380` serverName=`bpvm-esp32p4` serverBuild=`Nov 26 2026 19:01:19` version=`8.5` imageCrc=`883a93a9` capacidades=["META", "FILES", "TERMINAL", "DEBUG", "PACKS"]
- imagen: la COMPILADA en el PC: bpgenvm-c/esp32p4/build/bpvm_esp32p4.bin (26-11 19:21)
- imagen: arch=243 variant=None cpuFreqHz=360000000 resetReason=software uptimeMs=630681 fs=98304/16777216 B vmHeapBytes=25145344
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM15
- pantalla: si (INFO screenW x screenH = 480x800)
- inventario /lib+/app: 3 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 191 | 14 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 10 | 13 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 313 | 322 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 19 | 11 | EXITED OK exit=0 |
| GuiWinJson | **IDENTICO** | 739 | 59 | EXITED OK exit=0; host rc=0 |
| GuiShot | **NO-PETA** | 716 | 385 | EXITED OK exit=0 |
| BorraCarpetaFichero | **IDENTICO** | 174 | 23 | EXITED OK exit=0; host rc=0 |
| RutaFueraFlash | **DIFIERE** | 419 | 20 | texto distinto |
| FlashCarpetas | **IDENTICO** | 129 | 16 | EXITED OK exit=0; host rc=0 |
| GcHuecoPila | **IDENTICO** | 79 | 16 | EXITED OK exit=0; host rc=0 |
| RefCaducadaBuiltin | **IDENTICO** | 53 | 11 | EXITED OK exit=0; host rc=0 |
| DivBordes | **IDENTICO** | 62 | 9 | EXITED OK exit=0; host rc=0 |
| ListaBorde | **IDENTICO** | 225 | 18 | EXITED OK exit=0; host rc=0 |
| IndiceObjeto | **IDENTICO** | 255 | 27 | EXITED OK exit=0; host rc=0 |
| GenericosOrden | **IDENTICO** | 215 | 23 | EXITED OK exit=0; host rc=0 |
| SobrecargaEspecifica | **IDENTICO** | 54 | 11 | EXITED OK exit=0; host rc=0 |
| SobrecargaVisible | **IDENTICO** | 27 | 14 | EXITED OK exit=0; host rc=0 |
| BoolBits | **IDENTICO** | 85 | 11 | EXITED OK exit=0; host rc=0 |
| ArrayNuevo | **IDENTICO** | 96 | 14 | EXITED OK exit=0; host rc=0 |
| BucleConNombre | **IDENTICO** | 65 | 10 | EXITED OK exit=0; host rc=0 |
| ErroresConTipo | **DIFIERE** | 637 | 26 | texto distinto |
| IgualdadRefs | **IDENTICO** | 60 | 13 | EXITED OK exit=0; host rc=0 |
| VarParam | **IDENTICO** | 97 | 17 | EXITED OK exit=0; host rc=0 |
| StrNulo | **IDENTICO** | 111 | 14 | EXITED OK exit=0; host rc=0 |
| DatosGrandes | **IDENTICO** | 66 | 16 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 75 | 13 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 75 | 11 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 232 | 16 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=632007 fsUsed=102400 vmHeapBytes=25145344 pila libre: run=13552 io=25748 tareaREPL=25748 heap del sistema, minimo libre=225396
- tras ThrowSinAtrapar: uptimeMs=632672 fsUsed=102400 vmHeapBytes=25145344 pila libre: run=13552 io=25748 tareaREPL=25748 heap del sistema, minimo libre=225396
- tras ThreadTrasMain: uptimeMs=633731 fsUsed=102400 vmHeapBytes=25145344 pila libre: run=13476 io=25748 tareaREPL=25748 heap del sistema, minimo libre=225260
- tras MachineId: uptimeMs=634582 fsUsed=102400 vmHeapBytes=25145344 pila libre: run=13552 io=25748 tareaREPL=25748 heap del sistema, minimo libre=225084
- tras GuiWinJson: uptimeMs=638020 fsUsed=106496 vmHeapBytes=25145344 pila libre: run=12512 io=25528 tareaREPL=25528 heap del sistema, minimo libre=216908
- tras GuiShot: uptimeMs=640856 fsUsed=114688 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- artefacto GuiShot.shot de GuiShot: bajado a `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32p4_E8F60AE0B380\GuiShot.shot` (8243 B, crc cde419d3) -> PNG `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32p4_E8F60AE0B380\GuiShot.png`; antes del RUN: no existia
- tras BorraCarpetaFichero: uptimeMs=642930 fsUsed=114688 vmHeapBytes=25145344 pila libre: run=11740 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras RutaFueraFlash: uptimeMs=644466 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
<details><summary>RutaFueraFlash: cola del stderr del host</summary>

```
throw: ATRAPADA por un catch del programa
[bpvm] throw: "appendFile('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "readFileBytes('/../x810'): no se pudo abrir"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "writeFileBytes('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] pila: el main llegó a 244 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>RutaFueraFlash: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -13,7 +13,7 @@
 rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
 copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
 fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
-lastModified -> IOError: lastModified('/../x810'): no se pudo leer
+lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
 File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
 File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
...
```

oraculo (host):

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no se pudo leer
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no se pudo leer
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```

placa:

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```
</details>

- tras FlashCarpetas: uptimeMs=645219 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11740 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras GcHuecoPila: uptimeMs=645952 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras RefCaducadaBuiltin: uptimeMs=647085 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11740 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras DivBordes: uptimeMs=647831 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras ListaBorde: uptimeMs=649449 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras IndiceObjeto: uptimeMs=652938 fsUsed=135168 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras GenericosOrden: uptimeMs=655508 fsUsed=131072 vmHeapBytes=25145344 pila libre: run=11740 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras SobrecargaEspecifica: uptimeMs=656597 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras SobrecargaVisible: uptimeMs=657779 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11740 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras BoolBits: uptimeMs=658809 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11356 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras ArrayNuevo: uptimeMs=660096 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11224 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras BucleConNombre: uptimeMs=660963 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11224 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras ErroresConTipo: uptimeMs=664149 fsUsed=131072 vmHeapBytes=25145344 pila libre: run=11740 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
<details><summary>ErroresConTipo: cola del stderr del host</summary>

```
its ALTOS: un bpref_t de 64b gu
[bpvm] UAF: idx=178  gen del handle=0  gen del slot=1  (slots en uso=180)
[bpvm]   gen 0 con el slot en 1: o una referencia CADUCADA al PRIMER objeto de ese slot (nace con gen 0: el programa lo libero y lo siguio usando), o un TRUNCAMIENTO (el handle perdio sus 32 bits ALTOS: un bpref_t de 64b gu
[bpvm] pila: el main llegó a 500 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] mutex: 1 creados, la tabla llegó a 1
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>ErroresConTipo: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -19,7 +19,7 @@
 ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
 ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
 ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
-ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
+ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
 ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
 ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
...
```

oraculo (host):

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```

placa:

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```
</details>

- tras IgualdadRefs: uptimeMs=664785 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11224 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras VarParam: uptimeMs=666171 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11740 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras StrNulo: uptimeMs=667390 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11740 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras DatosGrandes: uptimeMs=671363 fsUsed=155648 vmHeapBytes=25145344 pila libre: run=11740 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras DatosAnchos: uptimeMs=679126 fsUsed=192512 vmHeapBytes=25145344 pila libre: run=11740 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras HeapInfo: uptimeMs=679881 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11740 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- tras HeapCompact: uptimeMs=681220 fsUsed=122880 vmHeapBytes=25145344 pila libre: run=11740 io=25528 tareaREPL=25528 heap del sistema, minimo libre=215932
- ejecutadas (con EXITED) 28 de 28 listadas; no terminaron 0; saltadas 0; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/main.win | samples\formdemo\resources\main.win | 390 | 548edd67 | ok |
| /app/GuiWinJson.mod | bpgenvm-c\build\tanda\GuiWinJson\GuiWinJson.mod | 2041 | ea106f91 | ok |
| /app/GuiShot.mod | bpgenvm-c\build\tanda\GuiShot\GuiShot.mod | 1347 | f794de7d | ok |
| /app/BorraCarpetaFichero.mod | bpgenvm-c\build\tanda\BorraCarpetaFichero\BorraCarpetaFichero.mod | 2271 | be28edf2 | ok |
| /app/RutaFueraFlash.mod | bpgenvm-c\build\tanda\RutaFueraFlash\RutaFueraFlash.mod | 3213 | 79cbf8d4 | ok |
| /app/FlashCarpetas.mod | bpgenvm-c\build\tanda\FlashCarpetas\FlashCarpetas.mod | 733 | c21b2696 | ok |
| /app/GcHuecoPila.mod | bpgenvm-c\build\tanda\GcHuecoPila\GcHuecoPila.mod | 1190 | 3304c6f0 | ok |
| /app/RefCaducadaBuiltin.mod | bpgenvm-c\build\tanda\RefCaducadaBuiltin\RefCaducadaBuiltin.mod | 1688 | 845498b8 | ok |
| /app/DivBordes.mod | bpgenvm-c\build\tanda\DivBordes\DivBordes.mod | 798 | 70f63a2f | ok |
| /app/ListaBorde.mod | bpgenvm-c\build\tanda\ListaBorde\ListaBorde.mod | 2918 | e6ddaaf1 | ok |
| /app/IndiceObjeto.mod | bpgenvm-c\build\tanda\IndiceObjeto\IndiceObjeto.mod | 12474 | 80c280cb | ok (por trozos) |
| /app/GenericosOrden.mod | bpgenvm-c\build\tanda\GenericosOrden\GenericosOrden.mod | 8456 | 52134d69 | ok (por trozos) |
| /app/SobrecargaEspecifica.mod | bpgenvm-c\build\tanda\SobrecargaEspecifica\SobrecargaEspecifica.mod | 1358 | 555c6ff1 | ok |
| /app/SobrecargaVisible.mod | bpgenvm-c\build\tanda\SobrecargaVisible\SobrecargaVisible.mod | 1999 | d3797df1 | ok |
| /app/BoolBits.mod | bpgenvm-c\build\tanda\BoolBits\BoolBits.mod | 876 | 7b87929a | ok |
| /app/ArrayNuevo.mod | bpgenvm-c\build\tanda\ArrayNuevo\ArrayNuevo.mod | 2393 | 2feee85e | ok |
| /app/BucleConNombre.mod | bpgenvm-c\build\tanda\BucleConNombre\BucleConNombre.mod | 1734 | 6c35f20c | ok |
| /app/ErroresConTipo.mod | bpgenvm-c\build\tanda\ErroresConTipo\ErroresConTipo.mod | 11493 | 7d9c7755 | ok (por trozos) |
| /app/IgualdadRefs.mod | bpgenvm-c\build\tanda\IgualdadRefs\IgualdadRefs.mod | 883 | 4a34e551 | ok |
| /app/VarParam.mod | bpgenvm-c\build\tanda\VarParam\VarParam.mod | 3481 | 1024398c | ok |
| /app/StrNulo.mod | bpgenvm-c\build\tanda\StrNulo\StrNulo.mod | 2784 | 4572ae05 | ok |
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
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Matriz pruebas x placas

| prueba | esp32p4@COM14 | esp32p4@COM15 |
|---|---|---|
| MathRango | IDENTICO | IDENTICO |
| ThrowSinAtrapar | IDENTICO | IDENTICO |
| ThreadTrasMain | IDENTICO | IDENTICO |
| MachineId | NO-PETA | NO-PETA |
| GuiWinJson | IDENTICO | IDENTICO |
| GuiShot | NO-PETA | NO-PETA |
| BorraCarpetaFichero | IDENTICO | IDENTICO |
| RutaFueraFlash | DIFIERE | DIFIERE |
| FlashCarpetas | IDENTICO | IDENTICO |
| GcHuecoPila | IDENTICO | IDENTICO |
| RefCaducadaBuiltin | IDENTICO | IDENTICO |
| DivBordes | IDENTICO | IDENTICO |
| ListaBorde | IDENTICO | IDENTICO |
| IndiceObjeto | IDENTICO | IDENTICO |
| GenericosOrden | IDENTICO | IDENTICO |
| SobrecargaEspecifica | IDENTICO | IDENTICO |
| SobrecargaVisible | IDENTICO | IDENTICO |
| BoolBits | IDENTICO | IDENTICO |
| ArrayNuevo | IDENTICO | IDENTICO |
| BucleConNombre | IDENTICO | IDENTICO |
| ErroresConTipo | DIFIERE | DIFIERE |
| IgualdadRefs | IDENTICO | IDENTICO |
| VarParam | IDENTICO | IDENTICO |
| StrNulo | IDENTICO | IDENTICO |
| DatosGrandes | IDENTICO | IDENTICO |
| DatosAnchos | IDENTICO | IDENTICO |
| HeapInfo | IDENTICO | IDENTICO |
| HeapCompact | IDENTICO | IDENTICO |

NECESITA OJOS: GuiShot en esp32p4@COM14: C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32p4_6055F9FB058D\GuiShot.png  
NECESITA OJOS: GuiShot en esp32p4@COM15: C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32p4_E8F60AE0B380\GuiShot.png  


## Tanda 2026-11-27 18:03:56

- manifiesto: `..\..\Users\Eduardo\AppData\Local\Temp\claude\2cbf9ff7f3759075\576fc834-e260-4649-ba6c-131c549812a9\scratchpad\lote85\lista_lote85.json` (28 pruebas listadas)
- oraculo: jar `toolchain\lexer-java\target\basicplus-frontend.jar` (2026-11-25 18:51:06) - exe `bpgenvm-c\build\bpgenvm-c.exe` (2026-11-27 17:01:29) - sabor `v2-gui1-lvgl0`
- placas conectadas: 1 (esp32p4@COM17)

### Oraculo por prueba (PC)

| prueba | modulo | crc .mod | tamano | compilacion | host rc | ms host | lineas salida |
|---|---|---|---|---|---|---|---|
| MathRango | MathRango | 2270c82e | 1611 | ok | 0 | 10 | 29 |
| ThrowSinAtrapar | ThrowSinAtrapar | 9b053410 | 295 | ok | 1 | 11 | 1 |
| ThreadTrasMain | ThreadTrasMain | 97dd1bb5 | 532 | ok | 0 | 336 | 3 |
| MachineId | MachineId | 42a7e155 | 452 | ok | 0 | 10 | 3 |
| GuiWinJson | GuiWinJson | ea106f91 | 2041 | ok | 0 | 86 | 17 |
| GuiShot | GuiShot | f794de7d | 1347 | ok | 0 | 383 | 8 |
| BorraCarpetaFichero | BorraCarpetaFichero | be28edf2 | 2271 | ok | 0 | 14 | 9 |
| RutaFueraFlash | RutaFueraFlash | 79cbf8d4 | 3213 | ok | 0 | 14 | 39 |
| FlashCarpetas | FlashCarpetas | c21b2696 | 733 | ok | 0 | 27 | 7 |
| GcHuecoPila | GcHuecoPila | 3304c6f0 | 1190 | ok | 0 | 14 | 3 |
| RefCaducadaBuiltin | RefCaducadaBuiltin | 845498b8 | 1688 | ok | 0 | 12 | 6 |
| DivBordes | DivBordes | 70f63a2f | 798 | ok | 0 | 10 | 10 |
| ListaBorde | ListaBorde | e6ddaaf1 | 2918 | ok | 0 | 23 | 26 |
| IndiceObjeto | IndiceObjeto | 80c280cb | 12474 | ok | 0 | 28 | 36 |
| GenericosOrden | GenericosOrden | 52134d69 | 8456 | ok | 0 | 23 | 30 |
| SobrecargaEspecifica | SobrecargaEspecifica | 555c6ff1 | 1358 | ok | 0 | 10 | 9 |
| SobrecargaVisible | SobrecargaVisible | d3797df1 | 1999 | ok | 0 | 13 | 4 |
| BoolBits | BoolBits | 7b87929a | 876 | ok | 0 | 12 | 15 |
| ArrayNuevo | ArrayNuevo | 2feee85e | 2393 | ok | 0 | 34 | 17 |
| BucleConNombre | BucleConNombre | 6c35f20c | 1734 | ok | 0 | 10 | 12 |
| ErroresConTipo | ErroresConTipo | 7d9c7755 | 11493 | ok | 0 | 30 | 48 |
| IgualdadRefs | IgualdadRefs | 4a34e551 | 883 | ok | 0 | 10 | 8 |
| VarParam | VarParam | 1024398c | 3481 | ok | 0 | 11 | 12 |
| StrNulo | StrNulo | 4572ae05 | 2784 | ok | 0 | 11 | 14 |
| DatosGrandes | DatosGrandes | 822e223a | 34291 | ok | 0 | 10 | 11 |
| DatosAnchos | DatosAnchos | e70ef4fb | 71917 | ok | 0 | 11 | 12 |
| HeapInfo | HeapInfo | 53946845 | 1228 | ok | 0 | 13 | 10 |
| HeapCompact | HeapCompact | 3e213ca1 | 3560 | ok | 0 | 15 | 17 |

### Placa esp32p4 - E8F60AE80FD4

- sello: boardName=`esp32p4` uniqueId=`E8F60AE80FD4` serverName=`bpvm-esp32p4` serverBuild=`Nov 26 2026 19:25:24` version=`8.5` imageCrc=`0ca38df8` capacidades=["META", "FILES", "TERMINAL", "DEBUG", "PACKS"]
- imagen: OTRA: la compilada en el PC (bpgenvm-c/esp32p4/build/bpvm_esp32p4.bin (26-11 19:21)) da 883a93a9
- imagen: arch=243 variant=None cpuFreqHz=400000000 resetReason=software uptimeMs=172763 fs=221184/5193728 B vmHeapBytes=25145344
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM17
- pantalla: si (INFO screenW x screenH = 1024x600)
- inventario /lib+/app: 19 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| MathRango | **IDENTICO** | 10 | 10 | EXITED OK exit=0; host rc=0 |
| ThrowSinAtrapar | **IDENTICO** | 10 | 11 | EXITED RUNTIME_ERROR exit=1 (excepcion no atrapada: Core.IndexError: ALOAD: índice fuera de rango 99 (length=3)) en ThrowSinAtrapar.bp:26; host rc=1 |
| ThreadTrasMain | **IDENTICO** | 310 | 336 | EXITED OK exit=0; host rc=0 |
| MachineId | **NO-PETA** | 9 | 10 | EXITED OK exit=0 |
| GuiWinJson | **DIFIERE** | 651 | 66 | texto distinto |
| GuiShot | **NO-PETA** | 611 | 402 | EXITED OK exit=0 |
| BorraCarpetaFichero | **IDENTICO** | 265 | 14 | EXITED OK exit=0; host rc=0 |
| RutaFueraFlash | **DIFIERE** | 68 | 14 | texto distinto |
| FlashCarpetas | **IDENTICO** | 159 | 27 | EXITED OK exit=0; host rc=0 |
| GcHuecoPila | **IDENTICO** | 163 | 14 | EXITED OK exit=0; host rc=0 |
| RefCaducadaBuiltin | **IDENTICO** | 13 | 12 | EXITED OK exit=0; host rc=0 |
| DivBordes | **IDENTICO** | 10 | 10 | EXITED OK exit=0; host rc=0 |
| ListaBorde | **IDENTICO** | 22 | 23 | EXITED OK exit=0; host rc=0 |
| IndiceObjeto | **IDENTICO** | 32 | 28 | EXITED OK exit=0; host rc=0 |
| GenericosOrden | **IDENTICO** | 29 | 23 | EXITED OK exit=0; host rc=0 |
| SobrecargaEspecifica | **IDENTICO** | 11 | 10 | EXITED OK exit=0; host rc=0 |
| SobrecargaVisible | **IDENTICO** | 10 | 13 | EXITED OK exit=0; host rc=0 |
| BoolBits | **IDENTICO** | 11 | 12 | EXITED OK exit=0; host rc=0 |
| ArrayNuevo | **IDENTICO** | 33 | 34 | EXITED OK exit=0; host rc=0 |
| BucleConNombre | **IDENTICO** | 11 | 10 | EXITED OK exit=0; host rc=0 |
| ErroresConTipo | **DIFIERE** | 119 | 30 | texto distinto |
| IgualdadRefs | **IDENTICO** | 11 | 10 | EXITED OK exit=0; host rc=0 |
| VarParam | **IDENTICO** | 13 | 11 | EXITED OK exit=0; host rc=0 |
| StrNulo | **IDENTICO** | 13 | 11 | EXITED OK exit=0; host rc=0 |
| DatosGrandes | **IDENTICO** | 13 | 10 | EXITED OK exit=0; host rc=0 |
| DatosAnchos | **IDENTICO** | 14 | 11 | EXITED OK exit=0; host rc=0 |
| HeapInfo | **IDENTICO** | 30 | 13 | EXITED OK exit=0; host rc=0 |
| HeapCompact | **IDENTICO** | 209 | 15 | EXITED OK exit=0; host rc=0 |

- tras MathRango: uptimeMs=173601 fsUsed=225280 vmHeapBytes=25145344 pila libre: run=13556 io=25748 tareaREPL=25748 heap del sistema, minimo libre=238652
- tras ThrowSinAtrapar: uptimeMs=174068 fsUsed=225280 vmHeapBytes=25145344 pila libre: run=13556 io=25748 tareaREPL=25748 heap del sistema, minimo libre=238652
- tras ThreadTrasMain: uptimeMs=174968 fsUsed=225280 vmHeapBytes=25145344 pila libre: run=13484 io=25748 tareaREPL=25748 heap del sistema, minimo libre=238652
- tras MachineId: uptimeMs=175486 fsUsed=225280 vmHeapBytes=25145344 pila libre: run=13484 io=25748 tareaREPL=25748 heap del sistema, minimo libre=238652
- tras GuiWinJson: uptimeMs=181492 fsUsed=229376 vmHeapBytes=25145344 pila libre: run=12512 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
<details><summary>GuiWinJson: cola del stderr del host</summary>

```
 pila t0: rango [507904..508188) = 71 palabras, 13 son refs al heap
[gc] vivo=5972 liberado=34944 heap=[68864..109780) freelist=si
[gc] reservas: de_lista=0 de_bump=793 astilla=0
[gc] libres: 49 huecos, 34944 B en total, el mayor 10028 | altas=49
[bpvm] GC: bump 109780 -> 109780 (recupera 0 B, tope 55751, heap 68864..501048)
[bpvm] pila: el main llegó a 1060 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] mutex: 1 creados, la tabla llegó a 1
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>GuiWinJson: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -1,14 +1,14 @@
-J1: {"type":"Panel","align":"CENTER","width":1024,"height":600,"children":[{"type":"Label","text":"Demo de Forms — Camino A","align":"TOP_MID","y":12},{"type":"Button","text":"Saludar","align":"CENTER","clic":"onSaludar"},{"type":"Checkbox","text":"Activar","align":"BOTTOM_MID","y":-20,"change":"onActivar"}]}
+J1: {"type":"Panel","width":1024,"height":600,"children":[{"type":"Label","text":"Demo de Forms — Camino A","align":"TOP_MID","y":12},{"type":"Button","text":"Saludar","align":"CENTER","clic":"onSaludar"},{"type":"Checkbox","text":"Activar","align":"BOTTOM_MID","y":-20,"change":"onActivar"}]}
 -- arbol tras cargar main.win --
 screen [1024x600 align=0 +0,0]
   panel [1024x600 align=0 +0,0]
-    panel [1024x600 align=4 +0,0]
+    panel [1024x600 align=0 +0,0]
...
```

oraculo (host):

```
J1: {"type":"Panel","align":"CENTER","width":480,"height":320,"children":[{"type":"Label","text":"Demo de Forms — Camino A","align":"TOP_MID","y":12},{"type":"Button","text":"Saludar","align":"CENTER","clic":"onSaludar"},{"type":"Checkbox","text":"Activar","align":"BOTTOM_MID","y":-20,"change":"onActivar"}]}
-- arbol tras cargar main.win --
screen [480x320 align=0 +0,0]
  panel [480x320 align=0 +0,0]
    panel [480x320 align=4 +0,0]
      label "Demo de Forms — Camino A" [-1x-1 align=1 +0,12]
      button [-1x-1 align=4 +0,0]
        label "Saludar" [-1x-1 align=4 +0,0]
      checkbox "Activar" [-1x-1 align=7 +0,-20 val=0]

WIN: {"type":"Window","width":480,"height":320,"children":[{"type":"Panel","align":"CENTER","width":480,"height":320,"children":[{"type":"Label","text":"Demo de Forms — Camino A","align":"TOP_MID","y":12},{"type":"Button","text":"Saludar","align":"CENTER","clic":"onSaludar"},{"type":"Checkbox","text":"Activar","align":"BOTTOM_MID","y":-20,"change":"onActivar"}]}]}
J2 == J1: true
arbol igual: true
hijos del panel: 3
hijos del boton (la etiqueta): 1
boton en JSON: {"type":"Button","text":"Saludar","align":"CENTER","clic":"onSaludar"}
FIN
```

placa:

```
J1: {"type":"Panel","width":1024,"height":600,"children":[{"type":"Label","text":"Demo de Forms — Camino A","align":"TOP_MID","y":12},{"type":"Button","text":"Saludar","align":"CENTER","clic":"onSaludar"},{"type":"Checkbox","text":"Activar","align":"BOTTOM_MID","y":-20,"change":"onActivar"}]}
-- arbol tras cargar main.win --
screen [1024x600 align=0 +0,0]
  panel [1024x600 align=0 +0,0]
    panel [1024x600 align=0 +0,0]
      label "Demo de Forms — Camino A" [-1x-1 align=1 +0,12]
      button [-1x-1 align=4 +0,0]
        label "Saludar" [-1x-1 align=0 +0,0]
      checkbox "Activar" [-1x-1 align=7 +0,-20 val=0]

WIN: {"type":"Window","width":1024,"height":600,"children":[{"type":"Panel","width":1024,"height":600,"children":[{"type":"Label","text":"Demo de Forms — Camino A","align":"TOP_MID","y":12},{"type":"Button","text":"Saludar","align":"CENTER","clic":"onSaludar"},{"type":"Checkbox","text":"Activar","align":"BOTTOM_MID","y":-20,"change":"onActivar"}]}]}
J2 == J1: true
arbol igual: true
hijos del panel: 3
hijos del boton (la etiqueta): 1
boton en JSON: {"type":"Button","text":"Saludar","align":"CENTER","clic":"onSaludar"}
FIN
```
</details>

- tras GuiShot: uptimeMs=187709 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11356 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- artefacto GuiShot.shot de GuiShot: bajado a `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32p4_E8F60AE80FD4\GuiShot.shot` (12280 B, crc b46c8ec2) -> PNG `C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32p4_E8F60AE80FD4\GuiShot.png`; antes del RUN: no existia
- tras BorraCarpetaFichero: uptimeMs=188932 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11616 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras RutaFueraFlash: uptimeMs=189780 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11356 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
<details><summary>RutaFueraFlash: cola del stderr del host</summary>

```
throw: ATRAPADA por un catch del programa
[bpvm] throw: "appendFile('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "readFileBytes('/../x810'): no se pudo abrir"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] throw: "writeFileBytes('/../x810'): error de escritura"
[bpvm] throw: ATRAPADA por un catch del programa
[bpvm] pila: el main llegó a 244 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>RutaFueraFlash: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -13,7 +13,7 @@
 rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
 copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
 fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
-lastModified -> IOError: lastModified('/../x810'): no se pudo leer
+lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
 File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
 File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
...
```

oraculo (host):

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no se pudo leer
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no se pudo leer
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```

placa:

```
== /../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/../x810'): error de escritura
appendFile -> IOError: appendFile('/../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/../x810'): error de escritura
listDir -> IOError: listDir('/../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/../x810'): no se pudo crear
rmdir -> IOError: rmdir('/../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/../x810', "w"): no se pudo abrir
== /a/../../x810
fileExists -> false
isDirectory -> false
readFile -> IOError: readFile('/a/../../x810'): no se pudo abrir
writeFile -> IOError: writeFile('/a/../../x810'): error de escritura
appendFile -> IOError: appendFile('/a/../../x810'): error de escritura
readFileBytes -> IOError: readFileBytes('/a/../../x810'): no se pudo abrir
writeFileBytes -> IOError: writeFileBytes('/a/../../x810'): error de escritura
listDir -> IOError: listDir('/a/../../x810'): no se pudo abrir
mkdir -> IOError: mkdir('/a/../../x810'): no se pudo crear
rmdir -> IOError: rmdir('/a/../../x810'): no se pudo borrar (¿no vacío?)
removeFile -> IOError: removeFile('/a/../../x810'): error al borrar
rename(fuera, dentro) -> IOError: rename('/a/../../x810' -> '/data/fuera810b'): error al renombrar
copyFile(fuera, dentro) -> IOError: copyFile('/a/../../x810' -> '/data/fuera810b'): error al copiar
fileSize -> IOError: fileSize('/a/../../x810'): no se pudo leer el tamaño
lastModified -> IOError: lastModified('/a/../../x810'): no implementado en esta plataforma
File(r) -> IOError: File('/a/../../x810', "r"): no se pudo abrir
File(w) -> IOError: File('/a/../../x810', "w"): no se pudo abrir
rename(dentro, fuera) -> IOError: rename('/data/fuera810c' -> '/../x810'): error al renombrar
copyFile(dentro, fuera) -> IOError: copyFile('/data/fuera810c' -> '/../x810'): error al copiar
fin
```
</details>

- tras FlashCarpetas: uptimeMs=190658 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11616 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras GcHuecoPila: uptimeMs=191433 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11356 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras RefCaducadaBuiltin: uptimeMs=191942 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11616 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras DivBordes: uptimeMs=192484 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11356 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras ListaBorde: uptimeMs=193376 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11356 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras IndiceObjeto: uptimeMs=194892 fsUsed=253952 vmHeapBytes=25145344 pila libre: run=11356 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras GenericosOrden: uptimeMs=196432 fsUsed=249856 vmHeapBytes=25145344 pila libre: run=11616 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras SobrecargaEspecifica: uptimeMs=196946 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11356 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras SobrecargaVisible: uptimeMs=197553 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11356 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras BoolBits: uptimeMs=197967 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11616 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras ArrayNuevo: uptimeMs=198504 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11616 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras BucleConNombre: uptimeMs=198932 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11616 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras ErroresConTipo: uptimeMs=200241 fsUsed=249856 vmHeapBytes=25145344 pila libre: run=11616 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
<details><summary>ErroresConTipo: cola del stderr del host</summary>

```
its ALTOS: un bpref_t de 64b gu
[bpvm] UAF: idx=178  gen del handle=0  gen del slot=1  (slots en uso=180)
[bpvm]   gen 0 con el slot en 1: o una referencia CADUCADA al PRIMER objeto de ese slot (nace con gen 0: el programa lo libero y lo siguio usando), o un TRUNCAMIENTO (el handle perdio sus 32 bits ALTOS: un bpref_t de 64b gu
[bpvm] pila: el main llegó a 500 de 16384 B
[bpvm] hilos: 0 arrancados, como mucho 1 a la vez (el main incluido)
[bpvm] mutex: 1 creados, la tabla llegó a 1
[bpvm] fin de RUN: la memoria del programa vuelve a su sitio (0 bloques sin liberar; plataforma: 9 vivos)

```
</details>

<details><summary>ErroresConTipo: diff oraculo vs placa</summary>

```diff
--- oraculo (host)
+++ placa
@@ -19,7 +19,7 @@
 ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
 ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
 ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
-ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
+ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
 ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
 ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
...
```

oraculo (host):

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no se pudo leer
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```

placa:

```
ok   división por cero: ArithmeticError: División por cero
ok   módulo por cero: ArithmeticError: Módulo por cero
ok   un long por cero: ArithmeticError: División por cero
ok   exponente negativo: ArithmeticError: exponente negativo en potencia entera
ok   byte(300): ArithmeticError: I32_TO_U8: valor fuera de rango 300
ok   factorial(13): ArithmeticError: factorial: 13 desborda integer (máx 12)
ok   un campo de null: NullReferenceError: referencia nula: acceso a un campo de un objeto null
ok   un método de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   un método privado de null: NullReferenceError: referencia nula: llamada a un método de un objeto null
ok   una cadena null: NullReferenceError: referencia nula: strlen de un string null
ok   un array null: NullReferenceError: referencia nula: acceso a un elemento de un array null
ok   un objeto eliminado: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una clave null: NullReferenceError: referencia nula: Map.put con una clave null
ok   un array: IndexError: ALOAD: índice fuera de rango 5 (length=2)
ok   un byte[]: IndexError: ALOAD_U8: idx fuera de rango 3 (len=2)
ok   charAt: IndexError: charAt: idx fuera de rango 7 (len=3)
ok   una List: IndexError: List: índice fuera de rango 3 (length=1)
ok   una conversión: CastError: conversion invalida: el valor no es un 'Perro'
ok   un fichero que no está: IOError: readFile('no_existe_h75.txt'): no se pudo abrir
ok   UTF-8 malo, por IOError: IOError: fromBytes: UTF-8 mal formado en el byte 1 (0xFF)
ok   fileSize de uno que no está: IOError: fileSize('no_existe_h75.txt'): no se pudo leer el tamaño
ok   lastModified de uno que no está: IOError: lastModified('no_existe_h75.txt'): no implementado en esta plataforma
ok   mkdir sobre un fichero: IOError: mkdir('h805_fichero.txt'): no se pudo crear
ok   rmdir de una que no está vacía: IOError: rmdir('h805_carpeta'): no se pudo borrar (¿no vacío?)
ok   RuntimeError las atrapa: RuntimeError: División por cero
ok   EncodingError, la suya: EncodingError: fromBytes: UTF-8 mal formado en el byte 0 (0xFF)
ok   una cadena eliminada, el uso 1: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 2: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 3: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 4: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 5: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 6: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 7: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 8: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 9: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 10: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 11: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   una cadena eliminada, el uso 12: NullReferenceError: referencia a objeto eliminado (use-after-free)
ok   un Mutex con un id que no vale: RuntimeError: mutex.lock: id inválido 999
ok   y su unlock: RuntimeError: mutex.unlock: id inválido 999
ok   un Mutex null: NullReferenceError: referencia nula: mutex.lock de un Mutex null
ok   y su unlock: NullReferenceError: referencia nula: mutex.unlock de un Mutex null
ok   un throw de un null: NullReferenceError: referencia nula: throw de un objeto null
ok   un throw de un null, con RuntimeError: RuntimeError: referencia nula: throw de un objeto null
ok   un throw de un null, con Exception: Exception: referencia nula: throw de un objeto null
ok   un throw de un null, sin tipo: sin tipo: referencia nula: throw de un objeto null
ok   un throw de un null, con su finally: finally, y atrapada sin nombre
fallos: 0
```
</details>

- tras IgualdadRefs: uptimeMs=200815 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11356 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras VarParam: uptimeMs=201796 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11616 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras StrNulo: uptimeMs=202419 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11356 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras DatosGrandes: uptimeMs=203591 fsUsed=274432 vmHeapBytes=25145344 pila libre: run=11224 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras DatosAnchos: uptimeMs=205264 fsUsed=311296 vmHeapBytes=25145344 pila libre: run=11616 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras HeapInfo: uptimeMs=205953 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11224 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- tras HeapCompact: uptimeMs=206989 fsUsed=241664 vmHeapBytes=25145344 pila libre: run=11616 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- ejecutadas (con EXITED) 28 de 28 listadas; no terminaron 0; saltadas 0; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/MathRango.mod | bpgenvm-c\build\tanda\MathRango\MathRango.mod | 1611 | 2270c82e | ok |
| /app/ThrowSinAtrapar.mod | bpgenvm-c\build\tanda\ThrowSinAtrapar\ThrowSinAtrapar.mod | 295 | 9b053410 | ok |
| /app/ThreadTrasMain.mod | bpgenvm-c\build\tanda\ThreadTrasMain\ThreadTrasMain.mod | 532 | 97dd1bb5 | ok |
| /app/MachineId.mod | bpgenvm-c\build\tanda\MachineId\MachineId.mod | 452 | 42a7e155 | ok |
| /app/main.win | samples\formdemo\resources\main.win | 390 | 548edd67 | ok |
| /app/GuiWinJson.mod | bpgenvm-c\build\tanda\GuiWinJson\GuiWinJson.mod | 2041 | ea106f91 | ok |
| /app/GuiShot.mod | bpgenvm-c\build\tanda\GuiShot\GuiShot.mod | 1347 | f794de7d | ok |
| /app/BorraCarpetaFichero.mod | bpgenvm-c\build\tanda\BorraCarpetaFichero\BorraCarpetaFichero.mod | 2271 | be28edf2 | ok |
| /app/RutaFueraFlash.mod | bpgenvm-c\build\tanda\RutaFueraFlash\RutaFueraFlash.mod | 3213 | 79cbf8d4 | ok |
| /app/FlashCarpetas.mod | bpgenvm-c\build\tanda\FlashCarpetas\FlashCarpetas.mod | 733 | c21b2696 | ok |
| /app/GcHuecoPila.mod | bpgenvm-c\build\tanda\GcHuecoPila\GcHuecoPila.mod | 1190 | 3304c6f0 | ok |
| /app/RefCaducadaBuiltin.mod | bpgenvm-c\build\tanda\RefCaducadaBuiltin\RefCaducadaBuiltin.mod | 1688 | 845498b8 | ok |
| /app/DivBordes.mod | bpgenvm-c\build\tanda\DivBordes\DivBordes.mod | 798 | 70f63a2f | ok |
| /app/ListaBorde.mod | bpgenvm-c\build\tanda\ListaBorde\ListaBorde.mod | 2918 | e6ddaaf1 | ok |
| /app/IndiceObjeto.mod | bpgenvm-c\build\tanda\IndiceObjeto\IndiceObjeto.mod | 12474 | 80c280cb | ok (por trozos) |
| /app/GenericosOrden.mod | bpgenvm-c\build\tanda\GenericosOrden\GenericosOrden.mod | 8456 | 52134d69 | ok (por trozos) |
| /app/SobrecargaEspecifica.mod | bpgenvm-c\build\tanda\SobrecargaEspecifica\SobrecargaEspecifica.mod | 1358 | 555c6ff1 | ok |
| /app/SobrecargaVisible.mod | bpgenvm-c\build\tanda\SobrecargaVisible\SobrecargaVisible.mod | 1999 | d3797df1 | ok |
| /app/BoolBits.mod | bpgenvm-c\build\tanda\BoolBits\BoolBits.mod | 876 | 7b87929a | ok |
| /app/ArrayNuevo.mod | bpgenvm-c\build\tanda\ArrayNuevo\ArrayNuevo.mod | 2393 | 2feee85e | ok |
| /app/BucleConNombre.mod | bpgenvm-c\build\tanda\BucleConNombre\BucleConNombre.mod | 1734 | 6c35f20c | ok |
| /app/ErroresConTipo.mod | bpgenvm-c\build\tanda\ErroresConTipo\ErroresConTipo.mod | 11493 | 7d9c7755 | ok (por trozos) |
| /app/IgualdadRefs.mod | bpgenvm-c\build\tanda\IgualdadRefs\IgualdadRefs.mod | 883 | 4a34e551 | ok |
| /app/VarParam.mod | bpgenvm-c\build\tanda\VarParam\VarParam.mod | 3481 | 1024398c | ok |
| /app/StrNulo.mod | bpgenvm-c\build\tanda\StrNulo\StrNulo.mod | 2784 | 4572ae05 | ok |
| /app/DatosGrandes.mod | bpgenvm-c\build\tanda\DatosGrandes\DatosGrandes.mod | 34291 | 822e223a | ok (por trozos) |
| /app/DatosAnchos.mod | bpgenvm-c\build\tanda\DatosAnchos\DatosAnchos.mod | 71917 | e70ef4fb | ok (por trozos) |
| /app/HeapInfo.mod | bpgenvm-c\build\tanda\HeapInfo\HeapInfo.mod | 1228 | 53946845 | ok |
| /app/HeapCompact.mod | bpgenvm-c\build\tanda\HeapCompact\HeapCompact.mod | 3560 | 3e213ca1 | ok |

notas de dependencias:

- la placa NO lleva la imagen compilada en el PC: imageCrc 0ca38df8, bpgenvm-c/esp32p4/build/bpvm_esp32p4.bin (26-11 19:21) da 883a93a9
- dependencia Core: en la zona de packs (pack:Stdlib/Core.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Math: en la zona de packs (pack:Stdlib/Math.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Machine: en la zona de packs (pack:Stdlib/Machine.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Gui: DESFASE de compilación —la placa tiene en /lib/Gui.mod la versión 7 (>= la mínima 7), crc 7cc3678e != el de hoy fcbd8e89: vale y NO se sube, pero la prueba corre con la suya; para probar la de hoy, regraba la imagen—
- dependencia Json: ya en /lib/Json.mod (crc igual; resuelto por nombre, como el RUN)
- dependencia Collections: ya en /lib/Collections.mod (crc igual; resuelto por nombre, como el RUN)
- dependencia Str: ya en /lib/Str.mod (crc igual; resuelto por nombre, como el RUN)
- dependencia IO: en la zona de packs (pack:Stdlib/IO.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Heap: en la zona de packs (pack:Stdlib/Heap.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados y los artefactos (GuiShot.shot)

### Matriz pruebas x placas

| prueba | esp32p4@COM17 |
|---|---|
| MathRango | IDENTICO |
| ThrowSinAtrapar | IDENTICO |
| ThreadTrasMain | IDENTICO |
| MachineId | NO-PETA |
| GuiWinJson | DIFIERE |
| GuiShot | NO-PETA |
| BorraCarpetaFichero | IDENTICO |
| RutaFueraFlash | DIFIERE |
| FlashCarpetas | IDENTICO |
| GcHuecoPila | IDENTICO |
| RefCaducadaBuiltin | IDENTICO |
| DivBordes | IDENTICO |
| ListaBorde | IDENTICO |
| IndiceObjeto | IDENTICO |
| GenericosOrden | IDENTICO |
| SobrecargaEspecifica | IDENTICO |
| SobrecargaVisible | IDENTICO |
| BoolBits | IDENTICO |
| ArrayNuevo | IDENTICO |
| BucleConNombre | IDENTICO |
| ErroresConTipo | DIFIERE |
| IgualdadRefs | IDENTICO |
| VarParam | IDENTICO |
| StrNulo | IDENTICO |
| DatosGrandes | IDENTICO |
| DatosAnchos | IDENTICO |
| HeapInfo | IDENTICO |
| HeapCompact | IDENTICO |

NECESITA OJOS: GuiShot en esp32p4@COM17: C:\lenguajes\pm\bpgenvm-c\build\tanda\GuiShot\esp32p4_E8F60AE80FD4\GuiShot.png  


## Tanda 2026-11-27 18:07:34

- manifiesto: `..\..\Users\Eduardo\AppData\Local\Temp\claude\2cbf9ff7f3759075\576fc834-e260-4649-ba6c-131c549812a9\scratchpad\lote85\lista_lote85.json` (28 pruebas listadas, filtro --prueba GuiWinJson)
- oraculo: jar `toolchain\lexer-java\target\basicplus-frontend.jar` (2026-11-25 18:51:06) - exe `bpgenvm-c\build\bpgenvm-c.exe` (2026-11-27 17:01:29) - sabor `v2-gui1-lvgl0`
- placas conectadas: 1 (esp32p4@COM17)

### Oraculo por prueba (PC)

| prueba | modulo | crc .mod | tamano | compilacion | host rc | ms host | lineas salida |
|---|---|---|---|---|---|---|---|
| GuiWinJson | GuiWinJson | ea106f91 | 2041 | ok | 0 | 65 | 17 |

### Placa esp32p4 - E8F60AE80FD4

- sello: boardName=`esp32p4` uniqueId=`E8F60AE80FD4` serverName=`bpvm-esp32p4` serverBuild=`Nov 26 2026 19:25:24` version=`8.5` imageCrc=`0ca38df8` capacidades=["META", "FILES", "TERMINAL", "DEBUG", "PACKS"]
- imagen: OTRA: la compilada en el PC (bpgenvm-c/esp32p4/build/bpvm_esp32p4.bin (26-11 19:21)) da 883a93a9
- imagen: arch=243 variant=None cpuFreqHz=400000000 resetReason=software uptimeMs=381605 fs=110592/5193728 B vmHeapBytes=25145344
- al conectar: nada corria (KILL: NO_SESSION)
- transporte: serie COM17
- pantalla: si (INFO screenW x screenH = 1024x600)
- inventario /lib+/app: 15 ficheros en /lib+/app, omitidos=0

| prueba | veredicto | ms placa | ms host | detalle |
|---|---|---|---|---|
| GuiWinJson | **IDENTICO** | 290 | 63 | EXITED OK exit=0; host rc=0 |

- tras GuiWinJson: uptimeMs=384125 fsUsed=118784 vmHeapBytes=25145344 pila libre: run=11224 io=24652 tareaREPL=24652 heap del sistema, minimo libre=238652
- ejecutadas (con EXITED) 1 de 1 listadas; no terminaron 0; saltadas 0; no llegaron a arrancar 0

subido a /app:

| remoto | origen | tamano | crc32 | resultado |
|---|---|---|---|---|
| /app/main.win | samples\formdemo\resources\main.win | 390 | 548edd67 | ok |
| /app/GuiWinJson.mod | bpgenvm-c\build\tanda\GuiWinJson\GuiWinJson.mod | 2041 | ea106f91 | ok |

notas de dependencias:

- la placa NO lleva la imagen compilada en el PC: imageCrc 0ca38df8, bpgenvm-c/esp32p4/build/bpvm_esp32p4.bin (26-11 19:21) da 883a93a9
- dependencia Core: en la zona de packs (pack:Stdlib/Core.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Gui: en la zona de packs (pack:Stdlib/Gui.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Json: en la zona de packs (pack:Stdlib/Json.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Collections: en la zona de packs (pack:Stdlib/Collections.mod, crc igual): se ejecuta XIP, no se sube
- dependencia Str: en la zona de packs (pack:Stdlib/Str.mod, crc igual): se ejecuta XIP, no se sube
- limpieza: 0 fichero(s) de /app borrados

### Matriz pruebas x placas

| prueba | esp32p4@COM17 |
|---|---|
| GuiWinJson | IDENTICO |


## Nota (27-nov): las once placas, y la P4X con `GuiWinJson`

El lote de la V8.5: las once placas, cada una con su imagen de `dist/firmware` (todas dicen la 8.5) y sus packs grabados por
el IDE del ZIP de prueba (`Micro32-Suite-8.5-prueba-win`, sha256 `29bfd30a…`): con los guiones `bd-metro`, `bd-stm32-dk2`
(con `SqlDemo` en la placa), `gui-stm32-dk2`, `gui-esp32c6`, `gui-esp32c5`, `gui-esp32p4-waveshare`,
`gui-bd-esp32p4-waveshare`, `gui-esp32p4-kit` y `gui-bd-esp32p4-kit` (en el kit y en la P4X); en las cuatro sin pantalla, la
zona formateada y el `Stdlib.pack`. La lista, las 24 del lote final de V8 y las cuatro de la tanda de V9. Lo que no sale
idéntico es lo de siempre: `RutaFueraFlash` y `ErroresConTipo` (`lastModified`, «no implementado en esta plataforma»), las dos
de pantalla saltadas en las placas sin ella, y `MachineId` y `GuiShot`, «no peta» (las capturas, miradas: bien en las seis).

**La P4X y `GuiWinJson`.** En la tanda de las 18:03 difería (el panel y la etiqueta del botón, sin su `align`): llevaba en
`/lib` cuatro copias sueltas de la stdlib de pruebas de antes —`Gui.mod`, de 51 009 bytes, vieja (la de la 8.5, 51 901), y
`Collections`, `Json` y `Str`—, que se buscan antes que el `Stdlib.pack` y lo tapaban. Repetida antes de tocar nada, igual (2
de 2; en el kit, idéntica). Quitadas, idéntica (2 de 2, y la tanda de las 18:07). Era el paso 5 del procedimiento del lote
(las copias sueltas de `/app` y `/lib`), que en las tres P4 se hizo después de la tanda; en las otras ocho, antes: ninguna.

