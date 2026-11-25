<!-- Generated from jc.html by scripts/docs_md.py: edit the HTML, not this file. -->

# BasicPlus — The JC language

JC is BasicPlus written with the syntax of Java and C#. This volume describes the language: how each thing is written in JC, what it is in BP and how the two differ. Everything else is shared with BP —the standard library, the graphical interface, the databases, the IDE and the boards— and their volumes apply as they are to a program in JC ([§19](#librerias)).

<a id="que-es"></a>
## 1. What JC is

<a id="otra-ropa"></a>
### 1.1 The same language, different clothes

JC (from **J**ava and **C**#) is BasicPlus with braces, semicolons and the type before the name. It is not another language: it is the same one with another syntax.

- **The compiler is the same.** `basicplus-frontend.jar` reads both `.bp` and `.jc` files, picks the reader by the extension and takes both to the same tree; from there on, everything is shared.
- **The bytecode is the same.** The same program, written in BP or in JC, gives the same `.mod`, byte for byte. Only the `.dbg` changes, because it cites its source and its lines.
- **The VMs cannot tell.** A program in JC runs the same on the PC and on the boards, is debugged the same way and uses the same libraries.

And that is why JC is neither Java nor C#: what BP does not have —lambdas, `struct`, your own generics with `<T>`…— JC does not have either, and some things behave as in BP even though they are written as in C#. They are gathered in [§17](#diferencias).

<a id="bp-o-jc"></a>
### 1.2 BP or JC?

It is a matter of taste: the result is the same, with the same speed and the same libraries. JC, if you come from Java, C# or C; BP, if you prefer blocks that close with `end` and statements without `;`.

- **They mix.** A module in JC imports modules in BP, and the standard library is written in BP ([§5.4](#import-propios)).
- **They translate.** The compiler takes a source from one language to the other, and so does the IDE, with a menu command ([§18.3](#traducir)).
- **The other volumes are in BP.** Their examples can be read in JC with the tables in this volume, or translated; [§19](#librerias) explains how to read a BP signature.

<a id="primero"></a>
## 2. A first program

<a id="hola"></a>
### 2.1 Hello, in both

BP

```
module Hola
  function main(arg: string := "mundo")
    print "hola, "; arg
  end main
end Hola
```

JC

```jc
module Hola
{
   function void main(string arg = "mundo")
   {
      println("hola, ", arg);
   }
}
```

The module goes between braces, and every statement ends in `;`. The type goes before the name (`string arg`), and a function that returns nothing is `void`. A parameter's default value is written with `=`. And `println` writes its pieces, one after another, and moves to a new line.

<a id="ejecutar"></a>
### 2.2 Compiling and running

The same commands as for a `.bp` ([reference §16](referencia.html.md#cli)):

```
bp build Hola.jc
bp run out/Hola.mod
bp run --c out/Hola.mod "a todos"
```

```text
hola, mundo
hola, a todos
```

The second argument to the VM is the one for `main`; without it, the parameter takes its default value. In the IDE, you open the `.jc` and run it like any other source ([§18.4](#ide)).

<a id="print"></a>
### 2.3 `print` and `println`

It is the first thing you notice when going from BP to JC. BP's `print` moves to a new line at the end, and the comma puts a space between the pieces. JC's does not:

- `print(a, b);` writes the pieces one after another, **with nothing between them and without moving to a new line**. It is BP's `print a; b;`.
- `println(a, b);` does the same and **moves to a new line** at the end. It is BP's `print a; b`.
- `println();` is just the line break, BP's empty `print`.

BP

```
module Piezas
  function main()
    var n: integer := 3
    print "n = ";
    print n;
    print ", y sigue en la misma línea"
    print "a"; "b"; 1 + 2
    print "a", "b"
    print
    print "fin"
  end main
end Piezas
```

JC

```jc
module Piezas
{
   function void main()
   {
      int n = 3;
      print("n = ");
      print(n);
      println(", y sigue en la misma línea");
      println("a", "b", 1 + 2);
      println("a", " ", "b");
      println();
      println("fin");
   }
}
```

Both write the same:

```text
n = 3, y sigue en la misma línea
ab3
a b

fin
```

- **A `"\n"` inside a string is just one more character:** it does not close the line. The line comes out whole —also with several threads writing at once— when a `println` closes it, or when the thread ends. For each line to come out when it should, use `println`.
- **The pieces are computed in order, and go into the line one by one.** If one throws an exception, what came before is already written and comes out with the next thing written: to avoid mixing them, compute first whatever can fail.
- `print` and `println` are JC reserved words, not functions from a library.

<a id="ejemplo"></a>
## 3. A whole program, in BP and in JC

The same program in both languages. It is the example with which JC's syntax was decided, and it touches almost all the basics: constants, a module variable and a module property, an enum, a tuple, a parameter with a default value, an `inline` function, `if`, `for`, `foreach`, `do`, `try` and `print`. First in BP:

```
module Ejemplo
  import Collections

  public const MAX: integer := 10
  const PI := 3.5
  var cuenta: integer := 0
  public property nivel: integer := 1

  public enum Color
    Rojo
    Verde := 5
  end Color

  function par(): (integer, string)
    return (1, "uno")
  end par

  public function sumar(a: integer, b: integer := 1): integer
    return a + b
  end sumar

  public function codigo(s: string, i: integer): integer
    inline CALL_BUILTIN 48
  end codigo

  public function main()
    var n: integer
    var s: string
    var l: List := List()
    { n, s } := par()
    if n > 0 and not (s == "") then print "si"
    for i := 1 to MAX step 2 do
      cuenta += i
    next
    for x in [1, 2, 3] do print x
    do
      n -= 1
    loop n > 0
    try
      throw RuntimeError("fallo")
    catch e: RuntimeError
      print e.msg
    endtry
    print "cuenta: "; cuenta; " pi: "; PI
  end main
end Ejemplo
```

And in JC:

```jc
module Ejemplo
{
   import Collections;

   public const int MAX = 10;
   const float PI = 3.5f;
   int cuenta = 0;
   public int nivel { get; set; } = 1;

   public enum Color { Rojo, Verde = 5 }

   function (int, string) par()
   {
      return (1, "uno");
   }

   public function int sumar(int a, int b = 1)
   {
      return a + b;
   }

   public function int codigo(string s, int i) inline CALL_BUILTIN 48;

   public function void main()
   {
      int n;
      string s;
      List l = new List();
      (n, s) = par();
      if (n > 0 && !(s == "")) println("si");
      for (int i = 1; i <= MAX; i += 2)
      {
         cuenta += i;
      }
      foreach (var x in [1, 2, 3]) println(x);
      do
      {
         n -= 1;
      } while (n > 0);
      try
      {
         throw new RuntimeError("fallo");
      }
      catch (RuntimeError e)
      {
         println(e.msg);
      }
      println("cuenta: ", cuenta, " pi: ", PI);
   }
}
```

Both write the same, and give the same `.mod`:

```text
si
1
2
3
fallo
cuenta: 25 pi: 3.5
```

What the comparison shows:

- **The type, always in front**: in variables, parameters, constants and the return type (`function int sumar(…)`). A BP constant can leave it out (`const PI := 3.5`); in JC, it cannot.
- **Reals, as in C#**: in JC, `3.5` is a `double`, and the `float` carries its `f`, `3.5f`. In BP it is the other way round: `3.5` is a `float`, and `3.5d`, a `double`.
- **What constructs carries `new`**: BP's `List()` is `new List()`.
- **BP's short property** is C#'s auto-property, `{ get; set; }`.
- **The unpacking** `{ n, s } := par()` is `(n, s) = par();`.
- **The word operators** are C's: `and`, `or` and `not` are `&&`, `||` and `!`.
- **The `for`, the `do` and the `catch`**, dressed as C#: `for (int i = 1; i <= MAX; i += 2)`, `do { … } while (n > 0);` and `catch (RuntimeError e)`.
- **The line break** that BP's `print` adds by itself is JC's `println`.

<a id="basico"></a>
## 4. The basics

- **Reserved words are case-sensitive**: `if`, not `If`. In BP it is the other way round: `IF` and `if` are the same word. Names are case-sensitive in both: `total` and `Total` are two names.
- **Every statement and every declaration ends in `;`**, and line breaks do not count: a statement can span several lines.
- **Blocks go between braces.** A loose brace, without the `if`, the loop or the function it belongs to, is an error: «un bloque suelto» (a loose block). With a single statement, the braces of an `if`, a `while`, a `do`, a `for` or a `foreach` can be left out (§8.1).
- **Comments**: `//` to the end of the line, as in BP, and also `/* … */`, which can span several lines.
- **Names**, as in BP: a letter or `_`, and then letters, digits or `_`, up to 63 characters. Those that start with `__` belong to the system.

```jc
/* A comment
   on several lines */
int total = 0;            // and a line comment
total = total
      + 1;                  // one statement on two lines
```

<a id="reservadas"></a>
### 4.1 The reserved words

| What for | Words |
|---|---|
| Modules | `module` `library` `import` `from` |
| Declarations | `const` `function` `class` `interface` `enum` `event` `var` `inline` `implements` `extends` |
| Modifiers | `public` `protected` `private` `static` `final` `native` `sync` `owner` |
| Types | `void` `int` `long` `float` `double` `bool` `string` `byte` `sbyte` `short` `ushort` |
| Objects | `new` `this` `base` `field` `is` `super` |
| Control | `if` `else` `while` `do` `for` `foreach` `in` `switch` `case` `default` `break` `continue` `return` `parallel` |
| Exceptions and events | `try` `catch` `finally` `throw` `raise` |
| Values | `true` `false` `null` |
| Output | `print` `println` |

`super` is reserved to tell you that in JC it is written `base`; and `implements` and `extends`, for the module headers inherited from BP. A few words are special only in their place and are valid as names outside it: `get` and `set` inside a property, `value` in its `set`, `pack` in an `import` and `Thread` in a `case` of `parallel`.

<a id="modulos"></a>
## 5. Modules and import

<a id="modulo"></a>
### 5.1 The module

A file is a module, as in BP: `module Name { … }`. Inside go, first, the `import`s, and then the definitions —constants, variables, properties, functions, classes, interfaces and enums— in any order. What is not `public` is private to the module.

```jc
module Medidor
{
   public const int MAXIMO = 100;
   int lecturas = 0;                     // private to the module
   public int ultima { get; set; }          // visible to those who import Medidor

   public function void apunta(int v)
   {
      lecturas++;
      ultima = v;
      if (ultima > MAXIMO) println("¡pasa de ", MAXIMO, "!");
   }

   function void main()
   {
      apunta(42);
      apunta(120);
      println(lecturas, " lecturas, la última ", ultima);
   }
}
```

```text
¡pasa de 100!
2 lecturas, la última 120
```

A module variable cannot be `public` (it is an error): what is shared with other modules is a property, like `ultima` ([manual §9.5](manual.html.md#props)). With `library "com.ejemplo";` before `module`, the `.mod` is called `com.ejemplo.Medidor.mod` ([manual §10.1](manual.html.md#library)).

<a id="main"></a>
### 5.2 `main` and the startup function

The program starts at `function void main()` of the root module, or at `main(string arg)` if it takes an argument (`Main` also works). And a `void` function without parameters named like the module is its **startup function**: it runs when the module is loaded, after those of the modules it imports and before `main`.

```jc
module Arranque
{
   int veces = 0;

   function void Arranque()
   {
      veces = 1;
      println("[init] cargado");
   }

   function void main(string arg = "defecto")
   {
      println("main con '", arg, "', veces = ", veces);
   }
}
```

```text
[init] cargado
main con 'defecto', veces = 1
```

With `bp run --c Arranque.mod hola`, the second line says `main con 'hola'`. Everything else about the argument —its 127-byte cap, the *autorun*, the IDE console— is as in BP ([manual §10.2](manual.html.md#main)).

<a id="import"></a>
### 5.3 `import`

The same as BP's, with their `;`, and always the first thing in the module:

| JC | BP | What for |
|---|---|---|
| `import Gpio;` | `import Gpio` | a module, by its name |
| `import com.ejemplo.Util;` | `import com.ejemplo.Util` | with its `library`; used as `Util.f()` |
| `import Helper from "plugins/helper.mod";` | `import Helper from "plugins/helper.mod"` | where the compiler finds its `.mod` or its `.bp` |
| `import Graficas from pack MisLibs;` | `import Graficas from pack MisLibs` | its interface, from that pack ([IDE guide §10.2](guia-ide.html.md#packs-usar)) |
| `import v1 from pack "SQLI";` | `import v1 from pack "SQLI"` | a pack's native functions, for whoever writes the library |

The rest, as in BP ([manual §10.3](manual.html.md#imports)): `import Core` is not needed, because the compiler always adds it —that is why `List`, `RuntimeError` or `len` can be used just like that—, and `import`s are not transitive: to name a type from another module, you have to import that module.

<a id="import-propios"></a>
### 5.4 Importing your own modules

A module in JC imports BP modules like any other: if the `.bp` is next to it, the compiler compiles it too. To import another module in JC there is, for now, one condition: **the compiler looks for the source of an `import` as a `.bp`**, so an imported `.jc` is compiled first, and its `.mod`, next to the importer or in the output folder, is what gets found. In a project, they are listed in `sources`, the imported one first ([§18.2](#proyecto)).

```jc
module Utiles
{
   public const int VECES = 3;

   public function string repite(string s, int n = 3)
   {
      string r = "";
      for (int i = 1; i <= n; i++) r += s;
      return r;
   }
}
```

```
module Viejo
  public function doble(n: integer): integer
    return n * 2
  end doble
end Viejo
```

```jc
module Programa
{
   import Utiles;        // in JC: compiled first
   import Viejo;         // in BP: the compiler finds Viejo.bp

   function void main()
   {
      println(Utiles.repite("ja"));
      println(Viejo.doble(21));
   }
}
```

```
bp build Utiles.jc
bp build Programa.jc
bp run out/Programa.mod
```

```text
jajaja
42
```

Without compiling `Utiles.jc` first, the compiler says so: «no se localizó .bp ni .bpi para import 'Utiles'» (no .bp or .bpi was found for the import), and then that `Utiles` is unknown. A default value is a literal, as in BP: `int n = VECES` is not valid, even though `VECES` is a constant.

<a id="tipos"></a>
## 6. Types, variables and literals

<a id="tipos-basicos"></a>
### 6.1 The types

C#'s, including the narrow ones. One name per type:

| JC | BP | What it is |
|---|---|---|
| `int` | `integer` | 32-bit signed integer |
| `long` | `long` | 64-bit signed integer |
| `float` | `float` | 32-bit real |
| `double` | `double` | 64-bit real |
| `bool` | `boolean` | `true` or `false` |
| `string` | `string` | text string, UTF-8 and immutable |
| `byte` | `byte` | 8-bit unsigned integer, 0..255 |
| `sbyte` | `int8` | 8-bit signed integer, -128..127 |
| `short` | `int16` (or `short`) | 16-bit signed integer |
| `ushort` | `word` | 16-bit unsigned integer, 0..65535 |
| `int[]`, `Punto[]` | `integer[]`, `Punto[]` | an array (§6.4) |
| `(int, string)` | `(integer, string)` | a tuple (§6.6) |
| `Punto`, `Object`, `List` | the same | a class, by its name; from another module, `Json.JsonObject` |

There is no `char`: a character in single quotes is an `int` (§6.3). Nor `uint`, `ulong` or `decimal`: BP does not have them. The narrow ones (`byte`, `sbyte`, `short`, `ushort`) are for storing —in an array or in a field they take 1 or 2 bytes— and in arithmetic they operate as `int` ([manual §4.1](manual.html.md#primitivos)).

<a id="variables"></a>
### 6.2 Variables and constants

The type in front, as in Java and C#, and the value with `=`:

| JC | BP |
|---|---|
| `int x = 5;` | `var x: integer := 5` |
| `int a, b;` | `var a, b: integer` |
| `int a = 1, b = 2;` | `var a: integer := 1, b: integer := 2` |
| `int a, b = 3;` — only `b` is 3 | `var a: integer, b: integer := 3` |
| `int a = 3, b = 3;` | `var a, b: integer := 3` — both are 3 |
| `owner Recurso r = new Recurso("db");` | `var owner r: Recurso := Recurso("db")` |
| `const int MAX = 10;` | `const MAX: integer := 10` |

- **Watch out for `int a, b = 3;`**: as in C#, the value is only `b`'s. In BP, `var a, b: integer := 3` gives it to both.
- **The type is always written.** There is no `var x = 5;` as in C#: `var` only goes in a `foreach` (§8.3) and in a `var` parameter (§9.2). And a constant carries its type, even though in BP it can be left out.
- **A local without a value cannot be read** before it is given one: it is a compile error, as in BP. A module variable, a field or a property without a value is 0, `false` or `null`, and a `string`, `""`.
- **A module constant is a literal** (a number, a `bool` or a string), and it takes no space: its value is put in at each use.

```jc
module Variables
{
   const int MAX = 3;
   int total;                     // module-level, no value: 0

   function void main()
   {
      int a = 1, b = 2;
      int c;                       // no value: it must be given one before it is read
      c = a + b;
      double media = c / 2.0;
      float f = 1.5f;
      long grande = 4000000000L;
      bool listo = c > MAX;
      string nombre = "Ana";
      total += c;
      println(a, " ", b, " ", c, " ", media, " ", f, " ", grande);
      println(listo, " ", nombre, " ", total);
   }
}
```

```text
1 2 3 1.5 1.5 4000000000
false Ana 3
```

<a id="literales"></a>
### 6.3 Literals

C#'s. What changes with respect to BP are the reals and the characters:

| JC | What it is | In BP |
|---|---|---|
| `42` · `0xFF` · `0b1010` · `1_000_000` | an `int` (a `long`, if it does not fit in 32 bits) | the same |
| `10L` | a `long` | the same |
| `1.5` · `1.5d` · `2e3` | a `double` | `1.5d` · `2e3d` |
| `1.5f` | a `float` | `1.5` |
| `'a'` · `'é'` · `'\n'` | an `int`: the character's code (97, 233, 10) | the number (BP does not have them) |
| `"hola"` | a `string` | the same |
| `true` · `false` · `null` |  | the same |

- **A real without a letter is a `double`**, as in C#, and it is not stored in a `float`: `float x = 1.5;` is an error («valor de tipo 'double' no asignable a variable de tipo 'float'», a value of type double cannot be assigned to a float variable). It is written `1.5f`. On the boards `float` is the better choice: almost all of them have a single-precision floating-point unit, or none at all.
- **The escape sequences**, C#'s: `\n` `\t` `\r` `\0` `\\` `\"` `\'`, and also `\a` `\b` `\f` `\v`, `\u00e9` (four hexadecimal digits), `\U0001F600` (eight) and `\x41`. BP only has the first six.
- **A character is one character**: `'ab'` is an error. Its value is the code point, the same that `charCodeAt` gives.
- **What JC does not have**: the `u` and `m` suffixes, and C#'s `@"…"` and `$"…"` strings. Each one gives an error that says so.

```jc
module Literales
{
   function void main()
   {
      int c = 'a';
      println(c, " ", 'A' + 1, " ", 'é', " ", 0xFF, " ", 0b1010, " ", 1_000_000);
      println("caf\u00e9 con le", 'c' == 99 ? "che" : "?");
      println("dijo \"hola\" y se fue");
      double d = 1.5;
      float f = 1.5f;
      println(d * 2, " ", f * 2);
   }
}
```

```text
97 66 233 255 10 1000000
café con leche
dijo "hola" y se fue
3 3
```

A real with an integer value is printed without decimals: `3`, not `3.0`, as in BP.

<a id="arrays"></a>
### 6.4 Arrays

| JC | BP |
|---|---|
| `int[] v = [1, 2, 3];` | `var v: integer[] := [1, 2, 3]` |
| `int[] v = new int[n];` | `var v: integer[] := integer[n]` |
| `Punto[] ps = new Punto[10];` | `var ps: Punto[] := Punto[10]` |
| `int buf[64];` | `var buf: integer[64]` |
| `byte m[4] = [1, 2, 250];` | `var m: byte[4] := [1, 2, 250]` |
| `len(v)` | `len(v)` |

- **The literal, with square brackets**, BP's: `[1, 2, 3]`, not `{ 1, 2, 3 }`.
- **`new T[n]`** creates an array of `n` elements, set to zero or to `null`, of any type. There are no arrays of arrays.
- **`int buf[64]` is a fixed-size array, as in C**: it is not a reference, but space in the function's frame or inside the object (a `private` field). It is only indexed, iterated over and measured; it is not passed or returned, and it does not go in the module ([manual §4.2](manual.html.md#arrays)).
- **The length is `len(v)`**, not `v.Length`; an index outside the array throws an `IndexError`.

```jc
module Arrays
{
   function int suma(int[] v)
   {
      int s = 0;
      foreach (var x in v) s += x;
      return s;
   }

   function void main()
   {
      int[] primos = [2, 3, 5, 7];
      int[] cuadrados = new int[4];
      for (int i = 0; i <= len(cuadrados) - 1; i++) cuadrados[i] = i * i;
      string[] nombres = new string[2];
      nombres[0] = "uno";
      int buf[8];                  // fixed size: in the frame, zeroed
      buf[0] = 42;
      println(suma(primos), " ", suma(cuadrados), " ", len(buf), " ", buf[0], " ", buf[1]);
      println(nombres[0], " ", nombres[1] == null);
   }
}
```

```text
17 14 8 42 0
uno true
```

<a id="cadenas"></a>
### 6.5 Strings and `null`

A JC string is BP's: UTF-8 text that does not change. What someone coming from Java or C# expects:

- **`==` compares the text**, as in C# (in Java it would compare the references), and `<`, `>`… compare the alphabetical order, by code point.
- **`+` concatenates**, and converts numbers, enums (their number) and objects (their `toString()`) to text.
- **A string has no methods.** You use the functions of `Core`, which are visible without importing anything: `len(s)`, `upper(s)`, `substring(s, desde, hasta)`, `indexOf(s, t)`, `split(s, sep)`, `replace`, `contains`, `startsWith`, `charAt`, `charCodeAt`, `parseInt`… (the list is in the [reference §13.1](referencia.html.md#stdlib-funcs)). To build up text piece by piece, `StringBuilder`.
- **It is not indexed**: `s[i]` is not valid; `charAt(s, i)` gives the character, as a string, and `charCodeAt(s, i)`, its code.

```jc
module Textos
{
   function void main()
   {
      string s = "hola mundo";
      println(len(s), " ", upper(s), " ", substring(s, 0, 4), " ", indexOf(s, "mu"));
      println(charAt(s, 1), " ", charCodeAt(s, 1), " ", contains(s, "mun"), " ", startsWith(s, "ho"));
      string[] partes = split("a,b,c", ",");
      println(len(partes), " ", partes[2], " ", replace(s, "mundo", "JC"));
      println(s == "hola " + "mundo", " ", "abc" < "abd", " ", parseInt("42") + 1);
      StringBuilder sb = new StringBuilder();
      sb.appendStr("uno");
      sb.appendStr("+dos");
      println(sb.toString());
   }
}
```

```text
10 HOLA MUNDO hola 5
o 111 true true
3 c hola JC
true true 43
uno+dos
```

**A string is never `null`, but a `string` variable can be**, as in C#: `string s = null;` is a variable that references no string. The same goes for a parameter, a field or what a function returns. With it:

- concatenating it and writing it out is like with `""`: `"x" + s + "y"` gives `"xy"`;
- `==` and `!=`: `null` is only equal to `null` (`s == ""` is `false`);
- a `switch` on it goes to the `default`;
- whatever needs a string —`len`, `upper`, `<`, files, a key of a `Map`…— throws a `RuntimeError`: «referencia nula: `upper` de un string null» (null reference: upper of a null string).

A `string` field, property or module variable without a value starts out as `""`, not `null`; a local without a value cannot be read (§6.2). And a `const string` cannot be `null`: it is a value, not a variable.

```jc
module Nulos
{
   string nombre;                  // module-level, no value: ""

   function string busca(int id)
   {
      if (id == 1) return "Ana";
      return null;
   }

   function void main()
   {
      string s = busca(2);
      println("[", s, "] [", "x" + s + "y", "]");
      println(s == null, " ", s == "", " ", len(nombre));
      try
      {
         println(upper(s));
      }
      catch (RuntimeError e)
      {
         println(e.msg);
      }
   }
}
```

```text
[] [xy]
true false 0
referencia nula: upper de un string null
```

<a id="tuplas"></a>
### 6.6 Tuples

A function can return several values, as in C#:

| JC | BP |
|---|---|
| `function (int, int) divmod(int a, int b)` | `function divmod(a: integer, b: integer): (integer, integer)` |
| `return (a / b, a % b);` | `return (a / b, a mod b)` |
| `(q, r) = divmod(17, 5);` | `{ q, r } := divmod(17, 5)` |
| `(int, int) t = divmod(9, 4);` | `var t: (integer, integer) := divmod(9, 4)` |

The unpacking targets must already exist —variables, fields or array elements—, and `_` discards a value. A tuple cannot be printed or put in a list ([manual §8.2](manual.html.md#tuplas)).

```jc
module Tuplas
{
   function (int, int) divmod(int a, int b)
   {
      return (a / b, a % b);
   }

   function void main()
   {
      int q, r;
      (q, r) = divmod(17, 5);
      println(q, " ", r);
      (int, int) t = divmod(9, 4);
      (q, _) = t;
      println(q);
   }
}
```

```text
3 2
2
```

<a id="enums"></a>
### 6.7 Enums

As in C#: `enum Color { Rojo, Verde = 5, Azul }`, with a trailing comma if you like. It is BP's `enum … end`. The values are numbered from 0, and an explicit one is an unsigned integer; C#'s expressions (`1 << 3`, `-1`) and the underlying type (`enum Color : byte`) are not there.

- **From an enum to an integer, yes**: `(int) Color.Verde` and `(int) c`, as in C#. In BP, `integer(c)`.
- **From an integer to an enum, no**: `(Color) 2` is an error. An enum is a closed type.
- **Printing it gives its number**, and its name comes from `Enum.getName(c)`.

```jc
module Colores
{
   public enum Color { Rojo, Verde = 5, Azul }

   function void main()
   {
      Color c = Color.Azul;
      println(c, " ", (int) Color.Verde, " ", (int) c + 1);
      println(Enum.getName(c));
      if (c == Color.Azul) println("es azul");
   }
}
```

```text
6 5 7
Azul
es azul
```

<a id="expresiones"></a>
## 7. Expressions and operators

<a id="operadores"></a>
### 7.1 The operators

| JC | BP | What it does |
|---|---|---|
| `=` | `:=` | assigns (it is a statement, §7.3) |
| `+ - * /` | the same | between two integers, `/` is integer division: `17 / 5` is 3 |
| `%` | `mod` | the remainder |
| `**` | `^` | the power: `2 ** 10` is 1024 |
| `&& \|\| !` | `and or not` | logical; `&&` and `\|\|` skip the second operand if the result is already clear |
| `& \|` | the same | bitwise; between two `bool`s, logical operators that evaluate both sides |
| `^` | `xor` | exclusive or |
| `<< >>` | `shl shr` | shifts |
| `== != < <= > >=` | the same | compare; between strings, the text (§6.5); between objects, whether they are the same one |
| `x is Perro` | `x instanceof Perro` | is it of that class or interface? (§7.4) |
| `c ? a : b` | `iif(c, a, b)` | the ternary (§7.5) |
| `(int) x` · `(Perro) a` | `integer(x)` · `Perro(a)` | conversions (§7.4) |
| `new Perro(…)` · `new int[n]` | `Perro(…)` · `integer[n]` | creates an object or an array |
| `obj::metodo` | the same | a method of an object, as a value (§13, §15) |

There is no `~`, the bitwise not (BP does not have it either: in JC it is written `x ^ -1`, and in BP, `x xor -1`), nor `??` or `?.`: each one gives an error that says so.

<a id="precedencia"></a>
### 7.2 Precedence, as in C#

From the weakest to the strongest:

| Level | Operators |
|---|---|
| 1 | `c ? a : b` (right-associative) |
| 2 | `\|\|` |
| 3 | `&&` |
| 4, 5, 6 | `\|`, then `^`, then `&` |
| 7 | `==` `!=` |
| 8 | `<` `<=` `>` `>=` `is` |
| 9 | `<<` `>>` |
| 10 | `+` `-` |
| 11 | `*` `/` `%` |
| 12 | the unary `-` and `!`, and the conversion `(T) x` |
| 13 | `**`, stronger than the unary minus and right-associative: `-2 ** 2` is -4, and `2 ** 3 ** 2` is `2 ** 9`, 512 |

BP's is not the same for the bitwise operators: in BP, the shifts go with `*`, and `|` and `xor`, with `+`. So the same text can give a different value. In JC:

```jc
module Precedencia
{
   function void main()
   {
      int a = 1;
      println(a << 1 + 2);            // 8: the + goes before the <<
      println(2 ** 3 ** 2, " ", -2 ** 2);
      println(7 % 3, " ", 6 ^ 3, " ", 6 & 3, " ", 6 | 3, " ", 1 << 4, " ", -16 >> 2);
      bool b = a > 0 && !(a == 2) || false;
      println(b);
   }
}
```

```text
8
512 -4
1 5 2 7 16 -4
true
```

And the same in BP, with its operators:

```
module PrecedenciaBp
  function main()
    var a: integer := 1
    print a shl 1 + 2               // 4: in BP, shl goes with the *
    print 2 ^ 3 ^ 2, -2 ^ 2
    print 7 mod 3, 6 xor 3, 6 & 3, 6 | 3, 1 shl 4, -16 shr 2
  end main
end PrecedenciaBp
```

```text
4
512 -4
1 5 2 7 16 -4
```

When translating, each language puts in the parentheses its precedence requires, so a translated program computes the same as the original: BP's `a shl 1 + 2` comes out in JC as `(a << 1) + 2`.

<a id="asignaciones"></a>
### 7.3 Assignments

| JC | BP |
|---|---|
| `x = e;` | `x := e` |
| `x += e;` `x -= e;` `x *= e;` `x /= e;` | the same |
| `x %= e;` `x ^= e;` `x <<= e;` `x >>= e;` | `x mod= e` `x xor= e` `x shl= e` `x shr= e` |
| `x &= e;` `x \|= e;` | the same |
| `x++;` `x--;` | `x += 1` `x -= 1` |

- **`x op= e` evaluates `x` once** (`a[f()] += 5` calls `f` once), and follows C#'s type rule: if the result does not fit in the type of `x`, it is valid only if `e` would fit, and then it is cut down, wrapping around (a `byte` that is 255, plus 1, is 0). Otherwise it is an error: `int i; i += 1.5;` does not compile.
- **`x++` and `x--` are statements**, after a variable, a field or an array element (`a[i]++`). `++x` does not exist, nor are they allowed inside an expression (`y = x++`, `a[i++]`).
- **An assignment is not an expression**: `a = b = 0;` or `if ((x = f()) > 0)` are not valid. They are written as two statements.

```jc
module Asignaciones
{
   function void main()
   {
      int i = 3;
      i += 2;          // 5
      i *= 4;          // 20
      i %= 6;          // 2
      i <<= 3;         // 16
      i ^= 1;          // 17
      i++;             // 18
      println(i);
      byte b = 255;
      b += 1;          // 0: a byte operates as an int and keeps its size
      long l = 1;
      l <<= 40;
      string s = "n=";
      s += 5;          // + concatenates
      println(b, " ", l, " ", s);
   }
}
```

```text
18
0 1099511627776 n=5
```

<a id="conversiones"></a>
### 7.4 Conversions and `is`

As in C#: `(T) x`. In BP, creating, calling and converting are written the same way —`Perro(x)`— and the compiler decides; in JC each one has its own form: `new Perro(x)` creates, `(Perro) x` converts and `f(x)` calls.

- **Between numbers**: `(int) d` truncates toward zero; `(byte)`, `(sbyte)`, `(short)` and `(ushort)` check the range at run time and, if the value does not fit, throw an `ArithmeticError`; `(long)`, `(float)` and `(double)` widen. From a small type to a big one it does not need to be written: `long l = i;` is valid.
- **Between classes**: `(Perro) a` goes down from an ancestor or from `Object`, and if the object is not a `Perro` it throws a `CastError`. What is already a `Perro` stays as it is. Two unrelated classes are not converted: it is a compile error.
- **`x is Perro`** says whether the object is of that class or interface, or of a child; also with the module in front, `x is Lib.Perro`. The rest of C#'s `is` (`x is Perro p`, `x is null`) is not there: for `null`, `x == null`.
- **A parenthesis or a conversion**, with C#'s rule: it is a conversion if between the parentheses there is a built-in type (`(int)`…), or if there is a name and after the `)` comes a name, a literal, a reserved word (`new`, `this`…), a `(` or a `!`. So `(a) - b` is a subtraction; to convert `-x`, `(Perro) (-x)`.

```jc
module Conversiones
{
   class Animal
   {
      public function string habla()
      {
         return "...";
      }
   }

   class Perro : Animal
   {
      public function string habla()
      {
         return "guau";
      }

      public function string trae()
      {
         return "la pelota";
      }
   }

   function void main()
   {
      double d = 3.9;
      int i = (int) d;                     // 3: truncates toward zero
      long l = (long) i * 1000000000;
      byte b = (byte) 200;
      println(i, " ", l, " ", b);
      Animal a = new Perro();
      if (a is Perro) println(((Perro) a).trae());
      Object o = a;
      Perro p = (Perro) o;                 // if it were not one: CastError
      println(p.habla());
      try
      {
         b = (byte) (i * 100);
      }
      catch (ArithmeticError e)
      {
         println("300 no cabe en un byte");
      }
   }
}
```

```text
3 3000000000 200
la pelota
guau
300 no cabe en un byte
```

Writing one thing for another is an error that says how it goes in JC: `Perro("Rex")` without `new` gives «'Perro(…)' crea un objeto: en JC se escribe 'new Perro(…)'» (it creates an object: in JC, write new Perro(…)), and `int(d)`, «en JC, una conversión se escribe (int) x» (in JC, a conversion is written (int) x).

<a id="ternario"></a>
### 7.5 The ternary

`c ? a : b` is `a` if `c` holds, and otherwise `b`. It is BP's `iif(c, a, b)`, and **it only evaluates the branch that applies**, so a recursive function that uses it terminates. Its type is that of the two branches: the same one; or two numbers, and the wider one wins; or `null` and a reference; or a class and its child, and the parent wins. It is not a statement: to choose what to do, an `if`.

```jc
module Ternario
{
   function int fib(int n)
   {
      return n < 2 ? n : fib(n - 1) + fib(n - 2);
   }

   function void main()
   {
      for (int n = 1; n <= 4; n++) println(n, n % 2 == 0 ? " par" : " impar");
      println(fib(10));
   }
}
```

```text
1 impar
2 par
3 impar
4 par
55
```

<a id="control"></a>
## 8. Control flow

<a id="if"></a>
### 8.1 `if`, `while` and `do`

| JC | BP |
|---|---|
| `if (c) { … } else if (d) { … } else { … }` | `if c then … elseif d then … else … endif` |
| `while (c) { … }` | `while c do … endwh` |
| `do { … } while (c);` | `do … loop c` |
| `while (true) { … }` | `do … loop` (without a condition) |

As in C. With a single statement, without braces. The `else` goes with the nearest `if`, and `else if` is BP's `elseif`. The `do` repeats while the condition holds, and a `continue` inside it goes to the condition, as in C#. The endless loop is `while (true)`: JC does not have BP's `do … loop` without a condition.

With a single statement, the `do` also goes without braces: `do i++; while (i < 3);`. If it has a name (§8.5), the name goes right after `do` and before the brace of its body: `do vuelta { i++; } while (i < 3);`.

```jc
module Control
{
   function string etapa(int edad)
   {
      if (edad < 18) return "menor";
      else if (edad < 65) return "adulto";
      else return "senior";
   }

   function void main()
   {
      println(etapa(10), " ", etapa(40), " ", etapa(70));
      int i = 0;
      while (i < 3) i++;
      do
      {
         i += 10;
      } while (i < 25);
      println(i);
      while (true)
      {
         i -= 7;
         if (i < 0) break;
      }
      println(i);
   }
}
```

```text
menor adulto senior
33
-2
```

<a id="for"></a>
### 8.2 `for`

JC's `for` is BP's dressed as C: a counter. It has four forms:

| JC | BP |
|---|---|
| `for (int i = a; i <= b; i++)` | `for i := a to b do` |
| `for (int i = a; i <= b; i += 2)` | `for i := a to b step 2 do` |
| `for (int i = a; i >= b; i--)` | `for i := a to b step -1 do` |
| `for (int i = a; i >= b; i -= 2)` | `for i := a to b step -2 do` |

- **The variable is declared by the `for`**, and it is always `int`.
- **The limit is computed once**, before starting, and it is inclusive: `<=` if it goes up, `>=` if it goes down.
- **The step is a literal number**, not a variable.
- **Anything else is an error that says so.** C's `i < n`, the most typical one, is written `i <= n - 1`; another condition, another increment or a step in a variable, with a `while`.

```jc
module Contar
{
   function void main()
   {
      for (int i = 1; i <= 10; i += 3) print(i, " ");
      println("fin");
      for (int i = 3; i >= 1; i--)
      {
         print(i, "... ");
      }
      println("¡ya!");
   }
}
```

```text
1 4 7 10 fin
3... 2... 1... ¡ya!
```

<a id="foreach"></a>
### 8.3 `foreach`

`foreach (var x in collection)` is BP's `for x in collection do`. It goes through an array or a `List` (also `SyncList` and `OwnerList`). The variable is always written `var`: it takes the type of the elements —in a plain `List`, `Object`; in a `List<Sensor>`, `Sensor` (§12)—. With a written type, `foreach (int x in a)`, it is an error. The list is measured once, on entry: what the body adds to it is not visited.

```jc
module Recorrer
{
   function void main()
   {
      int total = 0;
      foreach (var n in [2, 3, 5, 7]) total += n;
      println(total);
      List<Object> l = new List<Object>();
      l.add("uno");
      l.add(2);
      foreach (var x in l) println(x);
   }
}
```

```text
17
uno
2
```

<a id="switch"></a>
### 8.4 `switch`

C#'s form with BP's meaning: `case 1, 2:` with several values, and the `default` at the end. **It does not fall through from one case to the next**, so `break` is not needed; if it is written, it leaves the `switch`. The subject is an integer, a `bool`, an enum or a string, which is compared by its text; not a real or an object.

```jc
module Ordenes
{
   function void ejecuta(string orden)
   {
      switch (orden)
      {
         case "ls", "dir":
            println("lista");
         case "cd":
            println("cambia de carpeta");
         default:
            println("no conozco ", orden);
      }
   }

   function void main()
   {
      ejecuta("dir");
      ejecuta("cd");
      ejecuta("rm");
   }
}
```

```text
lista
cambia de carpeta
no conozco rm
```

<a id="break"></a>
### 8.5 `break` and `continue`, with a name

`break` leaves the nearest loop or `switch`, and `continue` goes on with the next iteration of the nearest loop. A loop can carry a name, after its keyword, to leave several at once or to continue with the outer one:

| JC | BP |
|---|---|
| `for fila (int i = 1; i <= 3; i++) { … }` | `for i := 1 to 3 do fila` |
| `foreach fila (var x in l) { … }` | `for x in l do fila` |
| `while fila (c) { … }` | `while c do fila` |
| `do fila { … } while (c);` | `do fila … loop c` |
| `break fila;` · `continue fila;` | `break fila` · `continue fila` |

They are not labels and there is no `goto`: the name is only visible inside its loop. On leaving, the `try`s in between are closed and their `finally`s run.

```jc
module Buscar
{
   function void main()
   {
      for fila (int i = 1; i <= 3; i++)
      {
         for (int j = 1; j <= 3; j++)
         {
            if (j > i) continue fila;
            if (i * j == 6)
            {
               println("encontrado: ", i, " x ", j);
               break fila;
            }
         }
      }
      println("fuera");
   }
}
```

```text
encontrado: 3 x 2
fuera
```

<a id="funciones"></a>
## 9. Functions

<a id="declarar"></a>
### 9.1 Declaring and calling

| JC | BP |
|---|---|
| `function int suma(int a, int b = 1) { … }` | `function suma(a: integer, b: integer := 1): integer … end suma` |
| `function void avisa(string msg) { … }` | `function avisa(msg: string) … end avisa` |
| `public function …` | `public function …` |
| `function (int, string) par() { … }` | `function par(): (integer, string) … end par` |

- **You write `function`**, as in BP, also in the methods of a class. C#'s form, `int suma(…)` without `function`, does not exist: it would be read as a variable.
- **The return type, always**, and `void` if it returns nothing. Without a type, and with a name that is not the class's, it is an error: «falta el tipo de la función; si no devuelve nada, void» (the function's type is missing; if it returns nothing, void).
- **Default values** are literals and go at the end. The compiler puts them in at each call, so they also work across modules.
- **Overloading**, by the parameters, as in BP: the return type does not count, and if several fit, the most specific one wins ([manual §8.4](manual.html.md#sobrecarga)).
- **There are no** named arguments, `params` or `ref`/`out`; the closest thing to `ref` is the `var` parameter (§9.2).

```jc
module Funciones
{
   public function string etiqueta(string texto, string antes = "[", string despues = "]")
   {
      return antes + texto + despues;
   }

   function string texto(int n)
   {
      return "int:" + n;
   }

   function string texto(string s)
   {
      return "str:" + s;
   }

   function void avisa(string msg)
   {
      println("aviso: ", msg);
   }

   function void main()
   {
      println(etiqueta("hola"), " ", etiqueta("hola", "<"), " ", etiqueta("hola", "<", ">"));
      println(texto(5), " ", texto("cinco"));
      avisa("fin");
   }
}
```

```text
[hola] <hola] <hola>
int:5 str:cinco
aviso: fin
```

<a id="param-var"></a>
### 9.2 `var` parameters

A `var` parameter does not receive a value but **a property of an object**, which is passed as `object::property`: reading the parameter reads the property, and assigning to it writes it. It is C#'s `ref`, but only with properties: this VM has no references to variables.

```jc
module Contadores
{
   public class Contador
   {
      public int valor { get; set; }
   }

   function void suma(var int n, int m)
   {
      n += m;
   }

   function void main()
   {
      Contador c = new Contador();
      suma(c::valor, 5);
      suma(c::valor, 2);
      println(c.valor);
   }
}
```

```text
7
```

In BP, `function suma(var n: integer, m: integer)` and the same call. It is passed `object::property`, of the same type and one the caller can read and write, or another `var` parameter by its name; not a variable or a field. No default value, and not in a constructor, an event or a `native`. Module properties and static ones, not yet ([manual §8.1b](manual.html.md#param-var)).

<a id="native"></a>
### 9.3 `native` and `inline`

```jc
module Nativo
{
   native function int sumaCuadrados(int n)
   {
      int s = 0;
      for (int i = 1; i <= n; i++) s += i * i;
      return s;
   }

   public function int codigo(string s, int i) inline CALL_BUILTIN 48;

   function void main()
   {
      println(sumaCuadrados(10), " ", codigo("A", 0));
   }
}
```

```text
385 65
```

- **`native function`** marks a function for the AOT: besides its bytecode, the compiler translates it into the board's machine code, and there it runs much faster; on the PC, interpreted. What fits in a `native` and what does not is in the [manual §8.3](manual.html.md#funciones-native): it is the same in JC.
- **An `inline` function** has a VM instruction as its body, written after the signature: `function T f(…) inline CALL_BUILTIN 48;`. It is how the standard library is written —`codigo` is the `charCodeAt` of `Core`—, and a normal program does not need it.

<a id="clases"></a>
## 10. Classes

<a id="herencia"></a>
### 10.1 Constructors, inheritance and `base`

As in C#, plus what BP has and C# does not. An animal and a dog:

```jc
module Zoo
{
   public class Animal
   {
      protected string nombre;
      private static int cuantos = 0;

      public function Animal(string nombre)
      {
         this.nombre = nombre;
         Animal.cuantos += 1;
      }

      public function string habla()
      {
         return "...";
      }

      public function string presenta()
      {
         return this.nombre + " dice " + this.habla();
      }

      public static function int total()
      {
         return Animal.cuantos;
      }
   }

   public class Perro : Animal
   {
      private int edad;

      public function Perro(string nombre, int edad) : base(nombre)
      {
         this.edad = edad;
      }

      public function Perro(string nombre) : this(nombre, 2)
      {
      }

      public function string habla()
      {
         return "guau";
      }

      public function string presenta()
      {
         return base.presenta() + " (" + this.edad + " años)";
      }
   }

   function void main()
   {
      Animal a = new Animal("Bicho");
      Perro p = new Perro("Rex", 3);
      Animal q = new Perro("Lua");
      println(a.presenta());
      println(p.presenta());
      println(q.presenta());
      println(Animal.total(), " animales");
   }
}
```

```text
Bicho dice ...
Rex dice guau (3 años)
Lua dice guau (2 años)
3 animales
```

Translated to BP —and it gives the same `.mod`—:

```
module Zoo
  public class Animal
    var nombre: string
    private var Animal.cuantos: integer := 0

    public function Animal(nombre: string)
      this.nombre := nombre
      Animal.cuantos += 1
    end Animal

    public function habla(): string
      return "..."
    end habla

    public function presenta(): string
      return this.nombre + " dice " + this.habla()
    end presenta

    public function Animal.total(): integer
      return Animal.cuantos
    end Animal.total
  end Animal

  public class Perro extends Animal
    private var edad: integer

    public function Perro(nombre: string, edad: integer)
      super(nombre)
      this.edad := edad
    end Perro

    public function Perro(nombre: string)
      Perro(nombre, 2)
    end Perro

    public function habla(): string
      return "guau"
    end habla

    public function presenta(): string
      return super.presenta() + " (" + this.edad + " años)"
    end presenta
  end Perro

  function main()
    var a: Animal := Animal("Bicho")
    var p: Perro := Perro("Rex", 3)
    var q: Animal := Perro("Lua")
    print a.presenta()
    print p.presenta()
    print q.presenta()
    print Animal.total(); " animales"
  end main
end Zoo
```

| JC | BP |
|---|---|
| `class Perro : Animal { … }` | `class Perro extends Animal … end Perro` |
| `function Perro(string n) { … }`, without a type | `function Perro(n: string) … end Perro` |
| `… : base(n) { … }` | `super(n)`, the first statement |
| `… : this(n, 2) { … }` | `Perro(n, 2)`, the first statement |
| `base.presenta()` | `super.presenta()` |
| `static` | the class name in front: `Animal.total` |
| `new Perro("Rex", 3)` | `Perro("Rex", 3)` |

- **The constructor** is a function with the name of the class, without a type. If the base has a constructor with parameters, a child that defines its own calls it with `: base(…)`: it is mandatory, even if the parameters have default values. And `: this(…)` delegates to another constructor of the same class ([manual §9.3](manual.html.md#ctor)).
- **Single inheritance**: one base class, and as many interfaces as it wants (§11). A class without a base descends from `Object`.
- **Every method is virtual except the `private` ones**: there is no `virtual` or `override`, and a child's method with the same signature replaces the parent's. To make it explicit, the `@override{}` annotation (§11). A `final` method cannot be redefined, and a `final` class (`public final class Base`) cannot be extended, not even from another module.
- **There are no** classes inside classes, `abstract`, `struct` or `static` classes. For a type without code, an interface.

<a id="visibilidad"></a>
### 10.2 Visibility

| JC | BP | Who sees it |
|---|---|---|
| `public` | `public` | everyone |
| `protected`, or nothing | nothing | the class and its children, also those in another module |
| `private` | `private` | only the class (and it is not virtual) |

- **Careful if you come from C#**: in C#, a member with nothing is private; in JC, as in BP, it is protected. The translator always writes it out, `protected`.
- **A field is never `public`**: it is an error, and the message points to the alternative, a public property (§10.3). What comes out of a class is its methods and its properties.
- **In the module**, what is not `public` is private to the module; `protected` and `static` only go in a class.

<a id="properties"></a>
### 10.3 Properties

| JC | BP |
|---|---|
| `public int lecturas { get; set; }` | `public property lecturas: integer` |
| `public string unidad { get; set; } = "C";` | `public property unidad: string := "C"` |
| `double celsius { get { … } set { … } }`, with `value` | `property celsius: double`, `get … endget`, `set(value) … endset`, `endprop` |
| `set(v) { … }` | `set(v) … endset` |
| `field` | `field` |

```jc
module Termometros
{
   public class Termometro
   {
      private double grados;

      public string unidad { get; set; } = "C";
      public int lecturas { get; set; }

      public double celsius
      {
         get
         {
            return this.grados;
         }
         set
         {
            if (value < -273.15) throw new RuntimeError("bajo el cero absoluto");
            this.grados = value;
            this.lecturas += 1;
         }
      }

      public double fahrenheit
      {
         get
         {
            return this.grados * 9 / 5 + 32;
         }
      }

      public long nivel
      {
         get
         {
            return field;
         }
         set(v)
         {
            field = v * 2;
         }
      }
   }

   function void main()
   {
      Termometro t = new Termometro();
      t.celsius = 25;
      t.celsius += 5;
      t.nivel = 7;
      println(t.celsius, " ", t.unidad, " = ", t.fahrenheit, " F");
      println(t.lecturas, " lecturas, nivel ", t.nivel);
      try
      {
         t.celsius = -300;
      }
      catch (RuntimeError e)
      {
         println(e.msg);
      }
   }
}
```

```text
30 C = 86 F
2 lecturas, nivel 14
bajo el cero absoluto
```

- **The automatic one is `{ get; set; }`**, whole: there is no `{ get; private set; }` or `init`. With the initial value after it, `= "C";`.
- **With only `get`**, it is read and not written (`fahrenheit`).
- **The `set` without a name** calls what it receives `value`, as in C#; `set(v)` gives it another name, as in BP.
- **`field`** is, inside the `get` and the `set`, the field where the property keeps its value, with its type.
- **A child can redeclare a property** of its parent, and `base.nombre` reads and writes the parent's. There are also module properties (§5.1) and static ones (§10.4).

<a id="static"></a>
### 10.4 `static`, `const` and `sync`

```jc
module Estaticos
{
   public sync int pedidos { get; set; }

   public class Cuenta
   {
      public const int MAXIMO = 1000;
      public static int abiertas { get; set; }
      public sync int saldo { get; set; }

      public function Cuenta(int inicial)
      {
         this.saldo = inicial;
         Cuenta.abiertas += 1;
      }

      public static function Cuenta abre(int inicial)
      {
         if (inicial > Cuenta.MAXIMO) throw new RuntimeError("demasiado");
         return new Cuenta(inicial);
      }
   }

   function void main()
   {
      Cuenta a = Cuenta.abre(100);
      Cuenta b = Cuenta.abre(50);
      a.saldo -= 30;
      pedidos += 2;
      println(a.saldo, " ", b.saldo, " ", Cuenta.abiertas, " ", Cuenta.MAXIMO, " ", pedidos);
   }
}
```

```text
70 50 2 1000 2
```

- **`static`** is what in BP carries the class name in front (`Cuenta.abre`). It works on functions, fields and properties, and is always used with the class in front, also from inside it: `Cuenta.abiertas`. A constructor or a destructor does not take it.
- **A class constant already belongs to the class**, as in C#: without `static`.
- **A static field does not leave the module**, just as no variable does: what other modules need to see goes in a static property ([manual §9.6](manual.html.md#static)).
- **`sync`** on a property, of a class or of a module, makes its `get` and its `set` atomic with respect to other threads. Each access, not the sum of several: `a.saldo -= 30` is a `get` and a `set`, and another thread can slip in between them. For that, a `Mutex` ([manual §9.5](manual.html.md#props)).

<a id="destructor"></a>
### 10.5 The destructor and `owner`

BP destroys objects right away, without waiting for the collector, when they have an owner: that is `owner`. And what has to be done when they are destroyed is written once, in the class's destructor.

| JC | BP |
|---|---|
| `public function ~Recurso() { … }` | `public function ~Recurso() … end ~Recurso` |
| `owner Recurso r = new Recurso("db");` | `var owner r: Recurso := Recurso("db")` |
| `protected owner Recurso contenido;` | `var owner contenido: Recurso` |
| `try (Recurso f = new Recurso("x")) { … }` | `try var f: Recurso := Recurso("x") … endtry` |

```jc
module Recursos
{
   public class Recurso
   {
      private string nombre;

      public function Recurso(string nombre)
      {
         this.nombre = nombre;
         println("abre ", nombre);
      }

      public function ~Recurso()
      {
         println("cierra ", this.nombre);
      }

      public function void usa()
      {
         println("usa ", this.nombre);
      }
   }

   public class Caja
   {
      protected owner Recurso contenido;

      public function Caja(string n)
      {
         this.contenido = new Recurso(n);
      }
   }

   function void trabaja()
   {
      owner Recurso r = new Recurso("db");
      r.usa();
   }

   function void main()
   {
      trabaja();
      try (Recurso f = new Recurso("fichero"))
      {
         f.usa();
      }
      owner Caja c = new Caja("caja");
      println("fin del main");
   }
}
```

```text
abre db
usa db
cierra db
abre fichero
usa fichero
cierra fichero
abre caja
fin del main
cierra caja
```

- **The destructor** is named like the class, with `~` in front, without parameters or type. It is called by the language, never by the program, every time the object is freed: when its owner's scope ends, when the collector reclaims it or when the program ends. It is not C#'s finalizer, which runs whenever it likes: with an owner, it runs at that moment ([manual §9.4b](manual.html.md#destructor)).
- **An `owner` local** is destroyed when its function is left, however it is left; it is not returned or stored anywhere else.
- **An `owner` field** is destroyed with its object, before it: the `Caja` has no destructor, and its resource is closed all the same.
- **`try (T r = e) { … }`** is Java's: the resource is an `owner` of the block and is destroyed when the block ends, also with an exception. It accepts `catch` and `finally`.

<a id="interfaces"></a>
## 11. Interfaces

A class inherits from a single class and implements as many interfaces as it wants. An interface says which methods and which properties a type has, without code, and it can inherit from several.

```jc
module Formas
{
   public interface Forma
   {
      function double area();
      function string nombre();
   }

   public interface Poligono : Forma
   {
      function int lados();
   }

   public interface Etiquetado
   {
      string etiqueta { get; set; }
   }

   public class Figura
   {
      public function string nombre()
      {
         return "figura";
      }
   }

   public class Cuadrado : Figura, Poligono, Etiquetado
   {
      private double lado;

      @implement{ Etiquetado }
      public string etiqueta { get; set; }

      public function Cuadrado(double l)
      {
         this.lado = l;
      }

      @implement{ Poligono }
      public function double area()
      {
         return this.lado * this.lado;
      }

      @implement{ Poligono }
      public function int lados()
      {
         return 4;
      }

      @implement{ Poligono }
      @override{}
      public function string nombre()
      {
         return "cuadrado";
      }
   }

   function void main()
   {
      Forma f = new Cuadrado(2.0);
      println(f.nombre(), " ", f.area());
      Poligono p = (Poligono) f;
      println(p.lados(), " ", f is Etiquetado);
      Etiquetado e = (Etiquetado) f;
      e.etiqueta = "cuadrado de 2";
      println(e.etiqueta);
   }
}
```

```text
cuadrado 4
4 true
cuadrado de 2
```

- **What an interface carries**: methods, only their signature and with their `function` (`function double area();`), and automatic properties (`string etiqueta { get; set; }`). Everything is public, without writing it. It carries no fields, constants, events, constructors or anything `static`.
- **`class Cuadrado : Figura, Poligono, Etiquetado`**: as in C#, the base class and the interfaces go in the same list, the base first. The first name can also be an interface; the compiler decides. In BP: `class Cuadrado extends Figura implements Poligono, Etiquetado`.
- **`@implement{ I }` is mandatory** on what the class declares to fulfil an interface: it names one of its interfaces that has that member, also an inherited one (`area` belongs to `Forma`, and `Poligono`, which inherits it, is valid). What the parent provides is not marked.
- **`@override{}` is optional** on what redefines a method or a property of the parent: it changes nothing, it just makes it explicit; if it redefines nothing, it is an error. A declaration can carry several annotations, like `nombre()`.
- **They are used like any other type**: variables, parameters, arrays, `is`, `(Poligono) f` and `==`. An interface is not constructed. A `Thread` and its children do not implement interfaces ([manual §9.8](manual.html.md#interfaces-clase)).

<a id="genericos"></a>
## 12. Generics

`List<Sensor>` is the usual `List` with an order for the compiler: what goes in has to be a `Sensor`, and what comes out is a `Sensor`, without writing the conversion. The class does not change and the VM does not notice. The same goes for `SyncList<T>` and `OwnerList<T>`; and a `Map` takes two, the key (`int` or `string`) and the value.

```jc
module Almacen
{
   import Collections;

   public class Sensor
   {
      private int v;

      public function Sensor(int v)
      {
         this.v = v;
      }

      public function int valor()
      {
         return this.v;
      }
   }

   function void main()
   {
      List<Sensor> sensores = new List<Sensor>();
      sensores.add(new Sensor(4));
      sensores.add(new Sensor(7));
      println(sensores.get(0).valor(), " ", sensores[1].valor());
      int suma = 0;
      foreach (var s in sensores) suma += s.valor();
      println("suma: ", suma);
      Collections.Map<int, string> nombres = new Collections.Map<int, string>();
      nombres.put(10, "diez");
      nombres[20] = "veinte";
      println(nombres.get(10), " ", nombres[20]);
      Collections.Map<string, Sensor> porNombre = new Collections.Map<string, Sensor>();
      porNombre["patio"] = new Sensor(21);
      println(porNombre["patio"].valor());
   }
}
```

```text
4 7
suma: 11
diez veinte
21
```

- **Between `<` and `>` goes a class, an interface or `string`**, as in Java. A number goes in its box: `List<Integer>`. `List<Object>` is the plain `List`.
- **`new Collections.Map<int, T>()`** creates the one with integer keys, which in BP is `Collections.numericMap()`; with `string` keys, BP's `Collections.Map()`. The `Map` is in the `Collections` module, which has to be imported.
- **`x[i]` on an object** is `x.get(i)`, and `x[i] = v`, `x.set(i, v)` (in a `Map`, `put`). It works with any class that has those methods ([manual §4.7](manual.html.md#indice-objeto)).
- **What does not mix**: `List<Perro>` does not pass as `List<Animal>`, as in Java and C#. The plain `List` does, in both directions.

**A class of yours is generic** if it states its base type with the `@element{type}` annotation. It is written with that type in its signatures, and whoever uses it asks for one that descends from it. There is no `<T>` variable, nor generic methods:

```jc
module Bolsas
{
   public class Medida
   {
      protected double v;

      public function Medida(double v)
      {
         this.v = v;
      }

      public function double valor()
      {
         return this.v;
      }
   }

   public class Metro : Medida
   {
      public function Metro(double v) : base(v)
      {
      }

      public function double enCm()
      {
         return this.v * 100;
      }
   }

   @element{Medida}
   public class Bolsa
   {
      private List cosas = new List();

      public function void mete(Medida m)
      {
         this.cosas.add(m);
      }

      public function Medida saca(int i)
      {
         return (Medida) this.cosas.get(i);
      }
   }

   function void main()
   {
      Bolsa<Metro> b = new Bolsa<Metro>();
      b.mete(new Metro(2));
      println(b.saca(0).enCm());
   }
}
```

```text
200
```

`b.saca(0)` comes out as a `Metro`, without converting. What is lost along the way —a list that goes through an `Object` or a plain `List`— and what happens between modules is in the [manual §4.6](manual.html.md#genericos): it is the same in JC.

<a id="eventos"></a>
## 13. Events

An event lets an object announce that something has happened, without knowing who is listening. It is the foundation of the graphical interface —a button does not know what your program does when it is pressed—, but it works in any class.

```jc
module Botones
{
   public class Boton
   {
      public int numero { get; set; }
      event onClick(Boton sender, int veces);

      public function Boton(int n)
      {
         this.numero = n;
      }

      public function void pulsa(int veces)
      {
         if (onClick != null) raise onClick(this, veces);
      }
   }

   public class Panel
   {
      private string nombre;

      public function Panel(string n)
      {
         this.nombre = n;
      }

      function event void pulsado(Boton b, int veces)
      {
         println("  boton ", b.numero, " x", veces, " en ", this.nombre);
      }
   }

   function void main()
   {
      Boton b = new Boton(7);
      Panel p = new Panel("principal");
      b.pulsa(1);
      b.onClick = p::pulsado;
      println("antes del raise");
      b.pulsa(3);
      println("despues del raise");
      sleep(30);
      println("fin");
   }
}
```

```text
antes del raise
despues del raise
  boton 7 x3 en principal
fin
```

| JC | BP |
|---|---|
| `event onClick(Boton sender, int veces);` | `event onClick(sender: Boton, veces: integer)` |
| `raise onClick(this, veces);` | `raise onClick(this, veces)` |
| `function event void pulsado(Boton b, int veces) { … }` | `function event pulsado(b: Boton, veces: integer) … end pulsado` |
| `b.onClick = p::pulsado;` | `b.onClick := p::pulsado` |
| `if (onClick != null) …` | `if onClick != null then …` |

- **The event is declared in the class that gives notice**, without `public`: subscribing is already public, and raising it is up to the class and its children. It takes four parameters at most.
- **The listener** declares a handler with `function event` and the same parameters, and subscribes with `::`, which binds an object and one of its methods. An event has one subscriber: assigning another replaces it, and `= null` removes it.
- **`onClick != null`**, inside the event's class, says whether it has a subscriber, like C#'s `if (Click != null)`: the first call, `b.pulsa(1)`, writes nothing, because there is none yet. Outside the class, an event is not a value: it is not stored or compared.
- **The important part: `raise` does not call the handler.** It queues it and returns at once; the handler runs later, on its thread. That is why «despues del raise» comes out before the handler's line. A C# event is something else: a list of methods that are called right there, with `+=` and `-=` ([manual §15](manual.html.md#eventos)).

<a id="excepciones"></a>
## 14. Exceptions

BP's `try`, with braces, and the `catch` by type with the type in front, as in C#:

```jc
module Errores
{
   public class SensorError : RuntimeError
   {
      public int pin { get; set; }

      public function SensorError(string msg, int pin) : base(msg)
      {
         this.pin = pin;
      }
   }

   function int lee(int pin)
   {
      if (pin < 0) throw new SensorError("pin no válido", pin);
      return 100 / pin;
   }

   function void prueba(int pin)
   {
      try
      {
         int r = lee(pin);
         println("lee ", pin, ": ", r);
      }
      catch (SensorError e)
      {
         println("sensor: ", e.msg, " (", e.pin, ")");
      }
      catch (ArithmeticError e)
      {
         println("cuenta: ", e.msg);
      }
      catch
      {
         println("otro error");
      }
      finally
      {
         println("  hecho");
      }
   }

   function void main()
   {
      prueba(4);
      prueba(-1);
      prueba(0);
   }
}
```

```text
lee 4: 25
  hecho
sensor: pin no válido (-1)
  hecho
cuenta: División por cero
  hecho
```

| JC | BP |
|---|---|
| `try { … } catch (RuntimeError e) { … } finally { … }` | `try … catch e: RuntimeError … finally … endtry` |
| `catch (Exception e) { … }` | `catch e` |
| `catch { … }`, without a variable: catches everything | `catch` |
| `throw new SensorError("…", 3);` | `throw SensorError("…", 3)` |
| `try (Recurso f = new Recurso("x")) { … }` | `try var f: Recurso := Recurso("x") … endtry` |
| `class SensorError : RuntimeError` | `class SensorError extends RuntimeError` |

- **The `catch`es are tried in order**: the most specific one, first. Every exception descends from `Exception`, with its `msg`.
- **The VM's errors carry their type**, all of them children of `RuntimeError`: `ArithmeticError` (an integer division by zero, a number that does not fit in its type), `NullReferenceError`, `IndexError`, `CastError` and `IOError` (and its child `EncodingError`). The rest is `RuntimeError` ([manual §11](manual.html.md#excepciones)).
- **The `finally` always runs**, also when a `return`, a `break` or a `continue` leaves the `try`; and it cannot leave with any of the three itself. The `catch` is optional: `try { … } finally { … }` is valid.
- **What JC does not have**: the `throw;` that rethrows (it is written `throw e;`), the `when` filters and C#'s `using` (it is Java's `try (…)`).
- **An exception that nobody catches** ends its thread; if it is the main thread, the program, which exits with code 1.

<a id="hilos"></a>
## 15. Threads and `parallel`

BP's threads are real threads, which the VM's scheduler alternates and which, on a dual-core board, run at the same time ([manual §14](manual.html.md#concurrencia)). In JC they are written in three ways:

```jc
module Hilos
{
   public class Calculo
   {
      public function void suma(int n)
      {
         int s = 0;
         for (int i = 1; i <= n; i++) s += i;
         println("suma hasta ", n, " = ", s);
      }
   }

   public class Contador : Thread
   {
      private string nombre;

      public function Contador(string nombre) : base(2048)
      {
         this.nombre = nombre;
      }

      public function void run()
      {
         println(this.nombre, " corre en su hilo");
      }
   }

   function int sumaRango(int a, int b)
   {
      int s = 0;
      for (int i = a; i <= b; i++) s += i;
      return s;
   }

   function void main()
   {
      parallel
      {
         case t1 = new Thread(2048):
            println("t1 = ", sumaRango(1, 100));
         case t2 = new Thread(2048):
            println("t2 = ", sumaRango(101, 200));
      }
      println("los dos han acabado");
      Contador c = new Contador("contador");
      c.start();
      c.join();
      Calculo k = new Calculo();
      Thread h = new Thread(k::suma(10));
      h.start();
      h.join();
   }
}
```

```text
t1 = 5050
t2 = 15050
los dos han acabado
contador corre en su hilo
suma hasta 10 = 55
```

- **`parallel { case t1 = new Thread(2048): … default: … }`** starts one thread per `case`, with the stack it states (in bytes), and waits for all of them at the `}`. The `default`, if there is one, runs on the calling thread in the meantime. It is BP's `parallel … endpar`, with `case t1 := Thread(2048)`.
- **What a `case` sees**: its own locals, and the module's functions, classes and constants. Not the module variables, nor the locals of the function that contains it: to share data, an object ([manual §14.3](manual.html.md#conc-encapsulacion)).
- **A child class of `Thread`** asks for its stack with `: base(2048)` and writes its `run()`; `start()` starts it and `join()` waits for it.
- **`new Thread(object::method(args))`** launches a method on another thread, without writing the class: what in C# is done with a lambda.
- **What is shared between threads** is protected with a `Mutex`, a `SyncList` or a `sync` property. Each `println` comes out whole. On a dual-core board, `t1` and `t2` may come out in another order.

<a id="anotaciones"></a>
## 16. Annotations

BP's, as they are: `@Name{ key = value, key }`, before the declaration, with the braces even if they carry nothing, and several per declaration if needed. They are not C#'s `[Attributes]` or Java's annotations. The ones there are: `@BD`, which describes the ORM's entities ([databases §3](basedatos.html.md#entidades)); `@element`, the type of a generic class (§12); and `@implement` and `@override` (§11).

```jc
module Entidades
{
   @BD{ tabla = "medidas" }
   public class Medida
   {
      @BD{ pk }
      public long id { get; set; }

      @BD{ columna = "sensor_id" }
      public long sensorId { get; set; }

      @BD{}
      public double valor { get; set; }
   }

   function void main()
   {
      Medida m = new Medida();
      m.valor = 21.5;
      println(m.id, " ", m.valor);
   }
}
```

```text
0 21.5
```

<a id="diferencias"></a>
## 17. What JC does not have, and what clashes

<a id="no-tiene"></a>
### 17.1 What JC does not have

JC is BP: what BP does not have, JC does not have. The most common of what is missing from Java and C#, or is written another way, the compiler recognizes and says how it is («JC no tiene el ?? de C#…», JC does not have C#'s ??; «en JC es 'is', como en C#», in JC it is is); the rest gives a syntax error.

| From Java or C# | In JC |
|---|---|
| lambdas, delegates, LINQ | no; a method as a value is `object::method`, for an event (§13) or a thread (§15) |
| your own generics: `class Caja<T>`, `T f<T>()` | no; a generic class states its base type with `@element{type}` (§12) |
| `struct`, nested classes, `abstract`, `static class` | no |
| `var x = 5;` | no: the type is always written (§6.2) |
| `char`, `uint`, `ulong`, `decimal` | a character is an `int` (§6.3); the others, no |
| `@"…"`, `$"…{x}"` | no; concatenate with `+` |
| `??`, `?.`, `x is T t`, `x is null` | no; `x == null`, `x is T` and `(T) x` |
| `++x`, `y = x++`, `a = b = 0` | `x++;` as a statement; an assignment does not go inside an expression (§7.3) |
| `~x` | `x ^ -1` |
| C's general `for` | the four forms of the counter; the rest, with `while` (§8.2) |
| a `switch` that falls through, `goto case`, patterns | no; each `case` is its own block (§8.4) |
| `goto` and labels | `break` and `continue` with the loop's name (§8.5) |
| `ref`, `out`, `params`, named arguments | the `var` parameter, with a property (§9.2) |
| `throw;`, `catch … when`, `using (…)` | `throw e;`; no filters; `try (T r = e)` (§14) |
| `namespace`, `using System;` | modules and `import` (§5) |
| operator overloading, reflection, `async`/`await` | no; for what blocks, a thread (§15) |

<a id="desde-java"></a>
### 17.2 If you come from Java or C#

What compiles the same as in Java or C#, but does something else, or is written slightly differently:

- **A class member without a modifier is protected**, not private as in C# (§10.2). And a field is never public: it is exposed through a property.
- **Functions and methods are declared with `function`**, and every method is virtual except the `private` ones.
- **`print` does not move to a new line**; `println` does (§2.3).
- **`==` between strings compares the text**, even if you come from Java; and strings have no methods: `len(s)`, `upper(s)`… (§6.5).
- **`int a, b = 3;` only gives a value to `b`**, as in C# (§6.2).
- **A real without a letter is a `double`**, as in C#; on the boards `float` is usually the better choice, `1.5f` (§6.3).
- **An event gives notice later**: `raise` queues it and moves on, and it has one subscriber (§13).
- **An object with an owner is destroyed right away**, with its destructor; the collector takes care of the rest (§10.5).
- **The `for` is a counter**, with the limit included and computed once (§8.2).
- **A `List` stores `Object`**: `List<Sensor>` so that the compiler knows what it stores (§12).
- **An exception that nobody catches ends its thread**; the others carry on (§14).

<a id="choca"></a>
### 17.3 What clashes with BP

What you need to know when translating from one language to the other (§18.3):

- **A BP name that is a reserved word in JC** —`base`, `int`, `bool`, `new`, `is`, `static`, `void`, `foreach`, `protected`, `println`…— is not translated: the translator says so, with its line, and renames nothing.
- **The other way round, a JC name that is a reserved word in BP** —`step`, `next`, `end`, `then`, `loop`, `to`, `mod`, `and`…, in upper or lower case, because BP's reserved words are not case-sensitive—, is not translated either: the translator says so, with its line («el nombre «step», que en BP es una palabra reservada», the name step, which is a reserved word in BP), and renames nothing. If you plan to translate, avoid them.
- **What BP has that JC cannot write**: a `for` with the step in a variable, a `do … loop` without a condition and an `inline` among other statements. The translator says so.
- **What JC has that BP cannot write**: `(Caja) x` when the constructor of `Caja` accepts `x`, because in BP `Caja(x)` would construct. The translator says so.
- **The written form of a literal does not travel**: `'a'` reaches BP as `97`, and `0xFF`, as `255`.
- **Comments and blank lines do not travel**: the translation comes out without comments, in the translator's format.

<a id="compilar"></a>
## 18. Compiling, translating and the IDE

<a id="compilar-jc"></a>
### 18.1 Compiling a `.jc`

Like a `.bp`: the compiler picks the reader by the extension, and the rest is shared. The options are the usual ones ([reference §16.1](referencia.html.md#cli-frontend)):

```
bp build Programa.jc
```

- **The `.mod`** is the same one the program written in BP would give, and the `.dbg` points to the `.jc` and its lines: the debugger stops in `.jc` files with no extra steps.
- **`native` functions** go through the AOT just like BP's.
- **`import`s** find `.bp` and `.mod` files; an imported `.jc`, compiled first (§5.4).

<a id="proyecto"></a>
### 18.2 A project

A `.bpbuild` ([reference §16.2](referencia.html.md#cli-bpbuild)) with `"main": "Programa"` looks for `src/Programa.bp` and, if it is not there, `src/Programa.jc`. With both at once, it does not guess: it says so («el main está dos veces, Programa.bp y Programa.jc: el proyecto no sabe cuál compilar», the main is there twice: the project does not know which one to compile) and does not compile. The `sources` list accepts `.jc` files, and its files are compiled in order, so a JC module that imports another JC module goes after it:

```
{
  "sourceDir": "src",
  "outDir":    "out",
  "main":      "Programa",
  "sources":   ["src/Utiles.jc", "src/Programa.jc"]
}
```

```
bp build app.bpbuild
```

With the files of §5.4 in `src`, it compiles `Utiles`, then `Programa` and, because `Programa` imports it, `Viejo.bp`.

<a id="traducir"></a>
### 18.3 Translating between BP and JC

The compiler translates a source into the other language and writes it to the output. It translates the already analysed tree, so it knows where each `new` goes, which call is a conversion and what type a constant has when BP does not write it.

| Option | With a `.bp` | With a `.jc` |
|---|---|---|
| `--escribir-jc` | its translation to JC | the same file, rewritten |
| `--escribir-bp` | the same file, rewritten | its translation to BP |
| `--comprobar-jc` | the round trip: it translates it to JC, reads it back and compares the two trees | — |

A BP source, with its comments:

```
module Saludo
  // how many times to greet
  const VECES := 2

  function main()
    for i := 1 to VECES do
      print "hola "; i     // no comma: no space
    next
  end main
end Saludo
```

```
bp frontend Saludo.bp --escribir-jc > Saludo.jc
bp frontend Saludo.bp --comprobar-jc
```

The second command does the round trip, and the tree that comes back is the same:

```text
Saludo.bp: EQUIVALENTE
```

The first one leaves the translation in `Saludo.jc`, without the comments and with the type the compiler deduces for the constant:

```jc
module Saludo
{
   const int VECES = 2;

   function void main()
   {
      for (int i = 1; i <= VECES; i++)
      {
         println("hola ", i);
      }
   }
}
```

```text
hola 1
hola 2
```

- **Comments do not travel**, nor do blank lines: the translation has the translator's format (three spaces of indentation in JC; two in BP).
- **What has no form in the other language** (§17.3) is not translated: «no soportado» (not supported) comes out, with the reason and the line in the original, and the exit code is 2. If the original does not compile, 3. On success, 0.
- **With a folder**, `--escribir-jc` and `--comprobar-jc` go through all its `.bp` files and give the counts: those that translate, those that do not, and why.
- **The translated program is the same**: compiled, it gives the same `.mod`, except where BP's `print` uses the comma, which in JC is a `" "` piece and writes the same with different code.

<a id="ide"></a>
### 18.4 In the IDE

Just the essentials; the details are in the [IDE guide](guia-ide.html.md).

- **`.jc` files are opened, edited and saved** like `.bp` files, and they appear in the project tree. Highlighting and folding, by braces, follow the file's extension; when you save a new file without an extension, the IDE adds the one of the editor's language.
- **Compiling, running and debugging** work the same, on the PC and on the board, with breakpoints on the lines of the `.jc`. In a project, the main can be `<main>.jc`; with both, the IDE says so before touching anything.
- **Edit → «Traducir a JC» and «Traducir a BP»** (translate to JC, to BP) save the active file and open its translation in a new tab, unsaved. What does not translate, the console reports, with its reason.
- **Project → New Project creates the main in BP.** To have it in JC: «Traducir a JC», save the tab as `src/<main>.jc` and delete the `.bp`.

<a id="errores"></a>
### 18.5 The error messages

- **Syntax errors** are JC's: `File.jc:line:column: error sintáctico: …` (or `error léxico`). The first ten come out at once (V9), as in BP; with `--max-errores=0`, all of them.
- **Many say how it is written in JC**: «en JC es 'base', como en C#» (in JC it is base, as in C#); «en JC, ++ y -- van detrás: v++;» (in JC, ++ and -- go after); «JC no tiene el ?? de C#, de momento (el ternario, c ? a : b, sí)» (JC does not have C#'s ?? for now; the ternary, yes); «'Perro(…)' crea un objeto: en JC se escribe 'new Perro(…)'» (it creates an object: in JC, write new); and what is brought from Java: «en JC la clase base y las interfaces van tras ':', como en C#: class Perro : Animal» (the base class and the interfaces go after ':'), «un método lleva 'function' delante del tipo: function int getX(…)» (a method takes function before its type), «en JC lo que se recorre va con foreach: foreach (var x in lista)» (what is traversed goes with foreach), «tipo 'String' no encontrado: en JC es 'string'».
- **The other errors** —types, names, visibility— come from the analysis, which is BP's, and some of them speak BP: `i += 1.5` gives «'+=': 'integer' + 'double' da 'double', que no se guarda solo en 'integer' (como en C#: escribe la conversión, x := integer(x + …))» (the result is a double, which is not stored in an integer by itself: write the conversion), which in JC is `i = (int) (i + 1.5);`. The tables in this volume give the equivalence.

<a id="librerias"></a>
## 19. The libraries

The standard library, the graphical interface, SQLite and the packs are compiled BP modules: a program in JC imports them and uses them the same way, with the same names. Their documentation is in the BP volumes:

| I want… | See |
|---|---|
| the functions of `Core`, `List`, `Map`, files, `Json`, `Math`… | [Reference, §13](referencia.html.md#stdlib) |
| the pins, the buses, the network, Bluetooth, the SD card, sound | [Reference, §14](referencia.html.md#dispositivos) |
| the graphical interface: screens, widgets, events, forms | [Graphical interface](gui.html.md) |
| SQLite and the ORM | [Databases](basedatos.html.md) |
| the IDE, the boards, the packs, debugging | [IDE guide](guia-ide.html.md) |
| the background of each construct: the GC, threads, `owner`, modules | [Language manual](manual.html.md) |

Their examples are in BP. They read in JC like this:

| In the documentation (BP) | In JC |
|---|---|
| `function parseInt(s: string): integer` | `int n = parseInt("42");` |
| `var l: List := List()` | `List l = new List();` |
| `var txt: Gui.Label := Gui.Label(scr, "Hola")` | `Gui.Label txt = new Gui.Label(scr, "Hola");` |
| `var m: Modelo.Medida := Modelo.Medida(l.get(i))` (converts) | `Modelo.Medida m = (Modelo.Medida) l.get(i);` |
| `print "valor:", v` | `println("valor: ", v);` |
| `b.onClick := this::pulsado` | `b.onClick = this::pulsado;` |
| `try var f: IO.TextFile := IO.TextFile("datos.txt", "r")` … `endtry` | `try (IO.TextFile f = new IO.TextFile("datos.txt", "r")) { … }` |
| `while not f.eof() do` … `endwh` | `while (!f.eof()) { … }` |

Or, for a whole example, copy it into a `.bp` and translate it: `--escribir-jc`, or «Traducir a JC» in the IDE. A real JC program, with the `Json` library, is in the repository: `samplesJC/JsonDemo.jc`, also tested on a board.
