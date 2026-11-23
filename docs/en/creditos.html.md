<!-- Generated from creditos.html by scripts/docs_md.py: edit the HTML, not this file. -->

[← Documentation index](index.html.md) [Manual](manual.html.md) [Reference](referencia.html.md) [Graphical interface](gui.html.md) [IDE guide](guia-ide.html.md) [🇪🇸 Español](../creditos.html)

# Credits and acknowledgements

BasicPlus is a stack of its own from top to bottom — compiler, two virtual machines, development environment — but it is **not built in a vacuum**. It rests on other people's work: filesystems, graphics libraries, a real-time operating system, each manufacturer's SDK, and the tools everything is built with.

**This project would not have been possible without them.** This page is here to name them, say what each one does inside, and say thank you.

## The heart of the virtual machine

| Project | What it does in BasicPlus | License |
|---|---|---|
| [littlefs](https://github.com/littlefs-project/littlefs)<br>v2.11.3 | The **flash filesystem**, the same one across all three micro families. It is designed for NOR memory and for a power cut not to leave the volume unusable — exactly what a device that gets plugged and unplugged needs. It is *vendored* in the repository (`third_party/littlefs`) so the build is reproducible without downloading anything. | BSD-3-Clause |
| [newlib](https://sourceware.org/newlib/)<br>Arm Ltd. and Eric Blake | Three pieces of the VM's **string library** (`bpgenvm-c/bpstr`), adapted from its code: finding a text inside another by looking at *pairs* of bytes (Arm's `memmem`, 2018), the *Two-Way* algorithm for long needles (Eric Blake, 2008) and the Cortex-M memory copy (Arm's `memcpy`, 2013, in assembly). All three were chosen by measuring them against ours on the boards: they won. Their license notices are included in full in `bpstr/bpstr.c`. | BSD-3-Clause (Arm) and permissive (Eric Blake) |
| [FreeRTOS](https://www.freertos.org/) | The **real-time operating system** (RTOS) the VM rests on when running on a board. It is not just the scheduler: from it come the *tasks* — the interpreter workers and the communications one — and also the queues, semaphores, mutexes and timers that BasicPlus's `Thread` and `Mutex` classes are built on. On the Pico and the STM32 the kernel is used directly; on the ESP32s it arrives inside ESP-IDF. | MIT |

## The graphical interface

| Project | What it does in BasicPlus | License |
|---|---|---|
| [LVGL](https://lvgl.io/)<br>v9.2.2 | The whole **graphical interface**. The widgets `Gui` offers are LVGL widgets underneath, and the drawing on the boards' screens is its work. It also includes the PNG decoder (`lv_lodepng`, based on [LodePNG](https://lodev.org/lodepng/)) used to load images. | MIT |
| [SDL2](https://www.libsdl.org/)<br>2.30.9 | The **simulated micro's window**: when you run a program with a GUI on the PC, what you see is LVGL painting onto SDL2. It is what makes it possible to develop interfaces without the board in front of you. | zlib |
| [Montserrat](https://fonts.google.com/specimen/Montserrat)<br>typeface | The **type you see on screen**. LVGL ships it compiled in several sizes and that is what `fontSize` selects, so it goes inside every firmware image. We also publish a bold cut as a standalone file (`samples/montserrat_26_bold.bin`) so the `FontLoadDemo` example can show runtime font loading. | SIL OFL 1.1 |

## Each micro's SDK

The firmware is the same portable engine across all three families, but each one needs its own waist: boot, clocks, flash, USB and peripherals. That part comes from the manufacturer.

| Project | What it does in BasicPlus | License |
|---|---|---|
| [Raspberry Pi Pico SDK](https://github.com/raspberrypi/pico-sdk) | The base of the **RP2350** firmware (Pico 2 and Metro): boot, USB CDC, flash, PIO, and the peripherals that `Gpio`, `Spi`, `I2c` and company rest on. | BSD-3-Clause |
| [ESP-IDF](https://github.com/espressif/esp-idf) (Espressif) | The base of the **ESP32** firmware (S3, C3, C5, C6 and P4): partition system, PSRAM, MIPI-DSI and the rest of the platform; and, since V8, the WiFi with its TCP/IP stack (lwIP) and the Bluetooth (NimBLE). | Apache-2.0 |
| [ESP-Hosted](https://github.com/espressif/esp-hosted-mcu) (Espressif) | On the **Waveshare P4**, since V8, the WiFi and Bluetooth through the board's ESP32-C6: the host goes inside the P4 image, and the C6's coprocessor firmware (version 3.0.9) in the ZIP, in `firmware/`. | Apache-2.0 |
| [STM32Cube](https://www.st.com/en/development-tools/stm32cubeide.html) (HAL + CubeIDE) | The base of the **STM32** firmware (Nucleo-U575 and Discovery U5G9J): peripheral HAL, the screen's LTDC, and the environment it is compiled with. | BSD-3-Clause |

## The compiler and the development environment

| Project | What it does in BasicPlus | License |
|---|---|---|
| [RSyntaxTextArea](https://github.com/bobbylight/RSyntaxTextArea)<br>3.3.4 | The **IDE's editor**: syntax highlighting, line numbers, current-line and breakpoint marking. | BSD-3-Clause |
| [PureJavaComm](https://github.com/nyholku/purejavacomm)<br>1.0.5 | The IDE's **serial port** — everything spoken to the board travels through there: uploading programs, running them, debugging them and reading the console. | BSD |
| [ASM](https://asm.ow2.io/) (OW2)<br>9.7 | JVM *bytecode* generation in the compiler's `jvm` backend (the original path, predating our own bytecode). | BSD-3-Clause |
| [JUnit 5](https://junit.org/junit5/)<br>5.10.2 | The **tests** for the frontend and the Java VM. | EPL-2.0 |

## The tools it is built with

Without listing them one by one in a table, because they are the ground you stand on: **GCC** and the **Arm GNU Toolchain** (arm-none-eabi) for native code and for AOT; **CMake** and **Make** to build the firmwares and the C VM; **Maven** and the **JDK** for the compiler, the Java VM and the IDE; and **Git**, which has kept every step of this.

> **About the licenses.** All of the above are permissive licenses and their conditions are respected. The license texts of whatever travels *inside* the repository sit next to their code — for example `bpgenvm-c/third_party/littlefs/LICENSE.md` — and the technical detail of which version is used and how to update it is in `bpgenvm-c/third_party/README.md`. BasicPlus is published under the **MIT** license.
>
> The newlib code that goes inside every firmware (in the string library) asks for its notice to travel with the binary. Here it is, verbatim:
>
> ```
> Copyright (c) 2018 Arm Ltd. All rights reserved.
> Copyright (c) 2013 ARM Ltd. All rights reserved.
>
> Redistribution and use in source and binary forms, with or without
> modification, are permitted provided that the following conditions are met:
> 1. Redistributions of source code must retain the above copyright notice,
>    this list of conditions and the following disclaimer.
> 2. Redistributions in binary form must reproduce the above copyright notice,
>    this list of conditions and the following disclaimer in the documentation
>    and/or other materials provided with the distribution.
> 3. The name of the company may not be used to endorse or promote products
>    derived from this software without specific prior written permission.
>
> THIS SOFTWARE IS PROVIDED BY ARM LTD ``AS IS'' AND ANY EXPRESS OR IMPLIED
> WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
> EVENT SHALL ARM LTD BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
> EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
> PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
> OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
> WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
> OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
> ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>
> Byte-wise substring search, using the Two-Way algorithm.
> Copyright (C) 2008, 2010 Eric Blake
> Permission to use, copy, modify, and distribute this software is freely
> granted, provided that this notice is preserved.
> ```

## And one mention apart

The name is a tribute to **Digital Equipment Corporation's BASIC-PLUS**, the structured dialect that ran under RSTS/E on the PDP-11s in the 1970s and 80s. There is not a line of its code here — there could not be — but the idea is: a language that is simple to read and does not treat you like a beginner.

Is someone missing from this page? That is an oversight, not an omission: tell us and it gets added.
