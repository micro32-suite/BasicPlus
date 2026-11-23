<!-- Generated from manual.html by scripts/docs_md.py: edit the HTML, not this file. -->

# BasicPlus — Language manual

A structured, typed, module-oriented language. A Java frontend compiles to its own bytecode (the `.mod` v9 format, "MOD9"), executed by the `bpgenvm` VM (mark-and-sweep GC, deterministic owner handling, typed exceptions).

<a id="intro"></a>
## 1. Introduction

BasicPlus (BP) takes the friendly syntax of Basic / Pascal and combines it with modern semantics: classes with single inheritance, modules as Modula-2-style units, exception handling, and deterministic "ownership" for immediate release of resources.

The overall pipeline is:

```
// 1) Compilation: each module → a .mod (binary, with its interface inside), in samples/out/
bp build samples/hola.bp

// 2) Execution: the VM loads the root .mod; the .mod files of its imports are
//    looked up by name, <library>.<Module>.mod (§10.3)
bp run samples/out/Hola.mod

// or both at once (with --c, on the C VM): bp run samples/hola.bp
```

<a id="hello"></a>
## 2. Hello world

```
module Hola

  function main(arg: string)
    print "hello, " + arg
  end main

end Hola
```

The minimum: a `module`, a `function main(arg: string)`, and matched `end`s. The VM passes an empty string to `main` when there are no arguments; how to pass one (and give it a default value) is in [§10.2](#main).

`print` writes its pieces one after another: a **comma** puts a space between two, and a **semicolon**, nothing. At the end it moves to a new line, unless it ends with `;`: then it leaves the line open and the next `print` carries on in it (V8). A `print` with nothing just moves to a new line.

```
print "x =", x              // x = 7
print "["; x; "]"           // [7]
print "a";
print "b"                   // ab
```

The open line comes out whole with the next line break ([§14.5](#conc-print)), so a piece is not seen until then; if the thread ends first, it comes out as it is.

The line break that `print` puts is the platform's end of line, the one `eol()` gives: `"\r\n"` on Windows, `"\n"` on Linux and on the micros (like Java's `System.lineSeparator()`). What the program writes inside a string comes out as it is: `"\n"` is always LF (10), and `"\r"`, CR (13), in both VMs (V8).

```
print "one\ntwo"              // on Windows: one LF two CR LF
print "a" + eol() + "b"        // a, the platform's line break, b
```

<a id="lexico"></a>
## 3. Lexical structure

<a id="comentarios"></a>
### 3.1 Comments

Line comments only, with `//` to the end of the line.

```
// this is a comment
```

<a id="identificadores"></a>
### 3.2 Identifiers

A letter or `_` followed by letters, digits or `_`. Case-sensitive, and **63 characters** at most (a longer one is a compile error; a function's full signature —its name with the types of its parameters— may be 160). Names starting with a double underscore (`__name`) belong to **the system**: the VM's primitives and the names the compiler synthesizes (`__init`, `__prop_get_x`…). Declaring one —a variable, a field, a parameter, a class, a constant, an enum, a property or a private function— is a compile error (V7).

<a id="keywords"></a>
### 3.3 Reserved words

| Category | Tokens |
|---|---|
| Structure | `module` `end` `import` `library` `from` |
| Declarations | `const` `var` `function` `native` `class` `extends` `interface` `implements` ([§9.8](#interfaces-clase)) `enum` `property` `get` `set` `endprop` `endget` `endset` `event` `raise` `inline` ([§8.3b](#inline)) |
| Visibility / modifiers | `public` `private` `final` `owner` `sync` |
| Instance | `this` `super` `field` |
| Control flow | `if` `then` `else` `elseif` `endif` `while` `do` `endwh` `loop` `for` `to` `step` `in` `next` `switch` `case` `default` `endsw` `parallel` `endpar` `break` `continue` `return` |
| Exceptions | `try` `catch` `finally` `endtry` `throw` `instanceof` |
| Booleans / null | `true` `false` `null` |
| Word operators | `and` `or` `not` `mod` `xor` `shl` `shr` |
| I/O | `print` |

<a id="literales"></a>
### 3.4 Literals

| Type | Examples |
|---|---|
| Integer | `0` `42` `-7` `0xFF` (hex) `0b1010` (binary) |
| Long | `123L` `4000000000L` — `L`/`l` suffix on a decimal integer |
| Float | `3.14` `1.0e-3` — with no suffix, a literal with a point or exponent is a `float` (f32) |
| Double | `1.5d` `5d` `2e3d` — `d`/`D` suffix on an integer or float |
| String | `"hola"` with escapes `\n \t \r \" \\ \0` |
| Boolean | `true` `false` |
| Null | `null` (references only: classes and arrays) |

Any numeric literal may include a **visual separator `_`** between digits (Python-style); the value is identical to the one without it. It works in decimal, hex, binary, the fractional part and the exponent: `1_000_000` · `0xDE_AD` · `0b1111_0000` · `2_000_000L` · `1_234.5` · `1_0e2`.

<a id="multilinea"></a>
### 3.5 Line continuation

A newline ends the statement, **except inside open parentheses or brackets**: there the newline is not significant and the expression continues on the next line. To split a long expression, wrap it in `( )`:

```
print ("total = " + intToString(a)
    + " / " + intToString(b))      // OK: inside ( )

var v: integer[] := [1, 2,
                       3, 4]          // OK: inside [ ]
```

<a id="tipos"></a>
## 4. Types

<a id="primitivos"></a>
### 4.1 Primitives

| Type | Range / detail |
|---|---|
| `integer` | Signed 32-bit integer (-2³¹..2³¹-1) |
| `long` | Signed 64-bit integer. Literal with `L` suffix: `4000000000L` |
| `float` | IEEE-754 32-bit |
| `double` | IEEE-754 64-bit. Literal with `d` suffix: `1.5d` |
| `byte` | Narrow unsigned integer, 8 bits (0..255) |
| `int8` | Narrow signed integer, 8 bits (-128..127) |
| `word` | Narrow unsigned integer, 16 bits (0..65535) |
| `int16` | Narrow signed integer, 16 bits (-32768..32767). `short` is an alias for `int16` |
| `string` | Immutable; internally UTF-8, indexing and `len()` by *code point* (`len("héllo") = 5`) |
| `boolean` | `true` / `false` |

The **narrow** types (`byte`/`int8`/ `word`/`int16`) are *storage* types: in arrays and fields they occupy 1–2 bytes per element; on the stack and in expressions they operate as `integer` (a read sign-extends or zero-extends according to the type). Assigning an out-of-range literal is a compile error, with the exact range in the message.

<a id="utf8"></a>
**A `string` is always valid UTF-8, and it does not change** (V8). What comes from outside —a file, a line, a network packet, a `byte[]`— is *decoded* when it is turned into text: `fromBytes(b)`, `readFile(path)`, `TextFile.readLine()` and `readStr(n)`, `Net.Tcp.recvStr(…)`. If the bytes are not valid UTF-8 (a file in Latin-1, for example), they throw `EncodingError`, a child of `IOError` (and so of `RuntimeError`), with the place. With a last argument `true` (`ignorarError`), instead of the exception, each bad piece becomes «�» (U+FFFD), as the Unicode standard says:

```
var t: string := readFile("latin1.txt", true)   // "año" in Latin-1 (61 F1 6F): a�o
try
  t := readFile("latin1.txt")
catch e: EncodingError
  print e.msg      // readFile('latin1.txt'): UTF-8 mal formado en el byte 1 (0xF1)
endtry
```

`readLine()` leaves the bad line read: a loop with a `try` carries on with the next one. `recvStr` waits for the rest of a character that arrives split between two packets. And `appendChar` with something that is not a character —a UTF-16 surrogate (`0xD800` to `0xDFFF`) or a number outside `0..0x10FFFF`— also throws `EncodingError`, with no argument to ignore it: it is a bug in the program. For text that changes, `StringBuilder`.

**A caveat about `double` on the RP2350** (Pico 2, Metro): *subnormal* values —those below `2.2250738585072014e-308`— are flushed to `0`. Everything above that boundary is exact, and byte-identical to the PC, the ESP32-P4 and the STM32. The reason is that that board's SDK uses optimized floating-point routines that drop subnormals in exchange for speed (measured: recovering them would cost 24 % of the time in all `double` arithmetic). In practice it affects nothing: `double` is used for measurements that need precision, and instrumentation works with 6 or 8 significant digits, not with three-digit negative powers of ten. The only thing worth knowing is that a computation that *underflows* will give `0` on that board and a tiny number on the others.

#### 4.1.1 Promotion and casts

In mixed operations and assignment there is **automatic promotion to the widest type**: `integer → long → float → double` (the narrow types are promoted to `integer` first). The opposite direction is NEVER implicit: narrowing requires an **explicit cast** using the call syntax of the target type:

```
var d: double := 3.9d
var i: integer := integer(d)     // 3 — truncates toward zero (integer(-3.9d) = -3)
var L: long    := long(i)        // explicit widening is available too
var f: float   := float(L)
var b: byte    := byte(i)        // validates the RANGE at runtime:
                                  // outside 0..255 throws RuntimeError (catchable)
```

The numeric casts are `integer(x)`, `long(x)`, `float(x)`, `double(x)` and the narrow ones `byte(x)`, `int8(x)`, `word(x)`, `int16(x)`. `integer(x)` on a float/double *truncates toward zero*; to round, use `floor`, `ceil` or `round`. Casting a literal outside the target type's range is rejected at compile time.

<a id="arrays"></a>
### 4.2 Arrays

An array is an indexable sequence of elements of the same type. BP distinguishes **two variants** depending on whether the size is known at declaration time, and that determines *where* the storage lives.

#### 4.2.1 Fixed-size arrays `T[N]`

A fixed array **is not a reference**: it is storage in place. It lives in the function's frame (a local variable) or inside the object (a `private var` field of a class), and it can only be **indexed** (`buf[i]`, with a range check at run time), **iterated** (`for x in buf`) and **measured** (`len(buf)`). Any other use —assigning it to another variable, passing it to a function, returning it, storing it in a field— is a compile error: there is no reference to hand out, and that is why it can neither escape nor outlive its owner. The size is an **integer literal > 0** and the elements are **primitives** (integers, narrow types, `long`, `float`, `double`, `boolean`; for `string` or classes use `T[]`). A literal initializer may be shorter than N: the rest stays at zero.

| Scope | Where it lives |
|---|---|
| Function local | In the frame: `4 + ⌈N·width/4⌉·4` bytes (the data is rounded up to 4: a `byte[3]` takes 8), zeroed when it is declared. No heap, no GC. |
| Class `private var` field | Inside the object: `1 + ⌈N·width/4⌉` slots (up to 255), zeroed when the object is constructed. Only the class itself indexes it. |
| Module global | **No** (compile error): at module level write `T[]`, with a literal `[…]` or `T[n]`. |

```
public class Media
  private var muestras: integer[8]      // inside the object
  var n: integer := 0                   // how many so far
  public function add(v: integer)
    this.muestras[this.n mod len(this.muestras)] := v
    this.n := this.n + 1
  end add
end Media

function Main()
  var buf: byte[64]                    // in the frame, zeroed
  var mascara: byte[4] := [1, 2, 250]   // the 4th stays at 0
  buf[0] := 42
  print len(buf)                       // 64
  // suma(buf)   ← error: not a reference (copy it into a T[] if it must be passed)
end Main
```

#### 4.2.2 Variable-size arrays `T[]`

The size is decided at run time. The array is allocated on the **heap** (opcode `NEWARRAY`) and referenced through a ref — a 64-bit *handle* with a generation counter, not an address: using an object that was already freed fails on the spot instead of corrupting silently. Managed by the GC.

```
// From a literal: the frontend emits NEWARRAY n + an ASTORE for each element
var primos: integer[] := [2, 3, 5, 7, 11]

// From a function: split, listDir, etc. return arrays
var partes: string[] := split("a,b,c", ",")
var ficheros: string[] := listDir(".")   // sorted; on both VMs and on the board

// With its size: T[n], of any type
var puntos: Punto[] := Punto[10]              // ten slots, set to null
var nombres: string[] := string[n + 1]        // the size is computed at run time
var cuentas: integer[] := integer[n]          // set to zero
```

`T[n]` creates an array of `n` slots of `T`: a class, an interface, an enum, `string` or a number, also with the module in front (`Mod.Punto[n]`). The slots of a number start at zero; those of an object or a string, at `null`. It is an expression, not the fixed array of [§4.2.1](#arrays), which goes in the type (`var v: integer[10]`). It is written like indexing, and what the name is decides it: if there it names something with a value (a variable, a parameter, a field), that wins and it is indexed. In JC it is written `new Punto[10]`, `new int[n]`. An array of arrays does not exist.

The VM uses five physical heap types depending on the element width: `TYPE_ARRAY_I8` (byte/int8 and UTF-8 strings), `TYPE_ARRAY_I16` (word/int16), `TYPE_ARRAY_I32` (integer; also floats, as 4 opaque bytes), `TYPE_ARRAY_I64` (long/double, 8 bytes per element) and `TYPE_ARRAY_REF` (8 bytes per element: object handles, scanned by the GC). The array carries its own length as the first slot. For the narrow widths, a read extends the value to i32 (signed or unsigned according to the type) and a write truncates to the element width.

#### 4.2.3 Access and iteration

Indexed with `arr[i]` (0-based). `for-in` iterates over all elements (see [§7.3](#for)).

```
for n in primos do
  total += n
next n
```

> For **dynamic** collections (grow, shrink, mixed types), use [`List`](referencia.html.md#stdlib-list) or [`OwnerList`](referencia.html.md#stdlib-ownerlist) instead of `T[]`. `T[]` arrays have a fixed size after creation (there is no `append`); `List` resizes internally.

<a id="enums"></a>
### 4.3 Enums

```
public enum Dia
  LUNES               // = 0
  MARTES              // = 1
  MIERCOLES
  JUEVES
  VIERNES
  SABADO := 10          // explicit jump
  DOMINGO             // = 11
end Dia

var d: Dia := Dia.MIERCOLES
```

Enums are symbolic names for `integer` constants. They auto-number from 0 unless assigned explicitly.

An enum is a type of its own, and closed: an integer does not convert into it —`Dia(2)` is a compile error: "'Dia' es un enum: no se llama ni se convierte desde un entero (usa Dia.VALOR)"—. When printed, or in a string, it gives its number: with `d` from above, `print "d=" + d` gives `d=2`, just like `print d` (V7).

The other way round, yes: an enum converts into its integer with the numeric conversion, `integer(d)` (and `long(d)`, `float(d)` or `double(d)`), whether it is a constant, a variable or a parameter: with `d` from above, `integer(d) + 1` gives `3`, and `integer(Dia.SABADO)`, `10` (V8).

**Its name**, with `Enum.getName(d)`: with `d` from above, `MIERCOLES`; and `Enum.getName(Dia.SABADO)`, `SABADO`. It works with the module's enums and with another module's (their names travel in its interface). The compiler resolves it: it writes into the module, once per enum, the function that goes from the value to the name; there is nothing to import (V8, `#778`). In a string, an enum is still its number: `"d=" + d` gives `d=2`, and `"d=" + Enum.getName(d)`, `d=MIERCOLES`.

<a id="clases-tipo"></a>
### 4.4 Classes

Any `class Foo ... end Foo` introduces a type `Foo` usable as a variable, parameter and return type. Refs admit `null`.

<a id="any"></a>
### 4.5 `any`

An internal type, **bidirectionally assignable**: any ref goes in, and any target type accepts an `any` value. You cannot write `any` as a type in BP source.

> **Careful if you come from an earlier version: collections NO LONGER use `any`.** Since V5, `List.add` takes `Object` and `List.get` returns `Object` — and `Object` is **not** bidirectionally assignable: getting an entity out needs an explicit *downcast*.

```
var p: Person := l.get(1)            // V4: fine. Today it does NOT compile.
var p: Person := Person(l.get(1))   // V5: the cast, explicit.
```

The change is deliberate: `any` let anything through and the failure showed up late. With `Object` the compiler makes you say what you expect, and if it is not that, it **fails right there**. For plain values there is a shortcut with no cast — `List`'s typed getters, in the reference.

The cast `Class(x)` goes down from an `Object` or from any ancestor of the class (`Perro(a)` with `a: Animal`); if the value is not of that class, it throws at run time. If the class has a constructor that accepts that argument, the constructor wins. In JC there is no doubt, because what constructs carries `new`: `new Caja(x)` creates an object and `(Caja) x` always converts, whether the constructor accepts `x` or not, and if `x` is already a `Caja`, it stays as it is, as in Java. That conversion cannot be written in BP, and the JC-to-BP translator says so.

A `string` also fits in an `Object` (and so, in a list or in a `Map`), and it is still text: printing it, concatenating it or calling its `toString()` gives its content, as in C#. An object gives its `toString()`, which, if its class does not override it, is its identifier (`object@…`) (V8, #748).

<a id="genericos"></a>
### 4.6 Generics: an order to the compiler

`List<Sensor>` is the usual `List` with an order for the compiler: it tells it what it holds (V8/H8, #793). The class does not change and the VM does not notice. Where the class's signature says its *base type*, `Object` in a `List`, the compiler reads `Sensor`: what goes in has to be a `Sensor`, and what comes out is a `Sensor`, without writing the cast. The same in its children, `SyncList<Sensor>` and `OwnerList<Sensor>`:

```
var sensores: List<Sensor> := List()
sensores.add(Sensor(4))
sensores.add("hola")            // compile error: 'List<Sensor>' holds 'Sensor', not 'string' (add)
print sensores.get(0).valor()        // no cast
for s in sensores do              // s is a Sensor
  print s.valor()
next
```

The compiler writes the cast: it is the one that by hand would be `Sensor(sensores.get(0))`, with the same code. It stays because the compiler sees what goes in through `add`, but not what the class does inside, nor what takes a detour through an `Object` or a plain `List`: if something else arrives there, the program stops on that line with «conversion invalida: el valor no es un 'Sensor'», and it does not corrupt the memory of the object next door.

- **Between `<` and `>` goes a class, an interface or `string`**, as in Java. A number goes in its box: `List<Integer>`. `l.add(5)` and `l.getInteger(0)` work as always, and `l.get(0)` gives an `Integer`. A number in a list costs about 28 bytes (the box, its reference and its handle), and in an array, 4: for many numbers, an array.
- **A `Map` takes two:** the key, `integer` or `string`, and the value. `put` receives the value, and `get` and `valueAt` return it. The key is checked on every call, and the factory has to match it: `Collections.Map()` for the `string` one and `Collections.numericMap()` for the `integer` one.
- **Assigning:** `List<Perro>` does not pass as a `List<Animal>`, as in Java and C#: through that variable a `Gato` would get in among the dogs. The plain `List` mixes with `List<Sensor>` both ways, like Java's raw types.
- **What does not travel:** the list does not know what it holds; `<Sensor>` goes in the declarations, not in the object. If it goes through an `Object` or a plain `List`, it is lost there, and whoever receives it declares it again: `var l: List<Sensor> := otro.dame()`.
- **Between modules:** the type arrives through the interface of the module that declares it, and the cast goes in the one that reads. To use a `Sensor` you have to import its module; to pass the list from hand to hand, you do not.
- **In a `native`:** a cast is not translated, so using the element as a `Sensor` is the same error as writing the cast by hand. Do it outside the native.

A new class is generic if it states its base type with `@element{type}`. It is written and compiled like any other, with that type in its signatures; its children inherit it, and whoever uses it can only ask for something that descends from it:

```
@element{Medida}
public class Bolsa
  public function mete(m: Medida) ...
  public function saca(i: integer): Medida ...
end Bolsa

var b: Bolsa<Metro> := Bolsa()
b.mete(Metro(2))
print b.saca(0).enCm()               // comes out as a Metro
var c: Bolsa<Sensor> := Bolsa()         // compile error: 'Bolsa' holds 'Medida', and 'Sensor' is not one
```

The rule applies to the class's methods and properties; in their signatures, the base type is always the element. There is no `T` variable: inside the class everything is still the base type. A class carries a single type (only `Map` carries two), and a class that inherits does not fix it: `class Sensores extends List<Sensor>` cannot be written. In JC, `new List<Sensor>()` and `foreach (var s in sensores)`, and `new Collections.Map<int, Tarea>()` creates the one with `integer` keys (`Collections.numericMap()`).

<a id="indice-objeto"></a>
### 4.7 An object with an index: `x[i]`

A `property` is two methods: `getP()` and `setP(v)`. With an index, they are the same ones with the index in front, and that is `x[i]` on an object (V8/H8, #794). There is nothing to declare: a class becomes indexable by writing those methods, and the VM does not notice.

| Written | Is |
|---|---|
| `x[i]` | `x.get(i)` |
| `x[i] := v` | `x.set(i, v)` (`x.put(i, v)` in a `Map`, which has no `set`) |
| `x.pin[i]` | `x.getPin(i)` |
| `x.pin[i] := v` | `x.setPin(i, v)` |

```
var sensores: List<Sensor> := List()
sensores.add(Sensor(4))
print sensores[0].valor()          // sensores.get(0), with its cast
sensores[0] := Sensor(5)           // sensores.set(0, …)
sensores[0] := "hola"              // compile error: 'List<Sensor>' holds 'Sensor', not 'string' (set)

var m: Collections.Map<string, Tarea> := Collections.Map()
m["riego"] := Tarea(3)             // m.put("riego", …)
print m["riego"].hora()            // m.get("riego")

class Gpio
  public function getPin(i: integer): boolean ...
  public function setPin(i: integer, v: boolean) ...
end Gpio

gpio.pin[3] := true        // gpio.setPin(3, true)
print gpio.pin[3]            // gpio.getPin(3)
```

- **It is a normal call:** it works with overloads (`t[3]` and `t["a"]`, next to a `get()` without an index), through an interface and through the vtable, and it is checked like any call. Without `get` it is not indexable, and without `set` it is read and not written.
- **It looks like an array and it is not one:** `l[i]` costs what `l.get(i)` does, a little more than twice reading from an array. For a tight loop, an array.
- **`x[i] += e`** reads with `get` and writes with `set`, and the object and the index are computed only once, as in an array.
- **A `property` `pin` can live alongside `getPin(i)`:** `x.pin` is the property, and `x.pin[3]`, the method. What clashes with the accessor is what has its shape: `getPin()` and `setPin(v)`.
- **Inside the class, if there is a field or a property `pin`, `pin[i]` indexes that member**, with `this` or without it: that is what the body of `getPin(i)` writes, which would otherwise call itself. If there is no member `pin`, it is `getPin(i)` too.
- **In a `native`,** `x[i]` is the call, with its bounds, and `x[i] += e` is not translated. `x[i]` does not go in an unpacking.

There is no `x[i, j]`: it is written `x.get(i, j)`. And `s[i]` still does not work on a string.

<a id="declaraciones"></a>
## 5. Declarations

<a id="var"></a>
### 5.1 `var`

```
var nombre: string
var edad:   integer := 30
var total:  long := 0L
var media:  double
var x, y, z: integer                  // multiple names
var pts: integer[100]                  // fixed array (§4.2.1)
var p: Punto := Punto(3, 4)             // class ref
```

**A global variable is always worth what its declaration says.** Globals —module `var`s and properties, and a class's static `var`s and properties— live in the module's constant space: with no initial value they are 0 (or `null`; a `string`, `""`); with a **literal** value (numeric/boolean/string), it is *baked* into the `.mod`, with no startup code, and the variable remains reassignable. Any other initial value —an array literal, a call, an object, an expression— is *computed when the module loads*, in the order they are written, after the modules it imports have been initialized and before its initializer function (the function with the same name as the module), which finds them already set.

A global `string`, a `string` field or a `string` property with no value —that nobody has assigned— is `""` from birth, like Java's `null`: a field has it before any constructor runs, so whatever the parent's constructor gives it (through a method of the child) is not lost; a written `:= ""`, on the other hand, runs after the `super()`, like every initializer (`#776`). It prints and concatenates as `""`, `len` gives 0, `== ""` gives `true` and `charAt(s, 0)` throws the same `RuntimeError` as with `""` ("charAt: idx fuera de rango 0 (len=0)"), the same on both VMs. A global array or an array field with no value is indeed `null`: `len` gives 0 and a `for` over it does not loop at all, but indexing it throws a `RuntimeError` (index out of range), the same on both VMs; and `print` does not show its contents (for one with no value it prints 0).

<a id="string-null"></a>
**A string is never `null`; a `string` variable can be** (`#774`, V8): `var s: string := null` is a variable that references no string, and the same goes for a parameter, a field or what a function returns. With it, as in C#:

- concatenating it and writing it, as `""`: `"x" + s + "y"` is `"xy"`, and `print s` writes an empty line;
- `==` and `!=`: `null` is only equal to `null` (`s == null`, `true`; `s == ""`, `false`);
- a `switch` on it goes to the `default`;
- what needs a string —`len`, `upper`, `charAt`, `substring`, `contains`, `<` and the other ordering operators, `Str.compare`, files, the network, the GUI…— throws a catchable `RuntimeError`, «referencia nula: `len` de un string null» (with the name of the primitive), like a `null` object; and a `null` key in a `Map`, «referencia nula: Map.put con una clave null».

A *local* `string` with no value is neither `null` nor `""`: it is indeterminate, and reading it before giving it a value is a compile error (below). And the literal `null` written as is in a concatenation (`"x" + null`) is still a compile error.

**A local variable is initialized before it is read.** A module `var` with no initializer is 0 (or `null`; a `string`, `""`): it lives in the data block of the `.mod`. A *local* with no initializer has an **indeterminate** value —whatever was on the stack—, so reading it before giving it a value is a **compile error**, with its line. The compiler checks that along *every* path that reaches a read —the branches of an `if`, the `case`s of a `switch`, a `while` that may not run, a `catch`…— the variable already has a value. Declaring it without a value and assigning it later is fine (`#540`, V7). (Since `#799`, V8, both VMs zero the locals on entering a function, so that the collector does not take for live an old reference left on the stack; but the language does not promise it: reading a local with no value is still a compile error.)

```
var total: integer          // no value yet
if n > 0 then
  total := n
else
  total := 0
endif
print total                 // fine: it has a value along both paths
```

<a id="const"></a>
### 5.2 `const`

```
public const PI: float := 3.14159
public const MAX_MS: long := 86400000L
const SALUDO: string := "hello"
const DEBUG: boolean := false
const MIN: integer := -40             // '-' on a literal, OK
```

A module `const` requires a **primitive literal** (integer/float/long/double/boolean/string, with an optional `-`) — the value is inlined at each use, occupies no slot, and public ones travel in the interface so importers inline them too. For a computed value or a non-primitive type, use a `var` assigned in the module's initializer function. It is not assignable in any scope, and there are no const arrays ([§4.2.1](#arrays)).

A `string` `const` is a real string: **it cannot be `null`** (`const NADA: string := null` is a compile error). A constant is a value, not a variable: it references nothing, so it cannot «reference no string» either, just as an `integer` cannot be `null`. A `string` *variable* can ([§5.1](#string-null); `#777`, V8).

<a id="var-owner"></a>
### 5.3 `var owner`

```
var owner r: Recurso := Recurso("db")
// when the function is left —normal end, return or exception— the object is
// DESTROYED (§9.4b): first what it owns, each with its destructor, and then
// the object itself (~Recurso). Several owners die in REVERSE declaration order.
```

A local `var owner` **cannot escape**: it can neither be returned with `return` nor stored in a field or an array (compile error), because once the function is left the object no longer exists. Passing it as an argument is fine (a loan). And to release a resource when leaving a *block*, rather than the function:

```
try var f: IO.TextFile := IO.TextFile("datos.txt", "r")
  while not f.eof() do
    print f.readLine()
  endwh
endtry                // f is destroyed here (~File() closes the file), however you leave
```

`try var` is sugar: the resource is a `var owner` of the enclosing scope and the `finally` releases it; it accepts `catch` and `finally` like any `try` (the resource is released after them). Full detail in [§12 Owner semantics](#owner).

<a id="operadores"></a>
## 6. Operators

| Category | Operators |
|---|---|
| Arithmetic | `+ - * / mod` (with int↔float coercion) |
| Power | `^` — `2 ^ 10` = 1024. `int^int` is exact (integer); `float^int` by squaring; `float^float` via exp·ln (float) |
| Bitwise (integer and long) | `& \| xor shl shr` (there is no bitwise NOT: `x xor -1`; `~` belongs to the destructor, [§9.4b](#destructor)). Between two `boolean`s, `& \| xor` work too, and they evaluate **both sides**: `f() & g()` always calls both, and `f() and g()` skips `g()` if `f()` already gives `false` |
| Comparison | `== != < <= > >=`. Between two strings they compare the **text**: `==` and `!=`, the content; `< <= > >=`, the alphabetical order by code point (that of the UTF-8 bytes: `"Z" < "a"`, `"ab" < "abc"`, `"z" < "ñ"`), like `Str.compare`. With a `string` variable set to `null`, `==` is only equal to another `null`, and ordering throws «referencia nula» ([§ the null variable](#string-null)). Between two objects, `==` and `!=` tell whether they are **the same object**; they work with two of the same type, with an interface, with `null` and with a class and one of its ancestors (`Object` included), as in Java. Two unrelated classes cannot be compared: they could never be the same object |
| Logical | `and or not` |
| Assignment | `:= += -= *= /= mod= &= \|= xor= shl= shr=` (the compound ones, below) |
| Ternary | `iif(condition, a, b)`: the value of `a` if the condition holds, and otherwise that of `b`; only the one that applies is evaluated (below) |
| Access | `.` (member) `[]` (index) `()` (call) |
| Type test | `x instanceof Foo` |
| String | `+` concatenates: it turns primitives, enums (their number) and objects (`toString()`) into text; an array, a tuple, the `null` literal or a call with no value have no conversion, and it is a compile error ("no hay conversión a string") |

Precedence (lowest to highest): `or` < `and` < `not` < comparison < bit-or < bit-xor < bit-and < shift < `+ -` < `* / mod` < unary < `^`. Power is **right-associative** (`2 ^ 2 ^ 3` = `2 ^ (2 ^ 3)` = 256) and binds tighter than unary: `-x ^ 2` = `-(x ^ 2)`.

<a id="compuestos"></a>
### 6.1 Compound assignments

`x op= e` is `x := x op e`, with `x` evaluated **once** (`a[f()] += 5` calls `f` once). The word ones are written joined: `x mod= 3`, `xor=`, `shl=`, `shr=`. The types, as in C#: the operation is done in the type of `x op e`; if the result does not fit on its own in that of `x`, it is only valid if `e` would fit on its own in `x` (or it is a shift), and then the result is cut down to the size of `x`, wrapping around. Anything else is an error: nothing is lost silently.

```
var b: byte := 255
b += 1                    // 0: a byte operates in integer and keeps its size
var l: long := 1
l shl= 40                 // 1099511627776
var s: string := "n="
s += 5                    // "n=5": '+' concatenates
var i: integer := 3
i *= 1.5                  // compile error: integer * float gives float, which does not fit on its own in integer
i := integer(i * 1.5)     // 4: the conversion, written out
```

<a id="iif"></a>
### 6.2 The ternary, `iif`

`iif(condition, a, b)` is the value of `a` if the condition holds, and otherwise that of `b`. It has the shape of a function, but **only the one that applies is evaluated**, like C#'s `c ? a : b` (and that is how it is written in JC): with `p` null, the line below does not fail, and a recursive `fib` with `iif` terminates. Its type is that of the two branches: the same one; or numbers, and the widest wins; or `null` and a reference; or a class and its child, and the parent wins; or a class and one of its interfaces, and the interface wins. Two classes that only share an interface have no common type: the conversion is written in one branch, `iif(c, B2(), IA(B1()))`, as in C# (`c ? new B2() : (IA) new B1()`).

```
var nombre: string := iif(p != null, p.nombre, "nadie")
return iif(n < 2, n, fib(n - 1) + fib(n - 2))
```

It is a value, not a statement (to choose what to do, an `if`); a local `var owner` cannot be a branch (the ternary does not move an owner: an `if` does); and the name belongs to the language: a function cannot be called `iif`.

<a id="control"></a>
## 7. Control flow

<a id="if"></a>
### 7.1 `if / elseif / else`

```
if edad < 18 then
  print "under age"
elseif edad < 65 then
  print "adult"
else
  print "senior"
endif
```

With a single statement, the `if` fits on one line: `if c then statement`, with no `endif` (writing one after it is an error, which the compiler names). The same goes for `while c do statement` and `for … do statement`, with no `endwh` or `next`. They can go anywhere in a block, also as the last statement of a block of their own kind (`#701`, V8).

<a id="while"></a>
### 7.2 `while / do`

```
while i < n do
  total := total + i
  i := i + 1
endwh

do
  i := i + 1
loop i < 100           // do-while: the body runs at least once; keeps going while the condition holds

do
  i := i + 1
  if i > 105 then break
loop                    // no condition: infinite loop, leave it with break
```

The loop with the condition at the end closes with `loop [condition]` (there is no `do … while`).

<a id="for"></a>
### 7.3 `for`

Two variants: numeric and foreach (`for-in`).

```
// Numeric: i := from to to [step]
for i := 0 to 9 do
  print i
next i

for i := 1 to 10 step 3 do
  print i                // 1 4 7 10
next i

// Foreach over an array (fixed or variable, any element type)
var primos: integer[] := [2, 3, 5, 7, 11]
for n in primos do
  total += n
next n

// …and over a List: each element, an Object
var l: List<Object> := List()
l.add("uno")
l.add(2)
for x in l do
  print x                // uno, 2
next x
```

Over a `List` (also `SyncList` and `OwnerList`), the variable is an `Object`; the list is measured **once**, on entry, like the limit of a numeric `for`: what the body adds is not visited, and if the body shortens it, `get` gives its index error.

The body closes with `next [name]` (not `endfor`); the name after `next` is optional and, if present, must match the iteration variable (documentation use).

`step` is a signed `integer`: a constant (`step -1` counts downwards) or an expression, which is evaluated only once before entering; if the step is negative the loop goes on while `i >= to`. A written `step 0` is a compile error.

<a id="switch"></a>
### 7.4 `switch`

```
switch dia
  case Dia.SABADO, Dia.DOMINGO
    print "weekend"
  case Dia.LUNES
    print "back to work"
  default
    print "weekday"
endsw
```

The subject is an **integer** (`integer`, `long`, `byte`…), a `boolean`, an **enum** or a **string**, which is compared by its *content*. A `case` may list several values, and each one is its own block: there is no fall-through. A real (`float`/`double`) or an object as the subject is a compile error —exact equality of reals is a trap, and comparing references is a job for `if`— (`#546`, V7).

```
switch command
  case "ls", "dir"
    list()
  case "cd"
    change()
  default
    print "unknown: " + command
endsw
```

<a id="breakcont"></a>
### 7.5 `break` / `continue`

A loop can carry a name, and `break` and `continue` can name one of the loops that are open, to leave several loops at once or to carry on with the outer one. The name goes after the loop's `do`, alone on the line: `do fuera`, `while c do fuera`, `for i := 1 to 3 do fuera`. They are not labels and there is no `goto`: the name is only seen inside its loop, and two open loops cannot have the same name. It closes the `try`s in between and runs their `finally`s; there is no leaving a `finally`. In JC, after the loop's word: `do fuera { … } while (c);`, `while fuera (c) { … }`, `for fuera (…) { … }`, `foreach fuera (…) { … }`; and `break fuera;`. With `do … loop false`, the loop is a block you leave with `break`: it goes round only once.

```
do fuera
  for i := 1 to 3 do
    if tabla[i] == buscado then
      break fuera              // leaves the for and the do
    endif
  next i
loop false
```

`break` leaves the nearest enclosing `while`, `do`, `for` or `switch`; `continue` jumps to the next iteration of the nearest loop (a `switch` is not a loop: a `continue` inside a `case` goes on with the loop around it). The next iteration of a `for` starts with its step, and that of a `do … loop c` with its condition: if `c` no longer holds, the loop ends, as in C (`#699`, V8).

<a id="parallel"></a>
### 7.6 `parallel` / `endpar`

Syntactic sugar for starting several threads without writing a subclass of [`Thread`](referencia.html.md#stdlib-thread) for each one. Each `case` introduces a thread whose body is the block's body; the `default` (optional) runs on the calling thread between the `start()`s and the `join()`s; after `endpar` all threads are joined.

```
function main(arg: string)
  parallel
    case t1 := Thread(2048)
      var r: integer := sumaRango(1, 10000)
      print "t1 = " + intToString(r)

    case t2 := Thread(2048)
      var r: integer := sumaRango(10001, 20000)
      print "t2 = " + intToString(r)

    default
      // runs on the calling thread; sees its locals and globals
      print "default while t1/t2 work"
  endpar
  print "all joined"
end main
```

Conceptually equivalent to the long pattern (`class W extends Thread …; W().start(); W().join()`), but the compiler synthesizes an anonymous subclass of Thread for each `case`, with the case body as its `run()`. The variables `t1`, `t2`, … are visible in the enclosing scope **after** `endpar`: they are already joined and can be inspected.

The first token after `:=` must be literally `Thread` with an integer argument (the worker's stack). For thread-owned state with fields, use the classic Thread-subclass pattern.

**Visibility rules** for the `case` body (object encapsulation — see [14.3](#conc-encapsulacion)):

| Symbol | Visible |
|---|---|
| Locals declared in the body itself | ✓ |
| stdlib (`print`, `intToString`, `yield()`, `Mutex`, ...) | ✓ |
| Module classes, functions, `const`s | ✓ |
| Module global variables (`var`) | ✗ semantic error |
| Locals of the enclosing scope | ✗ "unresolved identifier" |

The `default` block, in contrast, runs in the enclosing scope and sees EVERYTHING: locals, globals, etc. For branches to coordinate, they share state via objects ([Mutex](referencia.html.md#stdlib-mutex), `List`, shared classes).

<a id="funciones"></a>
## 8. Functions

```
public function suma(a: integer, b: integer): integer
  return a + b
end suma

function imprimir(msg: string)        // no ': T' → void
  print msg
end imprimir
```

- `public` → exported in the interface, callable cross-library.
- By default, functions are private to the module.
- The return type is declared with `: T` after the parentheses. If omitted, the function is `void`.
- Returning is done only with `return [value]`. With no explicit return, void.

<a id="defaults"></a>
### 8.1 Default parameter values

```
public function label(text: string, prefix: string := "[", suffix: string := "]"): string
  return prefix + text + suffix
end label

label("hi")              // "[hi]"
label("hi", "<")         // "<hi]"
label("hi", "<", ">")    // "<hi>"
```

A parameter with `:= value` is optional at the call site. Rules:

- The default value must be a **constant literal** (numeric, string, boolean).
- Parameters with defaults go **at the end** of the list; arguments are filled by position.
- The default is *substituted at the caller* at compile time (zero cost in the VM) and travels in the interface: it works the same way when calling functions from another library.

<a id="param-var"></a>
### 8.1b `var` parameters

```
function suma(var n: integer, m: integer)
  n += m                          // reads and writes the property it was given
end suma

var c: Contador := Contador()
suma(c::valor, 5)              // c.valor goes up by 5
```

A `var` parameter does not receive a value but a **property of an object**, passed as `object::property`: reading the parameter reads the property (its getter), and assigning to it writes it (its setter). It is C#'s `ref`, but only with properties: there are no references to variables, which this VM does not have. In JC: `void suma(var int n, int m)` and the same call.

- It takes `object::property`, or another `var` parameter by its name, passed as is. A variable, a field, an array element or `object.property` (its value) are compile errors.
- The property has the **same type** as the parameter, any type, and the caller must be able to read and write it. With a string or an object, it changes what the property points to, not the text or the object.
- The object is evaluated once, at the call. Inside, each read calls the getter and each assignment the setter; `n += m`, one of each.
- No default value, and no overloads that differ only in `var`. Not in a constructor, an event or a `native`.
- Not yet: module and static properties (they have no object), an object declared as an interface, an `owner` property, and MOD8.

Inside, two values travel: the object and a `long` with the slots of the getter and the setter, the way an event keeps its receiver and its method. No new objects and no change to the VM.

<a id="tuplas"></a>
### 8.2 Tuples (multiple return)

```
// A function can return SEVERAL values: a tuple type (T1, T2, ...)
function divmod(a: integer, b: integer): (integer, integer)
  return (a / b, a mod b)
end divmod

// Unpacking with { ... } := onto already-declared lvalues
var q: integer := 0
var r: integer := 0
{ q, r } := divmod(17, 5)        // q=3, r=2
```

Tuples are **first-class**: besides being unpacked on the fly, they can be stored in a variable, passed as a parameter and returned in stored form. The unpacking targets can be any lvalues, not just variables:

```
var t: (integer, string) := pair()   // store the tuple
{ n, s } := t                          // ... and unpack it later

{ arr[0], arr[1] } := coords()        // into array elements
{ p.x, p.y } := coords()               // into object fields
```

A tuple is not printed directly (`print t` is an error): unpack it first. The targets of `{ ... } :=` must already exist (it does not declare variables). And a tuple **does not go into a collection**: `List.add` takes `Object` and a tuple is not one ([§4.5](#any)); wrap it in a small class if you need it in a list.

<a id="funciones-native"></a>
### 8.3 `native` functions (AOT)

A function marked `native function` is a candidate for **AOT compilation** (Ahead-Of-Time): besides the normal bytecode, the compiler can translate it to native C for the micro, which runs directly (without the interpreter loop) to speed up hot compute kernels.

```
native function sumaCuadrados(n: integer): integer
  var s: integer := 0
  var i: integer := 1
  while i <= n do
    s := s + i * i
    i := i + 1
  endwh
  return s
end sumaCuadrados
```

- **Additive**: the `.mod` ALWAYS contains the function's bytecode. The native code travels **inside the same `.mod`** (its `native` section; there is no longer a separate application `.mdn`) and the runtime uses it if it matches the micro's architecture and its firmware's version (its ABI); otherwise the function runs interpreted —one from another version, such as that of a V6 `.mod`, is rejected with a warning—. Not compiling the AOT never breaks the program.
- **Per-platform behavior**:

  | Platform | `native` function |
  |---|---|
  | Raspberry Pi Pico 2 / Metro (RP2350, ARM Cortex-M33) | AOT-accelerated (≈40–90× on integer kernels). |
  | STM32 (Nucleo-U575, Discovery U5G9J; ARM Cortex-M33) | AOT-accelerated — same Thumb-2 code as the RP2350 (≈45× measured on an LZSS kernel on-board). |
  | ESP32-P4 (RISC-V with FPU) | AOT-accelerated (target `riscv` —`riscv32-esp-p4`—, since V4). |
  | ESP32-C5 / ESP32-C3 / ESP32-C6 (RISC-V without FPU) | AOT-accelerated (target `riscv-imc`, `ilp32` ABI, since V7; tested on the board on the C5, the C3 and the C6). Without an FPU, every `float` operation is done by the firmware —the same routine the interpreter uses—: the result is exactly the same, but it speeds up less than integer code. |
  | ESP32-S3 (Xtensa LX7) | Interpreted — same semantics, no speedup. The AOT emits ARM and RISC-V, not Xtensa; no date, outside the plan. |
  | PC VM (host) | Interpreted (there is a host AOT path for testing only). |
- **Supported subset**: functions and methods over primitives (`integer`, `long`, `float`, `double`, `boolean`, narrow types), `string`, arrays of any element type (create them with `T[n]` or a literal, and index them), objects, module variables, the narrowing conversions (`byte(x)`, `int16(x)`…, with the interpreter's range and message) and **any intrinsic function** of the stdlib —`Math.sin`, `sqrt`, `startsWith`, `sleep`…, those whose body is `inline CALL_BUILTIN` (§8.3b)—: the native calls the SAME builtin code as the interpreter, so the result is the same. A runtime failure (index out of range, null reference) or a `throw RuntimeError("…")` inside the native propagates to the `try/catch` that wraps it —since V7, also one INSIDE the native itself, with its `catch` by class and its `finally`—, with the interpreter's message (the exact line inside the native, not yet). What still does NOT fit — `try var` (the resource the block releases) inside the native, tuples with `float`, `long` or `double` fields (the others do fit, since V7), `instanceof`, events, `parallel`, `for … in`, **reading or writing fields** (own or inherited: use a getter), **calling static methods or properties**, `super` and `Heap.compact()` — is rejected by the compiler with its message and the line. Local fixed arrays `type[N]` are not supported either (compile error): use `var v: type[] := type[n]`. The same goes for a `native` *class method*: it is the same error, naming the method and the line (`#519`, V7). The live detail is in `docs/AOT_LIMITES.md`.
- **A native behaves like one more thread** (V7): if it calls something that blocks —`sleep`, `lock()` on a busy `Mutex`, a BP function that waits— it **is suspended** and the other threads carry on; in a long computation it **yields its turn** every 5 ms —it checks in its loops: on every iteration of a loop that calls something, through a mark the board's clock raises every 5 ms, so it yields in time even if each iteration is slow; and every 1024 iterations in a loop without calls, whose iterations are short by force—, and the IDE's **Stop** halts it even inside an infinite loop. A **recursion counts as a loop**: a native that calls itself —or another one that calls it back— checks on entry, every 1024 calls, so it also yields and stops even without loops. Inside, it runs on a thread of its own on the platform and passes the baton back and forth with the interpreter; a native that cannot yield (no loops, no recursion and no calls that block) runs directly, without that step.
- **Speed and `double`**: none of the boards has a double-precision FPU, so a `double` in a native is emulated by the firmware and speeds up much less than integer code. Measured on an ESP32-C3 (no FPU) with the same loop native and interpreted: with integers, about 100 times faster; with `double`, 5 times (307 ms against 1609); with `float`, which is emulated there too, almost 6 (200 against 1141). The floor is set by the emulation, not by the interpreter. If you want speed on the micro, use `float`: the boards with a single-precision FPU (Cortex-M33, ESP32-P4) do it with one instruction.
- **Debugging**: on the PC a native runs interpreted and is debugged like any other function; on the board, the debugger **does not stop inside it** (it runs as machine code), and the IDE says so when you set a breakpoint inside one. To step through it on the board, **remove `native`**: that is how you verify the algorithm; put it back once it works. What you debug is the algorithm; that the translation to C gives the same as the interpreter is the compiler's job, and its tests watch it (each native against its interpreted version, and each board against the PC).
- **Calling normal BP functions from a native** is possible (the bridge exists), but it crosses back into the interpreter: the speed gained is lost on every crossing. The compiler detects this and emits a **performance warning**. If that function blocks, the native is suspended along with it.
- **How the native code is generated**: the IDE does it **automatically** on *Run on Device*, according to the connected board: for RP2350/STM32 it detects the **ARM bare-metal toolchain** (`arm-none-eabi-gcc` — a standard install of the *Arm GNU Toolchain* or on the `PATH`; set manually in *Project → AOT (toolchain)…*; installation: [IDE Guide §5.1](guia-ide.html.md#aot)); for the RISC-V ESP32s (the P4, the C3, the C5 and the C6), the `riscv32-esp-elf-gcc` of the ESP-IDF install. It emits C, compiles PIC code and **merges it into the `.mod`** (into its `native` section) before uploading. If there is no toolchain, it **warns and the program runs interpreted**. The step can also be done by hand (`AotMain` emits C → the target's gcc → `MdnPack` packages it; the `bpgenvm-c/pico/build_mdn.sh` script chains the three for ARM).

<a id="inline"></a>
### 8.3b Intrinsic functions: the `inline` body

An **intrinsic** is a normal function whose body is written bytecode, one instruction per line, like Turbo Pascal's `inline($CD/$21)`:

```
public function sin(x: float): float
  inline CALL_BUILTIN 24
end sin
```

The compiler generates no code for it in the `.mod`: at each call it inserts that bytecode as is, with the arguments already on the stack (the mnemonic is the one in `docs/OPCODES.md`; the number, the builtin's id in both VMs). That is how the functions of `Math` are written, and their signature travels in the module's interface like any other. It is the syntax of the standard library and of the root module; a normal program does not need it.

<a id="sobrecarga"></a>
### 8.4 Function overloading

You can declare **several functions with the same name** as long as they differ in their **parameters**. The compiler picks the one that fits each call.

```
public function texto(n: integer): string
  return "int:" + intToString(n)
end texto

public function texto(s: string): string          // different TYPE
  return "str:" + s
end texto

public function texto(n: integer, veces: integer): string   // different COUNT
  ...
end texto
```

It works with **free functions**, **static methods**, **instance methods** and **constructors**. And also **across modules**: importing `Fmt` makes the three `Fmt.texto(...)` above available, resolved the same way — and since V7 also the overloads of **constructors** (`Lib.Punto(1, 2)` and `Lib.Punto()`, with `super(...)` picking by signature) and of **static methods** ([§9.6](#static)).

#### Which one it picks: the most specific

If several fit, the **most specific** one wins: the one that could be passed to all the others, as in Java. It is the same order as that of the `catch`es ([§11](#excepciones)): `catch e: Animal` goes before `catch e: Object`, because an `Animal` is also an `Object`. Here the compiler does the ordering and the call comes out already chosen: the virtual machine decides nothing (V8, `#772`).

```
function mete(o: Object): string ...
function mete(a: Animal): string ...
function foo(s: string): string ...
function foo(o: Object): string ...
function g(x: integer): string ...
function g(x: long): string ...

var p: Perro := Perro()      // Perro extends Animal
print mete(p)                // mete(Animal): an Animal can be passed where an Object goes
print foo(null)              // foo(string): a string, where an Object goes
var b: byte := 5
print g(b)                   // g(integer): an integer, where a long goes
var o: Object := p
print mete(o)                // mete(Object): to pick another one, a variable of its parameter's type
```

If none is more specific than the others, the call is **ambiguous**, and the compiler says which ones compete. It happens even if one «climbs» less in total: `h(Perro, Object)` and `h(Animal, Animal)` with `(Perro, Perro)` is ambiguous too, as in Java and C#.

```
function f(a: Perro, b: Object) ...
function f(a: Object, b: Perro) ...

f(p, p)
```

```
error semántico: llamada ambigua a 'f' con (Perro, Perro): encajan f(Perro, Object) y f(Object, Perro), y ninguna es más específica que las otras; para elegir una, pasa el argumento en una variable del tipo de su parámetro
```

#### What tells one overload from another

Only **the parameter list** (count and types). **The return type does NOT count**: two functions differing only in what they return are the same one to the compiler.

```
function g(a: integer): integer ...
function g(a: integer): string  ...   // ERROR
```

```
error semántico: sobrecarga duplicada: 'g' con la misma firma de parámetros ya declarada
```

The reason is that at the call site there is not always an expected type to decide with: `print g(1)` does not say which of the two you want.

#### Overloading and visibility

As in Java and C#, what cannot be seen from where the call is made is not a candidate: a `private` or protected overload does not compete from outside, and the choice is made among the visible ones. If the only one that fits cannot be seen, it is an error that says so (V8/H8, #796).

#### Overloading and inheritance: overriding one does NOT hide the others

If a subclass overrides *one* of the inherited overloads, the others are still there:

```
class Base
  public function saluda(): string ... // "base"
  public function saluda(n: integer): string ... // "base N"
end Base

class Hija extends Base
  public function saluda(): string ... // "hija" — overrides only THIS one
end Hija

var h: Hija := Hija()
print h.saluda() + " / " + h.saluda(7)   // -> hija / base 7
```

That is: the override replaces the version *with that same signature*, and the `(integer)` one is inherited untouched.

#### Careful when mixing it with default values

An overload and a [parameter with a default value](#defaults) can end up accepting the **same call**. With the same types in what the call gives, the one that **fills in fewer default values** wins: `h(1)` is the one with one parameter.

```
function h(a: integer): integer ...
function h(a: integer, b: integer := 0): integer ...

h(1)    // both fit: h(a), the other one would have to fill in b
```

Even so, the clean way out is usually to keep just one of the two forms: **either** overloads **or** a default value, but not both covering the same case.

<a id="clases"></a>
## 9. Classes

```
public class Persona
  var nombre: string   // a field is NEVER public
  var edad:   integer

  public function Persona(nombre: string, edad: integer)
    this.nombre := nombre
    this.edad   := edad
  end Persona

  public function saludar(): string
    return "Hi, I'm " + this.nombre
  end saludar
end Persona
```

<a id="campos"></a>
### 9.1 Fields

A `var` inside the class declares an instance field, and a field is **never public**: it is read and written through `this.field` inside the class (and its descendants, below), and is not touched from outside. Marking a field `public` is a **compile error**, and the message points you at the right alternative: `public property` (§9.5), which exposes a get/set and keeps the backing field private. The reason is by design: what crosses the module boundary is a *contract*, not the internal representation.

A field may be a fixed-size array `type[N]` if it is `private var`: it lives inside the object and only the class itself indexes it ([§4.2.1](#arrays)). If it has to be seen or passed, declare `type[]` and initialize it in the constructor with `type[n]`. A field is *protected* (or `private`): its class and its descendants see it, also those in another module — since V7 the interface publishes the non-private fields with their slot ([§9.2.1](#visibilidad)); to expose a value to *anyone*, use a `property`.

**Initializers.** An instance field (or property) may carry `:= value`: `var n: integer := 5`, `var s: string := "hola"`, `public property etiqueta: string := "sin nombre"`. They run *once* per object, in declaration order, inside the constructor right after the `super(...)` (written or implicit) and before its body — as in Java. The `""` of a `string` with no value is not an initializer: it is its value from birth, and it is already there before the `super(...)`, like Java's `null` ([§5.1](#var)). A class with initializers and no constructor gets one that runs them: with no arguments or, if its parent has a constructor, one per overload of the parent's, with the same parameters, which it passes on with `super(...)` —so it is still constructed the same way: `Tarea(4096)` with `Tarea extends Thread`—. The value is any expression (a literal, a construction, a call), but it cannot use `this` or other fields: that is what the constructor is for.

**The limit of a class.** A class takes up to 256 methods (counting the inherited ones and its properties' accessors) and 256 field slots (a reference, a `long` or a `double` take two). Going over is a compile error, with the class's line.

<a id="metodos"></a>
### 9.2 Methods

Like functions but inside the class. The implicit parameter `this` points to the instance. Non-static methods are virtual (dynamic dispatch via vtable) **except the `private` ones**, which are called directly — see [9.2.1](#visibilidad).

<a id="visibilidad"></a>
#### 9.2.1 Visibility: the three levels

A class member has one of three levels. The middle one is what you get *without writing anything*, because when building a hierarchy the normal case is that the child can use what the parent has:

| You write | Who sees it | Virtual? |
|---|---|---|
| `public` | Everyone | Yes |
| *(nothing)* — **protected** | Its class and its descendants, even in another module (methods and properties and, since V7, *fields* too) | Yes |
| `private` | Only its own class | **No** |

```
public class Base
  public function Base()
  end Base

  public function saluda(): string      // anyone sees it
    return this.adorna(this.crudo())
  end saluda

  function adorna(s: string): string    // PROTECTED: the child may use it
    return "<< " + s + " >>"
  end adorna

  private function crudo(): string      // only this class, not even the child
    return "hola"
  end crudo
end Base
```

**There is no `virtual` keyword, and none is needed:** everything except `private` is virtual. A protected method goes into the method table just like a public one — the difference between them is *who may name it*, not how it is called or what it costs.

**On another object, what is protected can be used if the object is of the class that uses it or of one of its children** (V8, `#760`; the rule of Java and C#). From `Perro`, the field `edad` of `Animal` is read on `this`, on another `Perro` or on a `Cachorro`, which is also a dog; on an object that is only an `Animal` —it could be a `Gato`— it is not: you ask for it through a public property of its own.

```
class Perro extends Animal
  function mayorQue(otro: Cachorro, a: Animal): boolean
    return this.edad > otro.edad    // fine: a Cachorro is a Perro
    // a.edad                        // compile error: an Animal may be a Gato
  end mayorQue
end Perro
```

`private` only makes sense inside a class: at module level, whatever is not `public` is already private to the module, and there are no descendants to protect from. And `public private` does not exist: they are mutually exclusive.

**When choosing:** use `private` when you want to be able to change or delete that method without checking who inherits from the class. If you leave it unmarked, a child —yours or one written by whoever uses your library— may be relying on it.

**Across modules** (since V7): a child declared in another module sees exactly what a same-module child sees — the protected methods, properties and **fields** of its base (`this.nombre` works), with `final` and `private` honoured. The one place where an inherited field still cannot be read is inside a `native` function ([§8.3](#funciones-native)): use a getter there.

<a id="ctor"></a>
### 9.3 Constructor

A function with the same name as the class. It runs when you do `ClassName(args)`. **The first line of the constructor says how the object is built**, and there are three forms:

- **Nothing** — implicit `super()` (Java model): if the class has a base, the compiler *injects* the call to the parent's parameterless constructor. If the parent's constructor *has* parameters, even with default values, the explicit call is mandatory (compile error if missing): the constructor a class defines is its official constructor, and a child that defines its own calls the parent's with its parameters. A child *without* a constructor is built with the parent's (see «Initializers»). If the parent has no constructor, there is nothing to call.
- **`super(args)`** — the parent through that constructor; it must be the first statement. Towards a parent with no constructor —`Object`, that of every class with no parent written, or a class that does not declare one—, `super()` is valid and does nothing, like the implicit one; with arguments, it is a compile error.
- **`ClassName(args)`** — *delegation*: this same object is initialized by that other overload of the constructor (which in turn does its `super` and the initializers), and then the body goes on. Only as the first statement: anywhere else `ClassName(args)` is a new object, as always. A constructor cannot delegate to itself or in a cycle, nor delegate and also call `super(...)`.

The [initializers](#campos) of fields and properties run after the `super` and before the body, in the constructor that does the `super`; the one that delegates does not repeat them.

**Visibility.** That of any member: `private` is private (only the class itself constructs it or delegates to it), `public` is public, and saying nothing makes it *protected*: the class and its subclasses use it (from `super(...)` or by constructing it), also those in another module, but not just anyone. A non-public constructor of a public class travels in the interface with its mark, and it is the module that uses it that gets the error.

<a id="herencia"></a>
### 9.4 Inheritance

```
public class Animal
  var nombre: string
  public function Animal(nombre: string)
    this.nombre := nombre
  end Animal
  public function hablar()
    print "..."
  end hablar
end Animal

public class Perro extends Animal
  public function Perro(nombre: string)
    super(nombre)
  end Perro
  public function hablar()
    print this.nombre + " says woof"
  end hablar
end Perro
```

Single inheritance. `super.method(args)` explicitly invokes the parent's method inside an override, and `super.prop` reads or writes its property ([§9.5](#props)). Inheritance also works **cross-module**: the base class can come from another imported library (vtable, protected fields, statics and `super(...)` by signature included: [§9.2.1](#visibilidad) and [§9.6](#static)). `x instanceof Foo` checks the dynamic type at runtime, and `Foo` can be any class, also one from another module (`o instanceof Lib.Base`, `e instanceof RuntimeError`; since V7).

**The root.** A class with no `extends` descends from `Object` (`toString()`, `compareTo(other)`), which is a class written in BasicPlus in `Core.bp`, like `Thread`, `Mutex` and `StringBuilder` ([§10.0](#raiz)). `Object` and `Thread` are declared there as `public root class`: a *root class* descends from nothing — that is why a `Thread` is not an `Object`: its `run()` has to be the first method of its table, which is what the VM starts. `root` can only be written in `Core`; in any other module it is an error.

<a id="destructor"></a>
### 9.4b The destructor: `~Class()`

```
public class Valvula
  var pin: integer := -1               // -1: no pin yet
  public function Valvula(pin: integer)
    Gpio.init(pin, Gpio.OUTPUT())
    Gpio.write(pin, 1)                 // opens
    this.pin := pin                    // now it is its own: noted at the end
  end Valvula
  public function ~Valvula()           // the opposite of the constructor
    if this.pin >= 0 then
      Gpio.write(this.pin, 0)        // closes
      Gpio.release(this.pin)          // and the pin goes back to how it was
    endif
  end ~Valvula
end Valvula
```

"What destroying this means" is written **once**, in the class, and not at every place where it is used. The destructor is named like its class, takes no parameters and returns nothing, and **the language calls it**, never the code, **every time the object is freed, whoever frees it** (V7, `#668`): when its owner dies —a local `var owner` when it leaves its scope, when it is reassigned or when a `try var` ends ([§5.3](#var-owner)); an `owner` field when it is reassigned or when the object holding it is destroyed—; when the GC collects it because nobody reaches it any more (it runs shortly after, between two scheduler turns); and when the program ends —also after an error or a STOP—, everything still alive that has a destructor, newest first (with a 3 s cap), so that everything goes back to how it was. It is virtual: the one of the object's real class runs, and when a child's finishes, its parent's runs. Every class has one (`Object` declares it empty in `Core.bp`): it is only overridden when there is an external resource to release — a descriptor, a query, a mutex, a pin.

**The order**: first what the object owns —its `owner` fields, and theirs, from the last to the first— and then the object itself; so **in its destructor, its `owner` fields are already `null`**. A destructor is normal code: it can wait, touch the GUI or `join` a thread. And if it throws an exception, that is reported (through the diagnostics, with the class) and the cleanup goes on with the others: a destructor that fails leaves nothing undestroyed.

**A library resource, in an `owner` field**: the device classes (`Pwm.Slice`, `Gpio.Pin`, `Uart.Port`…) already release what is theirs in their destructor (V7, `#667`, [Reference §14.1](referencia.html.md#stdlib-hw-soltar)), so a class that uses them needs no destructor: theirs dies with it, before it.

```
public class Motor
  var owner pwm: Pwm.Slice
  public function Motor(pin: integer)
    this.pwm := Pwm.Slice(pin, 20000)   // when the Motor dies, ~Slice stops the PWM
  end Motor
end Motor
```

**An object whose constructor threw is destroyed too**: it already exists in memory, and the GC (or the end of the program) collects it. A class that takes the resource itself, with a module's functions, has to release in its destructor *only what is its own*: it notes it at the end of the constructor, once it has it, and releases it once —that is what the library classes do, and what `Valvula` does with its `pin`: if `Gpio.init` throws, it stays at -1 and its destructor touches nothing—.

<a id="props"></a>
### 9.5 Properties

```
public class Punto
  var _x: integer
  public property x: integer
    get
      return this._x
    endget
    set(v)
      if v < 0 then
        throw RuntimeError("negative")
      endif
      this._x := v
    endset
  endprop
end Punto

// Short form: backing field + trivial getter/setter auto-generated
public property y: integer
```

A `property` synthesizes a backing field and two methods `getX`/`setX`. From code it is accessed like a field (`p.x`, `p.x := 5`).

Inside its `get`/`set`, `field` is that backing field, with the property's type: whatever is assigned to it is converted as in any assignment (`field := 7` in a `long` property), and assigning another type is a compile error (`#547`, V7).

```
public property nivel: long
  set(v)
    field := v * 2             // stores twice the value
  endset
endprop
```

A subclass can **redeclare** a property of its parent: it is an override —its accessors are virtual and the child brings its own backing field—, so the parent's code that reads it sees the child's. It works the same with a parent in the same module as in another (`#529`, V7). From the child, `super.prop` reads and writes the parent's, just as `super.m()` calls its method (also `super.prop += 1`; `#744`, V8).

#### sync properties (thread-safe)

```
public class Account
  public sync property balance: integer
  public function Account(initial: integer)
    this.balance := initial
  end Account
end Account
```

The `sync` modifier before `property` wraps the auto-generated getter and setter with `lock()` / `unlock()` against a `Mutex` shared per instance. The compiler:

- Automatically declares a hidden field `__syncMutex` (inherited by subclasses — it is declared only once, in the first link of the hierarchy that needs sync).
- Initializes it with `Mutex()` on entering the constructor. If the class has no constructor of its own, gives it its constructors, as with the [initializers](#campos): one per overload of the parent's constructor, with the same parameters (passed on with `super(...)`), or one with no arguments if the parent has none.
- Inserts `this.__syncMutex.lock()` at the start and `this.__syncMutex.unlock()` at the end of each `getX`/`setX`.

**Guarantees**: each individual access to the backing field is atomic with respect to other threads. A read never returns a partial state; a write is indivisible.

**Important**: a compound expression such as `this.value := this.value + 1` is NOT atomic as a whole — it decomposes into get + add + set, each individually atomic, but another thread can slip in between them. For compound atomic operations, use an explicit [`Mutex`](referencia.html.md#stdlib-mutex) around the block.

A `return` inside the custom body of a sync get/set correctly releases the mutex: the emitter injects the `unlock` before the jump to the exit point (no explicit try/finally is needed in BP). And an exception leaving the body —a `throw`, or an error inside a function it calls— releases it too before going on its way (V7). The same applies to module-level sync properties.

#### Module-level properties

```
module Counter
  // A public module property. The state lives in a private
  // global, accessible from outside ONLY through the get/set.
  public property tick: integer
  public function bump()
    tick := tick + 1
  end bump
end Counter

module App
  import Counter
  function main(arg: string)
    Counter.bump()
    print Counter.tick           // cross-module read → 1
    Counter.tick := 42          // cross-module write
  end main
end App
```

BP also lets you declare a `property` outside a class, at module level. It is the canonical way to expose mutable state to other modules: module `var`s are private by design (they are not exported in the interface), but a `public property` exposes its synthetic getter/setter, accessible via `Module.name` from another module that imports it.

Internally the compiler emits:

- A private global `__prop_<name>` that is the backing field.
- A public function `__prop_get_<name>()` that returns the value.
- A public function `__prop_set_<name>(__val)` that writes it.
- In the interface, a line `prop <name>:<type> public` that travels to importing modules (without exposing the accessors as normal functions).

The identifier `tick` within the module itself resolves to the getter/setter (not the global directly), so encapsulation is respected inside the owning module too. A module property takes its initial value just like a module-level `var` (see [§5.1](#var)): a literal is baked into the module, and any other expression is computed when it loads, before the module's initializer function.

`sync` is also valid on module properties:

```
module Stats
  public sync property contador: integer
end Stats
```

In this case the module declares a single global `Mutex` (`__prop_mutex`) shared by all its sync properties. It is initialized when the module loads (in `__init`) and the get/set wrap their body with `lock`/`unlock`. The guarantees and limitations are the same as for sync in classes.

MVP limitations:

- Module-level `owner` properties are not supported (classes only).
- `final` is not supported at module level (the modifier applies only to class properties).

<a id="static"></a>
### 9.6 Static members / `final`

BP has no `static` keyword: a member is static when it is declared **with a name qualified by the class** (`Class.member`) inside the class body. It works for `const`, `var`, `property` and `function`:

```
public class Counter
  public const Counter.MAX: integer := 100   // static const
  var Counter.viva: integer            // static var

  public property Counter.total: integer     // static property (auto get/set;
                                               // custom get/set allowed with `field`)

  public function Counter.bump()               // static method
    Counter.total := Counter.total + 1
  end Counter.bump
end Counter

// Access is ALWAYS qualified, with no instance — also from instance
// methods:
Counter.total := 7
Counter.total += 3
Counter.bump()
```

Static state lives as a global of the owning module (one per class, not per instance); 8-byte types (`long`/`double`) work the same. `final` on a class: not extensible; on a method: not overridable (the modifier goes before `function` or `class`).

**Static members cross the module boundary** (since V7): `Lib.Counter.total := 3`, `Lib.Counter.total += 1` and `Lib.Counter.bump()` work from another module just like from their own, and a child in another module sees the protected statics of its base. Static `const`s travelled already. The only thing that cannot call a static is a `native` function ([§8.3](#funciones-native)).

**A static `var` does not cross — and that is the model, not a limitation.** A `var` (module-level or class-level) lives in the module's data segment, and that segment is only valid for the module's own code. That is why no `var` can be `public`: *state leaves the module only through getters and setters*. If a descendant in another module needs that value, declare a `property` (protected, without `public`): it crosses through its accessors, just like a module property. Instance fields are the separate case: they cross by slot because the child *is* the object.

<a id="fields-owner"></a>
### 9.7 Fields owner

```
public class Caja
  var owner contenido: Recurso
  public function Caja(r: Recurso)
    this.contenido := r
  end Caja
end Caja
```

When a `Caja` is destroyed —whoever frees it: its owner, the GC or the end of the program—, its owner field `contenido` is destroyed and freed too, before it and recursively ([§9.4b](#destructor)). When the field is reassigned, the previous value is destroyed before the new one is written.

<a id="interfaces-clase"></a>
### 9.8 Interfaces

A class inherits from **one** class ([§9.4](#herencia)) and **implements** as many interfaces as it wants: it is multiple inheritance of *types*, not of code (V8, #756). An interface says which methods and which properties a type has, with no body, and it can inherit from several.

```
public interface Forma
  function area(): double
  function nombre(): string
end Forma

public interface Poligono extends Forma
  function lados(): integer
end Poligono

public interface Etiquetado
  property etiqueta: string
end Etiquetado

public class Cuadrado extends Figura implements Poligono, Etiquetado
  var lado: double
  @implement{ Etiquetado }
  public property etiqueta: string
  public function Cuadrado(l: double)
    this.lado := l
  end Cuadrado
  @implement{ Poligono }
  public function area(): double
    return this.lado * this.lado
  end area
  @implement{ Poligono }
  public function lados(): integer
    return 4
  end lados
end Cuadrado
```

`nombre()` is not in `Cuadrado`: it comes from `Figura`, its parent, which knows nothing about `Forma`. What counts is that the class has it, its own or inherited.

```
var f: Forma := Cuadrado(2.0)
print f.nombre(), f.area()                  // figura 4
var p: Poligono := Poligono(f)               // the conversion: if it is not one, RuntimeError
print p.lados(), f instanceof Etiquetado   // 4 true
var e: Etiquetado := Etiquetado(f)
e.etiqueta := "cuadrado de 2"              // the property, through the interface
```

- **What an interface carries:** instance methods, only their signature, and properties in short form (their name and their type: the class will have their getter and setter). There is no need for `public`: everything in an interface is public. It carries no fields, constants, events, constructors or anything `static`, nor `final`, `private`, `native` or `owner`: what it carries is what a class exports.
- **The class complies:** it has every method of its interfaces —and of those they inherit from— with the same name, the same parameters and the same return type, and every property with the same name and the same type, all of them `public`. If one is missing, it is a compile error that says which.
- **`@implement{ A, B }`, mandatory** on what the class declares that implements a member of an interface: it names one or several of the interfaces the class implements, and each one has to have that member (in the example, `area` belongs to `Forma`, and `@implement{ Poligono }` is valid, because `Poligono` inherits it). What is inherited from the parent is not marked.
- **`@override{}`, optional**, on what overrides a method or a property of the parent: it changes nothing, it just leaves it written; if it overrides nothing, it is an error. A declaration can carry several annotations, each one once (`@implement{ Forma }` and `@override{}`, for example).
- **Using them:** an interface is a type like a class: variables, parameters, arrays (`Forma[]`), `instanceof`, the conversion `Forma(x)` and `==`. A child inherits its parent's interfaces and overrides its methods without repeating them. An interface is not constructed.
- **Between modules:** a `public interface` is used and implemented from another module (`class Rect implements Lib.Medible`), and the annotation carries the name without the module (`@implement{ Medible }`). If the library changes an interface without recompiling whoever uses it, the loader says so when linking —the class is missing a new member (E11), or it implements one the interface no longer has (E12)— instead of failing on the call.
- **Limits:** a `Thread` and its children do not implement interfaces; interfaces belong to format 9, the default one; and a `native` function does not call through an interface.

In JC they are written as in C#: `interface Poligono : Forma { function int lados(); string Etiqueta { get; set; } }` and `class Cuadrado : Figura, Poligono, Etiquetado` —the first name can be the base class or an interface—, with the same annotations.

<a id="modulos"></a>
## 10. Modules

**A module's data.** A module's data —its module variables, its literals (each distinct one, once), its constants and what describes each class— **have no cap since V9** (until V8, 64 KB; before, 32): the ones more than 64 KB away from the code are read with a slightly longer instruction, and what rules is the board's memory. For something really big, split it into two modules (each one carries its own) or read it from a file.

<a id="raiz"></a>
### 10.0 The root module: `Core`

`Core` is the system module (Turbo Pascal's `System` unit), written in BasicPlus and compiled as the **root**: its public functions are visible *unqualified* in every program, whether it imports `Core` or not — `strlen`, `abs`, `parseInt`, `now`, `newIntArray`… They are declared in `bpstdlib/Core.bp`, one per line, as functions with an `inline` body ([§8.3b](#inline)), and that file is the only source of the primitive table of both virtual machines: `Builtin.java` and `builtin_ids.h` are generated from it.

**`import Core` is implicit.** The compiler adds it to the tree of every module that does not write it (except `Core` itself): you can write it or leave it out, and the result is the same. Its classes (`List`, `Exception`, `Integer`…) are written unqualified, and the four classes of the language —`Object`, `Thread`, `Mutex`, `StringBuilder`— are BasicPlus classes of `Core.bp`: until V7 the compiler wrote them in Java and copied all four into every `.mod` (≈1.3 KB per module, whether it used threads or not); now they are compiled once and every module references them. The order of their fields and methods is a contract with both VMs (`Thread.run()` in slot 0, the tid in field 0…) and it is noted in the file itself. That is why redeclaring one of the four in another module is a compile error: "'Thread' es una clase del lenguaje (Core): no se puede redeclarar".

An intrinsic is a normal function, and it **is overloaded** like any other: `Math.sign(x: integer)` and `Math.sign(x: float)` are two functions with the same name (until V7 the second one was called `signF`), and `len` is two overloads in the root — `len(s: string)` and `len(a: any[])` — instead of a special case in the compiler. `any[]` ("an array of anything": any `T[]` fits) can only be written in `Core`, like `any`. There is no sugar over a class: the length of a `List` is `lista.length()`.

<a id="library"></a>
### 10.1 `library` (optional)

```
library "com.example.app"
module Util
  ...
end Util
```

If you declare `library`, the artifact is named `com.example.app.Util.mod`. Without `library`, it is called `Util.mod`.

<a id="main"></a>
### 10.2 `main(arg: string)` and module constructor

```
module MiApp
  // Initializer (auto): runs when the module loads, after the imports.
  function MiApp()
    print "[init] loaded"
  end MiApp

  function main(arg: string := "default")
    print "running with arg='" + arg + "'"
  end main
end MiApp
```

- `function ModuleName()` is the module "constructor". It runs after all imports have been initialized.
- `function main(arg: string)` is the entry-point. Only the root module's main is called; the mains of dependencies remain as a utility for standalone testing.
- **The argument** is passed from the IDE console with `run MiApp hello` (quotes optional if it has spaces) and on the two PC VMs after the program (`bp run MiApp.mod hello`, `bp run --c MiApp.mod hello`). If nothing is passed, `arg` takes the **default value** declared in the signature (`:= "default"`, like any [parameter with a default](#defaults)) or the empty string if there is none. The board's *autorun* deliberately passes no argument: the default in the source is the deployment configuration.
- **The limit:** the argument fits in **127 bytes** of UTF-8 (127 letters with no accent; an «ñ» or an «é» take two). A longer one is an error, it is not cut: the default value is rejected by the compiler, on its line, and the one passed at run time, by the VM or the board, without running anything (`el argumento no cabe: 130 bytes (el tope es 127)`).
- Legacy form: `function Main()` with no parameters (still accepted).

<a id="imports"></a>
### 10.3 `import` / `from`

```
module App
  import Util                       // same library
  import com.example.Util           // qualified path
  import ext.tools.Helper from "plugins/helper.mod"
  ...
end App
```

- The last segment of the path is the local alias (`Util`, `Helper`). You use it as `Util.foo()`.
- `from "<path>"` tells the **compiler** where to find the `.mod` (or the `.bp`) to take the interface from. At run time the VM looks the module up by its name, always in the same order: the running pack, the program's folder (`/app`), the standard library (`/lib`) and the pack zone — the `from` path is not used.
- **`import Core` is not needed** (since V7): the compiler adds it to every module ([§10.0](#raiz)), so the `Core` types —`List`, `Integer`/`Long`/`Float`/`Double`/`Boolean`, `Comparable`, `Exception`, `RuntimeError`— and `try/catch` or `throw` ([§11](#excepciones)) are used without writing it. Writing it changes nothing.
- **Imports are not transitive** (`Core` aside, which is always there). Importing `A` does not bring in the modules `A` imports: to name a type of `B` you have to import `B` ("tipo cualificado 'B.Y' no encontrado"), and also if what you use from `A` depends on `B`. The compiler says so depending on the case:
  - a signature of `A` (of a function or of a method) uses an enum of `B`: it is an error, even if you do not use that signature — "la firma de 'A.f' usa el enum 'B.E' y este módulo no importa 'B' (un enum no puede cruzar sin resolver): añade \`import B\`";
  - a class of `A` extends one of `B`: it is a *warning* —"base cross-module 'B.Y' de la clase importada 'A.X' no resuelta (¿falta el import de su módulo?) — sin sus miembros heredados"— and the class is used without what it inherits from `B`: calling an inherited member is an error ("'X' no tiene miembro de instancia 'm'");
  - a class of yours extends one of `B` without importing it: it is an error — "la clase 'Z' extiende 'B.Y' y este modulo no importa 'B': anade \`import B\` (los imports no son transitivos)".
- **A library can grow without recompiling its users** (since V7, *late binding*): a `.mod` carries its references to other modules' classes by name and signature, and the loader resolves them against the version it finds. An added method, field or property —or a reordering— breaks nobody, as in Java; what would break —removing a member, changing its signature or its type— is rejected *at load time*, naming the symbol: "'Usa' necesita 'Lib.Sensor.nombre()s' y 'Lib' (gen 0) no lo tiene (tiene 'nombre()i'): recompila 'Usa'". And a dependency older than the version the module was compiled against does not load either: "'Lib' (gen 2) es mas antiguo que el que 'Usa' necesita (gen 3): actualiza /lib o recompila" (a library's version, its *gen*, is the `version` key of its `.bpbuild`).
- **What crosses the module boundary** (since V7): everything a descendant or a client can name — functions, classes with their public and protected methods, properties and fields, *all* constructor overloads (`super(...)` picks by signature), static members ([§9.6](#static)), `const`s and module properties. `private` does not cross — not within the module either.

<a id="interfaces"></a>
### 10.4 `module interface` — WITHDRAWN

**Module interfaces do not exist.** The sections that described `module interface` here, a module's `implements` and the `import Contract:Impl` binding were withdrawn from the language (Eduardo's decision, 30-Aug-2026), along with the samples that used them. **Class** interfaces, on the other hand, exist since V8 ([§9.8](#interfaces-clase); Eduardo, 31-Oct-2026), and with them `interface` and `implements` came back.

What those three sections were after —*evolving a module without breaking its users*— is still a goal, and the intended shape is **module inheritance**: keep the original module and add one that inherits from it. It is **deliberately on hold**, because it needs effective version control that does not exist yet. It will be revisited then. One part is already here: since V7, a library can *grow* —add methods, fields or properties— without recompiling its users ([§10.3](#imports)).

To compose functionality today: plain `import` (§10.3), **class inheritance** (§9), which does exist and is used —the standard library has 38 cases, from `SyncList extends Core.List` to `RuntimeError extends Exception`—, and class interfaces (§9.8).

<a id="encapsulacion"></a>
### 10.5 Class ↔ module encapsulation

From inside a class, only **public** module symbols are accessible (functions, consts, vars, properties). Types (classes, enums, import namespaces) are always visible.

```
module M
  function helperPriv(): integer     // private
    return 99
  end helperPriv

  class C
    public function bad(): integer
      return helperPriv()             // ERROR: not public
    end bad
  end C
end M
```

<a id="dospasadas"></a>
### 10.6 Two passes: why modules can call each other

The compiler processes each module **twice**:

1. **Interface pass** — it walks the declarations and notes *what* the module exposes: signatures of public functions, classes, properties and constants. It does not look at function bodies.
2. **Full pass** — now with every module's interface available, it compiles the real code and resolves each call.

That separation is what lets **two modules call each other**. When the body of `Par` is compiled, the interface of `Impar` already exists (and the other way round), so neither of the two has to be finished for the other one to compile:

```
module Par
  import Impar
  public function esPar(n: integer): boolean
    if n == 0 then return true
    return Impar.esImpar(n - 1)   // calls Impar
  end esPar
end Par

module Impar
  import Par
  public function esImpar(n: integer): boolean
    if n == 0 then return false
    return Par.esPar(n - 1)       // ...and Par calls Impar
  end esImpar
end Impar
```

This compiles and works. **Circularity in the CODE is allowed**, and it holds equally for functions, class methods and properties.

#### The limit: DEFINITIONS cannot be circular

What cannot close the circle is **the type itself**. If a public class of `TA` exposes a type from `TB`, and `TB`'s class in turn exposes a type from `TA`, the interface cannot be built: to know what `TA.Nodo` is you first need to know what `TB.Hoja` is, and vice versa.

```
// TA.bp
public class Nodo
  public property vecino: TB.Hoja      // TA depends on TB...
end Nodo

// TB.bp
public class Hoja
  public property duenyo: TA.Nodo     // ...and TB on TA -> circle closed
end Hoja
```

The compiler **does not abort**: it warns and **leaves out of the interface** the member it cannot resolve.

```
-- omitidas en interfaz (1): class Hoja.property duenyo: tipo no exportable
```

> **Mind this warning.** The module compiles, but that property *does not exist* for whoever imports it: the real error will show up later, in the module that tries to use it. If you see a “does not expose X” that does not match what you wrote, check for a cycle between definitions.

How to break it, in order of preference:

- **A third module** with the common types, imported by both. It is the clean solution and it usually reveals that those types were a separate piece all along.
- **Invert one of the two dependencies**: normally one of the two directions is the natural one, and the other can be solved by passing the datum as a parameter instead of storing it as a field.
- **Put both classes in one module**, if they really are a single thing split across two files.

Remember the limit applies only to *types that cross the module boundary*. Within one module, two classes may refer to each other with no problem.

<a id="overlays"></a>
### 10.7 Overlays: a program that loads another

A program can load another one with the modules it is missing, run its `Main` and, when it ends, unload it. That is the class `Overlay`, in the module `Overlays`:

```
import Overlays

function Main()
  var ov: Overlays.Overlay := Overlays.Overlay()
  ov.load("/app/Demo.mod")            // a .mod or a pack
  if ov.tryExe("its argument") then
    print "it ended well"
  else
    print "it failed: " + ov.getError()
  endif
  ov.unload()
end Main
```

What is already loaded is not loaded again. If both programs use the module `M1`, there is a single `M1`: the loaded program sees it as the one that loaded it left it, with its globals, and what it changes stays. What came in with it goes away with it.

- `load(path)` loads a `.mod` or a pack. It looks for it like a program: next to the main program, as given, in `/app`, in `/lib` and in the pack zone. The objects of the program move to make room for it, so it loads under controlled conditions, like `Heap.compact()`: **only from `Main`** (calling `load` directly), **with no other live threads**, **with no open files** and with **one load at a time**. If they are not met, or if it cannot be loaded, `RuntimeError`, and the program goes on as it was.
- `tryExe(arg)` runs the loaded program on the caller's thread, and comes back when its `Main` ends: `true` if it ended well; `false` if not, and the error is read with `getError()` (the message), `getErrorClass()` (the class, with its module) and `getTrace()` (the chain of calls, in positions). The exception does not come out: its class may belong to the program about to be unloaded. `arg` is the argument of its `Main`, and `""`, its default value. The program has to close its threads before it ends: if its `Main` ends and leaves one alive, that is an error too (*el programa ha acabado con hilos vivos*), and it cannot be unloaded until that thread ends. An error in a thread of the loaded program does not reach `tryExe`.
- `unload()` runs the destructors of what the program left and gives the memory back. If something of it is still alive, like an object of one of its classes kept in a module that stays, `RuntimeError` with its name (*sigue vivo un objeto de Demo.Cosa*): the program stays in memory, closed, and it can be tried again once that is released. It does not unload with other live threads either.

Inside a loaded program, a string literal is a heap string: what it leaves in a module that stays is still alive when the program goes. It costs an allocation each time a literal is evaluated, and only there. Its `native` functions run interpreted. They do not nest: inside a loaded program, `load` and `Heap.compact()` refuse, because its `Main` is not the one at the bottom of the stack. A complete example, in `samples/overlay`.

<a id="excepciones"></a>
## 11. Exceptions

```
try
  riskyOp()
catch e: RuntimeError
  print "runtime: " + e.msg
catch e: MiError
  print "my error: " + e.detalle
catch e
  print "unknown"
finally
  print "cleanup"
endtry

throw RuntimeError("something failed")
```

- `try` installs a handler on a VM handler stack.
- `catch e: Foo` only catches instances assignable to `Foo`. `catch e` (no type) is `catch e: Exception`: it catches any exception and `e` has its `msg`. It always goes last (clauses are tried in order).
- `finally` always runs (with or without an exception) —also when a `return`, `break` or `continue` leaves the `try`—. And it cannot leave with `return`, `break` or `continue` itself (compile error): it would hide the exception in flight. A `throw` inside is fine, and so is a `break` to a loop inside the `finally`.
- The `catch` is optional: a `try … finally … endtry`, with just the cleanup, is fine too (V7). If an exception is thrown, the `finally` runs and the exception goes on to the enclosing `try`.
- `throw expr` throws the value. If it is a class, its class_ptr is used for the typed `catch` match.
- All exceptions descend from `Exception` (with its `msg` property), which lives in the root module `Core` along with `RuntimeError`; since `Core` is always imported ([§10.0](#raiz)), they are used without writing anything.
- `print e` prints the **message**: `Exception.toString()` returns `msg`, and `RuntimeError` and user exceptions inherit it.
- A user exception is a class that extends `Exception` (it inherits `msg`; add whatever fields you want). `throw` and the typed `catch` require classes that descend from `Exception`.
- **The VM's errors carry their type** (V8, as in Java). They are all children of `RuntimeError`: `catch e: RuntimeError` still catches them all, regardless of the module where they occur, and the message is the usual one. With a `catch` of their class first, they are handled apart:
  - `ArithmeticError`: an integer division or modulo by zero, an integer power with a negative exponent, a number that does not fit in its type (`byte(300)`, `factorial(13)`).
  - `NullReferenceError`: using `null` —a field or a method of a `null` object, a `null` string where one is needed, an element of a `null` array, a `throw` of a `null` exception— and using an object that has already been deleted. A `throw` of `null` starts and doesn't finish: the error comes from the `throw` itself, and it is caught like any other.
  - `IndexError`: an index outside an array, a string (`charAt`…) or a `List`.
  - `CastError`: `Caja(x)` when `x` is not a `Caja`.
  - `IOError`: files (opening, reading, writing, removing, renaming…).

  The rest —pins and buses, the network, a full heap, a stack overflow— is still a `RuntimeError`. The same inside a `native` function.
  ```
  try
    media := total / n
  catch e: ArithmeticError
    print "no data: " + e.msg     // no data: División por cero
  endtry
  ```
- Text from outside that is not valid UTF-8 (`fromBytes`, `readFile`, `readLine`…) throws `EncodingError`, a child of `IOError` (V8, [§4.1](#utf8)), as in Java: whoever catches `IOError` or `RuntimeError` catches it too, and a `catch e: EncodingError` in front handles it apart.
- **Running out of memory is caught too.** If an allocation does not fit in the heap, the VM raises a `RuntimeError` with the message `No space in heap` instead of dying: a program working close to the limit can free and retry, or at least leave a record before giving up. The same on the PC and on the micro.
  ```
  try
    procesarLoteGrande()
  catch e: RuntimeError
    print "it did not fit: " + e.msg
  endtry
  ```
- An exception that nobody catches on the `main` thread ends the program with **exit code 1** (the same on both VMs and on the board); on another thread it ends *that* thread, the others carry on, and at the end the program exits with 1 all the same ([§14.1](#conc-modelo)). The report is diagnostic, not program output, and the IDE picks it up in its console (`help error` lists the codes); but the two VMs do not give it the same way. The C VM —the boards' one— names the exception's class and its message, whether the program or the VM itself threw it (`excepcion no atrapada: Core.ArithmeticError: División por cero`, `… MiMod.MiError: …`). The Java VM, with a `throw` of the program, names the class too (`Excepción no atrapada: MiMod.MiError: …`) and adds a stack trace with the symbolic name and the line of each frame; but with an error of the VM itself —division by zero, index out of range…— it only gives the message (`"División por cero"`), with neither the class nor the stack trace. Both also say **where**, in any of these cases: the call chain, up to 8 frames, as positions (`=== traza: Prueba+50 Prueba+72 ===` on stderr on the PC; in the `EXITED` with a board), and with the `.dbg` it is translated to the file, the line and the function: under the trace, `en Prueba.bp:5 (calcula)`, `llamado desde Prueba.bp:9 (Main)`. The Java VM does it, so does `bp run` (also with `--c`: the C VM, like a board, has no `.dbg`), and so does the IDE, with the board and with the local VM. A frame without its `.dbg` stays as a position (`Collections+1815`: the standard library in the ZIP does not carry its own): the line that matters is the one in your code, which does come out. If the error starts inside a `native` function, the line is that of its caller.

<a id="owner"></a>
## 12. Owner semantics

BP supports *deterministic* object destruction as a complement to the traditional GC. The basic rule: an object can have **one** owner; when the owner dies, the owned object dies too (cascade). And dying is being *destroyed*: its destructor runs ([§9.4b](#destructor)) and then its memory is freed.

### 12.1 `var owner x: T`

- On assigning `x := y`, the previous value of `x` is destroyed beforehand.
- On leaving scope —normal end, `return` or exception—, the current value of `x` is destroyed.
- Assigning `x` to a non-owner variable copies the ref without transferring ownership (it still belongs to `x`).
- Assigning to another local owner variable transfers: the source is left at `null` without being destroyed.
- A local `var owner` does not escape: it is neither returned nor stored in a field or an array (compile error, [§5.3](#var-owner)).

### 12.2 Fields `owner`

`var owner f: T` inside a class. The class descriptor marks which fields are owners; when the instance is destroyed, each of them is destroyed before it, from the last to the first (in its destructor, the instance already has them at `null`). When the field is reassigned, the previous value is destroyed before the new one is written (an owner-safe assignment).

### 12.3 Cascade through ref arrays

If an owner field holds a reference to a `TYPE_ARRAY_REF` array, its elements belong to the object too: when the container is destroyed, all the array's non-null elements are destroyed, each with its destructor. This is the mechanism behind [OwnerList](referencia.html.md#stdlib-ownerlist).

<a id="concurrencia"></a>
## 14. Concurrency

BP threads are run by N *workers* (real OS threads) that share out the queued threads. On the PC the default is `N=1`, and SMP is *opt-in*: `--workers=N` on the Java VM (see [§16.2](referencia.html.md#cli-vm)) and `--smp=N` on the PC C VM. On the board, since V7, the **dual-core** ones —the Pico 2, the Metro, the ESP32-S3 and the ESP32-P4— run two threads of the program truly at the same time, one per core (each on a *run*, a system task); the others —the C3, the C5, the C6 and the STM32s—, one at a time. On the dual-core ones, the ENV keys `vm.runs` and `vm.cores` change it without reflashing ([IDE Guide §9.3](guia-ide.html.md#entorno)); what it means for the program, in [§14.6](#conc-nucleos).

<a id="conc-modelo"></a>
### 14.1 Execution model

- The **main** BP thread (tid 0) starts first: it runs the module's initializer and then `main(arg)`. It has a large stack (16 KB). Only *it* can execute the `HALT` instruction that shuts the VM down.
- Any subclass of `Thread` adds a new BP thread when you call `start()`. The VM assigns it the stack its constructor asks for —`Thread(stackSize)`, in bytes; with 0, 2 KB— and queues it `RUNNABLE`. A free Java worker picks it up and runs its `run()` until return (THREAD_EXIT) or `yield()`/`sleep()`/`join()`/a lock.
- **The stack has a limit, and it is watched.** On entry, every function checks that its frame fits in its thread's stack; if it does not —an endless recursion, or a stack too small for the job— it throws a `RuntimeError` «desbordamiento de pila (el hilo tiene N B)» (stack overflow), which `try` catches like any other, the same in both VMs. The other threads are not affected.
- An exception that nobody catches ends *its* thread: the others carry on, and at the end the program exits with an error (code 1), so that the IDE or a script does not take it as a success. If it is main, the program ends. And it says so right then, on the program output (the PC console, the IDE's with a board): `=== excepcion no atrapada en un hilo (el hilo termina): <message> ===`.
- **There is no limit on live threads** (since V7): memory sets it, because each one takes the stack it asks for. A finished thread frees its place for another, so over its lifetime a program can create as many as it wants. `start()` throws a `RuntimeError` if there is no memory left for the stack it asks for ("no hay memoria para la pila del hilo").
- Each BP thread has its own context (`ThreadContext`): PC, SP, BP, CS, stack region, exception-handler stack. The heap (including objects owned by threads) is **shared**.
- When all BP threads finish, the VM shuts down. If main does `HALT` first, the in-flight workers are cut off at their next opcode.
- The graphical interface runs on a BP thread of its own: `Gui.start()` starts it and returns, `Gui.run()` also waits. It is in the [graphics volume](gui.html.md).

<a id="conc-preempt"></a>
### 14.2 Preemption and `yield()`

The quantum is counted in **opcodes**, the same in both VMs: 1024 by default, adjustable with `quantum=N` in the board's ENV (`--quantum=N` on the PC). When it runs out, the worker re-queues the thread and picks up the next RUNNABLE; so the switch between threads falls on the same instructions in the Java VM and in the C VM (the Java VM used to use a 10 ms timer, and the order of the output changed from run to run). The C VM also yields to the system, so an IDE `stop` gets through even if the program never sleeps. A builtin counts as one opcode, however long it is: a thread that spends its turn writing files to an SD card makes the others wait until it has used up its own; if it shows, `quantum=256` (the IDE guide, §9.3, has the measured case).

In parallel with preemption, BP code can yield the CPU **cooperatively**:

- `yield()` — yields once; the thread stays RUNNABLE and the scheduler picks it when its turn comes.
- `sleep(ms)` — marks BLOCKED_SLEEP until `now() + ms`. If there is no other RUNNABLE, the Java worker sleeps until the next wake-up.
- `join()` on another thread — marks BLOCKED_JOIN until the target finishes.
- `Mutex.lock()` on a taken mutex — marks BLOCKED_MUTEX until hand-off.

<a id="conc-encapsulacion"></a>
### 14.3 Encapsulation of `case` bodies

The body of each `case` inside a `parallel` is the `run()` of an anonymous Thread subclass synthesized by the compiler. It follows the same object-encapsulation rule as a normal class method: **it cannot read/write the module's global variables**. It can call module functions, instantiate classes, use `const`s and call builtins.

To coordinate, threads use shared objects ([Mutex](referencia.html.md#stdlib-mutex), `List`, stateful classes) instead of mutable globals. The compiler rejects the direct read with the message:

```
semantic error: the body of a 'case' inside 'parallel' cannot
access the global variable 'X'; use a const, a function or a
shared object
```

The `default` block does NOT suffer this restriction: it runs on the calling thread and sees its locals and globals.

<a id="conc-gc"></a>
### 14.4 GC and concurrency

The mark-and-sweep GC scans the stacks of all live threads and the modules' data blocks to identify roots. Only a live reference counts, checked against its counter: a number that happens to equal an object's address does not keep it alive (V8, `#799` and `#833`). The heap operations (`heapAlloc`, `gc()`, `freeOwnedObject`) are serialized under `vmLock` — two workers cannot mutate the heap at the same time.

**Stop-the-world safepoint**: when a worker needs the GC (because `heapAlloc` exhausts the heap), it sets a global flag `stopTheWorld`. The other workers check it at the start of each interpreter iteration: they synchronize `tc.{pc,sp,bp,cs}` and abandon `runOnContext` with a YIELD signal. They return to the `WorkerLoop`, see the flag and park in `vmLock.wait()`. The worker that requested GC waits until no other is in the RUNNING state (those parked in `vmLock.wait` inside `heapAlloc` are counted as parked via `parkedInHeapAlloc`), runs `gcLocked`, and then clears the flag.

In addition, each `tc` keeps an **alloc anchor** (`tc.allocAnchor`): `heapAlloc` leaves the just-allocated ref in it before releasing `vmLock`. If another worker triggers GC between `heapAlloc`'s `return` and the caller's subsequent push, the GC scanner sees the anchor as an extra root and does not free the object in transit.

The GC **does not move** anything: the free memory can end up split into holes. `Heap.compact()` does move —it slides what is alive to the start of the heap, with the world stopped—, but only when the program asks and under controlled conditions: from `Main`, with no other thread alive and never from a `native` ([reference §13.19](referencia.html.md#stdlib-heap)). It is possible because a reference is a *handle*: moving an object is changing its entry in the table.

**Wraps of allocation opcodes**: `NEW_OBJECT` and the `NEWARRAY` variants hold `vmLock` from allocation until publication to the BP stack (`tc.sp` synchronized). This closes the window in which another worker could sweep the just-created object before its ref reaches the stack of whoever created it.

The Java VM's SMP race **B1** (two workers on the same thread context) **is not closed**: with more than one worker (`--workers`), the Java VM is still experimental, as it has been since V2. Two of its paths have been closed —in V6, the one that was showing (only the worker that owns a thread decides about it); in V7, the one of a `sleep(0)` (`#613`)—, but it is not proven that it has no others. The C VM does not have it (its scheduler does not claim a thread that still has an owner), and since V6 its `Mutex` is atomic. `synctest.bp`, `synclisttest.bp` and `modpropsync.bp` are the reference tests. On the PC, SMP remains opt-in (one worker by default); on the board, the C VM uses both cores where there are two ([§14.6](#conc-nucleos)).

<a id="conc-print"></a>
### 14.5 `print` with several threads

A `print` comes out **whole**: its line, with all its pieces and the line break, never mixes with another thread's. Between two consecutive `print`s, another thread's line can land:

```
print "Result=", r      // comes out together: nothing slips in between "Result=" and r
print a
print b               // another thread's line may come out between a and b
```

A line built from several `print`s ending in `;` ([§2](#hello)) also comes out whole: what they leave on the open line comes out together, with the line break.

For **several lines** to come out together, join them in a `StringBuilder` and print them with a single `print`:

```
var sb: StringBuilder := StringBuilder()
sb.appendStr("Temperature: " + t + "\n")
sb.appendStr("Humidity: " + h)
print sb.toString()
```

It holds on every board and with any number of workers: with one, the thread switch could fall in the middle of a `print`; with two, two threads really print at the same time. The limit: a line longer than 1 KB (what fits at once in the output queue of the smallest board) may come out in pieces. And a trace the VM writes *while* a piece is being computed (on the PC, those of the simulated peripherals: `[gpio] read pin=25 …`) comes out before the line, not in the middle.

<a id="conc-nucleos"></a>
### 14.6 Two cores: what is shared, and a fatal failure

On a dual-core board (the Pico 2, the Metro, the S3 and the P4), two threads of the program run **at the same time**, each on its own core. Nothing changes that was not already true with one —the thread switch can also fall between two reads—, but now it really happens, and more often. The rule is this: **memory shared by two threads is the program's business; the VM's memory is the VM's**. What two threads read and write at the same time —a field of a shared object, a list, a property— is protected with a [`Mutex`](referencia.html.md#stdlib-mutex) or with a [`sync` property](#props). Without it, the result is that of any race —a counter that loses additions, a list half changed—, but the VM does not break: its heap, its tables and the GC are protected, and a `print` comes out whole ([§14.5](#conc-print)). The GUI protects itself: every operation on its widgets is run by the same run, so they can be touched from any thread.

What you gain depends on the program and on the board: two threads computing at the same time go faster, up to twice as fast (measured: ×2 on the P4, ×1.55–1.68 on the Pico 2, ×1.13 on the Metro); with strings, little or nothing (×1.33 on the P4; on the Pico 2, ×0.83: it loses); and a single-threaded program gains nothing ([§17](#pendientes)). A program being debugged, or one that uses SQLite, runs with one run even if there are two. The figures, and how to go back to one core without reflashing, are in the [IDE Guide §9.3](guia-ide.html.md#entorno).

**A fatal failure.** An error of the program is an exception ([§11](#excepciones)): it is caught or, at most, it ends its thread. A *fatal failure* is something else: the board's system cannot go on —a HardFault, the system's memory exhausted, an internal check that fails—. On the Pico 2 and the Metro, with two cores, the board leaves the report in the log —in RAM that survives the reboot—, reboots by itself in half a second and, when it starts, says so (`Machine.resetCause()` and the IDE's INFO give "fallo fatal") and **does not launch the autorun**: a program that failed right at startup would be a reboot loop; from the IDE it is started by hand. The ESP32 boards do the same with the autorun: after a panic (a processor exception) or the interrupt watchdog, the board reboots and the next boot **does not launch it** and says so in the log and on the console (`Machine.resetCause()` gives `panic/exception` or `int-watchdog`). The task watchdog, the one the `Wdt` module arms, is not a fatal failure: after it, the autorun is launched. On the STM32 boards, since V8, the same: a HardFault leaves the report in the log, the IWDG reboots the board after two seconds and the next boot does not launch the autorun (`#839`; before, they stayed stopped). Keeping the failure of one run from bringing the whole board down is for V9.

<a id="eventos"></a>
## 15. Events

An **event** lets an object *announce* that something has happened without knowing who is listening. The emitter declares **the signature** of what it will notify; the listener **subscribes** with one of its own methods.

It is the foundation of the graphical interface —a button does not know what your program does when it is pressed— but it is **not limited to it**: it works in any class.

<a id="ev-declarar"></a>
### 15.1 Declaring and raising

Inside the emitting class, `event` declares a name and parameters. It accepts [default values](#defaults) like any other signature:

```
class Boton
  public property numero: integer
  event onClick(sender: Boton, veces: integer := 1)

  public function Boton(n: integer)
    this.numero := n
  end Boton

  public function pulsa(n: integer)
    raise onClick(this, n)      // raises it
  end pulsa
end Boton
```

The `raise` works in any code of the emitting class, also in the `set` of a property: it is the way to give notice when a value changes (`#702`, V8).

<a id="ev-escuchar"></a>
### 15.2 Listening: `function event` and `::`

The listener declares a **handler** with `function event` and the same parameter list. It does not need to be public — normally it is private, because nobody else calls it.

The subscription is written with `::`, which binds **an object and one of its methods**:

```
class Panel
  var nombre: string

  public function Panel(n: string)
    this.nombre := n
  end Panel

  function event pulsado(b: Boton, veces: integer)
    print("  handler: boton " + b.numero + " x" + veces + " en " + this.nombre)
  end pulsado
end Panel

var b: Boton := Boton(7)
var p: Panel := Panel("principal")
b.onClick := p::pulsado          // subscribes the method of THAT object
```

<a id="ev-suscriptor"></a>
**Does it have a subscriber?** Inside the event's class (or a child), like the `raise`, `onClick != null` says whether someone has subscribed, and `onClick == null`, that nobody has: `b.onClick := null` unsubscribes it. It is the C# way (`if (Click != null)`). An event is not a value: anything else —storing it in a variable, writing it, comparing it with something else, or with `null` from outside its class— is a compile error (`#771`, V8).

```
public function pulsa(veces: integer)
  if onClick != null then
    raise onClick(this, veces)
  endif
end pulsa
```

<a id="ev-cuando"></a>
### 15.3 The important part: `raise` does NOT call the handler

> This is what you need to be clear about to avoid surprises: **`raise` queues the event and returns immediately**. The handler runs *afterwards*, when the scheduler injects its frame into the thread between two execution slices.

```
print("antes del raise")
b.pulsa(3)
print("despues del raise (el handler todavia NO ha corrido)")
sleep(30)
print("fin")
```

It prints, in this order:

```
antes del raise
despues del raise (el handler todavia NO ha corrido)
  handler: boton 7 x3 en principal
fin
```

Two practical consequences:

- **The one raising does not block.** That is why a button can give notice without the interface freezing while it waits for your code.
- **Do not count on the handler having already run** on the line after the `raise`. If you need the result, pass it through the event itself or wait until the handler has written it down.
- **The handler is one more function of its thread**: it can yield (`sleep`, a busy `Mutex`, a `join`) and throw. An exception it does not catch ends that thread, like any other, and the output says so (§14.1). In the GUI, handlers run on the GUI thread: if one throws without catching, the screen stops responding, and the output says why.

<a id="ev-async"></a>
### 15.4 Asynchronous calls

The same `::` can launch a method **on another thread**, without writing a `Thread` class by hand:

```
Thread(obj::metodo(args)).start()
```

It is meant precisely for what blocks: a long read, a heavy computation or a disk access launched from an interface handler, so that the screen keeps responding meanwhile.

> **And here you do need to be careful.** What is launched this way runs on a **thread other than the main one**. If you are going to share variables with the rest of the program, use the language's synchronisation mechanisms (see [14. Concurrency](#concurrencia)) to avoid corrupting the data. A normal event handler does *not* have this problem: it runs on the thread that receives it.

<a id="pendientes"></a>
## 17. Pending / not supported

Status at the close of V7 (October 2026). What was here and is now done: up to V6, classes/properties in the interface (cross-module), qualified types `Mod.Class`, `Collections.Map`, the project file, the GC's stop-the-world safepoint, automatic AOT from the IDE, the GUI ([separate volume](gui.html.md)), `catch e` as `Exception` ([§11](#excepciones)) and the native code inside the `.mod` ([§8.3](#funciones-native)); and in V7, the root module with an implicit `import Core` ([§10.0](#raiz)), the destructor and `try var` ([§9.4b](#destructor)) —owners are destroyed also when an exception goes out—, the cast from any ancestor ([§4.5](#any)), the signed `step` ([§7.3](#for)), `instanceof` of a class from another module ([§9.4](#herencia)), protected fields, statics and constructor overloads across modules ([§10.3](#imports)), `listDir` on both VMs, `try/catch/finally` inside a native ([§8.3](#funciones-native)), threads with no limit ([§14.1](#conc-modelo)) and the two cores on the board ([§14.6](#conc-nucleos)).

- `try var` (the `owner` resource the block releases) INSIDE a `native function`: declare it before with `var` and release it in a `finally` (since V7 a `try/catch/finally` inside a native does work). Nor `instanceof`, events or tuples with `float`, `long` or `double` fields inside a native (compile error, [§8.3](#funciones-native)).
- Fixed-size array `type[N]` at module level and inside a `native function` (compile error, with the alternative: `var v: type[] := type[n]`).
- **AOT on the ESP32-S3 (Xtensa)** — its `native` functions run **interpreted**: the AOT emits ARM (Thumb-2) and RISC-V, not Xtensa. The IDE says so at compile time, naming the targets that do exist, and the program still works — just without the speedup. *Measured on 22 Aug on an S3 DevKit: `fib(28)` takes the same time either way.* No date, outside the version plan.  
  **The ESP32-P4 DOES accelerate** (RISC-V, since V4), like the RP2350 and the STM32; and since V7 so do **the C5, the C3 and the C6** (RISC-V without FPU, target `riscv-imc`, `ilp32` ABI: [§8.3](#funciones-native)).
- `input()` only exists on the PC Java VM; on the C VM (PC and boards) it throws `RuntimeError` ("builtin 37 no soportado en esta VM") — the same `.mod` does not give the same output on both VMs. (`listDir()`, which was here, works on both since V7.)
- Performance improvement (not functionality): a `native`'s call to a function in ANOTHER module already works, but crosses the interpreter bridge (the compiler warns). The improvement — dispatching native→native directly, without re-entering the interpreter — has a closed design in `docs/AOT_CROSS_MODULE.md` (v4). Within the same module it is already a direct C call.
- Networking and Bluetooth on the micros: since V8, WiFi (`Air.Wifi` and `Net`, [§14.15](referencia.html.md#stdlib-net) and [§14.19](referencia.html.md#stdlib-air)) and Bluetooth, with keyboards and mice, work on the P4, the S3 and the C5. The C3 and the C6 do not carry them (with no PSRAM, they would take the RAM programs need), and on the Pico 2 W, later on; there they throw a catchable RuntimeError.
- `owner` / `final` do not apply to module properties.
- `Mutex` is non-reentrant; no `Semaphore` / `Channel` in the stdlib.
- Closures over the enclosing scope's locals in `case` bodies of the `parallel` statement (today only stdlib + module non-globals are visible — see [§14.3](#conc-encapsulacion)).
- More than one worker on the Java VM (`--workers`, the PC's SMP): experimental since V2, with the B1 race ([§14.4](#conc-gc)). By default it runs with one; on the board, the two cores are used by the C VM ([§14.6](#conc-nucleos)).
- With the RP2350's dual-core image —the default one on the Pico 2 and the Metro—, a single-threaded program runs somewhat slower than with the single-core image (measured on 15 Nov: computation, 3.5 % on the Metro and 7.7 % on the Pico 2), and on the Pico 2 one that prints a lot, quite a bit more (`PrintBench`, 1 321 ms against 745). With two threads, the dual-core image wins on both ([§14.6](#conc-nucleos)). Why printing is so slow on the Pico 2 is being investigated in V9 (`#665`).
- Keeping the fatal failure of one run from bringing the whole board down ([§14.6](#conc-nucleos)): in V9.
- Generics / type parameters in user classes.
- Explicit versioning of library contracts (covered in practice by each library's generation and late binding: [§10.3](#imports)).

---

BasicPlus reference manual — generated alongside development. Frontend: `lexer-java` · VMs: `miVM` (Java) and `bpgenvm-c` (host + RP2350 / ESP32-S3 / ESP32-C3 / ESP32-C5 / ESP32-C6 / ESP32-P4 / STM32U5) · Format `.mod` v9 (late binding; interface and native code embedded).  
BasicPlus rests on other people’s work — [credits and acknowledgements](creditos.html.md).
