<!-- Generated from cheatsheet.html by scripts/docs_md.py: edit the HTML, not this file. -->

# BasicPlus — one page

A small, statically typed language for microcontrollers. One bytecode runs on a PC and on RP2350, ESP32 (S3, C3, C5, C6, P4) and STM32 boards.

## Module & entry point

```
// One file = one module = one .mod
module Hello
  import Math

  function Main()
    print "hi " + intToString(42)
  end Main
end Hello
```

> Every block closes with what it opens: `end Main`, `endif`, `next i`. You never count braces. **No semicolons** — a newline ends a statement (a line left open inside `( )` or `[ ]` continues on the next one).

## Variables & types

```
var n: integer := 5         // type first, always: no inference
var x: float := 1.5
var big: long := 1000000000L
var d: double := 2.0d
var ok: boolean := true
var s: string := "utf-8 inside"

// sized for a micro, not for a PC
var b: byte, w: word          // unsigned 8 / 16
var i8: int8, i16: int16       // signed

var buf: byte[] := byte[256]
var t: integer[] := [1, 2, 3]
const PI: float := 3.14159     // module level; := also for const
```

> A `byte[]` costs **one byte per element**, not four — which matters when the whole machine has 512 KB.

## Control flow

```
if n > 10 then
  print "big"
elseif n > 0 then
  print "small"
else
  print "zero or less"
endif

while i < 10 do
  i := i + 1
endwh

for d in devices do
  print d
next d

switch colour
  case Colour.GREEN
    print "go"
  default
    print "stop"
endsw
```

> Also: `break`, `continue`, and compound assignment (`+=`, `*=`, `mod=` …).

## Functions

```
function add(a: integer, b: integer): integer
  return a + b
end add

// default parameter values (the type stays)
function label(text: string, prefix: string := "["): string
  return prefix + text
end label

// tuples: return several values, destructure them
var err: boolean, v: integer
{ err, v } := Str.parseInt("123")   // (error?, value): false 123
```

> **Public by default? No — private.** Only what you mark `public` leaves the module.

## Classes

```
public class Counter
  public property value: integer

  public function Counter(start: integer)
    this.value := start
  end Counter

  public function bump(d: integer)
    this.value += d
  end bump
end Counter

var c: Counter := Counter(10)
c.bump(5)
print c.value
```

> **Variables are never public.** If it has to be visible it is a `property`, so the day you need to validate it — or guard it with a mutex — no caller changes. Single inheritance with `extends`, `super(…)`, `instanceof`, and an `Object` root under every class (threads excepted: `Thread` is a root of its own). A destructor, `function ~Counter()`, runs whenever the object is freed — by its `owner`, by the GC or when the program ends — so a class that takes a resource gives it back.

## What is static, and what isn’t

```
// Module-level declarations are static already —
// there is no keyword, and no second copy of them.
module Config
  public const MAX: integer := 64
  public function clamp(n: integer): integer …
end Config

Config.clamp(99)        // from another module: qualified

// Inside a class, a static member is declared with
// its name QUALIFIED BY THE CLASS:
public const Counter.START: integer := 10
public function Counter.fromString(s: string): Counter …
end Counter.fromString

Counter.fromString("10")   // class name  -> static
c.bump(5)                 // instance    -> method
```

> Coming from Java or C#, this is the one habit to drop: there is no `static` keyword — you **qualify the name with the class**, both when you declare it and when you call it.

## Errors

```
try
  var v: integer := risky()
catch e: RuntimeError
  print "caught: " + e.msg
endtry

try
  throw RuntimeError("it broke")
catch e                  // no type = Exception
  print e                 // prints its message
endtry
```

> One hierarchy: `Object → Exception → RuntimeError`. Runtime faults (divide by zero, index out of range, null reference) are `RuntimeError` and you catch them like any other — even when the fault happens inside a function compiled to machine code. `Exception`, `List` and the wrappers live in `Core`, the root module, which every module imports on its own: no `import Core` needed.

## Threads

```
class Worker extends Thread
  var name: string
  public function Worker(name: string)
    super(2048)          // stack size in bytes
    this.name := name
  end Worker
  public function run()
    print this.name
    yield()
  end run
end Worker

var w: Thread := Worker("A")
w.start()
w.join()

var m: Mutex := Mutex()
m.lock()
// critical section
m.unlock()
```

> The VM's own threads, scheduled by the VM itself — same model on the PC and on the board. On dual-core boards (Pico 2, Metro, ESP32-S3, ESP32-P4) two of them run at once, one per core: whatever threads share, guard it with a `Mutex`. Also `SyncList` with a blocking `popBlocking()` for producer/consumer.

## Typed lists

```
var l: List<Sensor> := List()
l.add(Sensor(4))
l.add("x")                 // compile error
print l[0].value()         // l.get(0): no cast to write
l[0] := Sensor(5)          // l.set(0, …)
```

> `<Sensor>` is an order to the compiler: same class, same VM. What goes in must be a `Sensor`, and what comes out is one. Inside `< >` goes a class, an interface or `string`; a number goes in its box, `List<Integer>`. A new class opts in with `@element{Base}`. On any object, `x[i]` is `x.get(i)` and `x.pin[i]` is `x.getPin(i)`; it looks like an array and costs a call.

## Native: real machine code

```
native function fib(n: integer): integer
  if n < 2 then return n      // one-line if: no endif
  return fib(n-1) + fib(n-2)
end fib
```

> The compiler also emits C for that function, builds it and stores the machine code **inside the `.mod`**. Measured on an ESP32-C3 (V7) with an integer loop: **943 ms interpreted → 9 ms native**, about 100× (with `double` — no board has a double-precision FPU — 5×). Accelerated on RP2350, STM32, ESP32-P4 and, since V7, ESP32-C3, C5 and C6; on the ESP32-S3 (no AOT target) the bytecode runs instead — same result, no speed-up. Bytecode is always the safety net.

## Talking to hardware

```
import Gpio

function Main()
  var led: Gpio.Pin := Gpio.Pin(25, Gpio.Pin.OUTPUT)
  var i: integer := 0
  while i < 10 do
    led.on()
    sleep(250)
    led.off()
    sleep(250)
    i += 1
  endwh
end Main
```

> Every peripheral is a class: `Gpio.Pin`, `I2c.HardI2C` (or `modSoftI2C.SoftI2C`, I²C on any two pins), `Spi.Bus`, `Spi.Device`, `Uart.Port`, `Pwm.Slice`, `Adc.Channel`, `Rtc.Clock`, `Wdt.Timer`, `Timer.Alarm`. One that takes something — its pins, its channel — gives it back with its `release()` or when it is destroyed (a bus, `I2c.HardI2C` or `Spi.Bus`, only with `release()`: it has no destructor, on purpose), and in any case when the program ends. **The same program runs on every family** — only the pin numbers change, as long as the board has what it uses: there is no `Wdt` on the STM32 boards, for instance (it throws a catchable `RuntimeError`), and the GUI needs a screen and its packs.

## Build & run

```
# compile one file (writes out/Hello.mod)
bp build Hello.bp

# compile and run it on the PC (with --c, on the C VM)
bp run Hello.bp

# on the simulated micro, or on a board (it uploads what is needed)
bp run --sim Hello.bp
bp run --placa=COM22 Hello.bp

# the API of a library module, in BasicPlus (bp api alone: the modules)
bp api Collections

# the tests in tests/, on both VMs (the checks: import Assert)
bp test

# a project: bp build App.bpbuild / bp run App.bpbuild
{ "sourceDir": "src", "outDir": "out",
  "main": "App", "dependencies": [] }
```

> From the IDE it is one menu: run on the PC, on the simulated micro or on a board — with breakpoints and variable inspection in all three (on a board, not inside a `native` function: it runs as machine code).

## Why it looks like this

> **Blocks read in both directions.** You read code downwards while writing it and upwards while fixing it, so every close says what it closes.  
> **Private by default.** A program you can keep under control is one where you chose what to expose.  
> **The same bytecode everywhere.** Two independent VMs — one in Java, one in C99 — must print the same bytes for the same `.mod`. That rule is the backbone of the project, not a slogan.

Full reference, graphics guide and internals: see the documentation shipped with the release. · This page covers the language, not the standard library.
