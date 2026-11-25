<!-- Generated from referencia.html by scripts/docs_md.py: edit the HTML, not this file. -->

# BasicPlus — Reference

Standard library, command line and on-disk artifacts. The language itself is described in the [language manual](manual.html.md).

<a id="stdlib"></a>
## 13. Language library

What the language brings with it: collections, text, maths, files, concurrency and formats. None of this depends on the board.

<a id="stdlib-funcs"></a>
### 13.1 Built-in functions

| Category | Functions |
|---|---|
| Conversion | `intToString(n)` `floatToString(x)` `boolToString(b)` `parseInt(s)` `parseFloat(s)` |
| Strings | `strlen(s)` `upper(s)` `lower(s)` `trim(s)` `substring(s, start, end)` `indexOf(s, target)` `startsWith(s, pre)` `endsWith(s, suf)` `contains(s, sub)` `charAt(s, i)` `charCodeAt(s, i)` `replace(s, target, repl)` `split(s, sep)` |
| Integer arithmetic | `abs` `min` `max` |
| Float arithmetic | `sqrt` `pow` `exp` `random()` `randomInt(lo, hi)`<br>*Trigonometry, logarithms, π, e and the rest require `import Math` — see [§13.10](#stdlib-math).* |
| Numeric conversion | `floor(x)` `ceil(x)` `round(x)` |
| Expressions | `eval(s)` — evaluates a constant arithmetic expression given as a string (`+ - * /`, parentheses and unary; normal precedence) and returns a `float`: `eval("2 + 3*4")` = 14.0 |
| Time | `now()` ms since epoch · `sleep(ms)` |
| Concurrency | `yield()` yields the CPU to the scheduler (see [§14](manual.html.md#concurrencia)) |
| System | `gc()` · `input()` *— `input()` only in the Java VM (the one behind the IDE); the C VM —host and boards— throws a catchable `RuntimeError` «builtin 37 no soportado en esta VM (subconjunto C)»* |
| File | `readFile(path)` `writeFile(path, content)` `appendFile(path, content)` `fileExists(path)` *— files only: a folder gives `false` (for a folder, `IO.dirExists`)* `listDir(path)` *— names sorted by bytes; `RuntimeError` if it cannot be opened (see [§14.17.6](#stdlib-sd-list))* |
| Internal (stdlib) | `__newRefArray(cap)` `__growRefArray(arr, cap)` `__growIntArray(arr, cap)` `__charsToString(chars, len)` |

<a id="stdlib-list"></a>
### 13.2 `List`

```
// List, Integer, RuntimeError… live in Core, which every module imports by itself (§13.3)
var l: List := List()
l.add(10)                       // wrapped into an Integer for you
l.add(Person("Ana", 30))        // an object, as is

var p: Person := Person(l.get(1))    // get returns Object: the cast is needed
var n: integer := l.getInteger(0)      // or the typed getter, which converts

print l.length()                   // 2
l.remove(0)
```

A dynamic list that grows by doubling. Its slots are references the GC walks, so it can hold any object.

| member | what it does |
|---|---|
| `add(o: Object)` | appends an object |
| `add(i: integer)` · `add(l: long)` · `add(d: double)` · `add(f: float)` · `add(b: boolean)` | appends a primitive: **wraps** it for you in its class (§13.10) |
| `get(idx): Object` | the element, untyped. Outside the list it throws a `RuntimeError`: it looks at its size, not its capacity (#795) |
| `set(idx, o: Object)` | replaces it; it does not add: outside the list, the same as `get` |
| `length(): integer` | how many |
| `remove(idx)` | drops it and shifts the rest |

<a id="stdlib-list-typed"></a>
#### Getting values out: the typed getters

`get` returns `Object`, so an object needs a cast (`Person(l.get(i))`). For plain values there are the getters, which do not cast: they **convert**.

| getter | returns |
|---|---|
| `getString(idx)` | `string` — **always works**: everything knows how to become text |
| `getInteger(idx)` · `getLong(idx)` · `getFloat(idx)` · `getDouble(idx)` | the number, converting between numeric types |
| `getBoolean(idx)` | `boolean` |

> **The conversion rules, which are not arbitrary:**

- **Towards `string` always works**, because it cannot fail.
- **From `string` it does NOT.** A text element is not parsed: ask for that separately with `Str.parseInt` and friends, which return `(err, value)` instead of throwing. Turning text into a number fails because of the *content*, which is a different kind of problem.
- **`double` → integer TRUNCATES towards zero**: `-2.7` gives `-2` (careful — `floor` would give `-3`). To round there is `round()`.
- **If the number does not fit, it throws.** A `long` of 9,000,000,000 asked for as an `integer` is an error, not a silent truncation.
- `False` is **0** and `True` is **1**. Not the other way round: a number is not converted to a boolean.

<a id="stdlib-wrappers"></a>
### 13.3 Wrappers and `Comparable`

In BP everything descends from `Object`, but primitives —`integer`, `long`, `double`, `float`, `boolean`— are not objects. The **wrappers** are the class that makes them one, and that is what lets you put them in a `List` or a `Map`.

```
var o: Object := Integer(5)
var i: Integer := Integer(o)      // downcast; throws if it isn't one
print i.value()                  // 5
```

You rarely write them: `List.add(42)` already wraps for you. You write them on the way back.

| class | wraps |
|---|---|
| `Integer` | `integer` |
| `Long` | `long` |
| `Double` | `double` |
| `Float` | `float` |
| `Boolean` | `boolean` |

All five extend `Comparable` and share the same members:

| member | what it does |
|---|---|
| `value()` | the primitive inside |
| `toString(): string` | its text |
| `compareTo(other: Object): integer` | −1, 0 or 1 — what ordered containers use |
| `toInteger()` · `toLong()` · `toFloat()` · `toDouble()` · `toBoolean()` | convert, with the rules in §13.2. `List`'s getters are built on these |

> **`Comparable` is also the door for your own classes.** If one of your classes extends it and implements `compareTo`, it can already be sorted and used as a key. And its conversions come with a default implementation that **throws**: if your class does not know how to become a number, asking it to is a program error, not a zero.

> **They are written unqualified, and nothing needs importing.** `Integer`, `List`, `Exception`, `RuntimeError` and the rest live in `Core`, the root module, and since V7 every module imports it by itself: `import Core` may be written or left out, with the same result (in V6 it was compulsory; see [manual §10.0](manual.html.md#raiz)). They are written unqualified (`Integer`, not `Core.Integer`). What still holds for every other module: imports are **not transitive** — if you name a type from a module, you import that module yourself.

<a id="stdlib-ownerlist"></a>
### 13.4 `OwnerList`

```
var owner ol: OwnerList := OwnerList()
ol.add(Resource("A"))
ol.add(Resource("B"))
ol.removeAndFree(0)               // frees 'A' deterministically
// on scope exit: frees the array AND all items (cascade of FREE_REF)
```

Inherits from `List` (it lives in `Collections`; the compiler resolves the bare name, with no `import`). Its descriptor marks the element array as `owner`, so when the list is freed (via `var owner` or by cascade) the items are freed too. Since V6 it owns **for real**: a second reference to an element dies with the list (using it afterwards fails by handle, it does not corrupt). Methods:

- `add`, `get`, `set`, `length`, `remove`: inherited from List.
- `removeAndFree(idx)`: frees the object at `items[idx]` before shifting the rest. `remove(idx)` does not free (the original API is kept).

<a id="stdlib-synclist"></a>
### 13.5 `SyncList`

```
var sl: SyncList := SyncList()
sl.add(Item(1))                     // atomic
sl.add(Item(2))
var n: integer := sl.length()        // atomic
var it: Item := Item(sl.get(0))    // atomic; get returns Object: cast
sl.remove(0)                        // atomic
var last: Item := Item(sl.pop())    // atomic; null if empty
```

Inherits from `List` (it lives in `Collections`, like `OwnerList`, and is used the same way, with no `import`) and adds its own per-instance `Mutex`. Every public operation (`add`, `get`, `set`, `length`, `remove`) is wrapped with `lock`/`unlock`, so it is safe to call from multiple threads without external contention. Methods:

- `add`, `get`, `set`, `length`, `remove`: same as List, but **atomic**. `get` and `pop` return `Object`: the cast is yours.
- `pop(): Object`: atomically pops and returns the last element. If the list is empty, returns `null` (sentinel). The canonical primitive for producer/consumer queues.
- `popBlocking(): Object`: like `pop`, but waits (yielding) until there is something.

**Guarantee**: each individual operation is serializable with respect to the rest. A read never returns partial state; a `pop` never duplicates or loses the last element across threads.

**Limit to keep in mind**: SyncList guarantees atomicity *per individual operation*. A compound sequence such as "if `length() > 0` then `get(0)`" is NOT atomic as a block — another thread can sneak in between the two calls and leave the list empty. For compound read-modify-write sequences take an external [Mutex](#stdlib-mutex) around the block, or use `pop()`, which combines the check and the extraction in a single atomic operation.

**Implementation**: each overriding method takes the lock, calls the corresponding `List` method and releases it. Only `add(Object)` is overridden: the `add(integer)`, `add(long)`… overloads are inherited and end up in it, lock held. `pop()` and `popBlocking()` are the only new methods (they do not exist in `List`).

<a id="stdlib-sb"></a>
### 13.6 `StringBuilder`

```
var sb: StringBuilder := StringBuilder()
sb.appendStr("Hello, ")
sb.appendStr("world")
sb.appendChar(33)                  // '!'
sb.appendInt(42)
print sb.toString()              // "Hello, world!42"
print sb.length()                // → 15
```

Constructor with no arguments. It keeps **pieces**: each `appendStr` and each `appendInt` is one, and the loose characters of `appendChar` (one code point each) are gathered 64 at a time; `toString()` joins them in one go —one allocation and one copy per piece—, so appending never copies again what was already there (V7, `#587`: before, it stored each character in 4 bytes and `appendStr` copied character by character). `length()` counts the characters when asked.

<a id="stdlib-rterr"></a>
### 13.7 `RuntimeError`

```
try
  throw RuntimeError("something failed")
catch e: RuntimeError
  print e.msg                    // something failed
endtry
```

The VM's native error (index out of range, null, division by zero, failed builtin...) and also throwable by hand. It lives in the `Core` module alongside its base `Exception` (property `msg: string`), and `Core` is imported by itself: throwing or catching needs no `import` (since V7; in V6 you had to write `import Core`). A `catch e` without a type is `catch e: Exception`, and `print e` prints the message (`toString()` returns `msg`). Custom exceptions extend `Exception` (see [§11](manual.html.md#excepciones)).

Since V8 the VM's errors carry their type, as children of `RuntimeError`: `ArithmeticError` (an integer division by zero, a number that does not fit its type…), `NullReferenceError` (using `null`, or an object already deleted), `IndexError` (an index outside an array, a string or a `List`), `CastError` (converting an object to a class it is not) and `IOError` (files; and its child `EncodingError`, a string that is not valid UTF-8). `catch e: RuntimeError` still catches them all; with a `catch` of their own class first, they are handled apart ([manual §11](manual.html.md#excepciones)).

<a id="stdlib-thread"></a>
### 13.8 `Thread`

```
class Worker extends Thread
  var name: string
  public function Worker(name: string)
    super(2048)            // stackSize in bytes
    this.name := name
  end Worker
  public function run()
    var i: integer := 0
    while i < 5 do
      print this.name + " iter " + intToString(i)
      yield()
      i := i + 1
    endwh
  end run
end Worker

function main(arg: string)
  var w: Thread := Worker("A")
  w.start()
  w.join()
end main
```

Base class of BP threads. It is a `Core` class written in BP (since V7; before, the compiler synthesized it into every module), so it is always available without an `import`; and it is a *root* class: it does not descend from `Object` (its `run()` takes slot 0). To create a thread, subclass `Thread` and override `run()`. The constructor takes the stack size in bytes, and it is honoured (V7; `0` = the default, 2 KB; the program's main has 16 KB). A call that does not fit in the thread's stack throws a catchable `RuntimeError` «desbordamiento de pila (el hilo tiene N B)».

| Method | Description |
|---|---|
| `Thread(stackSize: integer)` | Constructor. The subclass must call it via `super(N)`. |
| `run()` | Body of the thread. Overridden in the subclass. When it returns, the thread ends. Slot 0 of the vtable (fixed by convention). |
| `start()` | Starts the thread: the VM allocates its stack region, enqueues it RUNNABLE and the VM's scheduler will run it. |
| `join()` | Blocks the calling thread until *this* thread finishes. If it already finished, it is a no-op. |

Related builtins (see [13.1](#stdlib-funcs)): `yield()` (yields the CPU without finishing) and `sleep(ms)` (yields + sleeps N ms; any other RUNNABLE thread runs meanwhile). For the `parallel/case/default/endpar` sugar see [§7.6](manual.html.md#parallel).

<a id="stdlib-mutex"></a>
### 13.9 `Mutex`

```
var m: Mutex := Mutex()

// inside the run() of each Thread that shares the mutex:
m.lock()                // blocks if held by another
// critical section
m.unlock()              // releases and hands off to the first waiter
```

Non-reentrant lock to coordinate between BP threads. Like `Thread`, it is a `Core` class written in BP (V7); always available without an `import`. Internally the instance holds an id `__mid` that points to a mutex of the VM. When the `Mutex` dies —the GC collects it or its owner releases it—, that VM mutex is free for the next one. *Changed in V8*: before, it was not released until the program ended, and a program that created maps (`Collections.Map` carries its own `Mutex`) or mutexes in a loop ran out of them (on the Pico 2, at around 256: «`mutex.lock: id inválido -1`»).

| Method | Description |
|---|---|
| `Mutex()` | Constructor. Requests a new id from the VM (`__mutexCreate`). |
| `lock()` | If free, takes it. If another thread holds it, marks the current one `BLOCKED_MUTEX`, adds it to the waiter queue and yields the CPU. When it receives ownership, `lock()` returns already holding the lock. |
| `unlock()` | Only legal from the owning thread; any other one raises an exception. If there are waiters, the first one receives ownership directly (hand-off, without re-attempt) and becomes RUNNABLE. |

Non-reentrant: if the same thread calls `lock()` again on a mutex it already holds, an exception is raised.

<a id="rnd"></a>
#### Random numbers

These are **implicit** (no `import` needed) and share the same source of entropy: `randomInt` is not a separate generator, it is `random()` scaled to the range.

| Function | Returns |
|---|---|
| `random(): float` | A value in **[0, 1)** — 0 can come up, 1 cannot. 24 bits of entropy. |
| `randomInt(lo, hi): integer` | An integer in **[lo, hi)**: `lo` included, **`hi` excluded**. Uniform. If `hi <= lo` it returns `lo` (it does not throw). |

> **The upper bound is NOT included.** This is the usual confusion, so here is the example: `randomInt(1, 4)` returns **1, 2 or 3**, never 4. For a six-sided die, `randomInt(1, 7)`. For a valid array index, `randomInt(0, len(a))` — which is exactly why the upper bound is excluded.

Where the bits come from depends on the machine: on the PC, the system generator; on the micro, whatever that chip offers. The *semantics* — the ranges above — are the same everywhere.

<a id="stdlib-math"></a>
### 13.10 `Math`

Mathematical functions available after `import Math`. They are all intrinsics ([manual §8.3b](manual.html.md#inline)): their body is `inline CALL_BUILTIN n`, and the `Math.foo(...)` call site carries that CALL_BUILTIN in place — there is no call overhead vs. the native operator. The implicit functions ([§13.1](#stdlib-funcs)) are not duplicated here.

```
import Math

function main(arg: string)
  var a: float := Math.sin(Math.pi() / 4.0)
  print a                          // 0.7071...
  var n: integer := Math.factorial(6)
  print n                          // 720
end main
```

| Function | Description |
|---|---|
| `pi(): float` | Constant π ≈ 3.14159… |
| `e(): float` | Euler's constant ≈ 2.71828… |
| `sin(x: float): float` | Sine. `x` in radians. |
| `cos(x: float): float` | Cosine. `x` in radians. |
| `tan(x: float): float` | Tangent. `x` in radians. |
| `asin(x: float): float` | Arcsine. Domain [-1, 1] → [-π/2, π/2]. |
| `acos(x: float): float` | Arccosine. Domain [-1, 1] → [0, π]. |
| `atan(x: float): float` | Arctangent → (-π/2, π/2). |
| `atan2(y: float, x: float): float` | Angle of the vector (x, y) in (-π, π]. Splits by quadrant. |
| `ln(x: float): float` | Natural logarithm (base e). |
| `log10(x: float): float` | Base-10 logarithm. |
| `sign(x: integer): integer` | −1, 0 or +1 depending on the sign of `x`. |
| `sign(x: float): integer` | Float overload (was `signF` until V7). `NaN` → 0. |
| `factorial(n: integer): integer` | `n!` with `0 ≤ n ≤ 12` (the largest that fits in i32). Out of range raises `RuntimeError`. |
| `gamma(x: float): float` | The Γ function (Lanczos approximation). Γ(n+1) = n! for naturals. Defined for `x > 0`; on `(0, 0.5)` it uses Euler's reflection. |
| `clamp(x, lo, hi): float` | Clamps `x` to `[lo, hi]`. *V6.* |
| `wrap(x, lo, hi): float` | Wraps `x` into `[lo, hi)` cyclically: `wrap(370, 0, 360)` = 10. Throws if `hi <= lo`. *V6.* |
| `hypot(x, y): float` | Length of the vector (x, y). *V6.* |
| `remap(x, inLo, inHi, outLo, outHi): float` | Maps `x` from one range to another, linearly and without clamping (outside the input range it extrapolates; `clamp` afterwards if you want it bounded). Throws if `inHi == inLo`. *V6.* |

<a id="stdlib-io"></a>
### 13.11 `IO`

Path manipulation and filesystem operations available after `import IO`. All functions are intrinsics. The path functions do NOT touch the disk — they only manipulate the string. The ones that do access it raise a catchable `RuntimeError` if they fail.

**On the board**: since V4 the firmware FS is littlefs, with real directories — `readFile`/`writeFile`/`appendFile`/ `fileExists`/`removeFile`/`rename`/ `fileSize`/`mkdir`/`rmdir`/`copyFile`/ `isDirectory`/`dirExists` work exactly as they do on the PC. The one exception is `lastModified`: littlefs stores no timestamps, so it raises a catchable `RuntimeError` instead of making one up.

**On the PC, the flash is a folder** (V8): a board path, one that starts with `/` (`/sys/bluetooth.json`), goes inside `~/.basicplus/flash` (on Windows, `%USERPROFILE%\.basicplus\flash`), the same for both VMs, and what is saved there stays, as on a board. Another folder, with `--flash-dir=<folder>`. A path that climbs above the root (`/../x`) does not leave it: it fails, as on a board.

**A relative path** (no leading `/`: `"readings.csv"`) does not go to the same place everywhere. When **reading** (`readFile`, `fileExists`, `fileSize`, a `File` opened for reading…) it is looked up, in order, in the program's folder (`App.projectPath()`), as is, in `/app` and in the packs. When **writing** (`writeFile`, `appendFile`, a `File` opened for writing…) it is used as is: on a board, at the root of the flash (`/readings.csv`), not in the program's folder; with the PC's IDE, in the program's folder; and in a PC VM launched by hand, in the folder it was launched from, outside the flash. That is why, on a board, if the program ships a file with that name, `readFile` reads that one and not the one it has just written. And a relative path that climbs (`"../x"`) fails on a board and in the IDE.  
**For a program's data, a path in `/data`**, each program in its own folder (`"/data/Thermostat/readings.csv"`): it is the same file on a board, in the IDE and in a PC VM, and the IDE never touches it. *V8*.

Separately there is `IO.prompt(spec)`, which asks the connected IDE to render a form and returns the JSON with the user's response (see [§13.1](#stdlib-funcs): the primitive BLOCKS the BP thread until it answers). **Java VM (PC) only**: the form is drawn by the IDE, so `IO.prompt` is a development utility. On the micros (VM-C, C subset) it is absent and raises a catchable `RuntimeError` — just like with no IDE connected. Wrap it in `try/catch` if the program must also run on the board.

```
import IO

function main(arg: string)
  var p: string := IO.pathJoin("build", "out.txt")
  print IO.pathExtension(p)               // "txt"
  if IO.isDirectory("build") == false then
    IO.mkdir("build")
  endif
  writeFile(p, "hi")
  print IO.fileSize(p)                    // 2
end main
```

| Function | Description |
|---|---|
| `pathJoin(a, b): string` | Joins two components with the OS separator. |
| `pathParent(p): string` | Parent directory. `""` if there is none. |
| `pathBasename(p): string` | Last component of the path. |
| `pathExtension(p): string` | Extension without the dot. `""` if there is none. |
| `pathAbsolute(p): string` | The name the FS is going to use. A **pure** function of (`p`, `App.projectPath()`): if `p` starts with `/` or has a scheme (`x:`), as is; if there is a project, `<projectPath>/p`; otherwise as is (relative stays relative). It does **not** look at the disk or normalize `..`/`.`: that way it answers the same on the PC and on the board. *Changed in V6* (it used to return the PC's OS path). |
| `mkdir(p)` | Creates the directory (and any missing intermediates). Does not fail if it already exists. |
| `rmdir(p)` | Removes a directory. Only if it is empty; with a file, it fails (for that, `removeFile`). *Changed in V8* (before, on the Java VM and on the boards' SD card, it also removed a file). |
| `removeFile(p)` | Removes a file; with a directory, it fails (for that, `rmdir`). *Changed in V8* (before, on the Java VM, on the boards' SD card and on a Linux PC, it also removed an empty directory). |
| `rename(src, dst)` | Renames/moves. Overwrites the destination if it exists. |
| `copyFile(src, dst)` | Copies a file. Overwrites the destination if it exists. |
| `fileSize(p): integer` | Size in bytes. Fails if `> 2 GB`. |
| `isDirectory(p): boolean` | `true` if `p` is an existing directory. |
| `dirExists(p): boolean` | The same as `isDirectory`, with the name that goes with `fileExists`: `true` if `p` is a folder that exists, empty or not. `fileExists` is for files only. |
| `lastModified(p): integer` | Last `mtime` in ms epoch (truncated to i32). **Not on the board**: littlefs stores no timestamps. |
| `prompt(spec): string` | Asks the connected IDE to show a form. `spec` is a JSON with the description. Blocks the BP thread until it answers. With no IDE connected, `RuntimeError`. |

<a id="stdlib-io-file"></a>
### 13.11b `IO.File` and `IO.TextFile` — the open file (V7)

The functions above work on the **whole** file. To read or write in parts — a multi-megabyte log on the SD card, a CSV line by line, a binary format with a header — there is an **open file**: an object with a cursor. `File` works in **bytes** and nothing else; `TextFile` inherits from it and **adds** the UTF-8 text overloads (`toBytes`/`fromBytes` are its encoder and decoder). It never redefines what it inherits: `write` means raw across the whole hierarchy, and formatted output is concatenated (`f.writeLine("t=" + t)`).

**All the state lives in the object** (on the board, the file-system engine's descriptor and its cache: ~340 B with littlefs, ~552 B with the SD card; on the PC, nothing). That is why there is no cap on open files: the limit is memory, and it is visible. If the object dies without `close()`, the collector closes it; the end of the run closes whatever is left and **says so** on the console. Anything you want to be observable — writes someone else will read — goes through `close()`, `flush()` or a `~File()` with `var owner` / `try var` ([manual §5.3](manual.html.md#var-owner)): the collector's path is only the safety net.

```
import IO

function main()
  try var log: IO.TextFile := IO.TextFile("/sd/log.txt", "a")   // closes itself when the try ends
    log.writeLine("boot")
  endtry

  var f: IO.TextFile := IO.TextFile("/sd/log.txt", "r")
  while not f.eof() do
    print f.readLine()
  endwh
  f.seek(0)
  print f.readStr(3), f.tell()        // three CHARACTERS (not bytes), and where the cursor is
  f.close()

  var b: IO.File := IO.File("data.bin", "r+")
  b.seek(4)
  b.writeByte(255)                     // overwrites byte 4, the rest stays as it was
  b.close()
end main
```

| `IO.File` | Description |
|---|---|
| `File(path, mode)` | Opens. Modes: `"r"` (must exist; read only), `"w"` (create or truncate; read and write), `"a"` (create if missing; cursor at the *end* on open — afterwards the position rules), `"r+"` (must exist; read and write). On failure, `RuntimeError` with the path and mode. The same path already open with either side writing → `RuntimeError` «ya está abierto» (several readers are fine). A pack resource opens only in `"r"`. The whole-file verbs (`readFile`, `writeFile`, `removeFile`…) are an `open` and a `close`: the same rule. |
| `close()` | Closes. Idempotent. `~File()` calls it. |
| `isOpen(): boolean` · `path(): string` | State, and the path it was opened with. |
| `size(): integer` · `tell(): integer` · `eof(): boolean` | Current size, cursor position, and `tell() >= size()`. |
| `seek(pos)` · `skip(delta)` | Absolute and relative (negative `delta` is fine). **Outside `[0, size()]` is a `RuntimeError`**: there are no holes; extending means writing at the end. |
| `readByte(): integer` | One byte (0..255), or `-1` at the end. |
| `read(buf: byte[]): integer` | Fills `buf` from the cursor and returns the bytes read (0 = end). Allocates nothing: the chunked copy loop. |
| `readBytes(n): byte[]` | Up to `n` bytes in a new array (shorter at the end). |
| `write(data: byte[])` · `writeByte(v)` | Raw, at the cursor; advances and extends when it reaches the end. |
| `flush()` | What was written reaches the medium (the engine's cache is flushed). |
| `IO.TextFile extends File` |  |
| `readLine(): string` | The next line without its terminator; tolerates `"\r\n"`. At the end it returns `""` — `eof()` is what tells. A file without a final newline still yields its last line. Native: ~0.2 ms per line on a Pico (measured). |
| `readStr(n): string` | `n` **characters** (not bytes), or whatever is left. |
| `write(s: string)` · `writeLine(s)` | The UTF-8 bytes of the text; `writeLine` appends `"\n"` (one only, the same on the PC and on the board). |

`seek` positions in **bytes** also in `TextFile`: jumping into the middle of a multi-byte character reads garbage until the next one. Multi-byte integers have no helper of their own in V7: build them with `readBytes`/`write` (and if a convention is needed, little-endian, the one of every micro in the envelope).

<a id="stdlib-log"></a>
### 13.12 `Log`

Application logger in pure BP on top of the `IO` file I/O: levels, output to console and/or file, size-based rotation and thread-safe (internal Mutex). **Failure-proof**: if the file fails (FS full, unsupported op), it warns ONCE and degrades to console-only — a logger never takes the application down.

```
import Log

Log.setLevel(Log.DEBUG)            // INFO by default
Log.setFile("app.log")             // "app.log" by default
Log.info("starting up")            // → [INFO ] starting up
Log.warn("low battery")
Log.error("sensor not responding")
```

| Function | Description |
|---|---|
| `debug/info/warn/error(msg)` | Emits a `[LEVEL] msg` line if `level >= setLevel`. |
| `setLevel(n)` | Minimum level: consts `Log.DEBUG/INFO/WARN/ERROR` (0..3). INFO by default. |
| `setFile(p)` | Path of the log file. |
| `setConsole(b)` / `setFileEnabled(b)` | Enables/disables each output (both on by default). |
| `setMaxSize(n)` | Rotation: on exceeding n bytes, the file is moved to `<path>.old` and a new one starts (16 KB by default). |
| `setTimestamp(b)` | Prepends the uptime in ms (off by default — deterministic output). |

<a id="stdlib-str"></a>
### 13.13 `Str`

String utilities in pure BP. The parsers return a **tuple** `(err, value)` — no exceptions on bad format: `err` is `true` when the text was *not* a number (and then `value` is 0):

```
import Str

var err: boolean := false
var v: integer := 0
{ err, v } := Str.parseInt("123")
if not err then print v          // 123

print Str.formatDouble(3.14159d, 2)   // "3.14"
print Str.padLeft("7", 3)             // "  7"
```

| Function | Description |
|---|---|
| `formatDouble(x, dec): string` | Rounded to `dec` decimals. |
| `longToString(x)` / `doubleToString(x)` | Identical to the concat `"" + x` (kept for compatibility and for composing). |
| `toHex(x: long): string` | Hexadecimal without prefix. |
| `fromCharCode(cp): string` | String of 1 code point. |
| `lastIndexOf(s, sub): integer` | Last occurrence (-1 if absent). |
| `compare(a, b): integer` | <0 / 0 / >0 (order by code points). |
| `padLeft(s, width)` / `padRight(s, width)` | Padding with spaces. |
| `parseInt/parseLong/parseDouble/parseHex(s): (boolean, T)` | Tuple `(err, value)`; `err=true` if the format is not valid (`parseInt("12x")` → `(true, 0)`). |

<a id="stdlib-collections"></a>
### 13.14 `Collections`

Ordered map + comparison infrastructure in pure BP, plus the two specialised lists `SyncList` (§13.5) and `OwnerList` (§13.4). The `Integer`/`Long`/`Double`/`Float`/ `Boolean` wrappers a primitive goes in with as key or value are the ones from `Core` (§13.3), not from this module — and `Core`, as in every module, is imported by itself.

```
import Collections

var ages: Collections.Map := Collections.stringMap()
ages.put("ana", Integer(30))
var w: Integer := Integer(ages.get("ana"))   // get returns Object: cast
print w.value()                          // 30
```

| API | Description |
|---|---|
| `stringMap()` / `numericMap()` | Factories: a Map with a string / numeric comparator. |
| `Map.put/get/containsKey/remove` | Basic operations. The key is an `Object`, and the two usual ones go unwrapped: `put(k: integer, v)`, `put(k: string, v)`, `get(k)`, `containsKey(k)`, `remove(k)` accept all three (an integer key needs `numericMap()`). `get(key): Object` returns `null` if absent. |
| `Map.getInteger/getLong/getFloat/getDouble/getBoolean/getString(k)` | Typed value getters, like `List`'s: the value was stored wrapped (`Integer(3)`, `Double(2.5)`…) and is unwrapped here; the key in any of its three forms. If the value is not of that type (or the key is absent) it throws `RuntimeError`: never a silent zero. |
| `Map.size()`, `keyAt(i)`, `valueAt(i)` | Iteration by index, in the comparator's ORDER (ordered map: binary search inside). Thread-safe (internal Mutex). |
| `Comparator` / `Comparable` | Base classes for custom ordering (`Map.withComparator(c)`). |

<a id="stdlib-stats"></a>
### 13.15 `Stats`

Incremental statistics in pure BP (double): meant for streams of sensor measurements without keeping the history.

| Class | API |
|---|---|
| `Accumulator` | `add(x)`, `count()`, `mean()`, `variance()`, `stdDev()`, `min()`, `max()` — online accumulation. |
| `LinReg` | `addPoint(x, y)` / `subPoint(x, y)` (sliding window), `addData(xs, ys, n)`, `slope()`, `intercept()`, `r()`, `predict(x)` — incremental linear regression. |

<a id="stdlib-compress"></a>
### 13.16 `Compress`

LZSS decompressor in pure BP, for deploying compressed data in the micro's flash (tables, resources). **Decompression only by design**: the compressor is a host tool.

```
import Compress

var dst: byte[] := newByteArray(8192)
var n: integer := Compress.decompress(src, len(src), dst, len(dst))
// n = bytes decompressed into dst; -1 if the destination does not fit
// or the data is corrupt (no exceptions)
```

<a id="stdlib-json"></a>
### 13.17 `Json`

Reading and writing JSON (`import Json`). The document is modeled with a class hierarchy: `JsonValue` (base) and its children `JsonNull`, `JsonBool`, `JsonInt`, `JsonFloat`, `JsonString`, `JsonArray` and `JsonObject`.

| API | Description |
|---|---|
| `Json.parseJson(s): JsonValue` | Parses a JSON string; raises `RuntimeError` if it is invalid. |
| `Json.writeJson(v): string`<br>`Json.writeJsonPretty(v): string` | Serializes (compact / indented). A value can also be serialized with `v.toJson()`. |
| `v.isObject() … v.isNull()` | Polymorphic type test: `isNull isBool isInt isFloat isNumber isString isArray isObject`. |
| `v.asObject() … v.asString()` | Checked cast (raises `RuntimeError` if the type does not match). |
| `JsonObject` | `put(key, v)` · `has(key)` · `getString/getInt/getFloat/getBool/getObject/getArray(key)` · `get…Or(key, def)` variants with a default value. |
| `JsonArray` | `add(v)` · `at(i): JsonValue` · `length()`. |

```
import Json

var root: Json.JsonObject := Json.JsonObject()
root.put("name", Json.JsonString("Ana"))
root.put("age",   Json.JsonInt(30))
print Json.writeJson(root)              // {"name":"Ana","age":30}

var v: Json.JsonValue := Json.parseJson("{\"ok\":true}")
print boolToString(v.asObject().getBool("ok"))
```

Full example: `samples/JsonDemo.bp`. The `.win` form loader ([graphics guide §22](gui.html.md#eventos)) uses this module.

<a id="stdlib-app"></a>
### 13.18 `App`

Introspection of the running project (`import App`), Java `getResource()` style: the program can ask where its root is and build explicit resource paths. The values depend on the environment (on the board, `/app/<project>/…`; on the host, the executed `.mod` and its base-dir) — like `now()` or the FS, they are not part of the byte-identical parity.

| Function | Description |
|---|---|
| `App.mainModule(): string` | Name of the main module in execution. |
| `App.mainModulePath(): string` | Path of the executed `.mod`. |
| `App.projectPath(): string` | Project root (the base of the relative paths of `readFile`, images, `.win`…). |

<a id="stdlib-heap"></a>
### 13.19 `Heap` (heap diagnostics, and compacting it)

What a program can ask about its memory (`import Heap`), on the PC and on any board. Each function *reads* counters of the VM —it allocates nothing and does not walk the heap—, so asking does not change what is asked; and it returns a **number**, to decide with it (a threshold, a warning). They are numbers of **each VM**: the heap size depends on the board's memory, and the PC VM and the board VMs do not split it the same way; like `now()` or the FS, they are not part of the byte-identical parity. Compare relations, not values.

| Function | Description |
|---|---|
| `Heap.getSize(): integer` | The heap size, in bytes: what a program can come to occupy. |
| `Heap.getFree(): integer` | The free bytes: what is left at the end plus the holes. |
| `Heap.getLargestFree(): integer` | The largest free block (header included): an allocation up to that size fits in one go. Against `getFree()`, it tells whether memory is fragmented. |
| `Heap.getFreeBlocks(): integer` | How many holes there are. |
| `Heap.getHandles(): integer` | How many objects there are in the heap: the live ones and the dead ones the GC has not collected yet. |
| `Heap.getCollections(): integer` | How many collections the program has done. |
| `Heap.compact()` | Compacts the heap (below). |

```
import Heap
if Heap.getLargestFree() < 4096 then
  print "fragmented:", Heap.getFree(), "B free, the largest", Heap.getLargestFree()
endif
```

`heapFrag()` and `heapMap()` remain: they return text and only exist in the PC VM (on a board, «builtin not supported»), to look at memory while developing.

<a id="stdlib-heap-compact"></a>
#### `Heap.compact()`: compacting the heap

The GC collects what is no longer used, but it does not move what remains: after many allocations and releases the free memory ends up split into holes, and a large allocation can fail with memory to spare. `Heap.compact()` does a full collection and **slides what is alive to the start** of the heap, so all the free memory ends up in one block: `getLargestFree()` becomes `getFree()`. It is for a program that runs for days, or that ends a phase and starts another:

```
loadData()
Heap.compact()
workLoop()
```

Moving an object is safe because a reference is a *handle*, not an address: it is enough to change its entry in the table. But there are raw addresses that cannot be followed (those of an expression half-way, those of a `native` function), so it compacts under **controlled conditions**:

- **Only from `Main`**, in its own code: from another function, or from an event handler, `RuntimeError` «Heap.compact: sólo se puede llamar desde Main».
- **With no other thread alive**: otherwise, `RuntimeError` «Heap.compact: no se puede compactar con otros hilos vivos».
- **Never from a `native`**: it is a compile error.

What cannot be moved stays where it is: the state of an open file (`IO.File`), which the board's file system keeps linked. If one is open, a hole may remain in front of it. Compacting includes its collection (`getCollections()` goes up by one) and costs a walk of the heap: it is for chosen moments, not for every turn of a loop.

A program with threads that runs for days **prepares** that moment in a quiet spell: `Main` tells its threads to stop (a flag each one checks in its loop; killing a thread from outside could leave a `Mutex` held) and waits for them with `join()`, closes whatever is open, compacts, rests and starts new threads for the next shift (`bpgenvm-c/samples/HeapReposo.bp`):

```
shift.stop()          // the order to stop
a.join()
b.join()
f.close()
Heap.compact()
sleep(60000)          // and the next shift, with new threads
```

<a id="stdlib-assert"></a>
### 13.20 `Assert` (the checks of a test)

The checks of a test (`import Assert`, V9): each one that fails throws `Assert.Failure` —a `RuntimeError`— with a short message, and the test ends with 1 and its trace says the line. The tests of a program or of a project are run by `bp test` ([§16](#cli)), on both PC VMs. It is not embedded in the firmwares: on a board, the IDE uploads it when a program uses it.

| Function | Description |
|---|---|
| `Assert.equals(expected, actual)` | That they are equal: `integer`, `long`, `double` (exact), `string` (the text; also `null`) or `boolean`. If not: «se esperaba 4, y es 5» (expected 4, it is 5). |
| `Assert.equals(expected, actual, what)` | The same, with what is being checked in front of the failure: «la suma: se esperaba 4, y es 5». |
| `Assert.isTrue(cond, what)` · `Assert.isFalse(cond, what)` | That it holds, or that it does not. A `double` with a margin: `Assert.isTrue(a - b < e and b - a < e, "…")`. |
| `Assert.fail(what)` | Always fails: what should not be reached. |

```
import Assert

function Main()
  var l: List := List()
  l.add(3)
  Assert.equals(1, l.length(), "one element")
  Assert.equals(3, l.getInteger(0))
  Assert.isTrue(l.length() > 0, "not empty")
end Main
```

An expected error is tested too: catch it, and check its message (`samples/pruebas/tests/PruebaPila.bp`).

<a id="dispositivos"></a>
## 14. Device libraries

What talks to the hardware: buses, pins, time and peripherals. It all works the same on the PC —where the hardware built-ins log to the console— and on the board, where they move real pins.

<a id="stdlib-hw-policy"></a>
### 14.1 HW policy = OO class

Project architectural decision: **every new hardware peripheral is modeled as an OO class** inside a BP module that encapsulates it. Full detail in `docs/HW_CLASS_POLICY.md`; summary here.

Reasons: encapsulation (the backend's opaque id lives in the instance), typing (`var bus: Spi.Bus` documents what the variable represents), and resource release: since V7 every class that takes something from the hardware releases it in its destructor ([«Releasing the resource»](#stdlib-hw-soltar), below).

Canonical pattern:

- A `Foo` module with low-level intrinsics suffixed with the resource type (e.g. `initBus`, `startSlice`) so they do not collide with the class's short methods (`start()`).
- A wrapping `Foo.Bar` class. The constructor takes the physical parameters + raises `RuntimeError` if the backend init fails.
- Static consts inside the class for enumerations (`Bar.MODE_X`, `Pin.PULL_UP`, etc.).
- Fields private to the owning module. They are **NOT** exported cross-module. To expose values cross-module you use a `property` with a getter (classic encapsulation).

**Documented exception**: the `Machine` module (formerly `Pico`, which still exists as an alias) exposes functions + constants without a class because the chip info is a singleton with no releasable resources. Same logic for future global-information modules.

Current state of the OO HW suite:

| Module | Class | Encapsulated resource |
|---|---|---|
| `Gpio` | `Gpio.Pin` | Pin number + mode |
| `I2c` | `I2c.Bus` | busId + pins + baudrate |
| `Spi` | `Spi.Bus` | busId + pins + baudrate + mode |
| `Uart` | `Uart.Port` | busId + pins + baudrate + format |
| `Pulse` | `Pulse.Counter` | counterSlice in input-gate mode |
| `Pwm` | `Pwm.Slice` | sliceId + channel A/B |
| `Adc` | `Adc.Channel` | ADC channel + physical pin |
| `Rtc` | `Rtc.Clock` | Wall clock with offset (logical singleton) |
| `Wdt` | `Wdt.Timer` | HW watchdog (singleton) |
| `Timer` | `Timer.Alarm` | Period + nextFire (pure BP, no HW) |
| `Machine` (alias `Pico`) | *(funcs + consts)* | *Micro and board info, singleton with no resources — documented exception* |

<a id="stdlib-hw-soltar"></a>
#### Releasing the resource (V7)

**Whatever an object takes from the hardware, it releases itself** (`#667`; Eduardo: «if a BP object consumes a resource, the object must have a destructor and release the resource if possible»). A `Pwm.Slice`, a `Pulse.Counter`, a `Neopixel.Strip`, a `Uart.Port`, a `Gpio.Pin`, a `Spi.Device` and an `Adc.Channel` have `release()` and a destructor that calls it. Releasing means **stopping it, leaving its unit free for someone else and returning its pins to their reset state** —an output stops being one—; a board LED (the Pico 2's GP25, the Nucleo's and the DK2's) goes back to the firmware, and a strip is switched off before it is released. The destructor runs when the object is freed, whoever frees it ([manual §9.4b](manual.html.md#destructor)): when a `var owner` goes out of scope, when the GC collects it and when the program ends —also after an error or a STOP—. So **when a program ends, whatever it took is back as it was**: no PWM left driving its signal, no strip left lit, no channel left taken for the next one.

`release()` releases earlier, and only once (a second call, and the destructor afterwards, do nothing). **Using the object afterwards is a named error** («`Pwm.Slice del pin 12: ya se soltó con release()`»): the channel it released may already belong to another object. What no object releases —the module functions, such as `Gpio.init` or `Uart.init`— is released at the end of the RUN by the platform's safety net, which says so in the diagnostics («`[bpvm] fin de RUN: 1 PWM seguian en marcha: se paran y sus pines vuelven al reset`»). `Wdt.Timer`: its destructor disarms the watchdog. `Spi.Bus` and `I2c.Bus` have no destructor *on purpose* —two `Bus` objects with the same id are the same bus—: their `release()` or the end of the RUN releases them.

<a id="stdlib-gpio"></a>
### 14.2 `Gpio`

GPIO pin control. The Java VM on the PC only logs; the C VM on the Pico 2 (RP2350) translates each call to the Pico SDK (`gpio_init`, `gpio_put`, `gpio_get`, `gpio_set_dir`, `gpio_pull_up/down`). The same `.mod` runs on both sides — handy for developing on the PC and then uploading to the microcontroller.

**Which pins your board has** —the program's, each bus's and the system's—, and the links to its manufacturer's documentation: [the boards and their pins](PLACAS.md). Or ask the board itself: `samples/PinesPlaca.bp`.

The module exposes two layers: an object-oriented `Gpio.Pin` class (recommended) and a set of low-level intrinsic functions that the class itself uses underneath (also available for drivers that need them).

#### 14.2.1 The `Gpio.Pin` class (recommended)

Each instance encapsulates the pin number and the mode. The constructor configures the pin; the `on()`/`off()` methods are the canonical way to write HIGH/LOW without having to repeat the number on each call.

```
import Gpio

function main(arg: string)
  var led: Gpio.Pin := Gpio.Pin(25, Gpio.Pin.OUTPUT)   // Pico's on-board LED
  var i: integer := 0
  while i < 10 do
    led.on()
    sleep(250)
    led.off()
    sleep(250)
    i := i + 1
  endwh

  var button: Gpio.Pin := Gpio.Pin(14, Gpio.Pin.INPUT)
  button.setPull(Gpio.Pin.PULL_UP)
  if button.isLow() then
    print "pressed"
  endif
end main
```

| Member | Description |
|---|---|
| `Pin(num, mode)` | Constructor. Configures the pin automatically. `mode`: `Pin.INPUT`, `Pin.OUTPUT` or, since V7, `Pin.OPEN_COLLECTOR` (open-drain output: it starts released, `off()` pulls the line down and `on()` releases it — a resistor makes it high —, and `value()` reads the line; on RP2350, whose pad does not have it, emulated since V9). **The common layer validates it against the micro's capability table** ([§Machine](#stdlib-machine-caps)) and the pin states, by name: "el pin 99 no existe en esp32c5", "el pin 26 está en uso analógico: primero release()". And on a board with the screen in the image (the P4, the DK2), its pins are the screen's from boot: "el pin 26 de esp32p4 es de la pantalla: no se puede usar" (`#669`). Its touch panel's I2C, instead, is a board bus and is shared: "el pin 7 es del I2C 0" (below, `I2c`). |
| `on()` | Drives the pin HIGH (only if it is `OUTPUT`). |
| `off()` | Drives the pin LOW (only if it is `OUTPUT`). |
| `toggle()` | Toggles HIGH↔LOW. Convenient for blinking. |
| `value(): integer` | Reads the pin. Returns 0 or 1. |
| `isHigh(): boolean` | `true` if the pin reads HIGH. |
| `isLow(): boolean` | `true` if the pin reads LOW. |
| `setPull(mode)` | Configures the internal resistor (only useful on `INPUT`). `mode`: `Pin.PULL_NONE` / `Pin.PULL_UP` / `Pin.PULL_DOWN`. |
| `release()` | V7: the pin goes back to free — another `Pin` or an `AnPin` may take it. `~Pin()` calls it: with `var owner` the pin is released when it goes out of scope. And it goes back to its reset state (`#667`): an output stops being one; a board LED goes back to the firmware. Afterwards, using the `Pin` is a `RuntimeError` («Gpio.Pin 13: ya se soltó con release()»). |

Static consts, reachable without an instance: `Pin.INPUT` (0), `Pin.OUTPUT` (1), `Pin.OPEN_COLLECTOR` (2), `Pin.ANALOG` (3, set by `AnPin`), `Pin.PULL_NONE` (0), `Pin.PULL_UP` (1), `Pin.PULL_DOWN` (2).

<a id="stdlib-anpin"></a>
#### 14.2.1b `Gpio.AnPin` — the analog pin (V7)

**A pin is analog or digital, never both** — and the common layer now checks it, on the five families and on the PC. `AnPin` **descends from `Pin`** (a physical pin may be either): `AnPin(num)` takes it in `Pin.ANALOG` mode and connects its ADC, taken from the **micro's pin map** (on an S3, GPIO 4 is channel 3 of unit 1; on the Pico, 26 is channel 0). On an `AnPin`, `on()`/`off()`/ `value()` are a `RuntimeError` ("el pin 26 es analógico: no se puede escribir"); on a pin in analog use, `Pin(num, OUTPUT)` too; on a pin without ADC, `AnPin` says "el pin 5 de esp32c5 no es analógico". Today the images serve ADC **unit 1**; a pin of unit 2 (the S3 and the P4 have two) says so by name.

```
var light: Gpio.AnPin := Gpio.AnPin(26)
print light.read(), light.readVolts(), light.channel()   // 0..4095, volts, the ADC channel
light.release()                                            // and now it may be digital
var led: Gpio.Pin := Gpio.Pin(26, Gpio.Pin.OUTPUT)
```

| Method | Description |
|---|---|
| `AnPin(num)` | Takes the pin as analog and connects its ADC (unit and channel from the map). |
| `read(): integer` · `readVolts(): float` | One conversion (0..4095) or in volts (Vref 3.3). If the backend cannot, `RuntimeError`. |
| `channel(): integer` | The ADC channel (unit 1) this pin is connected to. |
| `release()` · `~AnPin()` | Inherited from `Pin`: the pin goes back to free and to its reset state; afterwards, `read()` is a `RuntimeError`. |

#### 14.2.2 Low-level functional API

The intrinsic primitives that `Pin` uses underneath. Useful for device drivers that already manage their own pin model (SPI CS, ADC sync, etc.) and do not want the overhead of a Pin object per line.

| Function | Description |
|---|---|
| `init(pin, mode)` | Configures the pin. `mode`: `INPUT()` (0) or `OUTPUT()` (1). Call once per pin before `read`/`write`. |
| `pull(pin, pullMode)` | Internal resistor: `PULL_NONE()` (0), `PULL_UP()` (1), `PULL_DOWN()` (2). |
| `write(pin, value)` | Writes to an `OUTPUT` pin. `LOW()` = 0, anything else = `HIGH`. |
| `read(pin): integer` | Reads an `INPUT` pin. Returns 0 or 1. |

Functional constants (return literals): `INPUT()`, `OUTPUT()`, `LOW()`, `HIGH()`, `PULL_NONE()`, `PULL_UP()`, `PULL_DOWN()`.

<a id="stdlib-i2c"></a>
### 14.3 `I2c`

Multi-slave I²C master bus over 2 wires (SDA + SCL): the one of a peripheral of the micro — on the Pico 2 there are 2 (`i2c0`, `i2c1`) — or, since V9, a software one. Byte buffers are passed as `integer[]` where each slot carries one byte in the low 8 bits.

```
import I2c

function main(arg: string)
  var bus: I2c.I2C := I2c.HardI2C(0, 4, 5, I2c.STANDARD())     // peripheral 0: SDA=GP4, SCL=GP5, 100 kHz
  var devs: integer[] := bus.scan()
  for d in devs do
    print "device at 0x", d
  next d
  bus.release()
end main
```

**A bus is an `I2c.I2C`** (V9), whichever it is: it is the base class, and what a device library asks for. `I2c.HardI2C(id, sda, scl, baudrate)` is a peripheral's, and `modSoftI2C.SoftI2C(sda, scl)` a software one ([§14.3.1](#stdlib-softi2c)), for when there are no buses left or the pins do not match. **You go from one to the other by changing only the constructor**: methods, limits and errors are the same. And when it is opened, a device that was left halfway through a read — the board was reset in the middle — is taken out of there.

```
import I2c
import modSoftI2C
import Bmp280

function leer(bus: I2c.I2C)                          // it does not know which one
  var s: Bmp280.Sensor := Bmp280.Sensor(bus, 0x76)
  if s.begin() then
    s.measure()
    print s.temperature()
  endif
end leer

function main(arg: string)
  leer(I2c.HardI2C(1, 2, 3, I2c.FAST()))             // peripheral 1, on pins 2 and 3
  leer(modSoftI2C.SoftI2C(6, 7))                        // by software, on pins 6 and 7
end main
```

| Method of an `I2c.I2C` | Description |
|---|---|
| `write(addr, data, count): integer` | Sends `count` bytes to the device `addr` in **one** transaction (START…STOP), at most 256. Returns the bytes written, or `-1` if it does not answer. |
| `read(addr, data, count): integer` | Reads `count` bytes (at most 256) into `data`. Returns the bytes read, or `-1` if it does not answer. |
| `writeRead(addr, tx, ntx, rx, nrx): integer` | Writes and reads in **one** transaction, with a *repeated start* between them (V7). Returns the bytes read, or `-1`. |
| `execute(addr, t): integer` | Runs an `I2c.Transaction` (below). Returns the bytes moved, or `-1`. |
| `readReg(addr, reg): integer` | V9: the value of one register of the device (0..255), or `-1` if it does not answer. |
| `readRegs(addr, reg, data, count): integer` | V9: `count` bytes from register `reg` on, in one transaction. |
| `writeReg(addr, reg, value): integer` | V9: writes one register. `-1` if it does not answer. |
| `scan(): integer[]` | The addresses from `0x08` to `0x77` that answer. Each one is probed with a 0-byte write: some sensors do not answer a read unless they hold a finished measurement (up to V8 one byte was read, and they did not show up). |
| `isPresent(addr): boolean` | V9: whether somebody answers at `addr` (the same probe). |
| `release()` | Lets the bus go: if nobody else uses it and it is not the board's, it is closed and its pins become free. A second time does nothing; using it afterwards is a `RuntimeError` («`I2C 1: ya se soltó con release()`»). |

`I2c.Bus` is `HardI2C` under the name it had up to V8: what is written with it does not change. And a class of your own can be an `I2c.I2C` too — a multiplexer, a simulated sensor for a test —: it extends it and provides its `write`, `read` and `writeRead`; the rest is done with them.

<a id="stdlib-softi2c"></a>
#### 14.3.1 `modSoftI2C` — software I²C (V9)

`modSoftI2C.SoftI2C(sda, scl)`, or `SoftI2C(sda, scl, baudrate)`: an I²C bus on any two pins that can drive open-drain (`Machine.openDrainPins()`). It lives in its own module so that only those who use it pay for it.

- **The resistors.** Like any I²C bus, it needs its pull-ups to the supply (1 to 10 kΩ; sensor modules usually carry them). On opening, both lines are checked to rise; if not, it is a named error: «`SoftI2C 4/5: el pin 5 (scl) no sube: sin resistencia, o alguien lo sujeta`».
- **The speed.** The `baudrate` (100 kHz if not given) is the *maximum*: the interpreter makes the bits, and the real clock is around 20 kHz on the Nucleo and the Metro, and 10 on the S3. Plenty for a sensor; for a display or a memory, the peripheral. A device may hold the clock for up to some 50 ms.
- **Threads.** Each operation is whole: another thread using the same bus waits for it to finish.
- **The limits** are the peripheral's (256 bytes and 3 messages per transaction), except the bus time limit, which is its own.
- **On the PC** there are no pins: each operation writes a line (`[i2c] sda=4 scl=5 addr=0x76 write=[D0] read=1 (sim → ceros)`) and what is read is zero, as with the peripheral.

#### 14.3.2 The functions, by bus number

The original form, for drivers already written: only with the peripherals' buses.

| Function | Description |
|---|---|
| `init(bus, sda, scl, baudrate)` | Configures the bus. `bus`: 0 or 1. `baudrate` in Hz (typically 100 000 = standard, 400 000 = fast). |
| `write(bus, addr, data, count): integer` | Sends `count` bytes to the slave `addr` in **one** transaction (START…STOP), at most 256. Returns bytes written, or `-1` on NAK/timeout. |
| `read(bus, addr, data, count): integer` | Reads `count` bytes (at most 256) from the slave `addr`. Returns bytes read, or `-1` on error. |
| `writeRead(bus, addr, tx, ntx, rx, nrx): integer` | Writes `ntx` bytes and reads `nrx` in **one** transaction, with a *repeated start* between them: a register's number and its value, with nobody talking in between (V7). Returns the bytes read, or `-1` if the device does not answer. |
| `scan(bus): integer[]` | Scans addresses `0x08..0x77` and returns an array of those that ACKed. Each one is probed with a 0-byte write (up to V8, by reading one byte). |
| `release(bus)` | Lets the bus go: if nobody else uses it and it is not the board's, it is closed and its pins become free (also `bus.release()` on the class). |

**The bus is shared** (V7). Several peripherals use one bus at the same time — on the C5, the display and the microSD card share SPI 2 —; what is exclusive is each device's own: the CS on SPI, the address on I²C. The bus configuration (its pins; on I²C also its speed) is set **once**: the board declares it in its ENV (`i2c0=sda:0,scl:1,khz:400`) or, if not, whoever opens it first. Opening it later with the same pins — or with `-1`, "whatever it has" — attaches to it; with other pins it is a named error (`el I2C 0 es sda 0, scl 1 a 400 kHz (ENV i2c0): pides 100 kHz`). Its pins are reserved: a `Gpio.Pin` on them says `el pin N es del I2C 0`. `release()` lets it go — except the board's own, or one that someone else is using — and it is released automatically when the program ends. **The `count`.** It has to fit in the array: a negative `count`, one larger than the array's length, or a `null` array throw `RuntimeError` (catchable), with the same text on the PC and on the board. An I²C transaction is never split —the device would take the second piece for a new write—, so more than 256 bytes in one call is also `RuntimeError` («`i2c.write: count (300) supera el máximo de 256 bytes por transacción`»). `count` 0 is valid, both writing and reading: it moves no data, it probes the address (0 if someone answers, `-1` if not).

Constants: `BUS0()`, `BUS1()`, `STANDARD()` (100 kHz), `FAST()` (400 kHz).

**The transaction** (V7). Several messages in a row, with nobody in between, on any bus: an `I2c.Transaction` is *prepared* — `write(data, count)` and `read(data, count)` are added, without touching the bus — and executed **at once** with `bus.execute(addr, t)`: START, each message with a *repeated start* between two, and STOP at the end. It can be reused: each execution sends what the write arrays hold at that moment and fills the read arrays (`clear()` empties it). Returns the bytes moved, or `-1` if the device does not answer.

```
var t: I2c.Transaction := I2c.Transaction()
t.write([0xF4, 0x27], 2)
t.write([0xF5, 0xA0], 2)
bus.execute(0x76, t)            // two registers in one go
```

What fits in one transaction is the same on every microcontroller —what the smallest can do: the ESP32 runs it as one list of 8 bus *commands*—: up to 3 messages of at least one byte (each message is 2 commands, a read of more than one byte 3, and the STOP 1) and 256 bytes. And it **does not hog the bus**: before starting, the time it will take on the bus is computed (9 clocks per byte, each message's address included, at the bus speed); above the bus *limit* —20 ms, or the `ms:` of its ENV line (`i2c0=…,ms:30`), never more than 100— it is a `RuntimeError` and nothing is transferred: «`I2C 1: la transacción ocuparía el bus 23 ms a 100 kHz (máximo 20 ms)`».

<a id="stdlib-spi"></a>
### 14.4 `Spi`

Full-duplex SPI master bus over 4 wires (SCK + MOSI + MISO + CS). With the free functions and with `Spi.Bus`, each slave's CS is managed by the user with `Gpio.write(...)`; with `Spi.Device` (below) the module handles it, inside each transaction. On the Pico 2 there are 2 HW buses (`spi0`, `spi1`), each with several supported pin maps.

```
import Spi
import Gpio

function main(arg: string)
  Spi.init(Spi.BUS0(), 6, 7, 16, Spi.MHZ_1(), Spi.MODE3())
  Gpio.init(9, Gpio.OUTPUT())                // CS
  Gpio.write(9, Gpio.LOW())                   // select

  var tx: integer[] := [0x40, 0x00, 0x00]
  var rx: integer[] := [0, 0, 0]
  Spi.transfer(Spi.BUS0(), tx, rx, 3)

  Gpio.write(9, Gpio.HIGH())                  // deselect
  print "rx[1]=", rx[1], " rx[2]=", rx[2]
end main
```

| Function | Description |
|---|---|
| `init(bus, sck, mosi, miso, baudrate, mode)` | Configures the bus. `mode` 0..3 encodes `(CPOL, CPHA)`: 0=(0,0), 1=(0,1), 2=(1,0), 3=(1,1). `baudrate` in Hz (typically 1–10 MHz). |
| `write(bus, data, count): integer` | Sends `count` bytes. Returns bytes written. |
| `read(bus, data, count): integer` | Reads `count` bytes clocking dummy 0xFF on MOSI. Returns bytes read. |
| `transfer(bus, tx, rx, count): integer` | Full-duplex exchange: writes `tx[i]` and reads `rx[i]` simultaneously. Returns bytes exchanged. |
| `release(bus)` | Lets the bus go: if nobody else uses it and it is not the board's, it is closed and its pins become free (also `bus.release()` on the class). |

**The bus is shared** (V7). Several peripherals use one bus at the same time — on the C5, the display and the microSD card share SPI 2 —; what is exclusive is each device's own: the CS on SPI, the address on I²C. The bus configuration (its pins; on I²C also its speed) is set **once**: the board declares it in its ENV (`spi2=sck:6,mosi:7,miso:8`) or, if not, whoever opens it first. Opening it later with the same pins — or with `-1`, "whatever it has" — attaches to it; with other pins it is a named error (`el SPI 2 es sck 6, mosi 7, miso 8 (ENV spi2): pides sck 12`). Its pins are reserved: a `Gpio.Pin` on them says `el pin N es del SPI 2`. `release()` lets it go — except the board's own, or one that someone else is using — and it is released automatically when the program ends. **No limit on `count`.** The VM sends the data in 256-byte chunks, one driver call per chunk; since you drive the CS, it does not show on the wire. On the PC there is one simulation line per chunk. If a chunk fails in the driver, the call returns its error (`-1`). A negative `count`, one larger than the array (in `transfer`, than either of the two), or a `null` array throw `RuntimeError`.

Constants: `BUS0()`, `BUS1()`, `MODE0()`..`MODE3()`, `KHZ_500()`, `MHZ_1()`, `MHZ_4()`, `MHZ_10()`.

OO form with `Spi.Bus` (recommended):

```
var bus: Spi.Bus := Spi.Bus(0, 6, 7, 16, Spi.Bus.MHZ_4, Spi.Bus.MODE0)
bus.transfer(tx, rx, 3)
```

`Spi.Bus` and the free functions use the speed of their `init` and a hand-driven CS: they are for whoever is **alone** on the bus. On a shared bus, two calls with a hand-driven CS may get another device in between.

#### `Spi.Device` and `Spi.Transaction` (V7)

A `Spi.Device(bus, cs, baudrate, mode)` is one device of a **shared** bus: the bus by its number —the manufacturer's— and already established (its ENV line, or a `Spi.Bus` before), and only its own: its CS, its speed and its mode. The constructor reserves the CS (output, idle high). **The CS, with a hardware pull-up** (Eduardo: «that would be safer»): while the program does not hold it —when the board boots, or after it is released, which returns it to its reset state— nobody drives it high, and without the pull-up a device may stay selected, answering on the others' MISO. Each call is **one transaction**: it takes the bus, lowers the CS, transfers, raises the CS and lets it go; meanwhile nobody else uses the bus, and each device runs at its own speed (the display at 40 MHz and the microSD at 400 kHz on the same bus). They return the bytes (written, read or exchanged; `writeRead`, the read ones), or `-1` if the hardware fails.

| Method | Description |
|---|---|
| `write(data, count)` · `read(data, count)` · `transfer(tx, rx, count)` | Like those of `Spi.Bus`, each one a transaction with the CS inside. |
| `writeRead(tx, ntx, rx, nrx)` | Command and response with the CS low all along: writes `ntx` and reads `nrx`. |
| `execute(t: Spi.Transaction)` | All the operations of `t` in one transaction. |
| `release()` · `~Device()` | Lets the CS go, back to its reset state (`#667`); the device no longer transfers (named: `el CS 5 no está reservado como salida (¿release()?)`). The Pico's reset state has a pull-down: without the CS pull-up, the device stays selected, as when the board boots. |

A `Spi.Transaction` is *prepared* — `write`, `read` and `transfer` are added, without touching the bus — and executed **at once**: inside there are only transfers, neither waits nor program code. It can be reused (each execution sends what the arrays hold at that moment) and `clear()` empties it.

```
var flash: Spi.Device := Spi.Device(0, 5, Spi.MHZ_10(), 0)
var id: integer[] := newIntArray(3)
flash.writeRead([0x9F], 1, id, 3)          // JEDEC ID: command and response, one CS
var t: Spi.Transaction := Spi.Transaction()
t.write([0x02, 0x00, 0x10, 0x00], 4)      // program a page: header…
t.write(page, 256)                            // …and data, with the CS low
flash.execute(t)
```

**The bus is not hogged.** Before starting, the time on the bus is computed (8 clocks per byte at the device's speed); above the bus *limit* —20 ms, or the `ms:` of its ENV line (`spi2=sck:6,mosi:7,miso:8,ms:30`), never more than 100— it is a `RuntimeError` and nothing is transferred: «`SPI 2: la transacción ocuparía el bus 21 ms a 400 kHz (máximo 20 ms)`». An ADC that takes 200 ms to convert is used with two transactions —one that starts it and one that reads it—, with the bus free for the others in between (a `sleep`, or its ready pin). The same transactions exist in C for native code (the packs' BIOS v8).

<a id="stdlib-uart"></a>
### 14.5 `Uart`

Point-to-point asynchronous serial bus (logical RS-232) over 2 wires TX/RX + GND. No shared clock: both ends must agree on baudrate, format (data bits, stop bits, parity) and, if any, flow control (unsupported in v1 — 3-wire only).

There are two buses (`0` and `1`) on all five families; which pins each one takes is up to the micro. On the Pico 2 they are 2 HW UARTs (`uart0`, `uart1`) with several pin maps:

| Bus | TX | RX |
|---|---|---|
| `uart0` | GP0 / GP12 / GP16 / GP28 | GP1 / GP13 / GP17 / GP29 |
| `uart1` | GP4 / GP8 / GP20 / GP24 | GP5 / GP9 / GP21 / GP25 |

The `bpvm_pico` firmware uses USB CDC as stdio, so GP0/GP1 are free for the user (they do not conflict with `print`).

**Buffered reception (V6).** Each bus has a **512-byte** receive buffer filled by interrupt even while your program is doing something else: what arrives between two `read` calls is not lost past the hardware FIFO (32 B on the RP2350, 8 B on the STM32). If the buffer fills up, the extra bytes are dropped and the log says so («`N bytes descartados, el buffer de 512 se lleno`»). On the PC there is no port: the built-ins write a simulation line and `read` returns zeros.

```
import Uart

function main(arg: string)
  Uart.init(Uart.BUS0(), 0, 1, Uart.BAUD_115200(),
            8, 1, Uart.PARITY_NONE())
  var tx: integer[] := [0x41, 0x54, 0x0D, 0x0A]    // "AT\r\n"
  Uart.write(Uart.BUS0(), tx, 4)
  var rx: integer[] := newIntArray(64)
  var n: integer := Uart.read(Uart.BUS0(), rx, 64, 1000)
  print "RX bytes:", n
end main
```

| Function | Description |
|---|---|
| `init(bus, tx, rx, baudrate, dataBits, stopBits, parity)` | Configures the UART. `dataBits` 5..8, `stopBits` 1 or 2, `parity`: `PARITY_NONE()` / `PARITY_ODD()` / `PARITY_EVEN()`. |
| `write(bus, data, count): integer` | Sends `count` bytes. Blocks until the TX FIFO has accepted them. Returns bytes written or `-1`. |
| `read(bus, data, count, timeoutMs): integer` | Reads up to `count` bytes from the buffer and returns the bytes actually read (0..count). `timeoutMs > 0`: returns when it has `count` or when the deadline expires. `timeoutMs < 0`: blocks until it has them all. `timeoutMs == 0`: on RP2350 and STM32 it returns **at once** with whatever was there (non-blocking read); on ESP32 the driver treats it as «no deadline» and blocks until `count`. To poll without blocking on any family, ask for exactly what is there: `read(data, available(), 0)`. |
| `available(bus): integer` | How many bytes are in the receive buffer, ready to be read without blocking (the real count, on all five families). |

**No limit on `count`.** As in `Spi`, the VM works in 256-byte chunks (on the PC, one simulation line per chunk). In a `read` of more than 256, **the deadline counts per chunk**: each chunk waits at most `timeoutMs`, and one that comes back short ends the read. A negative `count`, one larger than the array, or a `null` array throw `RuntimeError`.

Constants: `BUS0()`, `BUS1()`, `PARITY_NONE()`, `PARITY_ODD()`, `PARITY_EVEN()`, and baudrate aliases: `BAUD_9600()`, `BAUD_19200()`, `BAUD_38400()`, `BAUD_57600()`, `BAUD_115200()`, `BAUD_230400()`, `BAUD_460800()`, `BAUD_921600()`.

There is also a `Uart.Port` class (recommended) with the same API in OO form — see [§14.1](#stdlib-hw-policy) for the general pattern.

```
var port: Uart.Port := Uart.Port(0, 0, 1, 115200,
                                  8, 1, Uart.Port.PARITY_NONE)
port.write(tx, 4)
var n: integer := port.read(rx, 64, 1000)
var got: integer := port.available()         // non-blocking poll, same on all five families:
if got > 0 then                            // read exactly what is there
  n := port.read(rx, min(got, 64), 0)
endif
```

`port.release()` —and `~Port()`, which calls it— turns the UART off, frees its receive buffer and returns its pins to their reset state (`#667`); afterwards, using the `Port` is a `RuntimeError`. A UART opened with `Uart.init`, with no object, is closed by the end of the RUN.

<a id="stdlib-pulse"></a>
### 14.6 `Pulse`

Hardware pulse counter. On the RP2350 each PWM slice can operate in "input gate edge counting" mode: the slice counter advances with each edge on pin B instead of with the system clock. Pure hardware, no CPU cost. Useful for rotary encoders, Hall sensors, flow turbines, Geiger counters, etc.

HW constraint: the pin passed to the constructor MUST be a pin that maps to channel B of some PWM slice (odd GPIOs: GP1, GP3, GP5, GP7, GP9, GP11, GP13, ..., GP29). Otherwise a `RuntimeError` is raised. Moreover, the associated slice CANNOT be used simultaneously as a PWM output — a slice operates in ONE mode at a time.

```
import Pulse

function main(arg: string)
  var c: Pulse.Counter := Pulse.Counter(13, Pulse.Counter.RISING)
  c.start()
  sleep(1000)
  print "pulses in 1s:", c.value()
  c.stop()
end main
```

| Member | Description |
|---|---|
| `Counter(pin, edgeKind)` | Constructor. `edgeKind`: `Counter.RISING` (0), `Counter.FALLING` (1), `Counter.BOTH` (2; on RP2350 falls back to RISING — no HW support for both). |
| `start()` | Starts counting. |
| `stop()` | Stops counting (the count and the unit are kept). |
| `value(): integer` | Current count. 16-bit counter → 0..65535. Reset periodically if you need more range. |
| `reset()` | Resets the counter to zero without stopping. |
| `release()` · `~Counter()` | V7 (`#667`): stops the counter, releases its unit (the RP2350's slice, the ESP32s' PCNT unit, the STM32's timer) and the pin goes back to its reset state. The destructor calls it. Afterwards, using the `Counter` is a `RuntimeError`. |

<a id="stdlib-pwm"></a>
### 14.7 `Pwm`

Hardware PWM signal generation. Each GPIO maps to a fixed slice + channel of the PWM by hardware (even = channel A, odd = channel B). The two channels of the SAME slice share frequency (clkdiv + wrap) but can have independent duty cycles.

Typical applications:

- Dimmable LEDs (PWM ~1-10 kHz).
- RC servos (50 Hz, 1-2 ms pulse).
- DC motors with a MOSFET (5-20 kHz).
- Audio tone generation (200-20000 Hz).

```
import Pwm

function main(arg: string)
  var p: Pwm.Slice := Pwm.Slice(10, 1000)   // GP10 at 1 kHz
  p.setDuty(50)                              // 50% duty
  p.start()
  sleep(2000)
  p.stop()
end main
```

| Member | Description |
|---|---|
| `Slice(pin, freqHz)` | Constructor. Configures the pin's slice to the given frequency. Duty starts at 0. Call `start()` to make it oscillate. |
| `setDuty(dutyPct)` | Duty cycle 0..100. Applied immediately. |
| `setFreq(freqHz)` | Changes the frequency. Affects both channels of the slice. The current duty is preserved. |
| `start()` | Starts generation. |
| `stop()` | Stops. The pin is left LOW. |
| `release()` · `~Slice()` | V7 (`#667`): stops the PWM, releases its channel (and the slice or the timer, if nobody else uses it) and the pin goes back to its reset state. The destructor calls it: a `Slice` that dies —its owner, the GC, the end of the program— does not leave the signal running. Afterwards, using the `Slice` is a `RuntimeError`. |

**Tip combined with Pulse:** to verify the frequency generated with PWM you can count the pulses with `Pulse.Counter` on another pin (wired to the PWM pin). Important: the two pins must be on DIFFERENT slices (e.g. GP10 (slice 5) + GP13 (slice 6)).

<a id="stdlib-adc"></a>
### 14.8 `Adc`

The MCU's analog-to-digital converter, **seen by channel** (unit 1). Since V7 the view **by pin** is [`Gpio.AnPin`](#stdlib-anpin), and both end up in the same place: `Adc.Channel(ch)` exists if the micro's pin map has a pin with that channel (S3 0..9, C5 0..5, RP2350A 0..3, RP2350B 0..7, U5 1..17), the common layer validates it by name («ADC: el canal 7 no existe en rp2350a (unidad 1: 4 canales)») and that pin turns analog —a `Gpio.Pin` on it is an error until `release()` (`~Channel()` calls it). On the RP2350 each channel sits on a fixed pin, and how many there are depends on the variant (the image is the same: it reads the variant from the silicon at boot):

| Channel | RP2350A (Pico 2) | RP2350B (Metro) |
|---|---|---|
| `CH0` | GP26 | GP40 |
| `CH1` | GP27 | GP41 |
| `CH2` | GP28 | GP42 |
| `CH3` | GP29 | GP43 |
| `4` … `7` | — | GP44 … GP47 (with `psram=1`, GP47 is the PSRAM's CS and belongs to the system: channel 7 cannot be used) |

12-bit resolution (0..4095), reference Vref ≈ 3.3 V typical. To read the die's internal temperature, do NOT use `Adc` — use `Machine.tempC()` (see [§14.9](#stdlib-pico)) which already does the conversion with the sensor's formula.

Since V6 a failed conversion **throws** `RuntimeError` (it used to return -1 and negative volts). On the STM32 (since V7) it serves ADC1: its 17 channels, on PC0–PC5, PA0–PA7 and PB0–PB2 (on the Nucleo-U575, A0 is PA3, channel 8); pins that only have ADC4 raise a `RuntimeError` with the reason.

```
import Adc

function main(arg: string)
  var sensor: Adc.Channel := Adc.Channel(Adc.Channel.CH0)
  while true do
    var raw: integer := sensor.read()        // 0..4095
    var v:   float   := sensor.readVolts()   // 0.0..3.3 V
    print "raw:", raw, "  V:", v
    sleep(100)
  endwh
end main
```

| Member | Description |
|---|---|
| `Channel(ch)` | Constructor. `ch`: `Channel.CH0`..`CH3`, or the channel number (on the RP2350B, up to 7; on the U5, from 1 to 17: there is no channel 0 there). If the micro does not have that channel, or its pin is in use, `RuntimeError` with the reason. |
| `read(): integer` | Raw reading 0..4095. Blocks ~2 µs per conversion. |
| `readVolts(): float` | Reading converted to volts using the nominal Vref (3.3 V). |
| `readAvg(n): integer` | Average of N readings. Reduces noise on analog sensors. Cost: N × 2 µs. |
| `release()` · `~Channel()` | V7 (`#667`): the pin goes back to free and to its reset state —another object, or a `Gpio.Pin`, may take it—. The destructor calls it. Afterwards, using the `Channel` is a `RuntimeError` («Adc.Channel 0: ya se soltó con release()»). |

Static consts: `Channel.CH0` (0), `CH1` (1), `CH2` (2), `CH3` (3), `VREF` (3.3).

<a id="stdlib-pico"></a>
### 14.9 `Machine` (micro and board information)

Information about the physical microcontroller: which chip it is and which board it sits on, identification, internal sensors, clock and control of the clk_sys frequency.

> **It used to be called `Pico`**, and that was a bad name: it is not the Pico's, it belongs to every micro. Since V6 the module is `Machine`; `Pico` still exists as an **alias** that forwards function by function, so V4/V5 programs (`import Pico`, `Pico.uniqueId()`) keep compiling and running. For new code, `Machine`.

**Documented exception** to the HW = OO class policy (see [§14.1](#stdlib-hw-policy)): `Machine` exposes functions + constants without a class because the chip's info has no "instance" (there is exactly one) and encapsulates no releasable resources.

```
import Machine

function main(arg: string)
  print "Micro:", Machine.getMicro()          // "rp2350a", "esp32c6", "host"…
  print "Board:", Machine.getBoard()          // "generic" unless the image knows it
  print "Serial:", Machine.uniqueId()
  print "CPU MHz:", Machine.cpuFreqHz() / 1000000
  print "GPIOs:", Machine.gpioCount()
  print "Reset:", Machine.resetCause()

  if Machine.getMicro() == "rp2350a" then
    Machine.setCpuFreqMHz(250)                // safe overclock (scales voltage automatically)
  endif
end main
```

| Function | Description |
|---|---|
| `getMicro(): string` | **The chip**, always real and specific: `"rp2350a"` (Pico 2) or `"rp2350b"` (Metro) — read from the silicon —, `"esp32s3"`, `"esp32c3"`, `"esp32c5"`, `"esp32c6"`, `"esp32p4"`, `"stm32u5"`; on the PC, `"host"`. *V6.* |
| `getBoard(): string` | **The board**. `"generic"` when the image does not know the model, which is the norm (images are built for the micro): that is what the ESP32s and an RP2350 without `/sys/board.json` answer. The STM32 knows it (`"nucleo-u575zi"`, `"u5g9j-dk2"`) and on RP2350 it comes from the `name` key of `/sys/board.json`. On the PC, `"host"`. *V6.* |
| `boardName(): string` | *Deprecated*: it is `getBoard()`. Kept for programs already written. |
| `uniqueId(): string` | Unique chip ID (16 hex chars). Stable across reboots and reflashes. |
| `tempC(): float` | Die temperature in °C (RP2350: ADC4 sensor, ±2 °C without calibration; STM32: internal sensor via ADC1, factory-calibrated; ESP32: the chip's own sensor, with an error under 2 °C between 20 and 100 °C). It is the same one the `INFO` gives (`tempMilliC`). *Changed in V8* (before, on the ESP32 it returned 0.0, and the `INFO` of the ESP32 and STM32 said 0). |
| `cpuFreqHz(): integer` | Current CPU frequency in Hz: the one it really runs at (on the ESP32s, since V8; before, it gave a nominal one, and on the S3, the C3 and the C6 it said 240 while running at 160). |
| `uptimeMs(): integer` | Ms since the board booted; on the PC, since the first call. It is a 32-bit `integer`: after ~24.8 days it turns negative and after ~49.7 it wraps to 0, but subtracting two readings (`uptimeMs() - t0`) still gives the time between them. *Changed in V8* (before, on the PC's Java VM it was the wall-clock time cut to 32 bits, which came out negative). |
| `gpioCount(): integer` | GPIOs available on the board, by variant: 30 on RP2350A, 48 on RP2350B; 30 on the PC. |
| `variant(): string` | `"A"` or `"B"` when the micro is an RP2350; `""` on any other (V7: it used to be derived from `gpioCount()` and answered "B" on an ESP32-P4). For the real package, `package()`. |
| `resetCause(): string` | Why the micro restarted: `"watchdog"`, `"power-on/run"`, `"reinicio pedido"` (RESET from the IDE), `"fallo fatal"` (the RP2350 with two cores, V7: see [autonomous startup](#cli-autorun))… depending on the family; on the ESP32, the chip's own (`"panic/exception"`, `"int-watchdog"`, `"task-watchdog"`…). On the PC, `"unknown"`. |
| `getEnv(key): string` | V7 (`#626`): the value of a key of the board's ENV —its [environment variables](guia-ide.html.md#entorno), the `key=value` pairs the IDE shows and edits—, or `""` if it is not there. Keys are case-insensitive. It is read from the flash: the last value written, also without restarting (`#638`); what the board configures at boot (`stack`, `vm.runs`…) changes on the next boot. A value longer than 255 bytes is a `RuntimeError`. On the PC there is no ENV: always `""`. |
| `setMark(code)` · `markCount()` · `markAt(i)` · `bootCount()` | A trail of «breadcrumbs» in retained RAM that survives a reset: the app drops marks per phase and after an unexpected restart reads the path that led to the failure (`markAt(0)` is always the first). Since V7 it works on the **three families** — the algorithm lives in the common layer and each silicon provides the RAM it keeps across resets: the STM32's backup registers, an uninitialised area on RP2350, `.noinit` on ESP32 — and survives a software reset, a watchdog reset or the IDE's `RESET` (a power-off, no). On the PC there is no reset to survive: `markCount()` is 0, `bootCount()` 1, and `Machine.hasBreadcrumb()` says so. |
| `setCpuFreqMHz(mhz): boolean` | Changes clk_sys. Clamped to `[MIN_CPU_MHZ, MAX_CPU_MHZ]`. Auto-scales Vdd_core (1.10/1.15/1.20/1.30 V depending on mhz). Returns `true` if the PLL could be configured. Call BEFORE configuring UART/SPI/I2C/PWM because their dividers are computed from clk_peri. The `sleep*` functions and `now()` are immune (independent 1 MHz HW timer). **On the ESP32s (V8):** each chip's values —the S3 and the C5, 80, 160 and 240; the C3, 80 and 160; the C6, 80, 120 and 160; the P4, only 360, and the P4X, only 400—, with the IDF's power management. A value within the range that the chip does not provide returns `false` and changes nothing. The buses do not need to be configured again (they run on an 80 MHz clock that does not change), and `sleep*` and `now()` stay exact. The boot frequency is set with `cpu.mhz` in the ENV ([appendix A](#env)). |

<a id="stdlib-machine-caps"></a>
#### What this micro has — the capability table (V7)

Every image carries, compiled in, **one capability table for its micro** (and its variant: the RP2350 picks A or B at boot; the ESP32s ask the IDF), and that single table feeds the IDE's `INFO`, these functions and the facades' validation. There used to be two sources and they disagreed (the Pico said 12 PWM in BP and 24 over the wire; a C5 believed it was an S3). On the PC both VMs count with the RP2350A profile.

| Function | Description |
|---|---|
| `uarts()` · `i2cs()` · `spis()`: `integer[]` | The **valid instances** of each bus, as `Uart.Port(id, …)`, `I2c.Bus(id, …)`, `Spi.Bus(id, …)` take them ("the count is the array's length"): `[0, 1]` on RP2350; on an ESP32-S3 `uarts() = [1, 2]` (0 is the IDE's cable), `spis() = [2, 3]`. |
| `pins()` · `analogPins()` · `pwmPins()` · `pulsePins()` · `openDrainPins()`: `integer[]` | The **pin map**: the GPIOs that exist, and which of them can read analog (`AnPin`), drive PWM, count pulses or drive open-drain. What BP builds by pin is asked by pin. The system's are not listed: those of the flash or the PSRAM, the IDE cable's and, on a board with the screen in the image (the P4, the DK2), the screen's (`#574`, `#669`). `samples/PinesPlaca.bp` writes it all, those included, with the reason. |
| `hasPin(n)` · `isAnalog(n)` · `isInputOnly(n)`: `boolean` | Questions about one pin (a GPIO that does not exist: `hasPin` false). |
| `manufacturer()` · `package()` · `pwmUnit()`: `string` | The manufacturer ("Raspberry Pi", "Espressif", "STMicroelectronics"); the package chosen at boot ("QFN-60"/"QFN-80" on RP2350, "LQFP144" on the Nucleo; the ESP32s do not say); and the **unit** `PWM_SLICES()` counts in: "slice" on RP2350, "canal" (channel: LEDC, timer) on ESP32 and STM32 — the same thing used to be counted in two units without saying which. |
| `adcUnits(): integer` · `hasBreadcrumb(): boolean` | How many ADC units the silicon has (the S3 and the P4, two), and whether the `setMark` breadcrumbs really exist on this micro. |

The usual counters are sugar over the table: `UART_BUSES()` = `len(uarts())`, `I2C_BUSES()`, `SPI_BUSES()`, `GPIO_COUNT()` (= `len(pins())`), `ADC_CHANNELS()` (= `len(analogPins())`), `PWM_SLICES()` (simultaneous outputs, in the unit of `pwmUnit()`). And `MAX_CPU_MHZ()` / `MIN_CPU_MHZ()` are now **per micro** (300/18 on RP2350; on an ESP32, since V8, the highest of its chip and 80 —on the P4, 360 both; on the P4X, 400—) — they used to be the RP2350's for all five families.

<a id="stdlib-rtc"></a>
### 14.10 `Rtc`

Wall clock with IDE→Pico synchronization. The Pico has no RTC with backup battery by default, so this module keeps an *offset* between "epoch (Unix) seconds" and "monotonic time since boot".

The BPIDE IDE sends a `TIME <epochsec>` command automatically when it connects to the device. After that, `epochSec()` returns the real UTC time. If not calibrated: on the Pico and the ESP32s, where the image uses no hardware clock (the RP2350 has none, and the ESP32's is not used), it returns seconds since boot (it starts at 0 on every boot) — still useful as a relative clock —; on the STM32 the chip's RTC keeps it, and it survives a reset; and on the PC it is the PC's time, on both VMs (V7, `#625`: the C VM used to count from the PC's boot).

**Is it on time?** (V7, `#626`). The first time it boots without it, the board writes the date of its image into its ENV (the `imagen.fecha` key, in seconds since 1970; once, so as not to wear the flash), and no correct time can be earlier: `isSet()` compares them. A program with autorun, which starts without the IDE, can tell this way whether its time is made up.

The API is limited to SECONDS because BP only has int32; range 1970..2038. For finer deltas within a session use `now()`.

```
import Rtc

function main(arg: string)
  var clk: Rtc.Clock := Rtc.Clock()
  if not clk.isSet() then            // V7: the time is not real
    // Calibrate manually if needed:
    clk.setEpochSec(1716544800)   // 2024-05-24 10:00:00 UTC
  endif
  print "epoch now:", clk.epochSec()
end main
```

| Member | Description |
|---|---|
| `Clock()` | Constructor with no arguments. The backend keeps the offset globally (logical singleton). |
| `epochSec(): integer` | Seconds since the Unix epoch. Uncalibrated, seconds since boot on the Pico and the ESP32s; on the PC, the PC's time. |
| `setEpochSec(sec)` | Calibrates: from here on, `epochSec()` returns `sec + time_elapsed_since_here`. |
| `isSet(): boolean` | V7 (`#626`): `true` if the clock is on time, that is, if `epochSec()` is not earlier than `imagen.fecha` (with one day of margin: the image date carries no time zone). Without that key —the PC, which has no ENV—, `true`. If the key is not seconds, a `RuntimeError` with its value. The key is read with `Machine.getEnv("imagen.fecha")` ([§14.9](#stdlib-pico)). |

<a id="stdlib-wdt"></a>
### 14.11 `Wdt` (watchdog)

The MCU's watchdog timer. If it is not "fed" within the configured timeout, the chip RESETS automatically. Useful for recovering from hangs in unattended deployments. It rescues a **hang** —the program goes on, but stops feeding it—; a program that **ends** —well, with an error or with a STOP— destroys its `Timer`, which disarms it, and the board does not restart (V7, `#667`: when a program ends, everything goes back to how it was).

**CRITICAL WARNING:** if you enable the watchdog with a short timeout and the code hangs, the chip resets in a loop. To get out: reflash a firmware that does NOT enable the watchdog at boot, or enter BOOTSEL (hold the button while connecting USB).

The constructor applies a minimum of 100 ms to the timeout to minimize accidental bricks. `Wdt` is an *MCU singleton*: there is only one watchdog; constructing several instances is legal but they all operate on the same HW (the last `enable` wins).

**Where there is a watchdog** — the V6 rule is «complete or not implemented»:

| family | Wdt |
|---|---|
| RP2350 (Pico 2, Metro) | yes, complete: `disable()` really stops it |
| ESP32 (S3, C3, C5, C6, P4) | yes, complete (Task WDT; `disable()` unsubscribes the task) |
| STM32 (Nucleo, Discovery) | **no**: the U5's IWDG cannot be stopped once armed, so the image does not offer it |
| PC (both VMs) | **no** (no chip to reset) |

Where there is none, `Wdt.Timer(…)`, `feed()`, `disable()` and `reenable()` throw a catchable `RuntimeError` («`Wdt.enable(2000): no implementado en esta plataforma`»), the same on both VMs. Wrap it in `try/catch` if the program must also run there.

```
import Wdt

function main(arg: string)
  var wdog: Wdt.Timer := Wdt.Timer(2000)   // 2 seconds
  while running do
    doWork()
    wdog.feed()        // must run within 2s
  endwh
  wdog.disable()       // before a long sleep
end main
```

| Member | Description |
|---|---|
| `Timer(timeoutMs)` | Constructor. Enables the watchdog. Clamped to the 100 ms minimum. |
| `feed()` | Feeds the watchdog: resets the counter to the configured timeout. Call periodically. |
| `disable()` | Really disables the watchdog (RP2350: `watchdog_disable`; ESP32: unsubscribes the task from the Task WDT). Useful before known long operations. |
| `reenable()` | Re-enables with the same timeout it had. |
| `~Timer()` | V7 (`#667`): if it is active, disables it —a `Timer` that dies does not leave the board about to restart with nobody to feed it—. When the program ends, also after an error. |

<a id="stdlib-time"></a>
### 14.11b `Time` (civil date and time)

`Time.Date` is an ordinary BP class — not a language type — over a `long` of epoch seconds (Unix, UTC; no time zone: a micro has none). The `long` removes the 2038 limit. Calendar arithmetic only (proleptic Gregorian), identical in both VMs; the clock comes from `Rtc`.

```
import Time
var d: Time.Date := Time.Date(1716544800L)      // from an epoch
print d.year, d.month, d.day, d.hour, d.weekday   // 2024 5 24 10 5 (0 = Sunday)
print d.toString()                                // 2024-05-24 10:00:00
var f: Time.Date := Time.Date(2024, 12, 31, 23, 59, 59)   // from fields (validated)
print f.epoch, f.addSeconds(1L).toDateString()    // 1735689599 2025-01-01
print Time.now().toString()                       // the VM clock (Rtc)
```

| API | Description |
|---|---|
| `Date(epoch: long)` · `Date(y, m, d, h, mi, s)` · `Date(y, m, d)` | Constructors; the civil ones throw `RuntimeError` when a field is out of range (29 February 2023…). |
| `epoch, year, month, day, hour, minute, second, weekday` | Read properties. `weekday`: 0 = Sunday … 6 = Saturday. |
| `addSeconds(n: long)` · `addDays(n)` · `secondsSince(other)` | Immutable: they return another `Date`; `secondsSince` is `this − other` in seconds. |
| `compareTo(o)` · `toString()` · `toDateString()` · `toTimeString()` | Natural order (works as a `Map` key with the natural comparator); "YYYY-MM-DD HH:MM:SS". |
| `Time.now()` · `esBisiesto(y)` · `diasDelMes(y, m)` · `epochDe(…)` | The VM clock's instant, and the standalone calendar functions. |

<a id="stdlib-timer"></a>
### 14.12 `Timer` (periodic alarms)

`Timer.Alarm` is a pure-BP abstraction over `now()`. It does NOT use hardware interrupts or callbacks — the user code polls the alarm with `check()` or synchronizes with `wait()`. Advantages:

- Portable to any target (Java host, C host, Pico) without a native backend.
- Immune to overclock: `now()` on the Pico uses the 1 MHz HW timer, which is independent of clk_sys.
- Zero cost in firmware (does not consume the MCU's HW timers).

Limitation: the resolution depends on how often the user calls `check()`. For critical timing (debouncing, bit-banging) use hardware PWM or the `Pulse` module.

```
import Timer
import Gpio

function main(arg: string)
  var led: Gpio.Pin := Gpio.Pin(25, Gpio.Pin.OUTPUT)

  // Mode A: non-blocking polling
  var blink: Timer.Alarm := Timer.Alarm(500)
  while running do
    if blink.check() then
      led.toggle()
    endif
    doOtherWork()
  endwh

  // Mode B: periodic loop without drift
  var beat: Timer.Alarm := Timer.Alarm(100)
  while i < 100 do
    sampleSensor()
    beat.wait()         // blocks until the next fire
    i := i + 1
  endwh
end main
```

| Member | Description |
|---|---|
| `Alarm(periodMs)` | Constructor. `periodMs=0` leaves the instance as a passive stopwatch (only `since()`). |
| `check(): boolean` | `true` if it was time to fire; advances `nextFire`. Catch-up safe: if you fall behind, it skips the missed multiples without firing in a burst. |
| `wait()` | Blocks until the next fire. For periodic loops without accumulated drift. |
| `reset()` | The next fire will be `periodMs` from NOW. |
| `since(): integer` | Ms elapsed since the last reset/construction. Useful to use the alarm as a stopwatch. |

<a id="stdlib-neopixel"></a>
### 14.13 `Neopixel`

WS2812 ("NeoPixel") LED strip. It is driven by the PIO on the RP2350 (Pico 2 / Metro) and by the RMT on the ESP32 family (S3, C3, C5, C6, P4; tested with the S3's LED, on GPIO48); on the STM32 the constructor raises `RuntimeError` ("no implementado en esta plataforma"). The pin is validated against the micro's table: one that does not exist, belongs to a bus, to the flash, to the IDE cable or to the screen raises a `RuntimeError` with the reason. As many strips fit at once as the micro has channels (4 on the RP2350, the S3 and the P4; 2 on the C3, C5 and C6); one more raises `RuntimeError` ("no se pudo iniciar: …"). Framebuffer pattern: the `set*` calls write to memory and `show()` flushes the whole strip.

```
import Neopixel

var strip: Neopixel.Strip := Neopixel.Strip(15, 8)   // pin, number of LEDs
strip.setColor(0, 0, 0)            // all off
strip.setPixel(0, 32, 0, 0)        // LED 0 in soft red
strip.show()
```

| Method | Description |
|---|---|
| `Strip(pin, count)` | Constructor: data pin + number of LEDs. |
| `setPixel(i, r, g, b)` | Color of one LED (0..255 per channel). |
| `setColor(r, g, b)` | Same color for the whole strip. |
| `clear()` | All to 0 (does not show). |
| `show()` | Flushes the framebuffer to the strip in one go (the WS2812 cannot take it in pieces): at most 2048 LEDs (4096 on STM32); more raises `RuntimeError` with the reason. |
| `count(): integer` | Number of LEDs. |
| `release()` · `~Strip()` | V7 (`#667`): switches the strip off (`clear()` and `show()`), releases its PIO state machine or its RMT channel and the pin goes back to its reset state —the board's NeoPixel, to the firmware—. The destructor calls it. Afterwards, using the `Strip` is a `RuntimeError`. |

<a id="stdlib-freq"></a>
### 14.14 `Freq`

Frequency meter by edge counting (`import Freq`): measures the frequency of a pin's signal by counting the edges arriving during a known time window (*gate time*) — `Hz = edges / window`. It relies on `Pulse.Counter` (hardware counting, no CPU cost); the pin has the same channel restriction as `Pulse.Counter` ([§14.6](#stdlib-pulse)).

| Member | Description |
|---|---|
| `Freq.RISING() / FALLING() / BOTH()` | Which edge to count. |
| `Meter(pin, edge)` | Creates the meter on a pin. |
| `measureHz(windowMs): integer` | A single measurement with a `windowMs` ms window. |
| `measureHzAvg(windowMs, samples): integer` | Average of `samples` measurements. |
| `maxHz(windowMs): integer` | Maximum measurable frequency with that window before the 16-bit counter overflows; above it, use a smaller window. |
| `close()` | Releases the counter —its unit and its pin, like `Pulse.Counter`'s `release()`—. The counter is an `owner` of the meter: if the `Meter` dies, its destructor releases it. |

<a id="stdlib-net"></a>
### 14.15 `Net`

Simple TCP client (H11). Available on the **PC** (both VMs: OS sockets) and on the boards with WiFi: the P4, the S3 and the C5 (lwIP). The WiFi has to be switched on first with [`Air.Wifi`](#stdlib-air); while it is off, `connect` gives `false`. On the other boards any operation raises a *catchable* `RuntimeError` («`Net: sin red en esta plataforma`»).

```
import Net

var c: Net.Tcp := Net.Tcp()
if c.connect("192.168.1.50", 7000, 2000) then   // timeout in ms
  c.sendStr("hi")                    // also send(data: byte[])
  var resp: string := c.recvStr(256, 1000)  // "" = timeout
  print resp
  c.close()
endif
```

Contract (identical in both VMs):

- `connect(host, port, timeoutMs): boolean` — a connection failure (refused, timeout, DNS) is a *normal* result: it returns `false`, it does not throw.
- `recv(max, timeoutMs): byte[]` / `recvStr` — **always with a timeout** (on a micro an infinite recv would block the entire worker). Timeout → empty `byte[]` / `""`. The peer closed → catchable `RuntimeError`.
- `send(data: byte[]): integer` / `sendStr(s)` — sends everything or raises `RuntimeError` (broken connection).
- `isOpen()`, `close()` (tolerant; `~Tcp()` calls it: a connection that dies is closed). There are also low-level module functions (`Net.tcpConnect/tcpSend/ tcpRecv/tcpClose`) with an integer handle.

<a id="stdlib-gui"></a>
### 14.16 `Gui` — separate volume

The graphical interface (screen and widget tree, the full catalog, color and fonts, `.win` forms, execution on host and board) has its own volume: [**BasicPlus — Graphical interface**](gui.html.md) (§18–25), with the quick reference of the `Gui.*` API in [§24](gui.html.md#referencia).

What changes in V6, in one line: the loop can run in its own thread (`Gui.start()` / `Gui.stop()` / `Gui.join()`; `Gui.run()` still blocks and equals `start()`+`join()`), there is a `Container` class and every constructor takes `parent: Container`, `Keyboard.attach` becomes `setTextarea`, any widget serializes with `toJson()`, `Gui.shot(path)` captures the screen to a `.shot` file (`bp png` turns it into a PNG) and the screen is the size of the board's panel (on the host, 480×320 unless `--screen=WxH`).

**What changes in V7: the GUI comes in a pack.** LVGL, the interface engine, is no longer inside any image: it is burned onto the board as one more pack —`Gui.pack` (the C5, the P4s and the DK2) or `GuiMini.pack`, trimmed for small displays (the C6)— and, on the boards with an SPI display (the C5 and the C6), also the driver's, `DriverSpi.pack`, which reads the board's panel from its ENV. The packs' engines need their RAM block, `packRam=<KB>` in the ENV (§15.9). Without the pack, `Gui.Screen()` says so: «`GUI: esta placa no tiene el pack 'LVGL' grabado (la GUI llega por el pack)`»; and with the pack but without the block, «`GUI: el pack de la GUI esta, pero su motor no cargo: falta packRam= en el ENV`». Board-by-board detail in the [graphics guide §23.4](gui.html.md#ej-pantalla). Five displays: the DK2, the P4 (kit and Waveshare), the ESP32-C6 (ST7789 240×240 over SPI) and, new in V7, the ESP32-C5 (ST7789 240×320 over SPI, with touch).

<a id="stdlib-sd"></a>
### 14.17 SD card

An SD card gives a microcontroller what it does not have: **room**. Gigabytes for logs, measurements, databases or configuration files, instead of the few megabytes of internal flash. And it is used like the rest of the filesystem: **it is just another path**.

```
writeFile("/sd/readings.csv", "time;value\n")
```

<a id="stdlib-sd-where"></a>
#### 14.17.1 Where it works

| family | SD card | how |
|---|---|---|
| **RP2350** (Pico 2, Metro) | yes | over SPI |
| **ESP32** (C5, C6) | yes | over SPI, on the display's bus (V7) |
| **ESP32** (P4) | yes | over SDIO, 1 or 4 bits |
| **ESP32** (S3, C3) | no | — |
| **STM32** | not yet | — (no board in the lineup has a slot) |

> **The card is a capability of the IMAGE, not of the board.** The RP2350 firmware is a single image for Pico 2 and Metro. What the Metro has on top is the **soldered reader**; on a Pico 2 you can wire one to whichever pins you like and it works the same, with no special firmware. The same goes for the C5, C6 and P4 images; the S3 and C3 ones have no reader.

The boards that come with a reader —their environment line (below) and plugging the card in is all it takes—: **Metro** (RP2350), **ESP32-P4** and the Waveshare **ESP32-C5** and **ESP32-C6** boards (their TF slot sits on the display's SPI).

<a id="stdlib-sd-pins"></a>
#### 14.17.2 Telling it where the reader is

The pins **do not go in the code**: they go in the board's environment, under the `sd` key. That way the same program works with two different wirings, which is the same idea that lets a `.mod` run on any family.

**On RP2350** (SPI) — this is how the Metro's are wired:

```
sd=sck:34,mosi:35,miso:36,cs:39,cd:40
```

**On the ESP32-C5** (SPI, on the same bus as the display) — the short form: the pins belong to the bus, which the board declares in its own line (`spi2=sck:6,mosi:7,miso:8`), and the SD only says which one, its CS and its speed (on the **ESP32-C6**, the same with its CS: `sd=bus:2,cs:4,khz:10000`):

```
sd=bus:2,cs:23,khz:10000
```

**On ESP32-P4** (SDIO) — this is the P4's:

```
sd=clk:43,cmd:44,d0:39,pwr:45,pwralto:0
```

The keys the SDIO variant accepts are `clk`, `cmd`, `d0`…`d3` (for 4 bits), `pwr` and `pwralto` (the pin that powers the rail and the level that switches it on), `slot`, `khz` (speed, default 20000) and `ldo` (the internal I/O regulator).

The SPI variant accepts `sck`, `mosi`, `miso`, `cs` (the only compulsory one), `bus`, `cd` and `cdalto`, and `khz`: the working speed, default 25000 —the top of the card's SPI mode—. It belongs to the *board*, not to the card: on the C5, MISO goes through the ESP32's GPIO matrix, which delays it, and bits get garbled at 25 MHz; at 10000, clean.

`cd` on SPI is the *card detect*, optional: if you do not wire it, drop it from the line.

<a id="stdlib-sd-mount"></a>
#### 14.17.3 Checking that it mounted

**You do not mount anything.** If the board has the reader configured, the firmware mounts the card **at boot** and says so in the log; from then on `/sd` is there. Worth reading those lines before suspecting your program. On the P4:

```
sd: SDIO slot 0, 1 bit(s), clk 43 cmd 44 d0 39 | pwr 45 (activo bajo) | ldo 4 | 20000 kHz (por defecto)
sd: montada en /sd por SDMMC (particion en el bloque 2048)
```

**The two lines say different things and you need both.** The first is the CONFIGURATION: which pins and at what speed it is going to try. The second is the RESULT. If only the first appears, the problem is wiring, power or the card itself; if the second appears, the card is there and whatever fails is yours.

**Pulling it out and putting it in with the board running** (V7). On the RP2350, with the *card detect* in the line —the Metro's `cd`—, the firmware watches the slot and says so in the log, without restarting: «`tarjeta RETIRADA — /sd desmontado`» and, when you put it back, «`tarjeta METIDA — /sd montado`». On the others (the C5, the C6, the P4), a card inserted after boot is mounted with `sd mount` on the IDE console ([IDE guide §7](guia-ide.html.md#consola)).

<a id="stdlib-sd-use"></a>
#### 14.17.4 Using it: it is just a path

With the card mounted —which the board does by itself—, everything you already know about files works under `/sd`: the file built-ins of [§13.1](#stdlib-funcs) and the [`IO`](#stdlib-io) module.

```
if not fileExists("/sd/config.txt") then
  writeFile("/sd/config.txt", "interval=60")
endif
var cfg: string := readFile("/sd/config.txt")
```

The file verbs are built-ins; nothing to import:

| verb | what it does |
|---|---|
| `readFile(path)` | the whole content, as a string |
| `writeFile(path, text)` | writes it; if it existed, **truncates** |
| `appendFile(path, text)` | appends at the end |
| `fileExists(path)` | `true` / `false` — files only (a folder: `IO.dirExists`) |
| `listDir(path)` | what a directory holds, sorted — see [§14.17.6](#stdlib-sd-list) |
| `readFileBytes(path)` | the content as bytes |
| `writeFileBytes(path, data)` | writes bytes |

**Each verb is an `open` and a `close`**, like an `IO.File` that opens, does its job and closes, so it follows its rule: a file open for writing is not opened again; for reading, as many as want to. With a `File` open for writing, `writeFile`, `appendFile`, `readFile`, `removeFile`, `rename` or `copyFile` on that path give a `RuntimeError` «ya está abierto»; with one open for reading, reading it (`readFile`, or copying from it) works, and writing it does not. And the same between two verbs: the first one that opens a file for writing keeps the others from opening it — if two threads `appendFile` the same file at once, the second gets «ya está abierto». (They used not to look: on the SD, writing a file that was open like this corrupted the volume.) A **log** that several threads write at once is not a file: it is a channel, the `Log` module, which takes writers at the same time and orders them (like the arbiter of an I2C or SPI bus), and writes its file itself.

**And the `IO` module** for the rest: `mkdir`, `rmdir`, `removeFile`, `rename`, `copyFile`, `fileSize`, `isDirectory`, `dirExists`, `lastModified`, and the path family `pathJoin`, `pathParent`, `pathBasename`, `pathExtension`, `pathAbsolute`.

```
import IO

IO.mkdir("/sd/logs")
var f: string := IO.pathJoin("/sd/logs", "2026-08.csv")
appendFile(f, "12:00;21.5\n")
print IO.fileSize(f), "bytes"
```

Paths **always use `/`**, also on Windows when you test on the PC. And in string literals the usual escapes work: `\n`, `\t`, `\r`, `\\`, `\"` and `\0`.

<a id="stdlib-sd-fs"></a>
#### 14.17.5 Two filesystems, side by side

Worth having it clear, because it explains several differences:

- **Internal flash** runs **littlefs**, meant for memory that wears out and for power cuts. That is where `/app`, `/lib` and `/sys` live.
- **The card** runs **FAT**, which is what a PC understands. You can pull it out, put it in your laptop and read what the micro wrote.

That is the whole reason the card is the place for data and the flash the place for programs: you want to be able to read data somewhere else.

> **Format cards as FAT32.** Cards over 32 GB often ship as exFAT, and **exFAT is not supported yet** — reformat them. Verified on hardware: a 128 GB SanDisk on Metro and P4, and a 32 GB one on the Metro.

<a id="stdlib-sd-list"></a>
#### 14.17.6 Listing a directory

```
var names: string[] := listDir("/sd/logs")
for f in names do
  print "  ", f
next f
```

It returns a `string[]`, and arrays are walked with `for … in … next`. Careful with this, it is easy to mix up: `.length()` belongs to **objects** —a `List`, a `StringBuilder`—, not to arrays.

**In both VMs since V7** (H3, 21-sep): before, only in the Java VM. It returns the names **sorted by bytes** — the order of a listing belongs to the file system, and this way the same program prints the same on the PC and on the board — and throws a catchable `RuntimeError`, *«listDir('…'): no se pudo abrir»*, if the directory does not exist (the Java VM used to return an empty list silently). No `.` or `..`. On the board the names go through the VM's scratch area (8-16 KB): a directory whose names do not fit throws *«demasiadas entradas»*.  
Do not confuse it with the IDE's file tree, which also lists the card: that is the firmware over the debug protocol, not your program.

And a note on cost: on a micro, listing a directory with many files **takes real time**, especially if the card is slow. It is not a free operation you can put inside a loop.

<a id="bytes"></a>
#### 14.17.7 Text and bytes

`readFile`/`writeFile` work with **text**; `readFileBytes`/`writeFileBytes`, with **raw bytes**. Use the byte versions for images, binaries or anything that is not text: pushing a binary through the text version corrupts it.

> `readFile` **brings the whole file into memory**. On a micro with a few megabytes of heap, reading a 50 MB file that way will not end well. For large files, either split them or use a database — that is what it is for (see [databases](basedatos.html.md)).

<a id="stdlib-sd-traps"></a>
#### 14.17.8 Known traps

**Without pull-ups a bus does not go quiet: it LIES.** If you wire your own reader, do not skip the resistors. A pad with no pull-up starts pulled down and returns `0x00`, which the card accepts as a valid answer — so instead of silence you get a false positive, which is far harder to debug.

**Rail power.** On boards that switch the card's supply with a transistor (the P4 does it on GPIO45), polarity matters: `pwralto:1` if the rail turns on with the pin high, and without it active-low is assumed — which is the P4 kit's case (a P-channel MOSFET: it conducts with the gate low, measured on the board). Get it wrong and the card simply does not answer, without saying why: with `pwralto:1` on the kit, `ESP_ERR_INVALID_RESPONSE` in the log.

**Do not mix up the board and the image.** When you read «Pico» in the documentation or in a message, it almost always means the firmware **image**, which is a single one for Pico 2 and Metro. The Pico 2 as it ships has no reader; the Metro does.

**Pulling the card out while the program is writing** corrupts whatever was half-written, exactly like on a PC. There is no magic: close first.

<a id="stdlib-sound"></a>
### 14.18 `Sound` (the sound)

A `.wav` through the speaker, **always in parallel** with the program (`import Sound`): `play` returns at once and the sound goes on while the program does its own work —a warning, for example—. One at a time: a `play` while another one is sounding cuts the previous one. It is played by a task of its own, which reads the file in chunks of about 50 ms; the path is resolved like that of `readFile`.

```
import Sound
Sound.play("/sd/aviso.wav")   // returns at once: it sounds while the program goes on
...
var pct: integer := integer(long(Sound.getPosition()) * 100 / Sound.getLength())
```

| Member | Description |
|---|---|
| `play(path)` | Plays the WAV and returns. What is known at the call —the file cannot be opened, it is not a WAV, a format that is not supported, a board with no sound— is a `RuntimeError` right then; what comes later (the SD card fails halfway through a song) stops the sound and is left in the log. |
| `stop()` | Stops whatever is sounding (if nothing is, it does nothing). |
| `isPlaying(): boolean` | `true` from `play` until it ends, or until `stop`. |
| `setVolume(v)` / `getVolume(): integer` | From 0 (nothing) to 100, 85 by default; outside that range, an error. It also works while it is sounding. The scale goes from −50 to 0 dB, half a dB per step, and on the PC it is 20 dB lower than on a board, so that 85 sounds alike. |
| `getPosition()` / `getLength(): integer` | The progress of the last `play`, in bytes of sound (without the WAV header): the position moves forward in chunks of about 50 ms and, at the end, it equals the length. The percentage, in `long`: a WAV of more than 21 MB times 100 no longer fits in an `integer`. |
| `isAvailable(): boolean` | Does this board have sound? The common layer answers it, without touching anything. |

**The formats:** PCM WAV of 8 or 16 bits, mono or stereo, from 8000 to 48000 Hz, at the file's own rate. No MP3.

**Where it sounds.** On the PC, through the system's audio (the C VM, on Windows); with `BPVM_SONIDO=mudo` in the environment, silently and at the same pace (the tests). On a board, if its family carries the sound part and its ENV the `audio` line ([appendix A](#env)) —the P4, with its ES8311 codec—; if not, `play` gives the error with the reason and `isAvailable()` returns `false`. The codec and the amplifier are only switched on while it sounds. When the program ends, whatever is sounding stops, the progress goes back to 0 and the volume to 85.

<a id="stdlib-air"></a>
### 14.19 `Air` (WiFi and Bluetooth)

Wireless (`import Air`), two classes: `Air.Wifi` and `Air.Bluetooth`. From a program you only switch it on and off: the network goes in a file, the same on every board, and the rest is sockets ([`Net`](#stdlib-net)).

```
import Air
import Net

var wifi: Air.Wifi := Air.Wifi()
if wifi.turnOn() then            // switches on and waits for an IP
  var c: Net.Tcp := Net.Tcp()
  if c.connect("192.168.1.50", 8080, 3000) then
    c.sendStr("hello")
    c.close()
  endif
endif
wifi.turnOff()
```

| Method | What it does |
|---|---|
| `turnOn(): boolean` | Switches on with `/sys/wifi.json` and waits for an IP, up to 20 s, without stopping the other threads. `true` with an IP; `false` if it does not get one (the network does not show up, the password is wrong), with the reason in the log. If it does not make it in time, the radio keeps trying. On a board without WiFi or without the file, a `RuntimeError` with the reason |
| `turnOff()` | Switches it off completely, also if the boot switched it on. If the IDE was connected over the network, it is cut off |
| `isConnected(): boolean` | There is a link and an IP: connections can be opened. If the network is lost, the board looks for it on its own |
| `isAvailable(): boolean` | Does this board have WiFi? Without switching anything on |

**The file.** `/sys/wifi.json`: `ssid`, and if needed `password`, `country` (two letters), `autoStart` (`true`: it switches on when the board boots) and `autoOff` (seconds without activity before it switches itself off; 600 by default, 0 never; an open connection counts as activity). It is written with the IDE's **WiFi** button, or like any file. The password is stored in the clear. `/sys/net.json`, if needed: `hostname`, for DHCP, or `ip`, `mask`, `gateway` and `dns` for a fixed IP. The ENV key `wifi` overrides `autoStart` ([appendix A](#env)).

**When the program ends**, if it touched it, the WiFi goes back to what the configuration says: if the program switched it on and the file does not say `autoStart`, it is switched off; if the program switched it off and the file says so, it is switched on, so the IDE can come back in over the network.

**Where.** The P4 (with `radio=c6` in its ENV), the S3 and the C5. Not the C3 or the C6: they have no PSRAM, and just by carrying it they would lose between 33 and 88 KB of RAM. On the Pico 2 W, a pack, later on. On the **PC**, `turnOn()` always gives `true`, because it already has a network.

<a id="stdlib-air-bt"></a>
#### Bluetooth: `Air.Bluetooth` and `Air.BtDevice`

Turn on and off, scan, connect and disconnect (V8). A device is connected by its address: the first time it is paired and remembered in `/sys/bluetooth.json`; after that it comes back on its own, without pairing again.

```
import Air

var bt: Air.Bluetooth := Air.Bluetooth()
bt.turnOn()
var seen: List := bt.scan(10000)           // 10 s: the ones in pairing mode
var d: Air.BtDevice := Air.BtDevice(seen.get(0))
if bt.connect(d) then                  // the first time it pairs and remembers it
  print d.getName() + " connected"
endif
bt.disconnect(d)                             // that connection; Bluetooth stays on, with the others
```

| `Air.Bluetooth` method | What it does |
|---|---|
| `turnOn(): boolean` | Turns on and waits until ready, up to 5 s; remembered devices come back on their own (one that is not there is not an error: it just does not connect). On a board without Bluetooth, a `RuntimeError` |
| `turnOff()` | Turns off: closes every connection |
| `isOn(): boolean` | Is it on and ready? |
| `isAvailable(): boolean` | Does this board have Bluetooth? Without turning anything on |
| `scan(ms): List` | Looks for `ms` for devices in pairing mode: a `List` of `BtDevice`, without the connected ones (up to 16) |
| `connect(d): boolean` | Connects. The first time it pairs and remembers it; after that, by its address. `false` if it is not found |
| `disconnect(d)` | Closes that connection; it stays remembered: it comes back with another `connect`, or on its own when Bluetooth is turned on again |
| `forget(d)` | Forgets it: the connection, its keys and its entry in the file |
| `listDevices(): List` | The remembered ones, in the order they were first connected |
| `isConnected(): boolean` | Is any remembered device connected? |
| `isAutoStart(): boolean` / `setAutoStart(b)` | Whether it turns on by itself at boot: the file says so (`"autoStart"`, as in `/sys/wifi.json`) |

`Air.BtDevice`: `getName()`, `getAddress()` (`"AA:BB:CC:DD:EE:FF"`), `getAddressType()` (`"public"` or `"random"`), `getKind()` (`"keyboard"`, `"mouse"` or `"unknown"`: a keyboard does not say so in the scan, it does when connected), `getRssi()` (the scan's signal strength, in dBm; 0 for remembered ones) and `isConnected()`.

**The file.** `/sys/bluetooth.json` is written by the class: `autoStart` and the devices, by address; and if needed, by hand, `autoOff` (seconds without use before it turns itself off; 600 by default, 0 never; a key or the mouse count as use). The board reads it at boot: if it says `autoStart`, it turns on and waits for the remembered ones. The ENV key `bt` overrides `autoStart` ([appendix A](#env)). The pairing keys are kept by the board separately, in `/sys/bluetooth.keys`, and `forget` also deletes the device's keys. **When the program ends**, if it touched Bluetooth, it goes back to what the file says.

```
{ "autoStart": true,
  "devices": { "02:00:00:00:00:01": { "name": "Teclado simulado", "addressType": "random", "kind": "keyboard" } } }
```

**Where.** On the **P4** (with `radio=c6` in its ENV: it goes through the same C6 as the WiFi), the **S3** and the **C5**, with Bluetooth LE keyboards and mice: what they send reaches [`Keyboards`](#stdlib-keyboards) and [`Mice`](#stdlib-mice), and in a program with a GUI, its controls. A device that is neither a keyboard nor a mouse does not stay: `connect` returns `false`, and the log says why. The C3 and the C6 do not carry it (they are short of RAM, with no PSRAM), nor do the Pico 2 or the STM32s: there `isAvailable()` is `false` and `turnOn()` throws a `RuntimeError`. On the **PC**, a simulated Bluetooth, the same in both VMs and in the IDE's simulated micro, with two test devices: «Teclado simulado» (keyboard) and «Ratón simulado» (mouse).

**Two things about the devices, not the board.** A mouse that is fully asleep (after many minutes unused, or after a while with the board's Bluetooth off) may not wake up when moved: a click does, and within a few seconds it comes back on its own; a keyboard wakes up with any key. And some devices change address every time they are paired with something else (another board, the PC): the board no longer recognises them, and they have to be paired again (`forget` the old one and `connect` the new one, from `scan`).

<a id="stdlib-keyboards"></a>
### 14.20 `Keyboards` (the keyboard)

The keyboard (`import Keyboards`; V8). A key is a 32-bit number: the low part is the key code from the HID standard (what a Bluetooth or USB keyboard sends), named in the `Keyboards.Key` enum; the high part is the state: Ctrl, Shift, Alt, AltGr, Windows and the locks. Its character comes separately: `"a"`, `"Ñ"`… or `""` for a special key (Enter, the arrows).

```
import Keyboards

var tk: Keyboards.Keyboard := Keyboards.Keyboard()
tk.onKey := screen::key                  // one notice per press, on the thread that created the keyboard

function event key(t: Keyboards.Keyboard, k: integer, c: string)
  if Keyboards.isKey(k, Keyboards.Key.ENTER) then
    print "Enter"
  elseif Keyboards.isCtrl(k) and Keyboards.isKey(k, Keyboards.Key.C) then
    print "Ctrl+C"
  elseif c != "" then
    print "key: " + c
  endif
end key
```

| `Keyboards.Keyboard` | What it does |
|---|---|
| `Keyboard()` | A program keyboard: from now on, every key reaches it through `onKey`, on the thread that creates it, which has to be running (a loop with `sleep`, for example). There can be several: every key goes to all of them |
| `onKey(t, k, c)` | The event: the keyboard, the key (the 32-bit number) and its character. One notice per press: a key held down does not repeat, and the modifiers on their own (Shift, Ctrl…) are not keys |
| `hasKey(): boolean` | Is any key waiting? From any thread |
| `readKey(): integer` | The next key (0 if none). There is one buffer, the system's: whoever reads first takes it |
| `getChar(): string` | The character of the last key read by `readKey` |
| `isConnected(): boolean` | Is a keyboard connected? |
| `close()` | Stops receiving events (`readKey` still works) |

**What a key carries**, without looking at bits: `Keyboards.getCode(k)` (the code), `isKey(k, Keyboards.Key.X)`, `isShift(k)`, `isCtrl(k)`, `isAlt(k)` (the left one), `isAltGr(k)`, `isWin(k)`, `isCapsLock(k)`, `isNumLock(k)`, `isScrollLock(k)` and `isFn(k)`. The bits, in case you need them: 16 left Ctrl, 17 left Shift, 18 Alt, 19 left Windows, 20 right Ctrl, 21 right Shift, 22 AltGr, 23 right Windows, 24 Caps Lock, 25 Num Lock, 26 Scroll Lock and 27 Fn. The enum keys, with their English names: `A`…`Z`, `D0`…`D9`, `ENTER`, `ESCAPE`, `BACKSPACE`, `TAB`, `SPACE`, `F1`…`F24`, `UP`, `DOWN`, `LEFT`, `RIGHT`, `HOME`, `END_KEY` (`end` is a reserved word), `PAGE_UP`, `PAGE_DOWN`, `INSERT`, `DELETE`, the keypad ones (`KP_0`…) and the rest of the standard.

**Where.** On the **PC**, the keys of the GUI window, only with a keyboard connected: the simulated one from [`Air.Bluetooth`](#stdlib-air-bt), «Teclado simulado». Without a GUI there is no keyboard on the PC. The character is the system's (the PC keyboard layout). In a program with a GUI, the GUI itself takes the keyboard to its controls (the focus, Tab, Enter), and the screen has the keys as they come, `onKey` ([gui.html §22.6](gui.html.md#ev-teclado)). On the **boards with Bluetooth** (the P4, the C5 and the S3, [§14.19](#stdlib-air-bt)), a Bluetooth keyboard, with or without a screen; the character is the one of the US layout (each country's, later on): a Spanish keyboard gives its `ñ` as `;`.

<a id="stdlib-mice"></a>
### 14.21 `Mice` (the mouse)

The mouse (`import Mice`; V8). It goes with a screen: its position is in the points of that screen, like the GUI's (`(0,0)` at the top left; with the screen rotated, as it is seen). Without a screen it can be connected, but it does nothing. The buttons, named in the `Mice.Button` enum: `LEFT`, `RIGHT`, `MIDDLE`, and `BACK` and `FORWARD`, the two side buttons many mice have.

```
import Mice

var mo: Mice.Mouse := Mice.Mouse()
mo.onPress := screen::pressed            // on the thread that created the mouse
mo.onMove := screen::moved
mo.onWheel := screen::wheel

function event pressed(m: Mice.Mouse, b: Mice.Button, x: integer, y: integer)
  if b == Mice.Button.LEFT then
    print "click at " + x + ", " + y
  endif
end pressed

function event moved(m: Mice.Mouse, x: integer, y: integer)
  if m.isPressed(Mice.Button.LEFT) then
    print "dragging at " + x + ", " + y
  endif
end moved

function event wheel(m: Mice.Mouse, d: integer)   // +1 up, -1 down, per notch
end wheel
```

| `Mice.Mouse` | What it does |
|---|---|
| `Mouse()` | A program mouse: from now on, what the mouse does reaches it as events, on the thread that creates it, which has to be running (a loop with `sleep`, for example). There can be several: each one gets every event |
| `onPress(m, b, x, y)` | When a button is pressed: the mouse, the button and the point where it was pressed. The `onMove` to that point comes first. There is no event on release, for now |
| `onMove(m, x, y)` | When it moves, with **only the last position**: if between two turns the mouse goes through several points, the program gets the last one (a Bluetooth mouse sends about 100 reports a second). The buttons and the wheel are never lost: they come in order |
| `onWheel(m, d)` | The wheel: the notches, +1 up and -1 down |
| `getX(): integer`, `getY(): integer` | The position, as it is now. From any thread |
| `isPressed(b: Mice.Button): boolean` | Is that button pressed, now? That is why, if the program is slow, the `onMove` at the end of a drag may reach it with the button already released |
| `isConnected(): boolean` | Is a mouse connected? |
| `close()` | Stops receiving events (`getX`, `getY` and `isPressed` still work) |

**Where.** On the **PC**, the mouse of the GUI window, only with a mouse connected: the simulated one from [`Air.Bluetooth`](#stdlib-air-bt), «Ratón simulado». As a touch screen, the window stays the same: the GUI buttons and fields respond to the PC mouse, connected or not. Without a GUI there is no mouse on the PC. In a program with a GUI, the GUI itself takes the mouse to its controls, with an arrow, and with «Ratón simulado» the PC mouse stops acting as a touch screen ([gui.html §22.6](gui.html.md#ev-teclado)). On the **boards with Bluetooth and a screen** (the P4 and the C5, [§14.19](#stdlib-air-bt)), a Bluetooth mouse, with the GUI's arrow; on the S3, which has no screen, it connects but does nothing. When fully asleep, a click wakes it up.

<a id="stdlib-devices"></a>
### 14.22 The devices: `bpdevices`

The installation brings the libraries of some devices, with their source, in `bpdevices/`. They are imported like those of the library (`import Bmp280`), but they do not live on the board: they belong to the program, and the IDE and `bp` upload them with it. On the PC, the compiler leaves their copy beside the program, in its output folder (V9). The I2C ones ask for a bus ([§14.3](#stdlib-i2c)): an `I2c.HardI2C` or a software one. Their whole API, with `bp api Bmp280`.

| Module | What it is | How it is used |
|---|---|---|
| `Bmp280` | Pressure and temperature: Bosch BMP280 (and BME280, without its humidity). I2C, `0x76` or `0x77` | `Bmp280.Sensor(bus, 0x76)`: `begin(): boolean` (is it there?), `measure()` and then `temperature()`, in °C, and `pressure()`, in hPa (`double`) |
| `Bme688` | Temperature, humidity, pressure and gas: Bosch BME680 and BME688. I2C, `0x76` or `0x77` | `Bme688.Sensor(bus, 0x76)`: the same, plus `humidity()`, in %, `gas()`, in ohms, and `airIndex()`, from 0 to 100 (approximate: it does not measure CO2) |
| `Mcp9804` | Temperature: Microchip MCP9804. I2C, from `0x18` to `0x1F` | `Mcp9804.Sensor(bus, 0x18)`: `readTemp(): float`, in °C |
| `Pca9554` | Eight input/output pins: PCA9554, from `0x20` to `0x27`, and PCA9554A, from `0x38` to `0x3F`. I2C | `Pca9554.Expander(bus, 0x20)`: `setDir(m)` (each bit a pin: 1, input; 0, output), `writeOut(v)` and `readIn()` |
| `Ad7177` | A 24-bit converter: Analog Devices AD7177-2. SPI, mode 3 | `Ad7177.Adc(bus, cs, sync)`: `leerId()`, `leerPowerV()`, in volts, and its registers (`rreg`, `wreg`, `readData`…) |

The examples: `samples/Bmp280Demo.bp`, `samples/Bme688Demo.bp`, `samples/tempread.bp`, `samples/adcid.bp` and `samples/adcpower.bp`. To test without the sensor, a class of yours that extends `I2c.I2C` and answers as it would is a valid bus: that is all the library asks for.

<a id="seguir"></a>
## Where to go next

| I want to… | look at |
|---|---|
| write and read files | `samples/FileTest.bp` |
| the `IO` operations | `samples/FileOpsTest.bp` |
| raw bytes | `samples/FileBytesTest.bp` |
| the examples of this page, runnable | `samples/SdDoc.bp` |
| a database on the card | `samples/SqlDemoSd.bp` and [databases](basedatos.html.md) |

The examples of this page are **executed**, not assumed: `samples/SdDoc.bp` runs them on both VMs with the same output. What belongs to the card itself —mounting, pins, FAT— was measured on the board.

<a id="packs"></a>
## 15. Packs

A **pack** is an artifact burned onto the board holding several files: `.mod` modules, their `.mdn` native bridges, resources and —if needed— native code that runs in place. It is good for two things that matter on a micro:

- **Shipping a library in one piece.** A pack is burned once and stays; the programs using it do not carry it around.
- **Not making everyone pay for the big stuff.** SQLite is larger than the whole VM. In a pack it only exists on the boards where someone wanted it.

<a id="packs-what"></a>
### 15.1 What a pack is, and what it is not

**It is not a language library.** Libraries (`Math`, `Json`, `Gpio`…) travel with the image or live in `/lib`. A pack is a *container*, and what is inside can be anything: modules of yours, someone else's, or a whole engine written in C.

**It is not an archive.** It is burned into its own flash region, and that is where what really matters comes from.

> **A pack saves RAM, not just flash.** A module living in the filesystem has to be **loaded whole into memory** to run: it costs RAM for as long as the program runs. A module living in a pack runs **in place**, from flash — only its external symbol table and its data block go to RAM. The code, which is most of it, is not copied.
>
> And the VM says so when loading it: *«'X' cargado XIP desde pack (codigo en sitio)»*.
>
> So a pack is not just «a way to distribute»: it is the difference between a large library fitting or not fitting. On a board with a few hundred kilobytes of RAM, a 40 KB module that is not copied is 40 KB left for your program.

<a id="packs-kinds"></a>
### 15.2 Two kinds: library and executable

The difference is one single thing: **whether the root module has a `main`**.

| kind | when | for what |
|---|---|---|
| **Library** | the root module has no `main` | other programs import it; it is not «run» |
| **Executable** | the root module has a `main` | the pack records its entry point in the manifest and can be launched |

You do not declare it: the compiler works it out and says so when building (*«pack: LIBRERIA (el modulo raiz no tiene `main`, y no le hace falta)»*).

**And the standard library goes differently in each** (since V7). An **executable** pack is a container: it carries its program and everything it imports, standard library included, so it runs with the versions it was made with, whatever happens outside. A **library** pack carries no standard-library module at all: the compiler leaves them out and says so (*«pack: LIBRERIA sin la stdlib (#623): Core, Str no van dentro; la placa los saca del Stdlib.pack (o de /lib)»*), and the board takes them from the `Stdlib.pack` —without copying them to RAM— or from `/lib`. That way an old copy inside a library cannot shadow everyone's.

<a id="packs-build"></a>
### 15.3 Building one

A pack comes out of a **project**. The key in the `.bpbuild` is `"out": "pack"`:

```
{
  "sourceDir":    ".",
  "outDir":       "out",
  "main":         "Demo",
  "dependencies": [],
  "out":          "pack",
  "pack": {
    "name":     "DemoLib",
    "version":  "1.0",
    "provides": "DEMO",
    "notas":    "anything, for whoever reads it"
  }
}
```

And it is built like any other project:

```
bp build my/project.bpbuild
```

From the IDE, *Project → Build Project*. The result is a `.pack` in the `outDir`.

> **`provides` is declared, not derived.** It is the four-character mark a pack publishes its native API under (SQLite's is `SQLI`). Deriving it from the name —cutting it to four and upper-casing it— would work until the first name that does not look like it, so it is written. Only needed if the pack publishes native code; a pure-BP library does not need it.

<a id="packs-inside"></a>
### 15.4 What goes inside

When the project says `"out": "pack"`, this is packed:

- the **`.mod`** files from `outDir` — the compiled modules;
- any **`.mdn`** — the AOT bridges, one per architecture;
- and the **resources**, whatever is in `resources/`: images, fonts, `.win` forms, data files.

That last one is what makes a pack self-contained: a graphics library can carry its own font and ask nothing of whoever uses it.

> **The `.npk` files are an ingredient, not an output.** If the pack carries native code, its binary is copied to the `outDir` *before* building: the compiler generates `.mod` and `.mdn`, but you supply the native code. It is all in `bpstdlib/sqlite/LEEME.md`, which is the complete example.

<a id="packs-burn"></a>
### 15.5 Burning and managing them

In the IDE, the **Packs** panel. Everything you can do with the board's pack region is there:

| button | what it does |
|---|---|
| **Refresh** | reads which packs are burned and what they carry |
| **Copy pack to board…** | burns a `.pack` |
| **Delete** | removes one |
| **Format region…** | leaves the pack region empty |

The board's boot also reports: it says where the region is, how big it is and whether it could map it.

When you burn a library pack, the panel asks the board about the standard-library modules the pack uses and does not carry; if one is missing, it says so (*«[Packs] AVISO: 'SQLite' usa Str de la stdlib, no lo lleva (un pack libreria no lleva la stdlib, #623) y la placa no lo tiene: graba tambien el Stdlib.pack, o el RUN lo subira a /lib (a la RAM)»*). It is burned anyway: it is memory, not an error.

And if the board had already loaded its packs' **engines** (the first program or the first query loads them), burning, deleting or formatting a pack **restarts** it: those engines' tables point to the region as it was, and using them after the change would jump somewhere else. The panel says so and reconnects by itself (`#671`).

<a id="packs-use"></a>
### 15.6 Using one from a program

Nothing special: `import` and that is it. A module living in a pack is imported exactly like one living in `/lib`.

```
import SQLite
```

**The order in which a module is searched** is a single one, the same on the PC and on the board, and on both VMs:

1. the **running pack**, if the program was started from a pack (its modules come first: a pack is like a container, self-contained, and nothing from outside changes its insides);
2. **`/app`** — the program's folder (on the PC, that of the `.mod` being run; in a project, `/app/<project>/`);
3. **`/lib`** — the standard library (on the PC, the `stdlibDir` of `BpVM.cfg` for the Java VM and `--libdir=` for the C VM);
4. the **region of burned packs**, and there the module runs *in place* (XIP), without being copied to RAM.

Neither the directory the VM is launched from nor `/sys` (which is for configuration files) is part of that list.

> **`/lib` shadows the pack, and `/app` shadows `/lib`.** If there is a `Core.mod` in `/lib` and a different one inside a pack, the `/lib` one wins — and the diagnostics say so: *«'Core' del FS eclipsa al del pack»*. It is a useful rule (you can replace a pack module without re-burning) and a trap in equal measure. If both copies are **identical** (the same size and the same CRC), there is nothing to shadow: the pack's is loaded, in place, without spending RAM (V7, `#650`), and the diagnostics say *«'Core' del FS es igual al del pack: se carga del pack»*.  
> The most common trap is the other one: a stale copy of a stdlib module in `/app` (a leftover from another session) shadows the one in `/lib`, and the program behaves like an older version. Since V7 that **is said in the program's output**, not only in the log: `aviso: 'Str' cargado desde /app, tapa al de /lib` (only if the two copies differ). When something behaves like an older version, look for that line; and if the `/app` module is older than the one the program needs, the version rule (§17.1) rejects it outright.

<a id="packs-from"></a>
### 15.7 Saying where a module comes from

Normally you do not need to. When you do —because the module is not where it is looked for, or because you want to pin it— the `import` can state the path:

```
import OtherMod from "external/other.mod"
import lib.Util from "../shared/util.mod"
```

The name may be qualified (`lib.Util`), and the path is relative to the file that declares it. It does the same as `dependencies` in the `.bpbuild`, but declared in the file that uses it instead of in the whole project.

**It is a hint for the compiler, not for the VM.** The `from` says where the `.mod` (its interface) is *when compiling*. At run time the module is searched by its name and in the order of §15.6, like any other: a path in the PC's source tree means nothing on the board.

<a id="packs-discover"></a>
### 15.8 Discovering them at run time

A program can find out by itself which packs are burned and what they carry, without anyone telling it in advance:

```
import Packs

var p: List := Packs.list()
var i: integer := 0
while i < p.length() do
  print p.getString(i)
  i := i + 1
endwh
```

And `Packs.listIn(pack, ext)` gives the files of one pack with a given extension — handy for an application that loads every `.win` or every font it finds.

<a id="packs-native"></a>
### 15.9 Packs with native code

A pack can carry machine code and run it on the board. That is what makes it possible to bring in an engine like SQLite, and it has a few consequences worth knowing:

- **Native code is per architecture.** An ARM `.npk` is no good on RISC-V, nor is the P4's (with an FPU) on the C5, the C3 or the C6 (without one). A pack may carry several, and when it is burned each board keeps its own.
- **It runs from flash**, mapped, without being copied to RAM.
- **Pack code cannot touch the platform heap.** What it needs from the system —files, clock, memory— the firmware lends it in a table, and its memory comes from a separate arena. That is why a pack never calls `malloc`.
- **That memory is a block requested in the board's environment** (V7). The native engines —SQLite, LVGL, a display driver— take their data and their arena from a RAM block the board reserves at boot: `packRam=<KB>` in its [environment variables](guia-ide.html.md#entorno) (or `SQLite=<MB>`, 2 at least, if only the database goes), and a reset. Without it no engine loads, and the IDE's INFO says so: *«RAM packs: no hay: un pack nativo no podría cargar. Añade packRam=\<KB> …»*. The RP2350 is the exception: without the key it has an 8 KB one («8 KB @ … (por defecto)» in the INFO), and neither the GUI nor SQLite loads there. How much each board needs is in the [graphics guide](gui.html.md#ej-pantalla) and in the [databases](basedatos.html.md) one.

The complete case, end to end, is in [databases](basedatos.html.md) and in `bpstdlib/sqlite/LEEME.md`.

<a id="packs-traps"></a>
### 15.10 Known traps

**A pack relocated for a different address is no good.** Native code is burned ready for one position; if the flash layout changes, it must be re-burned. Boot says so plainly — *«realojado para OTRA direccion — regrabalo desde el IDE»* — and compares the stamp it expected with the one the pack carries.

**The FS shadows the pack** (see §15.6) when its copy is different. The most common cause of «this behaves like the old version».

**The project's database does not travel.** The `database` key in the `.bpbuild` belongs to the PC and is used to verify entities; it is **not copied to the micro**. A database is not an artifact: it is data, and it accumulates what exists nowhere else. Copying it on every run would turn «run» into «lose the field data».

**And for the same reason, do not put the database in `resources/`**: that folder *is* copied on every run, so it would overwrite yours with the project's. The compiler warns you if you try.

<a id="cli"></a>
## 16. Compilation & execution

From the command line, everything goes through `bp` (at the root of the installation: `bp.bat`, and `bp` for bash). `bp build` compiles a source or a project (the `.mod` goes to `out/` next to the source) and only says where it went, or the errors, each one with its file (`App.bp:7:15: error semántico: …`, V9): the first ten, or all of them with `--max-errores=0`; `bp run` compiles if needed and runs on the Java VM (with `--c`, on the C VM), and exits with the program's code (a project that comes out as a pack, in its pack: on the PC that is where its resources are, §15.3); `bp png` turns a capture into a PNG (§23.5 of the graphics guide); and `bp help` tells it all. The standard library is the one in [BpVM.cfg](#cli-vmcfg) and, with none in sight, the installation's. Below are the compiler and the Java VM with all their options: `bp frontend` and `bp vm`.

```
bp build samples/blink.bp          (writes samples/out/Blink.mod)
bp run samples/blink.bp            (compiles and runs)
bp run --c samples/out/Blink.mod   (on the C VM)
```

**On a board or on the simulated micro** (V9), without opening the IDE: `bp run --placa=COM22` (or the IP of a board on the network) and `bp run --sim` compile, upload what is needed —the same as the IDE's *Run on Device*: only what the board does not already have— and run; the output and the exit code, as with the PC VMs, and the argument, after the program. The simulated micro is the IDE's, with its settings and its folder: if it is not running, `bp` starts it and stops it at the end. `bp placa` does the rest: `ls` (its files), `get` (download one), `stop` (stop what is running), `info` (which board it is), `packs` (the ones burnt on it and the room left) and `pack` (burn one: a `.pack`, or one of the installation's by its name; like the IDE, it prepares it for that board). A board, or the simulated micro, serves one client at a time: with the IDE connected to it, `bp` cannot, and says so.

```
bp run --sim samples/blink.bp          (on the simulated micro)
bp run --placa=COM22 samples/blink.bp  (on the board at COM22)
bp placa COM22 ls                      (its files: /app/Blink.mod…)
bp placa COM22 get MyApp.shot          (a capture from Gui.shot; then, bp png MyApp.shot)
bp placa COM22 pack Stdlib             (burns the installation's Stdlib.pack on it)
```

The board's paths start with `/` (`/app/Blink.mod`). In Git Bash, with two (`//app/Blink.mod`): bash turns `/app` into a Windows path before it reaches `bp`, and `bp` says so if that happens.

**The API of a module** (V9): `bp api Collections` writes it in BP —its public declarations, as they are written, without the bodies—, taken from its `.mod`, which carries it. It finds the module the way an `import` written in that folder would: the standard library, the libraries of the [BpVM.cfg](#cli-vmcfg) and the packs (also `SQLite` and `Orm`, which come without source); or a `.mod`, by its path. On its own, `bp api` lists the modules that can be imported. With `--todo`, also what only a subclass sees and what belongs to the system (the names that start with `__`, [§3.2 of the manual](manual.html.md#identificadores)).

```
bp api                    (the modules that can be imported)
bp api Collections        (its API: Map, SyncList…)
bp api out/MyLib.mod      (the API of one of yours, compiled)
```

**Tests** (V9): `bp test` runs the programs of the `tests/` folder (or the ones it is given) on both PC VMs, each in its own process, with no screen and with a time limit (`--tiempo=N`, 60 s if not given: a test that does not end does not hang the others). A test passes if it compiles, ends with 0 on both, prints the same on both and, if it has its `X.out` beside it, prints that; `bp test --guarda` writes each one's `X.out` with what it prints now (look at it before taking it as good). The checks, with the [`Assert`](#stdlib-assert) module. In a project (its `.bpbuild` in the folder, or named), the project is compiled first, and each test into its output folder: that way it finds its modules. One line per test, a failing one with its reason; it exits with 0 if they all pass. A GUI is tested the same way: [§24.4 of the graphics guide](gui.html.md#ref-pruebas). An example, a project with its tests: `samples/pruebas`.

```
bp test                   (those of tests/: «bien   tests/PruebaPila.bp» · «2 pruebas: 2 bien, 0 mal»)
bp test --guarda tests/PruebaGui.bp   (writes tests/PruebaGui.out)
```

<a id="cli-frontend"></a>
### 16.1 Frontend

```
bp frontend <file.bp> [options]
```

| Option | Effect |
|---|---|
| `--tokens` | Dump of the lexer's tokens. |
| `--ast` | Dump of the AST. |
| `--quiet` | Only the errors and warnings; if it compiles, nothing (V9). |
| `--max-errores=<n>` | How many errors are written at most (V9): 10 if not given; with 0, all of them. Warnings do not count. |
| `--compile <dir>` | Compiles to `.mod` (the interface goes inside). |
| `--interface <dir>` | Only parses and builds the interface — no code, no output file. |
| `--project <file.bpbuild>` | Compiles the whole project ([.bpbuild](#cli-bpbuild)); with `"out": "pack"`, it assembles the pack (§15.3). |
| `--dao` | With `--project`: generates the entities' DAOs and stops (see [databases](basedatos.html.md)). |
| `--stdlibDir=<dir>` | The standard library to compile against (V7). It overrides the `stdlibDir` of the [BpVM.cfg](#cli-vmcfg) the compiler finds by itself. |
| `--formato=9\|8` | The `.mod` format (V7): `9`, V7's and the default; `8`, the previous one, as an emergency exit (§17.1). What needs v9's class table is not in `8`: for instance, a string stored in an `Object` cannot be printed (V8). |
| `--backend=jvm\|mivm` | Backend (mivm is the default). |
| `-h`, `--help` | The options (V9). |

With `--compile`, the driver is recursive: it finds the `.bp` of the missing imports, builds their interfaces first (INTERFACE mode), then compiles the module, and finally recurses in FULL mode to produce the `.mod` of the deps.

<a id="cli-vm"></a>
### 16.2 VM (bpgenvm)

```
bp vm [options] <file.mod>
```

- By default it loads and runs the root `.mod`. The VM resolves the imports transitively by reading each referenced `.mod`.
- `--trace` prints PC/Opcode/CS/SP/tid per instruction.
- `--workers=N` the number of Java worker threads in parallel (default `1`, which serializes everything; `N > 1` is opt-in and equivalent to "simulated physical cores"). See [§14](manual.html.md#concurrencia).
- A **second positional argument** is the run argument that `Main(arg)` receives (`bp vm App.mod readings.db`); without it, Main gets the default value the source declares. Same on the host C VM (`bp run --c App.mod readings.db`) and in the IDE (`run App readings.db`). *V6.*
- `-d` dumps the bytecode (integrated disassembler).
- `--config <file>` loads a JSON config ([BpVM.cfg](#cli-vmcfg)) from the given path.
- `--no-config` ignores any auto-discovered BpVM.cfg and starts with defaults.
- `--no-screen`: no window. The GUI runs without a screen and `Gui.run()` returns as soon as it has nothing to do; the same name as in the C VM. *V9.*
- `-h`, `--help`: the options (also in the C VM and in the simulated micro).

**The two outputs** (V9): on standard output, only what the program prints, the same in both VMs, so `bp run X.bp > a` and `bp run --c X.bp > b` give the same file. What belongs to the VM goes to standard error: its diagnostics (`[miVM] …`, `[bpvm] …`) and, if the program dies, the error and its trace, with the file, the line and the function (` en Prueba.bp:5 (calcula)`). The exit code says how it ended.

<a id="cli-vmcfg"></a>
#### BpVM.cfg — VM configuration

```
{
  "memorySize": 524288,
  "stackBase":  262144,
  "stdlibDir":  "C:/lenguajes/pm/bpstdlib"
}
```

A JSON file with the VM's global configuration. All fields are optional; missing ones take the default value:

- `memorySize` (total bytes of the `memory` array; default 524288 = 512 KiB).
- `stackBase` (offset where the stacks start; default 256 KiB — it is validated that `stackBase < memorySize` and that at least `MAIN_STACK_BYTES` fit). If you set `memorySize` but not `stackBase`, it is derived as `memorySize/2`.
- `stdlibDir` (the standard library's directory: the PC's `/lib`). The VM looks there for a dependency that is not next to the program —the whole order, the same as on the board, in §15.6; neither the current directory nor the import's `from` count (V7)—, and the compiler compiles against it. `--stdlibDir <dir>` on the command line overrides it; on the host C VM, `--libdir=<dir>` plays the same role.

The parser accepts `// until-end-of-line` comments. It does not support arrays or nested objects (not needed today).

**Resolution**:

1. If you pass `--config <path>`, that path is loaded. If the file does not exist or the JSON is malformed, the VM aborts with a clear message.
2. Otherwise, the VM looks for `BpVM.cfg` in:
   1. the current directory (`cwd`);
   2. the directory where the root `.mod` is.

   The first one that exists is used.
3. If there is nothing, the defaults are used.

The BpIde also respects `BpVM.cfg` when you press `F5` (Run) or `F11` (Debug) — it looks first in the cwd and then next to the `.mod` it is running.

<a id="cli-vmproject"></a>
#### .bpproject — VM project file

```
{
  "main":        "out/MyApp.mod",
  "modulePaths": ["out", "../shared/modules"]
}
```

A JSON file that describes which .mod to start and where to look for the .mod of the imports. It is passed to the VM as an argument in place of the .mod:

```
bpgenvm MyApp.bpproject
```

The VM detects the type by extension (`.mod` vs. `.bpproject`). Fields:

- `main` (string, **required**): path to the .mod of the startup module. Can be absolute or relative to the directory of the .bpproject. The VM verifies that the file exists.
- `modulePaths` (array of strings, optional): directories where the VM looks for the .mod of the imports, in priority order. Relative paths are resolved with respect to the .bpproject.

**Full resolution of an import** (V7: the same order as the C VM and the board, §15.6):

1. The running pack, if the program was started from one.
2. The folder of the root `.mod` (and the working directory, if the VM has one) and each `modulePaths[i]/<basename>`, in order.
3. `stdlibDir/<basename>` (from BpVM.cfg).
4. If nothing exists, loading fails with «`falta el modulo 'X'`» (exit 2).

The current directory no longer counts, nor does the path in the import's `from`, which is a hint for the compiler (§15.7).

The parser accepts `//` comments. It supports arrays (unlike BpVM.cfg, which is flat). See `docs/BpProject.example` for an annotated template.

<a id="cli-bpbuild"></a>
#### .bpbuild — compiler and IDE project file

```
{
  "projectDir":   "./",
  "sourceDir":    "src",
  "outDir":       "out",
  "main":         "App",
  "dependencies": ["../shared/lib", "../utils/Logger.mod"]
}
```

A JSON file consumed by the compiler (the `lexer-java` frontend) and by the BpIde. Distinct from the `.bpproject`: that one lives at run-time and enumerates compiled *.mod*; this one lives at build-time and enumerates source *.bp* + compile dependencies.

Use from the CLI:

```
bp build app.bpbuild
```

Fields:

- `projectDir` (string, optional): project root. Default = the directory where the `.bpbuild` is. The rest of the relative paths are resolved with respect to this.
- `sourceDir` (string, **required**): directory with the project's `.bp` files.
- `outDir` (string, **required**): directory where the compiler emits the `.mod` files. Created on demand.
- `main` (string, **required**): the logical name of the main module (without extension). The compiler looks for `<sourceDir>/<main>.bp`.
- `dependencies` (array of strings, optional): each entry is a directory (looks for any `.mod` inside when resolving imports) or a specific `.mod` file. The one the program imports is copied to `outDir` (V9), which is where the PC's VMs look for it; if it changes, it is copied again when compiling.
- `version` (integer, optional; V7): the project's **generation**. Every `.mod` it compiles carries it in its header, and the version rule (§17.1) uses it: a dependency older than the one the module needs is rejected at load time. Without it, 0. It is not the `"version"` of the `"pack"` section (§15.3), which is free text.

**Import resolution in project mode**:

1. Other project sources under `sourceDir`.
2. `outDir` (already-compiled project modules).
3. Each `dependencies` entry in order.

**Integration with the BpIde**: a `Project` menu with entries *New Project...*, *Open Project...*, *Close Project*. When you open a project the top-left panel shows a NetBeans-style tree with three branches:

- **Sources**: all the `.bp` under `sourceDir`.
- **Output**: `.mod` under `outDir`.
- **Dependencies**: the entries of the `dependencies` field.

A double click opens the file in the editor. With a project loaded, Run/Debug compiles `<sourceDir>/<main>.bp` to `outDir/<main>.mod` and launches the VM pointing at that module. Without a project loaded, Run/Debug keeps using the active file (single-file mode).

The parser accepts `//` comments. See `docs/BpBuild.example` for an annotated template.

<a id="cli-disasm"></a>
### 16.3 Disasm

```
bp vm -d <file.mod>
```

Shows the header, imports, exports, data block and the disassembled code with annotations (function name, section, jumps with target).

<a id="cli-mcu"></a>
### 16.4 Running on microcontrollers (RP2350 / ESP32-S3 / C3 / C5 / C6 / P4 / STM32)

From the IDE, *Run on Device* runs the module on an MCU connected over a serial port (the «wire v1» protocol): the IDE uploads the `.mod` and any missing deps (it asks the board about each one and only uploads what is absent or stale —a library, by its version: another build of the same version is not uploaded—; the stdlib lives in `/lib`, which the firmware restores by itself at boot, or in the `Stdlib.pack` if it is burned, and the app's modules go to `/app`), runs it and shows the output. The files persist in the device's FS across reboots. A running program is aborted with *Run → Stop* (Ctrl+F2) or the console's `kill` command, without rebooting the board.

Five families, nine images, eleven boards. The VM's memory is decided by each image at boot and printed in the log: almost all of it is heap, and each BP thread's stack comes out of it when the thread starts (V8), so the RAM the threads use is that of the ones there are. Outside the heap there is the `Main` stack, 16 KB; `stack=N` (KB) in the board's environment changes it.

**Two cores** (V7). On the Pico 2, the Metro, the S3 and the P4 the VM runs two BP threads at once by default, one per core; on the others, one. `vm.runs=1` and `vm.cores=1` in the environment go back to one without reflashing (the detail, in the [IDE guide §9.3](guia-ide.html.md#entorno)).

| MCU | VM RAM | Notes |
|---|---|---|
| RP2350 (Pico 2 / Metro RP2350) | the SRAM the system leaves (on the Pico 2, 214 KB of heap, measured on 6 Oct, plus the threads' stacks); the Metro with `psram=1` in the environment, 6 MB in PSRAM | Wire v1 over USB-CDC; a single firmware image for both boards: the variant (A/B) is read from the silicon, and `/sys/board.json` only supplies the board name and its pins (LED, NeoPixel). `native` functions accelerated by AOT (ARM). SD card over SPI. |
| ESP32-S3 (Xtensa) | ~7 MB in PSRAM (V6: the module's 8 MB PSRAM finally enabled; without it, 160 KB) | Wire v1 over UART0 (the USB-UART bridge port); console/logs over the native USB (USB-Serial-JTAG). Persistent FS in a dedicated partition; pack region since V6. `native` interpreted (no AOT on Xtensa; out of plan). |
| ESP32-C3 · ESP32-C5 · ESP32-C6 (RISC-V, single core) *— the C3 and the C6, new in V6; the C5, in V7* | C3 and C6: about 128 KB of SRAM (whatever fits: the C6, 127 KB, 63 of heap; the C3, 112, 48 of heap); C5: ~6.5 MB in PSRAM | A single USB connector: the wire goes over USB-Serial-JTAG and the console over UART0. Flashing = BOOT+RESET by hand. `native` **accelerated** by AOT since V7 (target `riscv-imc`: RV32 without FPU, `ilp32` ABI, §17.4). Pack region on all three. The **ESP32-C6-LCD-1.3** brings an SPI display (ST7789 240×240, no touch) and Waveshare's **ESP32-C5-Touch-LCD-2.8** (32 MB of flash, 8 MB of PSRAM), an ST7789 240×320 with touch; on both the GUI comes in packs (§14.16) and the TF slot sits on the display's SPI. |
| ESP32-P4 (RISC-V) *— the P4X (revision v3.x), new in V8* | in PSRAM (all that is free minus the display's 4 MB: tens of MB) | Two images from the same code, one per chip revision (the IDF does not let one serve both). The **v1.x** one, single for its boards with a display: the panel is chosen with the `display` key of the board's environment (`display=st7701` for the Waveshare; see the [graphics guide §23.4](gui.html.md#ej-pantalla)), and wire v1 goes over UART (the USB-UART bridge port). The **v3.x** one (the ESP32-P4X), with the wire over USB-Serial-JTAG: its kit has no bridge. FS in PSRAM persisted to flash; GUI on a MIPI-DSI display with touch (LVGL, since V7 in the `Gui.pack`, §14.16); SD card over SDIO. `native` **accelerated** by AOT (RISC-V, since V4). |
| STM32U5 (Nucleo-U575ZI-Q · STM32U5G9J-DK2) | Nucleo 512 KB · Discovery 1792 KB (1 MB with the GUI's `packRam=768`) | Wire v1 over the ST-LINK's VCP; FS and packs in the internal flash left after the firmware. `native` accelerated by AOT (same Cortex-M33 as the RP2350). The DK2 carries the 800×480 LTDC display with touch (LVGL, since V7 in the `Gui.pack`). `Adc` since V7 (ADC1, §14.8); no watchdog (§14.11) and no SD card. |

The **language and the bytecode are identical** on all platforms (PC, RP2350, ESP32-S3/C3/C5/C6/P4, STM32): the same `.mod` runs on any of them. Only the hardware backend layer (GPIO, I²C, SPI…) and the AOT acceleration, which is architecture-specific, differ. Which peripheral is missing on which family is stated in each section of §14; a facade with no backend **throws** `RuntimeError` instead of making a value up.

Exit codes are the same on both VMs and the five families: 0 fine · 1 uncaught BP exception (also one in a thread that is not the main one: that thread ends, the others go on and the program exits with 1; a stack overflow, which since V7 is a `RuntimeError`, and a full heap; and a link error, `=== ERROR DE LINK: … ===`, §17.1) · 2 could not load (also a dependency rejected by the version rule, §17.1) · 3 internal VM failure · 4 out of memory to load or start the program (one that fills the heap while running gets a `RuntimeError`: that is the 1) · 130 Stop/KILL · 131 debugger. The IDE explains them with `help error`.

<a id="cli-autorun"></a>
#### Autonomous startup (`/sys/auto.txt`)

If the device's FS contains `/sys/auto.txt`, the firmware runs at boot the module named on its first line (e.g. `/app/MyApp.mod`) — the board acts as an autonomous device, without an IDE. The convenient way to manage it is the console command `autorun`:

```
/> autorun MyApp        ← writes /sys/auto.txt and persists it to flash
/> autorun              ← shows the current autorun
/> autorun off          ← disables it (removes the file)
```

Autonomous startup is safe by design: the serial port is still serviced *while* the app runs, so the IDE can connect to a board with an autorun in progress (even an infinite loop), stop it with `kill` and remove it with `autorun off` — a reflash is never needed. If the path does not exist or the program ends, the firmware continues to the normal REPL (there are no boot loops). Since V7 that also holds with a `native function` in a long loop: Stop stops it ([manual §8.3](manual.html.md#funciones-native)).

**After a fatal failure, no autorun** (V7). On the RP2350 with two cores —the default image—, a fatal failure (a HardFault, the system's memory or stack) leaves its report in the log and **restarts the board**; on the ESP32, such a failure is an IDF panic (or its interrupt watchdog), which gives its report on the console and also **restarts the board**. The next boot says so —in the log, and as the restart cause: `Machine.resetCause()` is `"fallo fatal"` on the RP2350, and `"panic/exception"` or `"int-watchdog"` on the ESP32— and **does not launch the autorun** («`autorun: … NO arranca: el arranque anterior acabo en un fallo fatal`»; the ESP32 also say it on the console): a program that fails at boot would be a restart loop. You start it by hand from the IDE. The watchdog of the `Wdt` module is not a fatal failure: after it, the autorun is launched. On the STM32, a HardFault leaves its report in the log and the board **stopped**: it does not restart by itself.

<a id="artefactos"></a>
## 17. On-disk artifacts

<a id="mod"></a>
### 17.1 `.mod` (binary, MOD9)

```
[MAGIC=0x4D4F4439]            4 bytes  "MOD9"
[dataSize]                    4
[mainOffset]                  4   offset to __startup, or -1
[importsSize]                 4
[exportsSize]                 4
[codeSize]                    4
[librarySize]                 4
[interfaceSize]               4   interface text (v6+)
[nativeSize]                  4   AOT native code (v7+); 0 if none
[gen]                         4   generation: the project's "version" (v8+); 0 if loose
[ifaceCrc]                    4   CRC32 of the interface section (v8+)
--- header (44) ---
[library  bytes]              librarySize
[imports  bytes]              importsSize   (name, fromPath) UTF pairs + deps subtable (v8+) + refs subtable (v9)
[exports  bytes]              exportsSize   (name, offset) pairs + CLASES subtable (v9)
[interface bytes]             interfaceSize interface text (§17.2)
[native    bytes]             nativeSize    .mdn blobs, one per family (§17.4)
[data block]                  dataSize      strings, constants, class descriptors
[code]                        codeSize      bytecode
```

**v6 = self-describing module.** It added `interfaceSize` to the header and an `interface` section: the `.mod` carries its own interface, and the separate `.bpi` file **no longer exists**. The VMs do *not* need it to run — they read `interfaceSize` from the header and skip the section; the compiler is what uses it, when resolving `import`s.

**v7 = the native code goes inside.** It adds `nativeSize` (36-byte header) and a `native` section between `interface` and `data` with the machine code of the `native function`s, one or several blobs depending on the architectures it was compiled for. Empty in almost every module. New sections are inserted *before* `data`, not at the end: the internal offsets of `data` and `code` are relative to their section and nothing needs recomputing.

**v8 = the module carries what it was compiled against** (V7). It adds to the header `gen` (the `"version"` of the project that compiled it; 0 for a loose file) and `ifaceCrc` (the CRC32 of its `interface` section), and in `imports` a `deps` subtable with, for each module it depends on, the generation and the interface CRC it was compiled against, and whether it extends one of its classes. With that the VMs apply **the version rule** at load time, and state it in the program's output with the same text on both (loading fails, exit 2):

- a dependency *older* than the module needs is rejected: `'Core' (gen 6) es mas antiguo que el que 'App' necesita (gen 7): actualiza /lib o recompila`. The generation is the `"version"` key (an integer) of the `.bpbuild` that compiled the dependency; V7's standard library is generation 7;
- if the dependency is v9, the rule looks no further: a newer one, or one with another interface, is decided by the late binding (below). With a v8 dependency —compiled with `--formato=8`— the rule still applies in full: the same generation with *another interface* is rejected (`'Str' (gen 7, interfaz 3e1a...) no es la interfaz con la que se compilo 'App' (interfaz 9c02...): recompila`), and a *newer* one is accepted if it links — unless the module **extends** one of its classes: children may be newer than their parents, parents may not be newer than their children (the child places its fields and methods after the parent's);
- a v6/v7 dependency carries no data: it counts as generation 0 and its interface is not checked (it is noted in the diagnostics).

**v9 = late binding** (V7, the format the compiler emits). The same 44-byte header; what changes is what the module says about the classes of *other* modules. Up to v8 it carried their numbers baked in —each method's slot in the vtable, each field's offset, the class descriptor—, and a change of shape in the library (a new method in the middle, one more field) left them wrong. A v9 carries **references by name** —the class, the member and its signature with the return type— in a `refs` subtable at the end of `imports`, and publishes its own classes in a `CLASES` subtable of `exports`; the loader builds, at load time, the classes that inherit from another module and resolves each reference once. The criterion is Java's:

- **backward compatibility**: a program compiled against a library runs with a newer version of it even if methods, fields or properties were added or reordered —also if the program extends its classes—, without recompiling it;
- **what is incompatible is rejected at load time, naming the symbol** —a member the program uses that is gone, or whose signature or type changed—: `'App' necesita 'Lib.Base.k()s' y 'Lib' (gen 8) no lo tiene (tiene 'k()i'): recompila 'App'`. Nothing runs silently with the wrong member. The text is the same on both VMs and comes out as `=== ERROR DE LINK: … ===` (over the wire, `LINK_ERROR`).

**The limits of binding by name.** An identifier has at most **63 characters** (a longer one is a compile error: «`identificador demasiado largo (70 caracteres; el maximo es 63)`»), and a function's signature —a class method or a module function: its class, if it has one, the name, the parameters and the return type— at most **160** (the compiler rejects it: «`… tiene 170 caracteres (maximo 160): acorta los nombres o divide la funcion`»). That way no name is ever truncated on one VM and not on the other.

Loaders run **v6, v7, v8 and v9** (same ABI). **v5** (`MAGIC "MOD5"`, 28-byte header) is **rejected**: it predates the 4→8-byte widening of references and running it would corrupt silently. The header size depends on the MAGIC: 28 / 32 / 36 / 44 / 44 bytes for v5 / v6 / v7 / v8 / v9.

> **From V6 to V7.** V7's compiler emits v9 (with `--formato=8`, the previous v8, as an emergency exit, §16.1). V7's VMs load V6's `.mod` files (v7): one that only uses functions and its own classes runs as is. But V7's standard library is entirely v9, and a V6 module that uses its **classes** —`List`, `RuntimeError`, `Gpio.Pin`…— does not link: what it looks up by its old name no longer exists, and the loader says so (`lib 'Core' presente pero no exporta 'Core.__cls_new_List' (la usa 'App'; version vieja?)`): that one is recompiled. Its native code does not work either: it is from another ABI (§17.4), and the function runs interpreted. The other way round, a v9 module that uses the classes of a v7 or v8 dependency is rejected, naming it (`'Lib' es MOD8 y 'App' necesita su tabla de clases: recompila 'Lib'`). Backwards yes, forwards no: a V6 image does not load a v9.

<a id="bpi"></a>
### 17.2 Module interface (text, v9)

The text carried in the `interface` section of the `.mod` (§17.1). Up to V3 it was written to a separate `.bpi` file; since V4 **no file is produced**: it is a section of the module itself, and its version line keeps the word `bpi` as its marker.

```
bpi 9
library com.example
module Util
func suma(a:integer,b:integer):integer public
func label(text:string,prefix:string="["):string public  // defaults travel
const PI:float=3.14159 public
enum Color public
  ROJO=0
  VERDE=1
end enum
class Punto public extends Core.Object   // full classes (L2 v3)
  ctor(x:integer,y:integer)
  ctor+(x:integer)                       // another constructor overload
  method modulo():double public
  prop x:integer public
end class
```

The interface exports functions (with defaults), consts (inlined in the importer), enums, arrays of primitives, tuples in signatures, and **full classes** (constructors, methods, properties, inheritance — even cross-module). All the language's primitive types (incl. `long`/`double`/ narrow ones) are valid in signatures. **Since `bpi 9` (V7) it carries no numbers**: no `layout` (how many fields, the vtable size), no slots, no offsets —a class's shape is decided by the loader when binding (§17.1)—, and a type from another module is qualified (`Core.Object`). Living inside the `.mod`, it cannot go stale with respect to the code it describes: they are emitted together or not at all.

<a id="dbg"></a>
### 17.3 `.dbg` (debug information, v3)

```
dbg 3
module Str
source C:\...\Str.bp
lines
1474 34          // bytecode offset → source line
...
vars ...         // variable name → frame slot (per function)
```

Generated alongside the `.mod`. It is consumed by the IDE's debugger for line breakpoints and to show locals by name — both against the local VM and against the device (same format).

<a id="mdn"></a>
### 17.4 Native code: the `native` section and `.mdn`

Machine code of a module's `native function`s (see [§8.3](manual.html.md#funciones-native)). It is **additive**: the `.mod` always carries the bytecode; if the runtime finds a blob for its architecture, it registers those functions as native (zero-copy load, data aligned to 4). Otherwise, everything runs interpreted.

**Since V6 the native code travels INSIDE the `.mod`** (the `native` section of the v7 format, §17.1): the IDE compiles the `native` functions in *Run on Device*, merges the blob into the `.mod` and **writes no loose `.mdn`** for the application (it even removes the one left by an earlier version, on the PC and on the board). So there are no two files that could drift apart. **In V7 the `.mod` carries the blob of ONE family**: the IDE recompiles it on every *Run on Device* and merges the one of the connected board. Taken to a board of another family, that blob is ignored and its `native` functions run interpreted; the multi-family `.mod` —one blob per family, the same file for any board— is left for V8 (`#584`). The loose `.mdn` file only survives as an ingredient of **packs** (`SQLite.mdn.RISCV` and siblings, §15.4).

**The native ABI is 9 in V7.** A blob of another ABI —that of a V6 `.mod` or pack on a V7 image, or the other way round— does not load: the board rejects it with a warning and the function runs interpreted; a pack with V6 native code (the `SQLite.pack`) is re-burned with V7's. The IDE's INFO states the board's ABI («ABI nativo: 9»), and if it is not the one the IDE generates, the IDE does not compile the native code for it and states the remedy.

| family | `native` — target: the family (the one in `aot.targets`) and its long name |
|---|---|
| RP2350 · STM32U5 (Cortex-M33) | accelerated — target `arm` (`arm-cortex-m33`; `arm-none-eabi-gcc`) |
| ESP32-P4 (RV32 with FPU) | accelerated — target `riscv` (`riscv32-esp-p4`; `riscv32-esp-elf-gcc`) |
| ESP32-C3 · C5 · C6 (RV32 without FPU) | accelerated since V7 — target `riscv-imc` (`riscv32-imc`; `ilp32` ABI; the same `riscv32-esp-elf-gcc`); with no FPU, every `float` or `double` operation is done by the firmware, and it speeds up less than integer code |
| ESP32-S3 (Xtensa) | interpreted (no AOT; out of plan) |
| PC (both VMs) | interpreted; the host has its own native path for tests only |

**Generation (CLI, outside the IDE)**: the `.mdn` is produced by the `build_mdn.sh` script in three steps — `AotMain` emits C, the family's gcc compiles it (`arm-none-eabi-gcc` to Thumb-2 PIC; `riscv32-esp-elf-gcc` with `-mcmodel=medany` plus a link step), and `MdnPack` packs it. It requires the toolchain on the `PATH` or in the `GCC` environment variable. The IDE runs this step **automatically** in *Run on Device* (toolchain detection/configuration in *Project → AOT (toolchain)…*, installation in the [IDE guide §5.1](guia-ide.html.md#aot)); the script remains for manual or automated builds.

<a id="proyecto"></a>
### 17.5 `.bpbuild` / `.bpproject` (JSON)

```
// App.bpbuild — the COMPILER's entry (and the IDE's):
{ "sourceDir": "src", "outDir": "out", "main": "App", "dependencies": [] }

// App.bpproject — the VM's entry to run:
{ "main": "out/App.mod", "modulePaths": ["out"] }
```

`bp build App.bpbuild` compiles the whole tree; `bp vm App.bpproject` runs it (both at once: `bp run App.bpbuild`). The IDE uses the `.bpbuild` as the project definition (the Sources / Resources / Output / Dependencies tree).

<a id="env"></a>
## A. The ENV keys

The ENV is the set of `key=value` settings that live in the board's flash, outside the file system: the firmware reads them and the IDE edits them (**Entorno** on the toolbar; [IDE guide §9.3](guia-ide.html.md#entorno)). A program reads any of them with `Machine.getEnv("key")` ([§14.9](#stdlib-pico)), from the flash and without rebooting; on the PC, always `""`. This is the full list of the ones V8's firmware reads.

**How they are written.** Keys are case-insensitive. Numbers go in decimal or with `0x` (a leading 0 changes nothing: `stack=064` is 64 KB). Yes/no values are `1` or `0` (`si`, `yes`, `true` and `on` also work). No spaces around the `=`. **When they take effect.** Those read at boot need a reset. Those read on each RUN apply to the next program. The screen ones are read when the GUI starts (the first `Gui.Screen()`), which in practice also means a reset.

| key | values (default) | what it does | boards | read |
|---|---|---|---|---|
| **Memory** |  |  |  |  |
| `packRam` | KB, in 4 KB pages; it must leave 128 KB to the VM. Without it, no block (on the RP2350, an 8 KB one) | The RAM block for the packs' native engines —LVGL, SQLite, the screen driver—, reserved before the VM: whatever it gets is taken from the VM. It wins over `SQLite`. When it changes, the safe thing is to re-burn the engines | all | at boot |
| `SQLite` | MB, from 2 to 4095 | The same block, asked for in MB for the database; it only counts without `packRam`. It fits where 2 MB are free | the Metro with `psram=1` · S3 · C5 · P4 | at boot |
| `psram` | `1` / `0` (0) | Turns on the Metro's PSRAM (fixed CS, GPIO47, which then belongs to the system) and the VM moves to it. On the Pico 2 it says so and does nothing; the ESP32s decide it by their image | RP2350 | at boot |
| `vmheap` | KB; by default, whatever the split leaves (on the C3 and C6, 128) | The whole VM block, heap and stacks. Above the ceiling, the ceiling; below the floor —64 KB; on the P4, 2 MB, also when `packRam` or `SQLite` take the rest— there is no VM: the board boots degraded and says why —in the board panel and when you run—, and the ENV is fixed from the IDE. Without PSRAM, what the block does not take belongs to the system (`malloc`), and that is where the tables used to load and link the modules go: on the Pico 2 the block leaves 64 KB, and a program of nine modules with `Gui` and `Json` needs about 80. It does not link and says so («no hay memoria del sistema (malloc)…», no system memory); with `vmheap=288` the block leaves 96 KB and it links | all | at boot |
| `stack` | KB; by default, 16 | The `Main` stack: the part of the VM block that is not heap (each thread's comes out of the heap, since V8). It is clamped between 16 KB and half the block, and it says so | all | at boot |
| **Threads and cores** |  |  |  |  |
| `quantum` | opcodes (1024) | How many opcodes a thread runs before yielding its turn | all | at boot |
| `vm.runs` | `1` or `2`; by default, one per core: 2 on the Pico 2, the Metro, the S3 and the P4; 1 on the rest | How many of the program's threads run at once. On the C3, C5 and C6, `2` puts the second one on the same core | RP2350 · ESP32 | at boot |
| `vm.cores` | `1` (by default, both) | Every VM task on core 0: the way back from two cores, without re-flashing | RP2350 · S3 · P4 | at boot |
| **Frequency** |  |  |  |  |
| `cpu.mhz` | MHz: the S3 and the C5, `80`, `160` or `240`; the C3, `80` or `160`; the C6, `80`, `120` or `160`; the P4, `360`; the P4X, `400`. By default, the image's: 160 on the S3, the C3 and the C6; 240 on the C5; 360 on the P4 and 400 on the P4X | The CPU frequency at boot, the same one `Machine.setCpuFreqMHz` sets ([§14.9](#stdlib-pico)). A value the board does not provide is reported in the log, and the image's stays | ESP32 | at boot |
| **The screen** |  |  |  |  |
| `display` | `ek79007` (default: the Function-EV, 1024×600) or `st7701` (the Waveshare 4.3", 480×800) | The board's MIPI-DSI panel | P4 | when the GUI starts |
| `lcd` | `<controller>,spi:N,dc:N,cs:N,w:N,h:N`; and `rst:P`, `bl:P`, `mhz:N` (20), `ram:WxH`, `off:XxY`, `seq:PATH`, `inv`, `bgr`, `traza`. P is a GPIO, or `x0`…`x7` on the expander (`xpwm`, only for `bl`) | An SPI panel —ST7789, ILI9341…— for the `DriverSpi` pack's driver; it needs its `spiN` line | C5 · C6 | when the GUI starts |
| `exp` | `ch32,i2c:N,addr:N` | The I²C pin expander (Waveshare's CH32V003); it needs its `i2cN` line | C5 · C6 | when the GUI starts |
| `touch` | `cst3530,addr:N[,i2c:N][,rst:P]`; without `i2c`, the one in `exp` | That screen's touch panel; without the line, no touch | C5 · C6 | when the pack loads and when the GUI starts |
| **Buses and the SD card** |  |  |  |  |
| `spiN` | `sck:N,mosi:N[,miso:N][,ms:N]`; `ms` from 1 to 100 (20) | Declares the board's bus N: its pins are reserved and whoever opens it hooks onto them; `ms` caps one turn. A misspelt subkey is an error in the log, and the bus stays undeclared | N: RP2350 0–1 · S3 and P4 2–3 · C3, C5 and C6 2 · STM32 1–3 | at boot |
| `i2cN` | `sda:N,scl:N[,khz:N][,ms:N]`; `khz` 100 | The same, with the bus speed. The touch panel's I²C is declared by the image (P4: `i2c0`; DK2: `i2c2`), and a line for it is rejected | N: RP2350, S3 and P4 0–1 · C3, C5 and C6 0 · Nucleo 1–4 · DK2 1–5 | at boot |
| `sd` (SPI) | `cs:N`; `sck`, `mosi` and `miso` if the bus is not in `spiN`; `bus:N` (0), `cd:N`, `cdalto:1`, `khz:N` (25000) | The SPI card reader ([§14.17](#stdlib-sd)) | RP2350 · C5 · C6 | at boot |
| `sd` (SDIO) | `clk:N,cmd:N,d0:N`, and `d1`, `d2` and `d3` all three (4 bits) or none (1 bit); `pwr:N`, `pwralto:1`, `slot:N` (0), `khz:N` (20000), `ldo:N` (4; 0 = no LDO) | The SDMMC card reader ([§14.17](#stdlib-sd)) | P4 | at boot |
| **Sound** |  |  |  |  |
| `audio` | `<codec>,mclk:N,bclk:N,ws:N,dout:N`; and `i2c:N` (0), `dir:N` (0x18), `pa:P` (none), `paalto:1` (1); `sda` and `scl`, if the board does not already declare that bus | The board's sound (`Sound`, [§14.18](#stdlib-sound)): the codec —for now, `es8311`—, the pins of its I²S, its I²C and the amplifier, which is only switched on while it sounds. Its pins then belong to the system. Without the line, the board has no sound and `Sound.play` says so. The Waveshare P4: `audio=es8311,i2c:0,mclk:13,bclk:12,ws:10,dout:9,pa:53` | P4 | at boot |
| **WiFi** |  |  |  |  |
| `wifi` | `1` / `0` | 1: it is switched on at boot, with what `/sys/wifi.json` says. 0: it is not, even if the file says `"autoStart": true`. Without the key, the file decides; and without a file, it stays off | P4 · S3 · C5 | at boot |
| `radio` | `c6` | The board carries an ESP32-C6 as its radio (not every P4 does). Without this line it has no WiFi or Bluetooth and its pins are free; with it, the SDIO and reset pins of the C6 belong to the system | P4 | at boot |
| **Bluetooth** |  |  |  |  |
| `bt` | `1` / `0` | 1: it is switched on at boot and waits for the remembered devices of `/sys/bluetooth.json` ([§14.19](#stdlib-air-bt)). 0: it is not, even if the file says `"autoStart": true`. Without the key, the file decides; and without a file, it stays off | P4 · S3 · C5 | at boot |
| **Storage** |  |  |  |  |
| `part.fs.size` | bytes, a multiple of the sector (4 KB; on the STM32s, 8 KB) | The size of the file system; the packs take the rest of the zone. Not edited by hand: the IDE's partition wizard sets it | all except the C5 and the Waveshare P4 (32 MB: the file system goes on top) | at boot |
| **Diagnostics** |  |  |  |  |
| `log` | `1` / `0` (0) | 1: the flash log keeps recording after boot —each RUN, the heartbeat…—. The boot is always recorded | all | at boot |
| `gc` | `1` / `0` (1) | 0 turns the garbage collector off for that RUN | all | on each RUN |
| `latido` | `1` / `0` (0) | 1: a heartbeat line in the log every 256 turns of the RUN; it only stays with `log=1` | all | on each RUN |
| **Written by the board** |  |  |  |  |
| `imagen.fecha` | seconds since 1970 | Not set by hand: the board writes it on its first boot —the date of its image— and `Rtc.Clock.isSet()` uses it to know whether the clock is set ([§14.10](#stdlib-rtc)). Erased, it comes back at boot; it does not change when another image is burnt | all | at boot |
| **Testing only** (not on a board in use) |  |  |  |  |
| `mpu` | `1` / `0` (0) | Each module's code becomes read-only: a write that steps on it stops the board with its PC. A diagnostic scaffold | RP2350 | on each RUN |
| `prueba.fallo` | `1` / `0` (0) | A deliberate fatal fault on **every** RUN, to test the fatal-fault path. Remove it afterwards | RP2350 · ESP32 | on each RUN |

`board`, `psramCsPin`, `flashSizeBytes` and `gpioCount` may show up in an old board's ENV: they are kept and nobody reads them.

---

BasicPlus reference manual — generated alongside development. Frontend: `lexer-java` · VMs: `miVM` (Java) and `bpgenvm-c` (host + RP2350 / ESP32-S3 / C3 / C5 / C6 / P4 / STM32) · `.mod` v9 format (late binding; embedded interface + `native` section).  
BasicPlus rests on other people’s work — [credits and acknowledgements](creditos.html.md).
