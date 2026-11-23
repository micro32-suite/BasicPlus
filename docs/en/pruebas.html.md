<!-- Generated from pruebas.html by scripts/docs_md.py: edit the HTML, not this file. -->

[← Documentation index](index.html.md) [Manual](manual.html.md) [Reference](referencia.html.md) [Graphical interface](gui.html.md) [IDE guide](guia-ide.html.md) [🇪🇸 Español](../pruebas.html)

# How BasicPlus is tested

BasicPlus runs on microcontrollers, and a microcontroller can stay powered on for days with nobody watching it, logging data or controlling something. A bug there goes unseen until it does harm. That is why every change goes through a battery of tests on the PC, and every version through a longer one on real boards.

This page goes through them all: what each one checks, how many cases it has and, where there is one, a real bug it caught. They are all in the repository; the end of the page explains how to run them.

## By the numbers

Measured on 18 and 19 November 2026, in the pre-release check of V8 (the compiler's tests and the net, on the 19th, after its last fixes). The numbers are redone each time a version is published.

| Test | What it checks | Result |
|---|---|---|
| The corpus, on both VMs | 217 programs: the same output, byte for byte | 217 of 217 |
| … in MOD8 | the same ones, compiled to MOD8, the module format before MOD9 | 209 of 209 (8 use what only the new format has) |
| … with two worker threads | the same ones, with two worker threads at once | 217 of 217 |
| The V6 capsule | 59 programs compiled by the published V6 compiler | 59 of 59 |
| The C tests | inside the C VM | 117 of 117 |
| The simulated micro · shadowing · the version rule | the IDE's simulator · the order in which modules are looked up · module versions | 15 · 15 · 9, all |
| The compiler and the Java VM | their own tests | 404 and 66, all |
| All the samples | 415 sample programs, compiled | 415 of 415 |
| The error programs | 39 programs that must fail, with what each error says | 151 of 151 |
| The documentation's examples | every code snippet in the manuals, compiled | 377 of 377, and 78 JC modules |
| The test round on the boards | 24 programs on all eleven boards, with the image that is published | as on the PC, except for what differs on purpose; and a hang on the ESP32-P4, once (on 15 November), not seen again in 400 consecutive runs and 500 screen captures |
| The endurance test | 48 hours straight, on four boards | without a single error or reboot |

## The golden rule: two machines, the same output

A BasicPlus program is compiled to a bytecode (the `.mod`) that is run by two separately written virtual machines: the **Java VM**, the reference one, on the PC, and the **C VM**, in C, which runs on the PC and inside the firmware of each board. The rule is that, for the same `.mod`, the two write **exactly the same thing, byte for byte**. A difference is a bug, even if the program «works».

For you, this means that what you see while debugging on the PC is what the board will do. And since they are two independent implementations of the same algorithm, a bug in one is almost never repeated by the other: the comparison gives it away.

Every new thing is also tested in a fixed order, from the cheapest to debug to the most expensive: first on the Java VM; then on the C VM, comparing against the Java one; and only then on the board. What does not work in Java will not work in C either, and what does not work in C will not work on the board either: that way, all that is left to catch on the board is what truly belongs to the hardware. How the two VMs are built is told in [BasicPlus from the inside](../bp-desde-dentro.html#s15) (Spanish).

## On every change: the net

No change to the virtual machines, the compiler or the standard library goes in without passing the safety net («the net», `compat.sh check`): about twenty minutes of tests on the PC. If a single one comes out red, the change does not go in.

### The corpus, on both VMs

217 programs — the samples, and many written while fixing a bug, so that it does not come back — are compiled and run on both VMs, and their output has to be identical. And twice more: compiled to MOD8, the module format before MOD9, because the VMs still load it, and with two worker threads at once, because the same program has to say the same thing with one as with two. And the corpus grows with each version: in V7 there were 149 programs; today, 217.

### What came before keeps working

- **The V6 capsule.** 59 programs compiled with the published V6 compiler — taken from its ZIP, just as it was released — run on today's VMs, and their output has to be the one they gave back then, byte for byte. A program from two versions ago runs without recompiling it.
- **Forwards.** A program compiled today, on the published V6 VM, has to be rejected with a message saying why: never loaded wrongly, never breaking the VM.
- **The version rule.** Nine cases of modules compiled at different times that come together in one program: when they are accepted and when they are rejected with a message, the same on both VMs.
- **The packs.** The native part of the packs (SQLite, the graphical interface) has to speak the same language as the VM, its ABI. Twice, a bump of that ABI left SQLite without its native functions on every board. Since then the net checks it, and it cannot happen again without turning red.
- **The library inside the firmware.** Each image carries the standard library inside and restores it at boot; the net checks that it is the same as the one that is published, the one in `bpstdlib/` (18 modules on the RP2350 and ESP32 boards, 17 on the STM32 ones).

### Inside the C VM

117 tests written in C exercise what a sample program cannot reach: the debugger core (pauses, steps, a Stop at a breakpoint, several threads), the native functions compiled to C against their interpreted version (a single one of those tests makes 494 comparisons), the filesystems and the SD card, the flash, the garbage collector, the threads and their scheduler, the packs and tight memory. Alongside them:

- **The stress tests:** the object table growing without end, a tight heap with one, two and four worker threads on both VMs, and threads yielding their turn to one another. On 15 November they caught a race: two threads ran out of room in the object table at the same time; one of them collected the garbage, and when the other tried again, the other threads had already used up the freed space, and it gave up with a false «out of memory». Now, before giving up, that thread collects the garbage itself.
- **The simulated micro,** the one the IDE uses when there is no board: it is built and tested with its 15 cases.
- **Shadowing:** the order in which modules are looked up (the program's folder, the library, the packs) is the same on both VMs, and if one of your modules shadows one in the library, you are warned. 15 cases.

## The tests that test the tests

A green test says nothing if it is not capable of turning red. That is why the tests of the most delicate parts — threads, the garbage collector, files, stopping a program — carry their own **sabotage**: a switch that deliberately undoes the fix they guard. The net checks both things: that with the fix the test comes out green, and that with the sabotage it comes out red. The thread-queue test alone has twenty.

And two rules: a test that is skipped counts as a failure, and so does one that ends well without saying its «OK». They come from a lesson: in V7, a review found tests that had not run for weeks — one had not linked since August — because they were in no net and nobody noticed. Since then, every C test that can run on its own is in the net.

## The compiler

- **Their own tests:** 404 for the compiler and 66 for the Java VM.
- **The error programs.** 39 programs that must fail, with 151 checks. Failing is not enough: each error has to say what it is supposed to say. If one that should fail starts compiling, a rule of the language has been lost; if the message changes, the diagnosis has got worse — or better, and then it is updated deliberately.
- **All the samples:** the 415 sample programs are compiled with today's compiler. While V6 was being prepared, this sweep found six published samples that no longer compiled.
- **The documentation.** Every example in the manuals is compiled (377 BP snippets and 78 JC modules, across 29 pages): an example that does not compile is a documentation bug, and a line the manual shows as an error (`// compile error: …`) has to produce it. And when the package is put together, it is checked that no link in the help is left broken.

## On the boards

### The test round

Before a release, each board is flashed with the image from the ZIP that is about to be published — the same one you will install — and is put through the test round: a series of programs that run on the PC and on the board. The PC's output is the reference, and the board's has to match it, except for what differs on purpose (a filesystem with no modification date, or a screen test on a board that has no screen). For V7, 50 programs on ten boards; for V8, in the final batch of 18 November, the 24 new programs on nine boards of three architectures: ARM, Xtensa and RISC-V; on the 19th, on the new board, the ESP32-P4X; and on the 20th, on the P4 kit: all eleven.

What the test round catches, the PC does not see. In the batch of 15 November, the new ESP32-C6 image had moved its memory block by 4 KB, and the graphical interface engines would not load until their packs were burned again.

### The endurance test

A PC is switched on for a few hours and then switched off; a device can run for days with nobody watching it. If it leaks memory or any other resource, one day it runs out of it and fails, and no test lasting minutes will see it.

The endurance test is a program that runs on its own, for days on end, on four boards: the Pico 2 and the Metro (the same chip, without PSRAM and with it: one acts as the other's control), the ESP32-P4, the one with the most resources, and the ESP32-C6, which has few; those two, with their screens. On each lap — about eleven seconds — it computes, creates and drops lists and maps, writes, reads and deletes a file, starts threads and draws on the screen. Every error is caught and logged, without stopping the test. Every ten minutes it logs the free memory after a garbage collection, and the chip's temperature: if the free memory goes down day after day, there is a leak.

The first time it ran, the Pico 2 started failing after 45 minutes, around lap 257: each map carries a mutex, and the VM never released its entry in the mutex table. On the PC the table grew without anyone noticing; on the Pico 2 the memory ran out. It was fixed in both VMs, and with the fix the Pico 2 went past a thousand laps without an error in three hours.

Then the four of them ran for 48 hours straight, from 15 to 17 November: without a single error or reboot, 61,360 laps between them. And in those 48 hours the test caught another bug, one that gave no error at all: on the boards with little heap, a block of memory the program no longer used stayed alive for hours. A number stored in a global variable happened to equal the address of an object, and the collector took it for a reference. Now it checks that it is one before accepting it.

The test is in the repository, in [compat/resistencia](https://github.com/micro32-suite/BasicPlus/tree/main/compat/resistencia), so that it can be repeated.

### Performance and memory

Performance is compared with that of the published versions, on the board (the Metro and the ESP32-P4): each version is measured as a whole, just as it was released — its compiler, its library and its firmware, taken from its ZIP — with the same test programs. If something has become slower, it shows before publishing. And each board's memory is measured: how much is left for your program and where the rest goes ([MEMORIA.md](../MEMORIA.md) (Spanish)).

## Before publishing

A checklist ([PUBLICAR.md](../PUBLICAR.md) (Spanish)) makes sure that what is published is what was tested: the ZIP is assembled and verified from the inside, the firmware images carry their checksum, the library pack is byte-for-byte identical to the library, and the package is deployed to a clean folder and tested by hand: the IDE, the boards, the samples. In V7, that list caught what had slipped past the earlier steps: the tests of the compiler and the Java VM were not in the net — now they are always run before publishing — and five sentences still counted nine boards when there were already ten.

## What needs someone in front of it

Some of it cannot be fully automated, because it needs something from outside or a person: the WiFi with a real network, the Bluetooth keyboard and mouse, the touch screens and the whole IDE — projects, the debugger, flashing a board. That is tested on the boards, with the network, the device or the person right there. What the language does not do yet, said plainly, is in the [known limitations](../PENDIENTES.md) (Spanish).

## Running them yourself

They are all in the repository. With the compiler and both VMs built, as the [quick start](QUICKSTART.md) explains, and with Python:

```
bash compat/compat.sh check                # the net: about twenty minutes
mvn -f toolchain/lexer-java/pom.xml test   # the compiler's tests
mvn -f toolchain/miVM/pom.xml test         # the Java VM's
python scripts/samples_sweep.py            # all the samples
bash scripts/h13-errores.sh                # the error programs
python scripts/doc_frags.py                # the documentation's examples
```

The test round (`bpgenvm-c/tools/tanda.py`) and the endurance test need boards; how to use them is in their own files.

## A final note

> Each version is verified and delivered with no known bugs, but that does not mean it has no errors: however much it is tested, some may always remain undetected. What the tests achieve is that it becomes ever harder for a bug under normal circumstances to go unnoticed, and that, with each new test, the circumstances in which one could appear have to be ever more extreme.
>
> But the ultimate test is another one: that more and more people use the tool. Unfortunately, the project does not have many users yet; we, at least, try to do our part.

If you find a bug, [tell us](https://github.com/micro32-suite/BasicPlus/issues): it is the best help there is.

Measured on 18 and 19 November 2026, for V8. The numbers are redone in the pre-release check of each version.
