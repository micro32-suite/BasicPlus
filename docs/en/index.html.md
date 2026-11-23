<!-- Generated from index.html by scripts/docs_md.py: edit the HTML, not this file. -->

[🇪🇸 Español](../index.html)

# BasicPlus

A general-purpose language for 32-bit microcontrollers: modern BASIC syntax, object orientation, a **graphical interface** and a first-class debugger. It compiles to bytecode that runs **identically** on the PC and on the micro.

- V7
- RP2350 · ESP32 S3/C3/C5/C6/P4 · STM32
- Two VMs · one byte-identical output
- Handle-based memory
- Tested on real hardware
- MIT

![The BasicPlus GuiColorDemo — a palette of coloured buttons — on a board with a screen](../img/guicolordemo.png)

`GuiColorDemo` on a board — GUI with LVGL. The same bytecode runs on the PC and on the micro.

The same program you debug on your desktop later blinks an LED on a Raspberry Pi Pico 2, an ESP32 (S3, C3, C5, C6 or P4) or an STM32 — no recompiling, no `#ifdef`, no surprises. On a PC with no GPIO the hardware builtins log to the console; on the board they drive real pins. The bytecode is the same, byte for byte.

```
// blink.bp — blinks the Pico on-board LED (GP25) using the OO API.
module Blink
  import Gpio

  function Main()
    var led: Gpio.Pin := Gpio.Pin(25, Gpio.Pin.OUTPUT)
    var i: integer := 0
    while i < 100 do
      led.on()
      sleep(300)
      led.off()
      sleep(300)
      i := i + 1
    endwh
    print "Blink done"
  end Main
end Blink
```

And a micro does not only move pins: it also **stores data**. BasicPlus ships **SQLite** — the same engine, the same `.db` file and the same code on the PC and on the board, with the database on an SD card. You can write the SQL by hand or let the **ORM** write it from your classes.

```
// Entities are annotated, and the compiler generates the DAO.
@BD{ tabla = "readings" }
public class Reading
  @BD{ pk }   public property id:    long
  @BD{}       public property value: double
end Reading

// ...and then, not one SQL statement in sight:
var w: Orm.Where := Orm.Where()
var cold: List := dao.list(w.lt("value", 22.0d))
```

The engine does not live inside the VM: it is burned separately, in a **pack**, so only those who use it pay for it — and it runs from flash without eating RAM. [How it works, in full →](basedatos.html.md)

**New in V8.** This version brings three big things:

- **WiFi and Bluetooth** on the ESP32s with PSRAM — the S3, the C5 and the Waveshare P4, which carries its radio in its ESP32-C6: the board joins the network by itself at boot and the IDE works with it without a cable; from Bluetooth, for now, the keyboard and the mouse. Both radios are off by default, and switch themselves off after ten minutes unused.
- **JC**, a new language, a mix of Java and C# for those who work with those languages: without trying to be either of them, and with our own libraries. Inside it is BasicPlus, with the same compiler and the same bytecode, and a program is translated from one to the other from the IDE ([the JC volume](jc.html.md)). To test it, Mono's C# test suite: of 2,322 tests, 848 run, and along the way both languages gained operators, interfaces and generics.
- **Reliability.** Four boards, 48 hours in a row with a program that touches everything, without a single error or restart, looking above all for any resource — memory — that might be slowly lost over time; the test found two real bugs, now fixed. Everything that is tested, in [How BasicPlus is tested](pruebas.html.md).

And also: what was pending from V7 and what came up along the way, fixed; strings, much faster (on the Pico 2, walking a 2 KB one went from 535 to 20 ms); sound on the Waveshare P4; and an image for the **ESP32-P4X**, the new revision of the P4, from the same code. Nine images for eleven boards. Details in the [v8.0 release](https://github.com/micro32-suite/BasicPlus/releases/tag/v8.0) and the [release notes](../RELEASES.md) *(Spanish)*; what V7 brought — packs, one image per micro and the second core — is in the [v7.0 release](https://github.com/micro32-suite/BasicPlus/releases/tag/v7.0).

**V8.1** changes nothing in the product: it reorganizes the project as a suite. BasicPlus moves to the [micro32-suite](https://github.com/micro32-suite) organization, together with **toolchain** (the compiler, the IDE and the Java VM) and **runtime** (the C VM and the firmware), each with its own history. The download is now called `Micro32-Suite-8.1-win.zip`, in the [v8.1 release](https://github.com/micro32-suite/BasicPlus/releases/tag/v8.1).

## Getting started

- [Quick start → Zero to blink, platform by platform: compile, run on the PC and upload to the board.](QUICKSTART.md)
- [Installing the firmware → Flash the VM on each micro (prebuilt image or built by you): Pico/Metro, ESP32 (S3, C3, C5, C6, P4), STM32; and the packs a board with a screen needs.](INSTALAR_FIRMWARE.md)

## The language and the tools

- [Cheat sheet (1 page) → The whole language on one sheet, to **print** or keep open beside you while you code. On the web.](https://micro32-suite.github.io/BasicPlus/cheatsheet.html)
- [Language manual → Lexicon, types, classes, modules, exceptions, concurrency and `native` (AOT) functions.](manual.html.md)
- [JC, BasicPlus with braces → The Java and C# syntax on the same compiler and the same bytecode: each construct, in JC and in BP, and how to translate from one to the other.](jc.html.md)
- [Reference → The complete standard library, the command line and the on-disk artifacts (`.mod`, `.dbg`, `.pack`…).](referencia.html.md)
- [Graphical interface → The `Gui` module: screen and widgets, layout, color and fonts, events and forms. Same bytecode on the PC and on the board.](gui.html.md)
- [Databases → SQLite on the micro: the pack, plain SQL, `@BD` entities, the ORM with its generated DAOs, indexes and how not to eat your memory.](basedatos.html.md)
- [Packs → Shipping a library in one piece and burning it onto the board: the two kinds, what goes inside, how it is used and the traps.](referencia.html.md#packs)
- [The SD card → Gigabytes for your data: which families support it, how it is wired and configured, and how it is used — which is like any other path.](referencia.html.md#stdlib-sd)
- [IDE guide → The window, projects, Run/Stop, the board explorer, the micro console and the debugger.](guia-ide.html.md)

## Under the hood

- [BasicPlus from the inside → (Spanish) The architecture told end to end: compiler, bytecode, the two VMs, the GC, AOT and the firmwares.](../bp-desde-dentro.html)
- [Project philosophy → (Spanish) What BasicPlus is and what it does not want to be.](../PHILOSOPHY.md)
- [How BasicPlus is tested → Every test each version passes, on the PC and on the boards: what each one checks, its numbers and the bugs they caught.](pruebas.html.md)
- [Known limitations → (Spanish) What the language does not do yet, said plainly, and why.](../PENDIENTES.md)
- [Release notes → (Spanish) What v8.0 brings, what changes when upgrading from v7, the downloadable artifacts and what is not there yet.](../RELEASES.md)

Low-level specs *(Spanish)*:

- → [`.mod` format](../MOD_FORMAT.md) — the bytecode binary spec.
- → [Opcodes](../OPCODES.md) — the semantics of all 189 instructions (plus a [browsable view](../opcodes.html), partial: the V1 opcodes with their AOT translation).
- → [Heap layout](../HEAP_LAYOUT.md) — the runtime `memory[]`.
- → [Builtins](../BUILTINS.md) — the `CALL_BUILTIN` catalog.
- → [Wire protocol](../BPVM_WIRE_PROTOCOL.md) — the JSON-per-line PC↔board link.

## Platforms

| Platform | Transport | Notes |
|---|---|---|
| PC (Windows/Linux/macOS) | — | Both VMs; TCP daemon for the IDE. |
| Raspberry Pi **Pico 2** and Adafruit **Metro RP2350** (Cortex-M33, dual core) | USB-CDC | A **single image** for both boards: the variant (A/B) is detected in hardware; board name and pins come from `/sys/board.json`; the Metro's PSRAM is enabled in the environment (`psram=1`). By default two BP threads run at once, one per core. AOT enabled. |
| **ESP32-S3** (Xtensa LX7, dual core) | UART0 | Persistent FS on a dedicated partition; console over native USB. 8 MB PSRAM as the VM heap, and a pack area. By default two BP threads run at once, one per core. `native` runs interpreted (no AOT on Xtensa). |
| **ESP32-C3** and **ESP32-C6** (RISC-V without FPU, single core) — *since V6* | USB-Serial-JTAG (the only USB) | Same ESP-IDF port; the console goes over UART0. No PSRAM: the VM gets up to 128 KB. The Waveshare **C6** (ESP32-C6-LCD-1.3) has an **SPI** display, ST7789 240×240 with no touch, painted by the `GuiMini` and `DriverSpi` packs (with the `Stdlib` pack too, or the GUI doesn't fit). A pack area on both. AOT enabled since V7 (`ilp32`). |
| **ESP32-C5** (RISC-V without FPU, single core) — *new in V7*, with a screen | USB-Serial-JTAG (the only USB) | The Waveshare ESP32-C5-Touch-LCD-2.8: 8 MB of PSRAM for the VM, 32 MB of flash, a TF slot and an ST7789 240×320 **SPI** display with touch, painted by the `Gui` and `DriverSpi` packs. The console goes over UART0. AOT enabled (`ilp32`). |
| **ESP32-P4** (RISC-V, dual core) — with a screen | UART; on the P4X, USB-Serial-JTAG | LVGL GUI on a MIPI-DSI panel + touch: the panel driver comes in the image, LVGL in the `Gui` pack. A **single image** for the boards with revision v1.x of the chip, the Function-EV kit (EK79007 1024×600) and the Waveshare 4.3" (ST7701 480×800); the panel is chosen at *runtime* from the environment (`display=st7701`). Since V8, another one for v3.x, the **ESP32-P4X** (its Function-EV kit, with the same 7" panel), from the same code: the IDF does not let one image serve both revisions. By default two BP threads run at once, one per core. AOT enabled (RISC-V). |
| **STM32** (Nucleo-U575ZI-Q · Discovery U5G9J-DK2) | ST-LINK VCP | FS in internal flash; AOT enabled (same Cortex-M33 as the RP2350). The **Discovery DK2** adds an LTDC 800×480 screen + touch: the panel driver comes in the image, LVGL in the `Gui` pack. `Adc` works (ADC1, since V7); `Wdt` does not: its IWDG cannot be stopped once started. |

Nine images for eleven boards. A board with a screen needs, besides its image, the screen's packs — burned from the IDE: *Placa* → *Packs* — and a RAM block for their engine (`packRam=` in the environment): what to burn on each one, in [Installing the firmware](INSTALAR_FIRMWARE.md).

On all of them: the cable has a system thread of its own, `io`, apart from the program, so the board keeps answering the cable while the program runs — and, since V7, also lists and reads files —; a "wire v1" REPL with file upload, remote RUN and a run argument (`run X <arg>`), **Stop** (cooperative KILL without resetting the board), **autorun** (`/sys/auto.txt` starts your program on power-up, and the IDE can attach live), unified exit codes and on-device debugging with breakpoints (while debugging, the program's threads take turns, as on a single core). On the dual-core boards, `vm.cores=1` and `vm.runs=1` in the environment take the board back to one core without reflashing.

## Verified on real hardware

This is not desk theory: the full stack has been exercised on silicon. On a **Raspberry Pi Pico 2 / Pico 2 W** (RP2350) the whole hardware ladder was validated end to end — from the IDE, with *Run on Device*, running the **same bytecode** as on the PC:

| Subsystem | On-board test |
|---|---|
| Execution / OO | cross-module stdlib classes dispatching on the micro ✅ |
| GPIO | blinking LED (`Gpio.Pin`) ✅ |
| I2C | real BMP280 sensor (T/P) + bus scan ✅ |
| SPI | BME688 over SPI: `chip_id` + T/RH/P/gas reads with memory paging ✅ |
| UART | loopback, byte echo ✅ |
| PWM + counter | 1 kHz / 500 Hz counted in hardware, < 0.1 % error ✅ |
| ADC | chip internal temperature (23.9 °C) ✅ |
| RTC | monotonic clock + recalibration ✅ |
| Watchdog | feed / timeout / disable ✅ |
| Timers | hardware alarms (polling, synchronized, stopwatch) ✅ |

On the **STM32** (Nucleo-U575ZI-Q) the **four critical buses** were also validated on the board with real sensors: GPIO, **SPI** (BME688), **UART** (loopback) and **I2C** (BME280, T/P). And on the **ESP32-S3** (DevKitC) those **same four buses** were validated on the board with real sensors (BME688 over SPI, BME280 over I2C, GPIO and UART loopbacks) — the **three families are on par**. On STM32 and ESP32 the non-critical peripherals work too (PWM, ADC and RTC; the STM32's external ADC since V7); the watchdog, on the ESP32s — the STM32 has none, on purpose: its IWDG cannot be stopped once started. The **Metro RP2350B** shares the firmware image with the Pico — one `.uf2` for both, the variant is detected at runtime. V6 added the **ESP32-C3** and **ESP32-C6** (and the UART gained a 512-byte receive ring), V7 the **ESP32-C5** and V8 the **ESP32-P4X**. The V8 test round passed, with the images being released, on **all eleven boards and three architectures**: Pico 2, Metro, S3, C3, C5, C6, the three P4s (the Function-EV kit, the Waveshare and the P4X kit), Nucleo and DK2.

**Boards with a screen (since V3).** The GUI (LVGL) has been verified on hardware on all six: **STM32U5G9J-DK2** (LTDC 800×480 + GT911 touch), **ESP32-P4-Function-EV** (EK79007 1024×600), since V8 the **ESP32-P4X-Function-EV** (the same panel), **Waveshare ESP32-P4** (ST7701 480×800), **Waveshare ESP32-C6-LCD-1.3** (ST7789 240×240 over SPI) and, since V7, **Waveshare ESP32-C5-Touch-LCD-2.8** (ST7789 240×320 over SPI + touch) — widget catalogue, colour, `.win` forms, touch and screen capture (`Gui.shot`), with the same bytecode on all of them. Since V7, with LVGL from a pack. The program's screen is the size of the panel.

## Credits

BasicPlus is a stack of its own from top to bottom — compiler, two virtual machines, IDE — but it is **not built in a vacuum**. The flash filesystem is **littlefs**; the graphical interface is **LVGL**, painting onto **SDL2** on the PC; the VM’s tasks rest on the **FreeRTOS** RTOS; each micro boots with its manufacturer’s SDK — **Pico SDK**, **ESP-IDF**, **STM32Cube**; and the IDE edits with **RSyntaxTextArea** and talks to the board through **PureJavaComm**.

**This project would not have been possible without them.** They are all named, with what each one does inside and under which license, on the [**credits and acknowledgements**](creditos.html.md) page.

> **The name.** BasicPlus is a homage to **Digital Equipment Corporation's BASIC-PLUS**, the structured dialect that ran under RSTS/E on the PDP-11s through the 70s and 80s — the BASIC whole systems were written in, and a generation learned to program with. The same idea (a language that is easy to read but doesn't treat you like a beginner) transplanted to today's small hardware.

BasicPlus — documentation written alongside the development. Frontend `lexer-java` · VMs `miVM` (Java) and `bpgenvm-c` (host + RP2350 / ESP32 S3·C3·C5·C6·P4 / STM32) · IDE `BpIde`. MIT license.
