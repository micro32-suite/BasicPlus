<!-- Generated from basedatos.html by scripts/docs_md.py: edit the HTML, not this file. -->

# Databases

BasicPlus talks to **SQLite**. The same engine, the same `.db` file and the same code on the PC, on the Metro, on the ESP32-P4 and on the Discovery (STM32). It can be used two ways, and both are legitimate:

- **with SQL**, writing the statements yourself — direct and no surprises;
- **with the ORM**, which writes them for you from your classes.

**Which boards can.** Two things are needed: native code of the engine for that architecture —the pack brings it for ARM (RP2350 and STM32) and for the ESP32-P4's RISC-V— and RAM for its arena ([§1](#pack)). The **Metro RP2350** with PSRAM (`psram=1` in the environment; the Pico 2 has none), both **ESP32-P4** boards (kit and Waveshare) and, since V7, the **Discovery** (STM32) meet them; the Discovery runs `SqlDemo` with the database in flash, but with no external RAM its arena is hundreds of KB, not megabytes: for small databases. The **Nucleo** does not: it does not have enough memory for a database, and in V7 its pack area carries only the `Stdlib.pack`. The **ESP32-S3** has a pack area but there is no Xtensa binary, and there is none either for the FPU-less RISC-V of the **C3**, the **C5** and the **C6**.

<a id="pack"></a>
## 1. The pack: install it first

The engine **is not inside the VM**. It is a *pack* of native code burned separately, published under the name `SQLI`. This is not a whim: SQLite is larger than the whole VM, and whoever does not use databases should not pay for it.

**The pack comes built**, in the package's `packs/` folder. It only needs building if you change the library, from the repository:

```
java -jar toolchain/lexer-java/target/basicplus-frontend.jar \
     --project bpstdlib/sqlite/SQLite.bpbuild --backend=mivm
```

(First copy what is in `bpstdlib/sqlite/nativo/` into `bpstdlib/sqlite/out/` —the engines, already compiled: the compiler does not generate them, it picks them up. The details are in `bpstdlib/sqlite/LEEME.md`.)

**Burn it onto the board**: in the IDE, *Packs* panel → **«Copy pack to board…»** and pick `packs/SQLite.pack`. *Refresh*, *Delete* and *Format region…* are right there too. Since V7 the pack **carries no copy of the standard library**: the board takes `Core` and `Str` from the `Stdlib.pack`, from flash and without spending RAM, or from `/lib`, in RAM. Burn `packs/Stdlib.pack` too if the board does not have it —above all on boards without PSRAM—; if something is missing when you burn, the panel says so.

**Give it memory.** SQLite works on an **arena** of its own, separate from the VM heap. It comes out of the **RAM block for native engines**, which the board reserves at boot with the size its environment says (after changing it, a reset):

```
SQLite=4
```

In megabytes: four is what the P4 uses; **the minimum is 2** and the maximum 4095. Since V7 there is also a generic key, `packRam=<KB>`, in kilobytes and without that minimum, which **takes precedence over `SQLite=`** when both are there; with it the Discovery, which has no PSRAM, runs `SqlDemo` with `packRam=512`. The block belongs to **all** the engines on the board: if it also loads the graphical interface's, SQLite gets whatever LVGL leaves. With no block —neither key, `SQLite=` below 2 or a value that does not fit— the pack will not start; boot says so on its `packs:` line, and the IDE's INFO under «RAM packs», with the remedy.

**All at once, with a script** (V9; [IDE guide §14.1](guia-ide.html.md#guiones-instalacion)): in the IDE, **Guiones → Ejecutar un guion…** (run a script) and `bd-metro`, `bd-stm32-dk2` or, with the graphical interface, `gui-bd-esp32p4-kit` or `gui-bd-esp32p4-waveshare`. It formats the packs area (it asks first), sets the memory, reboots the board and burns the packs.

> **On the PC: the simulated micro.** The simulator shipped with the IDE carries the engine **linked in** since V6 (`SQLite.mod` and `Orm.mod` travel to it just as to a board, and there is no pack to burn): the examples on this page run without a board. If you build it yourself, that is `make sim LVGL=1 SQLITE=1`. The command-line C VM (`bpgenvm-c`) does not: the first call throws *«sql_open: falta el codigo nativo del pack 'SQLI' v1»*.

<a id="sinorm"></a>
## 2. Without the ORM: plain SQL

Three verbs, and they are the only three.

```
import SQLite

var db: SQLite.Db := SQLite.Db()
if not db.connect("/sd/readings.db") then
  print "could not open -> ", db.errorMessage()
  return
endif
```

`connect` **returns `false`**, it does not throw: a missing card or a wrong path is something that *happens*, and your program decides what to do. There is also `connectRead(path)` for read-only.

<a id="exec"></a>
### 2.1 Fire and forget

```
db.exec("CREATE TABLE readings (id INTEGER PRIMARY KEY, sensor TEXT, value REAL)")
db.exec("INSERT INTO readings(sensor, value) VALUES('temp', 21.5)")
print "last id: ", db.lastInsertId()    // long
print "rows touched:", db.changes()
```

Several statements in one call, separated by `;`. Here **malformed SQL IS an exception**: that is a bug in your program, not something the world did.

<a id="undato"></a>
### 2.2 Asking for ONE value

```
print db.execInt("SELECT count(*) FROM readings")
print db.execDouble("SELECT avg(value) FROM readings WHERE sensor = 'temp'")
print db.execStr("SELECT sensor FROM readings ORDER BY id LIMIT 1")
```

There is one per answer type because BP is statically typed: the return type has to be decided at compile time. The second parameter is **what to answer when there is no row at all**, which is not the same as «it is zero»:

```
db.execInt("SELECT value FROM readings WHERE sensor = 'wind'", -1)   // -1
```

<a id="filas"></a>
### 2.3 Walking rows

```
var q: SQLite.Query := db.query("SELECT sensor, value, t FROM readings ORDER BY value")
while q.nextRow() do
  print q.getStr(0), q.getDouble(1), q.getLong(2)
endwh
q.release()
```

Columns go **by index, starting at 0**, like BP arrays. There are also `columnCount()`, `columnName(i)` and `columnType(i)` for walking a table you do not know in advance. And `getInt`, `getLong`, `getDouble` and `getStr` to read.

> **The rule that makes it hard to get wrong: only what `query` returns has to be released.** Everything else ends by itself. And `close()` belongs to the **database**, goes once at the end, and has nothing to do with the `release()` of queries.

<a id="entidades"></a>
## 3. Defining entities: what is stored, and where

An entity is an ordinary class with `@BD` annotations. The key point:

> **Only what carries `@BD` is persisted.** An unannotated `property` is yours and never reaches the database. Nothing has to be excluded: what you want stored has to be included.

```
module Model

  @BD{ tabla = "readings" }
  public class Reading
    @BD{ pk }                     public property id:       long
    @BD{ columna = "sensor_id" }  public property sensorId: long
    @BD{}                         public property value:    double

    public function Reading()
      this.id := 0
      this.sensorId := 0
      this.value := 0.0d
    end Reading
  end Reading

end Model
```

- `@BD{ tabla = "..." }` on the class — which table it maps to.
- `@BD{ pk }` — the primary key. The database sets it on insert, and when `insert` returns your object already carries it.
- `@BD{ columna = "..." }` — when the column is named differently from the property. Without it, the property name is used.
- `@BD{}` on its own — stored, same name.

Types map like this: `long`/`integer` → `INTEGER`, `double`/`float` → `REAL`, `string` → `TEXT`.

<a id="orm"></a>
## 4. The ORM: `Dao` and `Where`

On top of the entities goes **one DAO per table**. It gives you the usual verbs without writing SQL, and `Where` builds the conditions:

```
var w: Orm.Where := Orm.Where()
w.eq("sensor_id", 1L).lt("value", 22.2d)
var cold: List := rdao.list(w)
```

`Where` has `eq`, `ne`, `lt`, `le`, `gt`, `ge`, `like`, `isNull`, `isNotNull` and `raw` for anything else; they chain with AND, and `orNext()` switches the link to OR. `sql()` shows you what it is about to send.

> **`Where` is not sugar: it is safety.** It writes values **escaped**. A name like `O'Brien` concatenated by hand breaks the statement; through `Where` it goes in whole and nothing happens.

### Reading the results

`list()` returns a `List` whose elements are `Object`. For the entity, a cast; for plain values, the **typed getters**:

```
var r: Model.Reading := Model.Reading(rows.get(i))   // entities: cast
var n: integer := other.getInteger(0)                 // values: converts
```

<a id="generar"></a>
## 5. Generating the DAOs

In the IDE: the **«DAO build»** button (or menu). From the command line:

```
bp frontend --project my/project.bpbuild --dao
```

It reads the project's `@BD` annotations and writes a module with one DAO per entity. The file opens by warning that it is **not to be edited**, and carries a `@generado` fingerprint: if nothing changed, the generator says `ya al dia` and leaves it alone.

<a id="crud"></a>
## 6. The operations (CRUD)

With `dao` built on a connection (`ReadingDao(db)`):

| verb | what it does |
|---|---|
| `insert(e)` | inserts; on return `e` carries its key |
| `add(e)` | the same, when you do not care about the id |
| `loadById(id)` | fetches one by key, or `null` |
| `load(e)` | fills `e` from the database using its key; `false` if it was not there |
| `refresh(e)` | reloads `e` (same as `load`, named for intent) |
| `update(e)` | saves the changes; `false` if it did not exist |
| `delete(e)` | deletes; the object is left with key 0 |
| `deleteById(id)` | deletes by key |
| `list(w, max)` | the ones matching the condition |
| `listAll(max)` | all of them |
| `uno(cond)` | the first match, or `null` |
| `close()` | closes the DAO (the connection is closed by whoever opened it) |

<a id="extender"></a>
## 7. Extending a DAO

**Never edit the generated file**: it gets rebuilt and you lose the changes. Inherit:

```
import SQLite
import Orm
import Model
import ModelDao        // imports are not transitive: all four

public class ReadingDaoPlus extends ModelDao.ReadingDao
  public function ReadingDaoPlus(base: SQLite.Db)
    super(base)
  end ReadingDaoPlus

  // By ANOTHER column. Convention: by key, `...By<something>`.
  public function loadBySensor(sensorId: long): Model.Reading
    return Model.Reading(this.uno("sensor_id = " + sensorId))
  end loadBySensor
end ReadingDaoPlus
```

That way you can regenerate whenever you like, which is exactly what it is designed for.

<a id="verificar"></a>
## 8. Verifying your entities against the real database

If your project declares a database, **the compiler checks the `@BD` annotations against the real schema** on every build and warns about anything that does not line up: missing tables, missing or extra columns, mismatched types.

```
{
  "sourceDir": ".",
  "outDir":    "out",
  "database":  "readings.db"
}
```

- **They are warnings, never errors.** A database can be designed in full before the program, and with forty tables ahead nobody writes forty entities in one go. Blocking the build over that would turn the tool into a nuisance.
- **The database is opened read-only.** It is yours and may hold data that exists nowhere else; a build tool has no business writing there.
- **Verification is optional by design.** It needs a JDBC driver at run time; if it is missing, the step is skipped, says so, and the build carries on.

<a id="indices"></a>
## 9. Speeding up `SELECT`s with indexes

Nothing BasicPlus-specific here: it is SQL, sent with `exec`.

```
db.exec("CREATE INDEX IF NOT EXISTS ix_readings_sensor ON readings(sensor_id)")
```

Rule of thumb: **index the columns you filter or sort by**, especially the foreign keys you use in `Where.eq(...)`. It shows up sooner on a micro than on a PC, because the card is slow: with no index, SQLite walks the whole table reading from the SD.

And the flip side, which also matters: every index takes space and makes `INSERT`s more expensive. On a logger that writes a lot and queries little, a spare index costs.

<a id="ventanas"></a>
## 10. Working in windows, so you do not eat your memory

A `SELECT` of a hundred thousand rows does not fit in a microcontroller. There are two ways, and the first one is the good one.

**With a cursor** — `query` + `nextRow` **never holds more than one row in memory**. It does not matter if the table has a million records:

```
var q: SQLite.Query := db.query("SELECT id, value FROM readings ORDER BY id")
while q.nextRow() do
  process(q.getLong(0), q.getDouble(1))
endwh
q.release()
```

**By pages**, when you need the results together (to sort them, show them or send them):

```
var q: SQLite.Query := db.query("SELECT n FROM t ORDER BY n LIMIT 2 OFFSET 2")
```

And in the ORM the cap goes on the verb itself — **`list` and `listAll` bring at most 1000 unless you say otherwise**, which is a safety net and not a whim:

```
var page: List := rdao.list(w, 50)
```

> A large `OFFSET` is expensive: SQLite has to count the rows it skips. To walk a whole table the cursor is better, or paginate by key (`WHERE id > last ORDER BY id LIMIT 50`).

<a id="varias"></a>
## 11. Several queries at once

Here is one that surprises people coming from JDBC: **you can keep several queries open on the same connection, and nest them**. Each `query` carries its own cursor and they advance independently.

```
var s: SQLite.Query := db.query("SELECT DISTINCT sensor FROM readings")
while s.nextRow() do
  var name: string := s.getStr(0)
  // ...and a query INSIDE the other one's walk
  var howMany: integer := db.execInt("SELECT count(*) FROM readings WHERE sensor = '"
                                    + Orm.esc(name) + "'")
  print name, "->", howMany
endwh
s.release()
```

(`Orm.esc` belongs to the `Orm` module: the fragment needs `import Orm` besides `import SQLite`.) In JDBC this forces a second connection, because a `Statement` closes its `ResultSet` when reused. Here it is not needed: the inner `execInt` calls open and release their own without touching the outer cursor.

<a id="conexiones"></a>
## 12. More than one connection

That works too, and at the same time:

```
var a: SQLite.Db := SQLite.Db()
var b: SQLite.Db := SQLite.Db()
a.connect("/sd/readings.db")
b.connect("/sd/config.db")
```

> **But watch the memory.** Both connections come out of the **same arena**, the one of the block the environment declares (`SQLite=` or `packRam=`, [§1](#pack)), and it does not grow: every open database takes its own page cache and structures. On a PC you do not notice; on a micro with a 4 MB arena you do.

The rule: **if two DAOs work on the same database, they share a connection.** Pass them the same `Db` when constructing them; each closes its own, and the connection is closed by whoever opened it, last.

<a id="trampas"></a>
## 13. Known traps

**The `L` suffix on `long` literals.** A millisecond timestamp does not fit in 32 bits. Since V5 the type of an integer literal is decided by its magnitude, so it is no longer truncated; the `L` is still a good habit, because it says what you mean:

```
1754300000000L    // long, explicit
1754300000000     // long as well: does not fit an integer
```

**The apostrophe.** Concatenating user text by hand breaks the statement. Use `Where`, or `Orm.esc(...)` if you write the SQL yourself.

**Where the database lives.** On a board with a card, on the card: `/sd/readings.db`; without one —and on the IDE's simulated micro, which has none—, in the micro's flash: `readings.db`. **Do not put it in `resources/`** — that folder is copied to the micro on every run and would overwrite your database with the project's.

**The path comes as an argument.** Since V6 `Main` receives the run argument, and the default is declared on the parameter itself — which is where deployment is configured:

```
function Main(arg: string := "medidas.db")
  correr(arg)
end Main
```

In the IDE's micro console, `run SqlDemo` uses the default and `run SqlDemo /sd/other.db` whatever you say; both PC CLIs take it as a second argument after the `.mod`. **Autorun** passes no argument: it starts with the source's default.

**One core.** On dual-core boards (the Metro, the P4), a program that uses SQLite runs its threads one at a time, as on a single-core board: the engine is compiled without threads. It works the same; it just does not use the second core.

<a id="seguir"></a>
## Where to go next

| I want… | look at |
|---|---|
| plain SQL, the three verbs | `samples/SqlDemo.bp` |
| the ORM with hand-written DAOs | `samples/DaoDemo.bp` |
| the ORM with generated DAOs | `samples/GenDemo.bp` |
| the same database on the card | `samples/SqlDemoSd.bp` and [the SD card](referencia.html.md#stdlib-sd) |

The examples on this page are **executed**, not assumed: they come from those three programs, which run end to end and return their memory.
