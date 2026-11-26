<!-- Generated from gui.html by scripts/docs_md.py: edit the HTML, not this file. -->

# BasicPlus — Graphical interface

Third volume of the BasicPlus documentation, dedicated to the **GUI**: the `Gui` module of the standard library, its widgets and the forms. It complements the [Language manual](manual.html.md#intro) and the [Standard library reference](referencia.html.md#stdlib).

<a id="intro"></a>
## 18. Introduction

The BasicPlus graphical interface is just another module of the standard library: `Gui`. A program builds a tree of widgets (screen, labels, buttons, tables…), hooks up events and enters the event loop with `Gui.run()` — or starts it on its own thread with `Gui.start()` and carries on (§24.1). The same program — the same `.mod` — runs unchanged on the PC and on the microcontroller.

![BasicPlus font demo on the host](../img/gui/fonts-demo.png)

A BasicPlus GUI program running on the host (SDL window). Same bytecode on the board.

<a id="intro-vms"></a>
### 18.1 The three VMs

The widget tree (the *model*) is portable and lives in the core; what changes is who *paints* it:

| VM | Render | Where |
|---|---|---|
| miVM (Java) | Swing | PC — quick preview from the IDE |
| VM-C (host) | LVGL + SDL window | PC — identical to the board render |
| VM-C (device) | LVGL (from the GUI pack) + display | Microcontroller with a display: ESP32-C5-Touch-LCD-2.8, ESP32-C6-LCD-1.3, ESP32-P4 (kit and Waveshare) and STM32U5G9J-DK2, with its display packs burnt (§23.4) |

All three execute the **same bytecode** and build the **same widget model**; the only difference is the paint backend. That is why a GUI written and tested on the PC goes to the board without touching the code (only, if anything, the pins or the screen size).

> The model can be dumped as text with `Gui.dumpTree()`, or as JSON with `toJsonText()` on any widget (§24.2): it is the source of truth shared by the three VMs and the basis of the parity checks. Throughout this volume we use the dump to show the structure of each example without relying on a screenshot. When you do need to see the pixels, that is `Gui.shot` (§23.5).

<a id="intro-run"></a>
### 18.2 How it runs

- **Preview on the PC** — from the IDE, or from the command line with the C VM built with the LVGL render (`make LVGL=1`) and an SDL window.
- **On the board** — the IDE's *Run on Device* button; it uploads the `.mod` and the project's `resources/` and runs it on the real display. See the [IDE guide](guia-ide.html.md). Before that, once per board, you burn its display packs: since V7, LVGL is not in the firmware image (§23.4).

<a id="intro-primeros"></a>
### 18.3 First steps of a GUI project

Until now, BasicPlus programs were mostly written for small devices: in most cases *automata*, with no user intervention. A device with a graphical interface is almost the opposite: the application sits **waiting for the user to interact**, and the medium is the graphical display and its touch panel.

Before starting the application itself you have to think about the **hardware**. A graphical application needs a display with touch:

- **The display** — the first thing is to settle its size.
- **The microcontroller** — there are important decisions here: you need a micro with **RAM** (the bigger the display, the more RAM you will need). It also helps if the micro brings graphics support — with **DSI** preferably, if the display is medium or large.
- **A good option is a display that includes the micro** — like the boards with an integrated ESP32-P4; and, for small things, an SPI display like the one on the ESP32-C5-Touch-LCD-2.8 (240×320, touch) or the one on the ESP32-C6-LCD-1.3 (240×240, no touch). The five supported displays, and what each one needs, are in §23.4.

> To get a feel for the RAM: the *framebuffer* alone of a 1024×600 display in 16-bit color takes ~1.2 MB — more than the entire SRAM of most micros. That is why graphics boards carry **PSRAM** (the reference ESP32-P4 boards, 32 MB): a medium or large display without PSRAM is asking for trouble.

With the hardware chosen you can start **designing the interface**: the main screen and the rest of the screens. And finally the code, in this natural order:

1. Start the application with `main`, like any BasicPlus application.
2. Create the screen (`Gui.Screen()`, §19.1).
3. Set the orientation, if the default needs changing (`Gui.setRotation`, §23.4).
4. Create the first window (§22) and, from it, the rest of the application.
5. Enter the event loop with `Gui.run()` — the application sits waiting for the user. If the program has more to do meanwhile, `Gui.start()` starts the loop and returns (§24.1).

And none of this has to be right on the first try: the interface is **iterated on the PC** — preview and LVGL render (§23.1–23.2) — and, once it convinces you, the *same* `.mod` is uploaded to the board. A good starting point is the `samples/formdemo` project (§22) or any of the `Gui*` demos that ship with the library.

<a id="intro-arranque"></a>
### 18.4 Two ways to start the interface: `run()` and `start()`

Once the tree is built, somebody has to *pump* the GUI: serve the display, the touch panel and the events. There are two ways to start that loop, and the choice decides **what the main thread does meanwhile**.

|  | `Gui.run()` | `Gui.start()` |
|---|---|---|
| What it does | Starts the loop **and waits for it**: it is `start()` + `join()`. | Starts the loop **and returns**. |
| When it returns | When the GUI ends. On the PC, when the window is closed; **on a board there is no window to close**: it only returns if a handler calls `Gui.stop()` or the IDE kills the program. In practice, whatever follows `run()` runs "when the application ends". **Without a screen** —in tests: the C VM with `--no-screen` or without LVGL, or miVM without a window (`-Djava.awt.headless=true`)—, as soon as there is nothing left to handle: it handles whatever is queued and returns, so a GUI program ends by itself. | Right away. The program stays alive while the loop runs, even if `Main` ends. Without a screen, the loop ends as soon as it has no work left, and nothing injected afterwards gets handled: a test click (`Gui.click`, §24.4) goes before `Gui.run()`, which handles it and returns; afterwards, it raises an error that says so. |
| The main thread | Stays **parked** in the `join()`: it does nothing else until the GUI ends. | **Keeps running alongside** the GUI: it can read sensors, wait, write into widgets… |
| Where handlers run | In both cases, **on the GUI thread** (a BP thread of its own, 8 KB stack), never on the main one. Between iterations the loop sleeps for as long as LVGL asks, with a BP `sleep`, so it does not starve the other threads. |  |
| To finish | From a handler, `Gui.stop()`. | `Gui.stop()` asks the loop to end (does not wait; another thread or a handler may call it) and `Gui.join()` waits for it. A second `start()` does not start another loop. |

The detail to keep in mind with `start()`: **`Main` and the handlers are two threads touching the same data**. A counter that `Main` reads and a handler writes needs the usual thread discipline (a single writer, a `SyncList`, a `Mutex`). With `run()` that problem does not exist, because the main thread is asleep. Widgets themselves may be touched from any thread: the model lives in the VM, not in the GUI thread.

The application that *is* its screen uses `run()`:

```
module GuiRunDemo
  import Gui

  function Main()
    var scr: Gui.Screen := Gui.Screen()
    var b: Gui.Button := Gui.Button(scr, "Press")
    b.align(Gui.Align.CENTER, 0, 0)
    Gui.run()                       // does not return until the GUI ends
    print "the GUI has ended"      // on a board: only after Gui.stop() or a kill
  end Main
end GuiRunDemo
```

The one that has work of its own plus a screen uses `start()`:

```
module GuiStartDemo
  import Gui

  function Main()
    var scr: Gui.Screen := Gui.Screen()
    var lbl: Gui.Label := Gui.Label(scr, "measuring...")
    lbl.align(Gui.Align.CENTER, 0, 0)
    Gui.start()                     // starts the loop and RETURNS
    var i: integer := 0
    while i < 5 do                  // Main stays alive: does its own work
      sleep(200)
      lbl.setText("sample " + i)
      i := i + 1
    endwh
    Gui.stop()                      // asks the loop to end...
    Gui.join()                      // ...and waits for it
    print "done"
  end Main
end GuiStartDemo
```

Both exit with code 0 on both VMs. `samples/GuiShot.bp` is the second pattern with a screenshot in the middle.

<a id="conceptos"></a>
## 19. Concepts

<a id="conceptos-arbol"></a>
### 19.1 Screen and widget tree

Everything hangs from a **screen** (`Gui.Screen`), the root of the tree. Each widget is created naming its *parent*, so the tree is assembled top-down. A minimal example:

```
module Hello
  import Gui

  function Main()
    var scr: Gui.Screen := Gui.Screen()
    var txt: Gui.Label := Gui.Label(scr, "Hello, world")
    txt.align(Gui.Align.CENTER, 0, 0)
    Gui.run()
  end Main
end Hello
```

The resulting model (`Gui.dumpTree()`):

```
screen [480x320 align=0 +0,0]
  label "Hello, world" [-1x-1 align=4 +0,0]
```

`-1x-1` means "automatic size" (the widget fits its content); further down you will see how to set size and position.

**The screen is the size of the panel.** The `480x320` above is the *host* default; on the board `scr.width`/`scr.height` and the dump report the real panel size: 240×320 on the C5, 240×240 on the C6, 800×480 on the DK2, 1024×600 on the P4 (480×800 on the Waveshare). The same program gives a different dump on each display. To make the PC mimic a given board, the host C VM accepts `--screen=WxH` (§23.2).

<a id="conceptos-component"></a>
### 19.2 Component and Container (common base)

All widgets descend from `Gui.Component` (which in turn descends from `Object`, like everything in BasicPlus). `Component` provides what is common to any widget: text, geometry, alignment, color and font. The most used members:

| Member | What for |
|---|---|
| `align(anchor, dx, dy)` | Places the widget relative to its parent (see 19.3). |
| `width` / `height` | Size in pixels (properties; unset = automatic). |
| `fontSize` | Text size in px from the compiled catalog (see 21.2). |
| `setFont(id)` *(on `Label`)* | Applies to a label a font loaded with `Gui.loadFont` (see 21.2). |
| `setBgColor(c)` / `setTextColor(c)` | Background and text color (see 21.1). |
| `getParent()` | The container that holds it (`null` at the root). |
| `delete()` | Removes it from the tree with its children (see 24.2). |

The widgets that can **contain** others — `Screen`, `Panel`, `Window`, `TabPage`, `Tabview` and `Button` — descend from `Gui.Container`, which extends `Component` with the list of children (`childCount()`, `childAt(i)`). The leaves (`Label`, `Checkbox`, `Slider`…) descend from `Component` directly. Every constructor takes the parent as `parent: Container`: a `Label` inside a `Checkbox` does not compile. The tree is yours to walk and dump (`toJson()`, §24.2).

**A widget's owner is its container**: on creation it registers with it, and it stays there until a `delete()` (its own or an ancestor's). If you also hold it with a local `var owner`, when that goes out of scope its destructor removes it from the tree and from the screen and unregisters it from its container (V7, 3-Oct); the screen (`Screen`) is never removed that way. For everything else, a plain reference.

> **OO policy.** Like the rest of the library, widgets are classes: no public fields, only properties. This keeps the API stable across versions and boards.

<a id="conceptos-layout"></a>
### 19.3 Layout: align, position, size

Positioning is by **anchors** (a subset of LVGL's `ALIGN`): `align(anchor, dx, dy)` anchors the widget to an area of its parent and applies a `(dx, dy)` offset in pixels. Anchors available in `Gui.Align`:

```
TOP_LEFT     TOP_MID     TOP_RIGHT
LEFT_MID     CENTER      RIGHT_MID
BOTTOM_LEFT  BOTTOM_MID  BOTTOM_RIGHT
```

Example: a label at top-center, pushed 20 px down, with text size 32:

```
var t: Gui.Label := Gui.Label(scr, "Title")
t.fontSize := 32
t.align(Gui.Align.TOP_MID, 0, 20)
```

<a id="conceptos-geom"></a>
### 19.4 Explicit geometry and Panel

As an alternative to `align`, a widget is positioned and sized by hand with the `x`, `y`, `width`, `height` properties — or all at once with `setBounds(x, y, w, h)`. A `Gui.Panel` is a simple container to group widgets; it supports optional scrolling via `scrollDir` (`Gui.ScrollDir.VER`, `HOR`, `BOTH` or `NONE`). **Nothing scrolls unless the program asks for it**: the screen, a panel and the page of a tab are born with `NONE` (V8.5; until then, on the board they scrolled even though it said so). The list, the text field and the table do scroll: it is part of what they are.

```
var p: Gui.Panel := Gui.Panel(scr)
p.x := 10
p.y := 20
p.width := 100
p.height := 50
p.scrollDir := Gui.ScrollDir.VER
```

**What fits inside a `Panel` is less than its size**: it has a 2 px border, very light grey, and a padding inside, and the `x`, `y` and `align` of its children are counted from there, not from its corner. The padding depends on the width of the screen (its native one: rotating it does not change it). The page of a tab (`TabPage`) leaves the same padding, with no border; and the window of a form (`Gui.Window`) is a panel.

| width of the screen | a child at (0, 0) comes out at | inside a 200 × 100 one there is room for |
|---|---|---|
| up to 320 | 15 px from its corner (2 + 13) | 170 × 70 |
| from 321 to 719 | 18 px (2 + 16) | 164 × 64 |
| 720 or more | 22 px (2 + 20) | 156 × 56 |

What does not fit is cut off, with no bars, unless the panel scrolls (its `scrollDir`). To cover a whole panel, a child of its size, centered (`align(Gui.Align.CENTER, 0, 0)`). All this is LVGL's; since V8.5, the Java VM does the same, with the padding of its screen, the 480 × 320 one.

> **BasicPlus does not draw free shapes** (lines, circles, canvas): the interface is composed out of widgets. For a colored rectangle, a `Panel` with `setBgColor` is enough. A pixel-level drawing canvas would be a future extension; it is not there today.

<a id="catalogo"></a>
## 20. Widget catalog

Each widget is a `Gui` class descending from `Component` (§19.2), so it inherits `align`, size, color and font. For each one we show the constructor in **BP code** and, below it, **the same thing in the `.win` file (JSON)** — which is the usual way to assemble the interface (the form designer; see §22). **Events** (`onClick`, `onChange`) are covered in §22. The screenshots are from the LVGL render on the host.

<a id="w-label-button"></a>
### 20.1 Label and Button

`Gui.Label` shows text; `Gui.Button` is a pressable button. Both take the parent as the first argument, and the text next. On the button the text is **optional** (`Button(parent, text := "")`): a button is a container, and without text it is empty, ready for whatever you hang on it (an icon, a label of your own). The text goes in the center, also with a size of your own.

![Label and button](../img/gui/click.png)

GuiClickDemo — a label and a centered button.

```
var lbl: Gui.Label  := Gui.Label(scr, "waiting")
var btn: Gui.Button := Gui.Button(scr, "Press me")
btn.align(Gui.Align.CENTER, 0, 0)

var ico: Gui.Button := Gui.Button(scr)              // no text: an empty container
var icoTxt: Gui.Label := Gui.Label(ico, "+")     // whatever you hang on it
```

The same in the `.win` (JSON):

```
{ "type": "Label",  "text": "waiting",  "align": "TOP_MID", "y": 10 },
{ "type": "Button", "text": "Press me", "align": "CENTER", "clic": "onPress" }
```

<a id="w-check"></a>
### 20.2 Checkbox

`Gui.Checkbox` is a labeled check box; its state lives in the `checked` property. The `Gui.Toggle` switch (an on/off without text) is shown in §20.3.

![Checkbox](../img/gui/check.png)

GuiCheckDemo — checked box.

```
var cb: Gui.Checkbox := Gui.Checkbox(scr, "Enable")
cb.checked := true
```

The same in the `.win` (JSON):

```
{ "type": "Checkbox", "text": "Enable", "checked": true, "change": "onEnable" }
```

<a id="w-value"></a>
### 20.3 Slider, Bar and Toggle

`Gui.Slider` (editable slider), `Gui.Bar` (progress bar, read-only) and `Gui.Toggle` (switch). Slider and Bar share `setRange(min, max)` and the `value` property.

![Toggle, slider and bar](../img/gui/value.png)

GuiValueDemo — switch on, slider at 150/200 and bar at 7/10.

```
var sw: Gui.Toggle := Gui.Toggle(scr)
sw.checked := true

var sl: Gui.Slider := Gui.Slider(scr)
sl.setRange(0, 200)
sl.value := 150

var pb: Gui.Bar := Gui.Bar(scr)
pb.setRange(0, 10)
pb.value := 7
```

The same in the `.win` (JSON):

```
{ "type": "Toggle", "checked": true, "align": "TOP_MID", "y": 20 },
{ "type": "Slider", "min": 0, "max": 200, "value": 150, "align": "TOP_MID", "y": 90 },
{ "type": "Bar",    "min": 0, "max": 10,  "value": 7,   "align": "TOP_MID", "y": 160 }
```

<a id="w-input"></a>
### 20.4 Dropdown and Textarea

`Gui.Dropdown` is a drop-down list (options separated by `\n`, selection in `selected`); `Gui.Textarea` is a text field (`text` property, and `readOnly` for read-only). Typing into it requires a keyboard (§20.9).

![Dropdown and textarea](../img/gui/input.png)

GuiInputDemo — drop-down (Azul) and text field.

```
var dd: Gui.Dropdown := Gui.Dropdown(scr)
dd.setOptions("Red\nGreen\nBlue")
dd.selected := 2

var ta: Gui.Textarea := Gui.Textarea(scr)
ta.text := "hello"
ta.readOnly := true
```

The same in the `.win` (JSON; `readOnly` is code-only for now):

```
{ "type": "Dropdown", "options": "Red\nGreen\nBlue", "selected": 2 },
{ "type": "Textarea", "text": "hello" }
```

<a id="w-table"></a>
### 20.5 Table

`Gui.Table` is a grid of text cells: `setGrid(rows, cols)` sizes it and `setCell`/`getCell` write and read by `(row, col)`. Out of range, `getCell` returns `""`.

![Table](../img/gui/table.png)

GuiTableDemo — 2×3 table with header.

```
var t: Gui.Table := Gui.Table(scr)
t.setGrid(2, 3)
t.setCell(0, 0, "Name")
t.setCell(1, 0, "Ann")
```

The same in the `.win` (JSON; since V7): the grid and, if any cell says something, all of them, row by row —it is what `toJson()` writes—:

```
{ "type": "Table", "rows": 2, "cols": 3, "cells": [["Name", "", ""], ["Ann", "", ""]] }
```

<a id="w-tab"></a>
### 20.6 Tabview

`Gui.Tabview` groups pages into tabs. `addTab("name")` creates a tab and returns its page (a `Gui.TabPage`, which is a `Container`) on which you hang widgets; `active` is the visible tab. Pages are not built by hand: they only come from `addTab`.

![Tabs](../img/gui/tab.png)

GuiTabDemo — two tabs, second one active.

```
var tv: Gui.Tabview := Gui.Tabview(scr)
var p1: Gui.TabPage := tv.addTab("One")
var l1: Gui.Label := Gui.Label(p1, "Page 1")
tv.active := 1
```

In the `.win` (JSON): pending — pages/tabs are nested structure (2nd phase). For now, by code.

<a id="w-image"></a>
### 20.7 Image and ImageView

`Gui.Image` is the *asset* (loaded once with `loadFile`, PNG format); `Gui.ImageView` is the widget that shows it via `setImage`. Several views can share the same asset; `refresh()` reloads only if the asset changed.

![Image](../img/gui/image.png)

GuiImageDemo — two views of the same PNG asset.

```
var img: Gui.Image := Gui.Image()
var ok: boolean := img.loadFile("testimg.png")   // from the project (cwd or /app)

var v: Gui.ImageView := Gui.ImageView(scr)
v.setImage(img)
```

In the `.win` (JSON): pending — the asset and the view need a shared reference (2nd phase). For now, by code.

<a id="w-msg"></a>
### 20.8 Msgbox

`Gui.Msgbox` is a notice with text and buttons (`setButtons`, labels separated by `\n`). It is not modal: it does not block the program. Pressing a button fires `onChange` and `result` holds the button index.

![Message box](../img/gui/msg.png)

GuiMsgDemo — notice with an OK button.

```
var mb: Gui.Msgbox := Gui.Msgbox(scr, "Operation complete")
mb.setButtons("OK")
```

The same in the `.win` (JSON):

```
{ "type": "Msgbox", "text": "Operation complete", "buttons": "OK" }
```

<a id="w-list"></a>
### 20.9 ListBox and Keyboard

`Gui.ListBox` is a list of selectable items (`setItems`, separated by `\n`; `selected` is the index). `Gui.Keyboard` is an on-screen keyboard that is tied to a `Textarea` with `setTextarea` and auto-places itself at the bottom. `setBounds(x, y, w, h)` sets position and size at once.

![List and keyboard](../img/gui/list.png)

GuiListKbd — list, text field and on-screen keyboard.

```
var lst: Gui.ListBox := Gui.ListBox(scr)
lst.setItems("One\nTwo\nThree")
lst.setBounds(5, 5, 180, 140)

var ta: Gui.Textarea := Gui.Textarea(scr)
var kb: Gui.Keyboard := Gui.Keyboard(scr)
kb.setTextarea(ta)
```

> **Changed in V6.** This used to be `kb.attach(ta)`. Now `attach(parent)` is how any widget registers with its container (the constructor calls it), so the keyboard is tied to its field with `setTextarea(ta)`; the old `attach(ta)` no longer compiles (`Textarea` is not a `Container`).

The list in the `.win` (JSON); the keyboard, for now, code-only (2nd phase):

```
{ "type": "ListBox", "items": "One\nTwo\nThree", "selected": 1 }
```

> Other widgets following the same pattern, not shown here: `Gui.Spinbox` (integer with arrows), `Gui.Led` (on/off indicator), `Gui.Panel` (grouping container) and `Gui.Chart` (series chart for sensors: `setPointCount`, `addSeries`, `push`; demo in `samples/ChartDemo.bp`). All of them in the table of §24.3.

<a id="color-fuentes"></a>
## 21. Color and fonts

<a id="color"></a>
### 21.1 Color

A color is built with `Gui.Color(0xRRGGBB)` (red-green-blue, one byte per channel). It is applied to any widget with `setBgColor` (background) and `setTextColor` (text):

![Color palette](../img/gui/color.png)

GuiColorDemo — eight buttons with colored background and text.

```
var b: Gui.Button := Gui.Button(scr, "Red")
b.setBgColor(Gui.Color(0xD00000))     // red background
b.setTextColor(Gui.Color(0xFFFFFF))   // white text
```

In the `.win` (JSON) the color goes as a hex string (JSON has no `0x` literals):

```
{ "type": "Button", "text": "Red", "bgColor": "0xD00000", "textColor": "0xFFFFFF" }
```

> Pick the text color to match the background (white over dark, black over light) so the contrast stays readable — as in the screenshot.

<a id="fuentes"></a>
### 21.2 Fonts

There are two ways to choose the font of a text.

#### Compiled catalog — by size

The `fontSize` property of any widget sets the text size in pixels, picking from the catalog of fonts compiled with LVGL (on the board, inside the GUI pack, §23.4): **Montserrat** at `12, 14, 16, 18, 20, 24, 28, 32, 36, 40, 48` px (default, 14). The value must match one of those sizes; otherwise the default font is used. The pack for small displays (`GuiMini`, the C6's) only goes up to 24 px: a larger size comes out at 24, and the board's log says so once.

```
var t: Gui.Label := Gui.Label(scr, "Title")
t.fontSize := 32
```

#### Loaded fonts — `.bin` at runtime

For bold, other families or sizes outside the catalog, a `.bin` font is loaded (LVGL's *binfont* format, the one produced by the `lv_font_conv` tool). `Gui.loadFont(path)` reads it from the project and returns an id; `setFont(id)` applies it to the widget. The path resolves like images do (project folder on the PC, uploaded `resources/` on the board).

![Font demo](../img/gui/fonts-demo.png)

FontLoadDemo — default (14), `fontSize=32`, and a loaded `.bin` (Montserrat 26 bold).

```
var fid: integer := Gui.loadFont("montserrat_26_bold.bin")
var l: Gui.Label := Gui.Label(scr, "Bold text")
l.setFont(fid)
```

> **Accents and ñ.** The compiled Montserrat font is ASCII-only: no `ñ`, no accented vowels. For accented text (Spanish, French, …), generate a `.bin` including the Latin-1 range (`lv_font_conv --range 0x20-0xFF …`) and load it with `loadFont`.

> The miVM/Swing preview does not parse the `.bin`: the id is valid but the text shows in the default font. The real render of the loaded font is seen on the LVGL host and on the board.

<a id="eventos"></a>
## 22. Events and forms

A **form** is a class extending `Gui.Window` plus a `.win` file (JSON) describing its widgets. The `.win` declares the interface and names the *handlers*; the window class implements those handlers as methods. This keeps the design (the `.win`) and the logic (the methods) separate.

<a id="ev-handlers"></a>
### 22.1 Handlers: clic and change

A widget fires an event on interaction: `clic` when pressed (buttons) and `change` when its value changes (checkbox, slider, dropdown, list…). In the `.win`, the `"clic"` and `"change"` keys name the **window method** to run. The method receives the widget that fired it (`sender`):

```
public function onSave(sender: Gui.Component)
  print "saving…"
end onSave
```

<a id="ev-varios"></a>
### 22.2 Several widgets, several handlers

Each widget names **its own** handler. With two buttons, you give each a different name and the window has one method per button:

```
{
  "class": "MyWindow",
  "type": "Panel",
  "children": [
    { "type": "Button", "text": "Save",   "align": "BOTTOM_LEFT",  "clic": "onSave"   },
    { "type": "Button", "text": "Cancel", "align": "BOTTOM_RIGHT", "clic": "onCancel" }
  ]
}
```

```
module MyApp
  import Gui

  public class MyWindow extends Gui.Window
    public function MyWindow()
    end MyWindow

    public function onSave(sender: Gui.Component)
      print "save"
    end onSave

    public function onCancel(sender: Gui.Component)
      print "cancel"
    end onCancel
  end MyWindow

  function main(arg: string)
    var w: MyWindow := MyWindow()
    w.load("main.win")     // builds the tree and binds the handlers
    Gui.run()
  end main
end MyApp
```

> The `"class"` at the root of the `.win` must match the window class (here `MyWindow`): that is how the handlers it names are known to belong to that class.

> Since the handler receives `sender`, you can also reuse **one** handler for several widgets and tell them apart by who arrives. But one handler per widget is the usual, clearer style.

<a id="ev-async"></a>
### 22.3 Long work from an event (without freezing the GUI)

An event handler runs on the thread that *pumps* the GUI (the one of `Gui.run()` / `Gui.start()`, with an 8 KB stack): if the handler takes long (heavy computation, waits), the screen freezes — no repaint, no touch handling — until it returns. The solution is to launch the work on a **separate thread** and return immediately:

```
class Task extends Thread
  var lbl: Gui.Label
  public function Task(l: Gui.Label)
    super(2048)
    this.lbl := l
  end Task
  public function run()
    // ...long work; it can touch widgets (setText...) safely
    this.lbl.setText("done")
  end run
end Task

// and in the button's onClick, ONE line:
Task(this.lbl).start()
```

The handler returns, the GUI stays alive, and the task can **update widgets directly**: each GUI operation (`setText`…) is done whole, with no other thread cutting in. On the PC and on almost every display board, BP threads take turns by quanta on a single processor; on the P4, which since V7 runs two at once, one per core (`vm.runs`, [IDE guide §9.3](guia-ide.html.md#entorno)), the VM hands every GUI call to the first of the two —the display's—, with nothing for the program to do. Full demo: `samples/GuiAsyncDemo.bp`.

The short form, with no class to declare, is the language's asynchronous call ([manual §15.4](manual.html.md#ev-async)): a method of the object itself launched on another thread.

```
// in the button's onClick: `trabajo` is a method of this same class
Thread(this::trabajo()).start()
```

<a id="ev-slots"></a>
### 22.4 From name to method (at load time)

You write method *names* in the `.win`. When the form is loaded, `load` resolves each name against the method table the `.mod` already carries and subscribes the event: nothing is baked into the file and the IDE plays no part, so the `.win` goes to the board as is. With `"name": "boton1"` and no `"clic"`, the handler is *derived*: `boton1_onClick` / `boton1_onChange` (and the widget is assigned to the window's `boton1` property, if it declares one). An explicit `"clic"` wins over the derived name. An explicit name that does not exist shows up on press (`[bpvm] evento: slot -1 no resoluble … — descartado`); a derived name that does not exist is silently ignored, which is the normal case (a button rarely has an `onChange`).

> The `.win` and its images/fonts live in the project's `resources/` folder; the IDE uploads them to the device along with the program (see the [IDE guide](guia-ide.html.md)). On the PC, with *Run* and with `bp run`, the program finds them in its pack (`"out": "pack"` in the `.bpbuild`); *Run Window* copies them itself.

<a id="ev-codigo"></a>
### 22.5 Subscribing from code (without a `.win`)

Everything above goes through a `.win` file, which is the comfortable path. But a widget you build in code needs no file at all: `onClick` and `onChange` are [**events**](manual.html.md#eventos) of the language, subscribed with `::`, naming the object and the method that will attend to them.

```
var boton: Gui.Button := Gui.Button(panel, "Start")
boton.onClick := pantalla::boton_onClick     // this object attends it
```

The handler is **a function of any object** — it does not have to inherit from anything:

```
public function event boton_onClick(sender: Gui.Component)
  print "clicked"
end boton_onClick
```

**The naming convention** is worth keeping even here, where nothing forces it: `<componentName>_<eventName>`. The same name in the variable, in the `name` of the `.win` and in the handler — so that reading any of the three tells you where the other two are.

And a consequence that is easy to miss: **with no subscriber, nothing happens**. A widget whose event nobody attends simply does not react — it is not an error, and there is no warning. If a button "does nothing", the first thing to check is whether its event was subscribed.

> **Migrating from V3.** This *replaces* the old model and it **breaks** programs: a program that subclassed the widget to attend a button no longer works. If you come from V3, change
>
> ```
> // V3 — no longer valid
> class MyButton extends Gui.Button
>   public function onClick()
>     ...
>   end onClick
> end MyButton
> ```
>
> into this, which also saves you the class:
>
> ```
> // V4
> boton.onClick := pantalla::boton_onClick
> ```
>
> The reason for the change: the old model **forced you to create a type for every button** you wanted to attend. The event does the same job in one line, and the handler can live wherever it makes sense.

<a id="ev-teclado"></a>
### 22.6 The keyboard and the mouse

With a keyboard or a mouse connected (over Bluetooth, with [`Air.Bluetooth`](referencia.html.md#stdlib-air-bt)), the GUI uses them on its own, without writing anything (V8):

- **The keyboard** types into the control that has the focus. Tab and Shift+Tab move to the next and the previous control, in the order they were created; Enter presses the focused button; in a field, Backspace, Delete, the arrows, Home and End; in a slider, the arrows change the value. Clicking a field also gives it the focus. With no keyboard connected nobody has the focus, and the GUI looks as always.
- **The mouse** moves an arrow and clicks, and the wheel scrolls whatever is under the arrow (a list, a panel that scrolls). With a touch screen, both work.

**The keys as they come:** the screen has its event, `onKey`, with every key —also the ones the GUI uses—, on the GUI thread, like a click. The key is the one of [`Keyboards`](referencia.html.md#stdlib-keyboards) (a 32-bit number: the code in the low part and the state in the high part) and its character (`""` for a special key). The last screen created, or loaded with `load()`, gets them.

```
var scr: Gui.Screen := Gui.Screen()
scr.onKey := screen::key

function event key(s: Gui.Screen, k: integer, c: string)
  if Keyboards.isKey(k, Keyboards.Key.F1) then
    help()
  endif
end key
```

**On the PC**, the keyboard and the mouse are those of the window, and only with the simulated ones of `Air.Bluetooth` connected («Teclado simulado» and «Ratón simulado»), as on a board: with no keyboard connected the window does not type, not even the Swing one. With «Ratón simulado», the PC mouse stops acting as a touch screen and acts as a mouse, with the GUI's arrow in the window of the VM-C and the simulated micro (doing both, every click would count twice); without it, it acts as a touch screen, as always. **On the boards with Bluetooth and a screen** (the P4 and the C5), the same with a paired Bluetooth keyboard and mouse ([reference §14.19](referencia.html.md#stdlib-air-bt)): the mouse's arrow on the screen, the clicks and the wheel, and the keyboard in the controls, with the focus and Tab.

<a id="ev-claves"></a>
### 22.7 The keys of the `.win`

Each node is a widget: its `type` and its keys, all optional. Those of all of them:

| Key | What it does |
|---|---|
| `name` | Its name: the window's property that receives it, and its derived handlers (§22.4) |
| `align`, `x`, `y` | With `align` (`"TOP_MID"`, `"CENTER"`…, §19.3), `x` and `y` are the offset from the anchor; without it, its position |
| `width`, `height` | Its size; without them, its automatic one |
| `fontSize`, `bgColor`, `textColor` | The text and the colours, as `"0x2060D0"` (§21) |
| `clic`, `change` | The handler, when it is not the one derived from `name` (§22.1) |
| `children` | The widgets inside it, in a `Panel` or a `Button` |

The root, with none of the position and size ones, covers the whole screen. And those of each one:

| `type` | Its keys |
|---|---|
| `Panel` | those of all |
| `Label`, `Button` | `text` |
| `Checkbox` | `text`, `checked` |
| `Toggle` | `checked` |
| `Slider`, `Bar`, `Spinbox` | `min`, `max` (0 and 100), `value` |
| `Textarea` | `text` |
| `Led` | `value` (0 to 255) |
| `Dropdown` | `options` (separated by `\n`), `selected` |
| `ListBox` | `items` (separated by `\n`), `selected` |
| `Msgbox` | `text`, `buttons` (their labels, separated by `\n`) |
| `Chart` | `points` (how many fit), `min` and `max` (its axis), `chartType` (`LINE` or `BARS`). The series and their data are set by the program, after `load` (`addSeries`) |
| `Table` | `rows`, `cols` and `cells` (a list of rows, each a list of texts) |

An unknown `type` is reported on the console, and a `Panel` takes its place. What `toJson()` writes (§24.2) are these very keys.

<a id="ejecutar"></a>
## 23. Running (host and board)

A BasicPlus GUI can be run three ways, from fastest to most faithful: preview on the PC (Swing), real render on the PC (LVGL) and the board. All three run the same `.mod`.

<a id="ej-preview"></a>
### 23.1 Preview on the PC (miVM / Swing)

The IDE's *Run* button executes the program on the Java VM and paints the widgets with Swing. It is the fastest loop for iterating layout and logic. Being an *approximation* (Swing widgets, not LVGL), it has two limits, detailed in §25: it does not render loaded `.bin` fonts and it does not copy the `resources/` folder, so `.win` forms are tested with the program in a pack (`"out": "pack"`), on the board or as in §23.2.

<a id="ej-host"></a>
### 23.2 Real render on the PC (VM-C + LVGL/SDL)

The host C VM built with LVGL opens an SDL window and paints **exactly like the board** (same library, same fonts). It comes with the installation (`bin/bpgenvm-c.exe`). From the command line, `bp run --c`: it compiles if needed and tells the C VM where the standard library is; the options below go before the program (`bp run --c --screen=240x240 MyApp.bp`), and the program's relative paths (`.win`, images) start at the folder it is launched from. From the IDE it is the *Run Window* button, which prepares it and launches it for you:

```
bp run --c MyApp.bp
```

Useful options:

| Option | What for |
|---|---|
| `--mem=N` | VM memory in bytes (default 512 KiB). Handy to rehearse a specific board's budget. |
| `--screen=WxH` | Screen size (default 480×320). With `--screen=240x240` the PC mimics the C6: the dump and `toJson()` come out as on the board. |
| `--no-screen` | No window: the program runs the same (and `Gui.shot` captures the same), useful in automated tests. |
| `--basedir=DIR` | Root for relative paths (`readFile`, `load`, images) when not launching from the project folder. |
| `--libdir=DIR` | The PC's `/lib`: where the standard library is when it is not next to the program (what `stdlibDir` in `BpVM.cfg` is for the Java VM). Modules are looked up in the program's folder, then here, then in the packs (`--pack=`). |
| `--trace` | Per-instruction trace (diagnostics). |

<a id="ej-placa"></a>
### 23.3 On the board

The IDE's *Run on Device* button does everything: it compiles, uploads to the device the program, any missing stdlib dependencies and the project's `resources/` folder (the `.win` files go as they are, §22.4), and runs it on the real display. `print` output goes to the IDE console; *Stop* (Ctrl+F2) kills the run.

> **What it does not upload is the display.** Since V7 the board's GUI comes in packs —the engine, LVGL, and the driver of its display— that are burnt once, plus a RAM block in its ENV. Which packs and which lines each board needs, and what a program sees if something is missing, in §23.4.

To make the application start **when the board powers up**, with no PC, use autorun from the explorer console:

```
/> autorun MyApp      (and to remove it:  autorun off)
```

When a program ends —normally, with an error or with *Stop*—, the board leaves a clean display for the next one: a new screen, without the previous program's widgets, colors or events, and at 0°. Since V7 there is no need to reset the board between one run and the next.

<a id="ej-pantalla"></a>
### 23.4 The displays, their packs and rotation

Five boards with a display. On all of them the screen is the size of the panel (§19.1):

| Board | Panel | Size | Touch |
|---|---|---|---|
| Waveshare ESP32-C5-Touch-LCD-2.8 | ST7789, SPI, 2.8" | 240×320 | yes |
| Waveshare ESP32-C6-LCD-1.3 | ST7789, SPI, 1.3" | 240×240 | no |
| ESP32-P4-Function-EV | EK79007, MIPI-DSI, 7" | 1024×600 | yes |
| Waveshare ESP32-P4 Touch-LCD-4.3 | ST7701, MIPI-DSI, 4.3" | 480×800 (portrait) | yes |
| STM32U5G9J-DK2 | LTDC, 5" | 800×480 | yes |

The other boards —the Pico 2, the Metro, the S3, the C3 and the Nucleo— have no GUI: their image does not carry it.

<a id="ej-packs"></a>
#### The display comes in packs (V7)

Since V7 no image carries LVGL: the GUI engine goes in a pack that is burnt into the board's pack area, and whoever uses the board decides whether it has a display, not the image. A board with a display needs three things:

- **the LVGL pack**: `Gui.pack` or, on a small display without PSRAM, `GuiMini.pack` —the same LVGL with room for 256 widgets (§25), fonts up to 24 px (§21.2) and screenshots of up to 40 KB (§23.5)—. One or the other, not both.
- **the driver of its display**, which publishes itself under the `'PANT'` mark: on the P4 and the DK2 the image carries it (their MIPI-DSI and LTDC); on the C5 and the C6 it is another pack, `DriverSpi.pack`, the generic driver for SPI displays, which reads the board from a few ENV lines (below).
- **a RAM block for the native engines**: `packRam=<KB>` in the ENV (or `SQLite=<MB>`, the database one, which works the same). Without it no engine loads —neither the GUI nor SQLite—, and the IDE's INFO says so on its «RAM packs» line. The block is shared by every engine: the GUI's asks for about 380 KB (`GuiMini` and `DriverSpi` together, about 130), and if you also use SQLite, add its share.

| Board | Packs | In the ENV |
|---|---|---|
| ESP32-C5 (Waveshare 2.8") | `Gui.pack` + `DriverSpi.pack` | `packRam=512` and the lines of its display (below) |
| ESP32-C6 (Waveshare 1.3") | `Stdlib.pack` + `GuiMini.pack` + `DriverSpi.pack` | `packRam=136` and the lines of its display (below) |
| ESP32-P4 (the kit and the Waveshare) | `Gui.pack` | `SQLite=4` (or `packRam=<KB>`); on the Waveshare, also `display=st7701` |
| STM32U5G9J-DK2 | `Stdlib.pack` (recommended) + `Gui.pack` | `packRam=768` |

The packs come in the `packs/` folder of the BasicPlus package, and the same `Gui.pack` serves the three boards that use it: when burning it, the IDE keeps the engine of the board in front of it. Neither the LVGL pack nor the driver pack carries the standard library (V7): the board takes `Gui.mod` and its companions from the `Stdlib.pack`, if it is burnt —from the flash, without spending RAM—, or from `/lib`, into RAM. On the C6 the `Stdlib.pack` is a must: without it the GUI does not fit.

They are burnt from the IDE —the *Placa* button, «Copiar pack a la placa…» ([IDE guide §10.3](guia-ide.html.md#packs-panel))— **after** setting the ENV (the *Entorno* button, [§9.3](guia-ide.html.md#entorno)) and resetting the board: the ENV is read at boot, and each engine is sealed for the RAM block the board has when it is burnt (if you change `packRam=` later, burn it again). Step by step, and when to burn again, in «[The board's packs](INSTALAR_FIRMWARE.md#packs)» (INSTALAR_FIRMWARE).

<a id="ej-env-spi"></a>
#### The ENV lines of the C5 and the C6

The generic driver knows nothing about the board: the ENV tells it, one line per bus and one per device. The C5's, with its touch panel and the pin expander that drives it:

```
spi2=sck:6,mosi:7,miso:8
i2c0=sda:0,scl:1,khz:400
lcd=st7789,spi:2,dc:9,cs:10,rst:x1,bl:xpwm,mhz:40,w:240,h:320,inv
exp=ch32,i2c:0,addr:0x24
touch=cst3530,i2c:0,addr:0x58,rst:x0
packRam=512
```

The C6's, with no touch:

```
spi2=sck:7,mosi:6,miso:5
lcd=st7789,spi:2,dc:15,cs:14,rst:21,bl:22,mhz:40,w:240,h:240,ram:240x320,inv
packRam=136
```

The `miso` in `spi2=` belongs to the TF card, which sits on the same bus as the display (its `sd=` line, in the [reference, §14.17](referencia.html.md#stdlib-sd)): the bus is shared, and what is exclusive to each device is its CS.

<a id="ej-otra-spi"></a>
#### Another SPI display, without writing C

`DriverSpi` is not one board's driver: it is made for any MIPI-DCS controller over 4-wire SPI (ST7789, ILI9341, GC9A01, ST7796…), and tested with the ST7789 of the C5 and the C6 (the pack that ships with BasicPlus is built for their family, RISC-V without FPU). The board goes in the ENV and the controller in a text file, so another display of that kind is described rather than programmed:

- `spiN=` (and `i2cN=`, if there is touch or an expander): the pins of each bus.
- `lcd=`: the controller (the name of its `.seq`), `spi:N`, `dc:`, `cs:` and the size of the glass at 0° (`w:`, `h:`); and when needed, `rst:` and `bl:` (reset and backlight), `mhz:` (20 if not given, and never above what the controller's datasheet allows: 62 on the ST7789), `ram:` and `off:` (when the controller's memory is larger than the glass, as on the C6), `inv`, `bgr` and `seq:`. A pin is a GPIO (`21`) or an expander output (`x1`).
- `touch=` and `exp=`: the touch panel and the pin expander (today, the C5's CST3530 and CH32). Without `touch=`, the display has no touch.
- the controller's **start-up sequence**, in a `.seq`: the ST7789's travels inside the pack; another one you write yourself —copying the one in the manufacturer's example— and name it with `seq:/sys/mio.seq`.

What every driver provides —`init`, `size`, `flush` and, if it can, `rotate` and `touch`— is the `'PANT'` contract, the same for `DriverSpi` as for the image drivers of the P4 and the DK2: that is why the same LVGL pack serves them all.

<a id="ej-sin-pack"></a>
#### If something is missing

The first `Gui.Screen()` says so, with a (catchable) `RuntimeError`, instead of leaving the screen black:

| If… | the program gets |
|---|---|
| the image has no GUI (the Pico 2, the Metro, the S3, the C3, the Nucleo) | `builtin 135 no soportado en esta VM (subconjunto C)` |
| the LVGL pack is not there | `GUI: esta placa no tiene el pack 'LVGL' grabado (la GUI llega por el pack)` |
| the LVGL pack is there, but its engine did not load: no `packRam=` in the ENV, or the block changed since it was burnt | `GUI: el pack de la GUI esta, pero su motor no cargo: falta packRam= en el ENV` —or, after the colon, the engine's warning (`realojado para OTRA direccion — regrabalo desde el IDE`) or `mira el log de la placa` |
| the display driver is not there (on the C5 and the C6, `DriverSpi.pack`) | `GUI: no hay driver de pantalla ('PANT'): graba el pack del driver de esta placa` |
| an ENV line of the display is wrong | the reason, by name: `GUI: pantalla: ENV lcd: falta 'dc'` |
| the display does not start | `GUI: la pantalla no arranco: su driver fallo al iniciarse (el motivo, en el log)` |

The rest is in the board's log: which engines it loaded and, if one did not, why.

<a id="ej-rotacion"></a>
#### The P4 panel, the C6 and rotation

The ESP32-P4 firmware is a **single image** with a panel catalog: it picks one when the GUI starts by reading the `display` key of the **board environment** (the IDE's *Entorno* button, [IDE guide §9.3](guia-ide.html.md#entorno)). With no key, or an unknown value, it uses the default panel, the kit's (`ek79007`). The C6 has no touch: its GUI is output only (indicators, charts, status); and it has no PSRAM, so it carries the small pack and the standard library in flash, and with `packRam=136` its VM is left with about 127 KB (63 of heap).

The **orientation** is changed at runtime, LVGL style:

```
Gui.setRotation(90)    // 0, 90, 180 or 270 degrees
```

The rotation swaps the logical dimensions and the touch panel is transformed automatically — `align` keeps working with no changes. The natural place to call it is at the start, before creating widgets. It rotates on all five boards —the DK2, since V7—, on the LVGL host and in the Swing preview; and the rotation lasts as long as the program: the next one starts at 0°.

On a board, the image is rotated because the panel has really been turned, to be seen that way. On the PC there is no panel to turn: **the window turns with the screen**. At 90° or 270°, a landscape window becomes portrait and the image is upright, as whoever has the board mounted that way will see it; at 180°, it looks unrotated. Clicks and the mouse land where they are seen.

<a id="ej-shot"></a>
### 23.5 Screenshot: `Gui.shot`

`Gui.shot(path): integer` writes the screen **as LVGL drew it** to a `.shot` file (RGB565 in strips, compressed; format in `docs/SHOT_FORMAT.md`) and returns the bytes written. It goes through the same path on the host (with a window or `--no-screen`), on miVM and on the five displays; the one that counts is LVGL's (the PC's C VM, the simulated micro or the board): the Java VM's is that of its preview, an approximation (it does not paint a `Chart` or a `Led`, and the fonts are the PC's). On failure it throws a catchable `RuntimeError`: «sin pantalla» (C VM built without LVGL), «error de escritura», «no cabe en el tope de captura» (256 KB; 40 with `GuiMini`, the C6's pack) or «sin memoria».

```
Gui.start()
sleep(300)                          // pump BEFORE capturing
var n: integer := Gui.shot("MyApp.shot")
Gui.stop()
Gui.join()
```

**Pump before capturing.** The LVGL theme animates state transitions (the check of a `Checkbox` takes ~100 ms to appear): a capture right after `cb.checked := true`, without a loop iteration, comes out with the box empty. The capture is what is seen at that instant, not the model.

On the board the file lands in the file system (a relative path, from its root: `"MyApp.shot"` is `/MyApp.shot`; to leave it elsewhere, the full path, `"/data/MyApp.shot"`) and is downloaded with the `get` command of the IDE console —since V7, also while the program is running: the board sends it in chunks, between its output— or, without the IDE, with `bp placa` (V8.5, §16 of the reference). On the PC, `bp png` turns it into a PNG:

```
bp placa COM22 get MyApp.shot   (downloads it from the board at COM22)
bp png MyApp.shot               (leaves MyApp.png next to it)
```

Measured sizes: C6 ~3 KB, DK2 ~7 KB, P4 ~9 KB. The image is the proof for the eye; the automatic oracle is still the tree (`toJson()`, §24.2). Demo: `samples/GuiShot.bp`.

<a id="referencia"></a>
## 24. Gui.\* quick reference

Summary of the public surface of the `Gui` module. The detailed semantics are in the previous sections (catalog §20, color and fonts §21, forms §22).

<a id="ref-modulo"></a>
### 24.1 Module functions and constants

| Function | What it does |
|---|---|
| `Gui.run()` | Enters the event loop and does not return until the GUI ends. Equivalent to `start()` + `join()`. Without a screen, it returns as soon as there is nothing left to handle (§18.4). |
| `Gui.start()` | Starts the loop on its own BP thread and **returns**. The program stays alive while the loop runs, even if `main` ends. A second call does nothing. Without a screen, the loop ends as soon as it has no work left (§18.4). |
| `Gui.stop()` | Asks the loop to end; does not wait. Can be called from another thread or from a handler. |
| `Gui.join()` | Waits for the loop to end. |
| `Gui.shot(path): integer` | Captures the screen to a `.shot` and returns the bytes written; `RuntimeError` on failure (§23.5). |
| `Gui.click(w)` | A click on widget `w`, like the user's: raises its `onClick` (V8.5). To test a GUI with nobody in front of it (§24.4). |
| `Gui.change(w)` | Raises `w`'s `onChange`, as if the user changed its value; it does not touch the value: it is whatever the program sets (`cb.checked := true`) (V8.5, §24.4). |
| `Gui.dumpTree(): string` | The screen's tree, as text: what a test compares (V8.5, §24.4). |
| `Gui.loadFont(path): integer` | Loads a `.bin` font (LVGL binfont) and returns its id (§21.2). |
| `Gui.setRotation(deg)` | Screen orientation: 0, 90, 180, 270 (§23.4). |
| `Gui.Color(rgb): Color` | `0xRRGGBB` color for `setBgColor`/`setTextColor` (§21.1). |

> The `onClick`/`onChange` handlers are dispatched **inside** the loop, on the GUI thread — with `run()` and with `start()` alike; what changes is the main thread, which with `run()` stays parked in the `join()` (§18.4). A `print` written after `Gui.run()` comes out after all the handlers, not before. A program that does `start()`, works, and then `stop()` + `join()` exits with code 0 on both VMs.

Constants (constant classes):

| Group | Values |
|---|---|
| `Gui.Align` | `TOP_LEFT · TOP_MID · TOP_RIGHT · LEFT_MID · CENTER · RIGHT_MID · BOTTOM_LEFT · BOTTOM_MID · BOTTOM_RIGHT` |
| `Gui.ScrollDir` | `NONE · HOR · VER · BOTH` |

<a id="ref-component"></a>
### 24.2 Component and Container (inherited by every widget)

`Component`, the base of every widget:

| Member | Kind | What it does |
|---|---|---|
| `name` | property string | Logical name of the widget (set by the `.win`; shows in `toJson`). |
| `x` / `y` | property integer | Position relative to the parent, in pixels. |
| `width` / `height` | property integer | Size in pixels; unset = automatic (shown as `-1`). |
| `fontSize` | property integer | Text size from the compiled catalog (§21.2). |
| `scrollDir` | property integer | Container scrolling (`Gui.ScrollDir.*`). |
| `setPos(x, y)` / `setSize(w, h)` / `setBounds(x, y, w, h)` | function | Geometry in one go. |
| `align(anchor, dx, dy)` | function | Anchor to the parent + offset (§19.3). |
| `setBgColor(c)` / `setTextColor(c)` | function | Colors (§21.1). |
| `refresh()` | function | Forces a repaint of the widget. |
| `getParent(): Container` | function | The container that holds it; `null` at the root (`Screen`, `Window`). |
| `typeName(): string` | function | The class name (`"Label"`, `"Button"`…), the same `type` as in the `.win`. |
| `toJson(): Json.JsonObject` / `toJsonText(): string` | function | The subtree in `.win` format: `type`, `name`, what is specific to the widget (`text`, `checked`, `value`…), `align` by name with `x`/`y` as offsets, `width`/`height` only when not automatic, `fontSize`, the colors, and the explicit `clic`/`change`. What `Window.load` loaded comes back out the same (round trip). `toJsonText` gives the text without having to import `Json`. |
| `clean()` | function | Removes the widget's CHILDREN (the widget stays). |
| `delete()` | function | Removes the widget and its children (children before parent) and unregisters it from its parent. **Idempotent**: deleting twice does not fail. |
| `~Component()` | destructor | Not called by hand: the language calls it when the object is released —a `var owner` going out of scope, the GC, the end of the program— and it does a `delete()` (§19.2). The `Screen` is not removed this way. *(V7.)* |
| `onClick` / `onChange` | **event** | Subscribed with `::`: `button.onClick := window::button_onClick`. See [§22.5](#ev-codigo). *(In V3 these were virtual methods you overrode by subclassing; not any more.)* |

`Container` (extends `Component`) — inherited by `Screen`, `Panel`, `Window`, `TabPage`, `Tabview` and `Button`; it is the type of the `parent` in every constructor:

| Member | Kind | What it does |
|---|---|---|
| `childCount(): integer` | function | How many children it has. |
| `childAt(i): Component` | function | The i-th child, in creation order. |
| `toJson()` | function | What `Component` gives plus `children` with the children. |
| `delete()` / `clean()` | function | Cascading: children first, each one on both planes (model and LVGL). |
| `register(c)` / `unregister(c)` | function | Adds and removes a child. Called by the constructor (`attach`) and by `delete()`; not meant to be called by hand. |

<a id="ref-widgets"></a>
### 24.3 Widgets

In every constructor `parent` is a `Container` (§24.2). The classes marked *(Container)* can have children; the rest are leaves. On the board, with the widget table full, a constructor throws `RuntimeError` (§25).

| Class | Constructor | Own members |
|---|---|---|
| `Screen` *(Container)* | `Screen()` | `load()` — makes this screen the visible one. `onKey(s, k, c)` — the keys as they come (§22.6). It is the size of the panel (§19.1). On a board without the GUI —without its packs, or with a display that does not start— the constructor throws `RuntimeError` with the reason (§23.4). |
| `Panel` *(Container)* | `Panel(parent)` | — (grouping container; everything inherited). |
| `Label` | `Label(parent, text)` | `setText(t)`, `setFont(id)`. |
| `Button` *(Container)* | `Button(parent, text := "")` | — (the click arrives via handler or `onClick`). With text it carries a child `Label`; without text it is an empty container. |
| `Checkbox` | `Checkbox(parent, text)` | `checked: boolean`, `setText(t)`. |
| `Toggle` | `Toggle(parent)` | `checked: boolean`. |
| `Slider` | `Slider(parent)` | `setRange(mn, mx)`, `value: integer`. |
| `Bar` | `Bar(parent)` | `setRange(mn, mx)`, `value: integer`. |
| `Spinbox` | `Spinbox(parent)` | `setRange(mn, mx)`, `value: integer`. |
| `Led` | `Led(parent)` | `on()`, `off()`, `value: integer`. |
| `Dropdown` | `Dropdown(parent)` | `setOptions(s)` (separated by `\n`), `selected: integer`. |
| `Textarea` | `Textarea(parent)` | `text: string`, `readOnly: boolean`. |
| `ListBox` | `ListBox(parent)` | `setItems(s)` (separated by `\n`), `selected: integer`. |
| `Keyboard` | `Keyboard(parent)` | `setTextarea(ta)` — the field it edits (formerly `attach`, §20.9). |
| `Msgbox` | `Msgbox(parent, msg)` | `setButtons(s)` (labels by `\n`), `result: integer`. |
| `Tabview` *(Container)* | `Tabview(parent)` | `addTab(name): TabPage`, `active: integer`. |
| `TabPage` *(Container)* | — (returned by `addTab`) | The page of a tab; serves as `parent`. |
| `Table` | `Table(parent)` | `setGrid(rows, cols)`, `setCell(r, c, s)`, `getCell(r, c): string`. |
| `Chart` | `Chart(parent)` | `setPointCount(n)`, `addSeries(rgb): integer`, `push(series, v)`, `setValue(series, i, v)`, `setRange(mn, mx)` (Y axis), `setType(Chart.LINE \| Chart.BARS)`; up to `Chart.MAX_SERIES` (8) series. |
| `Image` | `Image()` | `loadFile(path): boolean`, `width(): integer`, `height(): integer`. (Asset, not a widget: it has no parent.) |
| `ImageView` | `ImageView(parent)` | `setImage(img)`, `refresh()`. |
| `Window` *(Container)* | `Window()` | `load(path): Component` — builds a `.win` and binds handlers (§22); `destroy()` (= `delete()`). |

<a id="ref-pruebas"></a>
### 24.4 Testing a GUI with nobody in front of it

A GUI is tested like any program (V8.5): a test in `tests/`, which `bp test` runs on both PC VMs, with no screen ([§16 of the reference](referencia.html.md#cli)). What the user would do, the test does: `Gui.click(w)`, a click, and `Gui.change(w)`, a change of value (the value, whatever the program set before). And what is checked: what the handlers did, with [`Assert`](referencia.html.md#stdlib-assert), and the screen's tree, `Gui.dumpTree()`, which the test prints and `bp test` compares with its `.out`.

**The click, before `Gui.run()`.** With no screen, `Gui.run()` handles whatever is in the queue and returns; whatever were injected afterwards nobody would handle, and `Gui.click` says so with an error («el lazo de la GUI acabó; sin pantalla, el clic va antes de Gui.run()»: the GUI loop ended; with no screen, the click goes before Gui.run(), §18.4). With `Gui.start()`, the same: with no screen, the loop ends as soon as it has no work left.

```
module PruebaGui
  import Gui
  import Assert

  class Pantalla
    public property etiqueta: Gui.Label
    public property clics: integer := 0

    function event boton_onClick(quien: Gui.Component)
      this.clics += 1
      this.etiqueta.setText("PULSADO")
    end boton_onClick
  end Pantalla

  function Main()
    var scr: Gui.Screen := Gui.Screen()
    var p: Pantalla := Pantalla()
    p.etiqueta := Gui.Label(scr, "esperando")
    p.etiqueta.align(Gui.Align.TOP_MID, 0, 10)
    var boton: Gui.Button := Gui.Button(scr, "Pulsa")
    boton.align(Gui.Align.CENTER, 0, 0)
    boton.onClick := p::boton_onClick

    Gui.click(boton)
    Gui.run()

    Assert.equals(1, p.clics, "el clic llega a su manejador")
    Assert.isTrue(contains(Gui.dumpTree(), "\"PULSADO\""), "la etiqueta, tras el clic")
    print Gui.dumpTree()
  end Main
end PruebaGui
```

What it prints, the tree after the click, is its `tests/PruebaGui.out` (written by `bp test --guarda`):

```text
screen [480x320 align=0 +0,0]
  label "PULSADO" [-1x-1 align=1 +0,10]
  button [-1x-1 align=4 +0,0]
    label "Pulsa" [-1x-1 align=4 +0,0]
```

The whole project, with another test: `samples/pruebas`. The old names (`Gui.__guiClick`, `Gui.__guiChange`, `Gui.__guiDumpTree`) still work; on a board with the library from before V8.5, only those: the new ones come with its `Stdlib.pack`.

<a id="matices"></a>
## 25. Fine print and limitations

Worth knowing before it surprises you. None of them blocks the work; all have a way out.

### Without its packs, the board does not paint (V7)

A board that painted with the image alone in V6 needs, in V7, its display packs as well, and the engines' RAM block in its ENV. Without them, the first `Gui.Screen()` throws a `RuntimeError` saying what is missing. What each board needs, in §23.4.

### The screen is the size of the panel

Since V6 the tree no longer models a fixed 480×320: on the board it is the size of the real panel (§19.1), so a form with no size fills whatever display it runs on. Two consequences: a program that *assumed* 480×320 on the board changes geometry, and a `.win` saved with `toJson()` carries the size of the panel it was saved on — it is not portable across displays without touching that `width`/`height`. To reproduce on the PC what happens on a given board, `--screen=WxH` (§23.2).

### What `toJson()` does not save yet

Since V7 (3-Oct) it saves the ranges (`min`/`max`), the options and the items, the `Msgbox` buttons, the colors (`bgColor`/`textColor`, as `"0xRRGGBB"`), the shape of a `Chart` (`points`, `chartType`, its range) and the grid of a `Table` (`rows`, `cols` and `cells`); and `Bar`, `Led`, `Chart` and `Table` are in the tree like the rest (they count in `childCount()` and get their clicks). What it does not save yet: the tab titles, the image of an `ImageView` and the field of a `Keyboard` (and the loader does not build those three from a `.win`); nor the series and samples of a `Chart`, which are the program's data, not shape.

### Swing preview: an approximation

The host *Run* (miVM/Swing, §23.1) does not render `.bin` fonts (it uses the default font even though the id is valid), does not paint a `Chart` (its box, empty) or a `Led`, and does not copy `resources/`, so a `.win` form there does not find its file (with the program in a pack, `"out": "pack"`, it does). For the exact pixel or to try forms on the PC: the C VM with LVGL (§23.2), copying the `.win` and the assets next to the `.mod`.

### Display state between runs (board)

Up to V6, a GUI cut short —IDE *Stop*, or an error— could leave leftovers of the previous program on the board's display (its colors, for example), and you had to reset the board. Since V7, when any program ends the board starts a clean screen for the next one: without its widgets, colors or events, and at 0° (§23.3).

### Default font: ASCII only

The compiled Montserrat font has no `ñ` or accents (§21.2): for accented text, generate a `.bin` with the Latin-1 range and load it with `loadFont`.

### The touch panel's I2C bus is shared (P4 and DK2)

On the P4 and the DK2 the display driver lives in the image, and the I2C bus of its touch panel —I2C 0 on the P4 (SDA 7, SCL 8), I2C 2 on the DK2 (PF0 and PF1, pins 80 and 81)— **belongs to the board and is shared** (V7), at 100 kHz: a program opens it with those pins (or with `-1`, "whatever it has") and talks to its own devices on it. With other pins or at another speed it gets an error by name —«el I2C 0 es sda 7, scl 8 a 100 kHz (la imagen: el táctil de la pantalla): pides sda 20»—, and it cannot release it. The display's other pins —on the P4, backlight and reset; on the DK2, the backlight and the LTDC ones, among others— are not the program's: «el pin 26 de esp32p4 es de la pantalla: no se puede usar». How a bus is shared, in the [reference, §14.3](referencia.html.md#stdlib-i2c).

### The widget table has a limit (board)

On the board —and on the PC's C VM— the model has room for **512** live widgets at a time (**256** with `GuiMini`, the C6's pack), the screen included; what you remove with `delete()` frees its slot. Past that, the constructor throws a catchable `RuntimeError` —«Gui: no caben mas widgets: esta GUI tiene sitio para 256»— instead of leaving the widget unpainted without a word, as up to V6. miVM has no limit.
