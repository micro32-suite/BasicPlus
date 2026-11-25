#!/usr/bin/env python3
# docs_md.py — 23-nov-2026 (V9 H1.7, #858 b y d): la documentación del usuario en Markdown, sacada de su HTML, y el
# índice para las IAs (docs/llms.txt).
#
# Para quien la lee con una herramienta —una IA—: en el HTML el código va troceado por el coloreado
# (<span class="k">var</span> n: …) y un grep de un trozo de código no lo encuentra; en Markdown, sí, y pesa la mitad.
# Un solo original, el HTML: el Markdown dice lo mismo por construcción (Eduardo, 23-nov, de la documentación: «que se
# mantiene sola»). No se edita a mano: se edita el HTML y se vuelve a pasar el script.
#
# Las páginas: las del usuario en inglés (docs/en/*.html) y la chuleta (docs/cheatsheet.html, que sólo está en
# inglés). Cada una, junto a la suya, con el nombre que propone llms.txt (llmstxt.org): X.html → X.html.md. Y
# docs/llms.txt: qué es BasicPlus y sus páginas en Markdown, cada una con su descripción de seo_paginas.py. La web los
# sirve tal cual (docs/.nojekyll); el ZIP lleva los .md (montar-zip.sh).
#
#   python -I -X utf8 scripts/docs_md.py               escribe los .md y docs/llms.txt
#   python -I -X utf8 scripts/docs_md.py --comprobar   sólo dice cuáles no están al día (sale con 1 si alguno)
#
# Lo que convierte es lo que usan estas páginas: los títulos, los párrafos, las listas, las tablas, el código, las
# figuras, los recuadros de nota y de aviso y las tarjetas de la portada. El índice de cada página (su <nav>), no: el
# Markdown ya tiene sus títulos. Una etiqueta que no conoce la dice (y escribe lo de dentro): nada se pierde en silencio.
# Una página nueva en docs/en/: su fila en ORDEN (si no, el script la nombra y no escribe nada).
import importlib.util
import os
import re
import sys
from html.parser import HTMLParser

RAIZ = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
DOCS = os.path.join(RAIZ, "docs")

# Las páginas, en el orden de llms.txt: su ruta dentro de docs/, y su nombre allí. Las de OPCIONALES van en su
# sección «Optional» (lo que se puede saltar si no cabe).
ORDEN = [
    ("cheatsheet.html", "One-page reference"),
    ("en/manual.html", "Language manual"),
    ("en/referencia.html", "Reference"),
    ("en/gui.html", "Graphical interface"),
    ("en/jc.html", "JC"),
    ("en/basedatos.html", "Databases"),
    ("en/guia-ide.html", "IDE guide"),
    ("en/pruebas.html", "How it is tested"),
    ("en/index.html", "Home page"),
    ("en/creditos.html", "Credits"),
]
OPCIONALES = {"en/index.html", "en/creditos.html"}

# Las que ya son Markdown (no salen de un HTML), para llms.txt: su ruta, su nombre y su descripción.
EN_MD = [
    ("en/PLACAS.md", "Boards and their pins",
     "each supported board's pins (the program's, each bus's and the system's) and the links to its manufacturer's "
     "documentation."),
    ("en/INSTALAR_FIRMWARE.md", "Installing the firmware",
     "flashing each board's image, its packs and its environment."),
]

MARCA = "<!-- Generated from %s by scripts/docs_md.py: edit the HTML, not this file. -->"

VACIAS = {"br", "img", "meta", "link", "hr", "input", "col", "wbr", "source", "area", "base"}
SALTA = {"head", "nav", "style", "script", "title", "meta", "link", "template", "noscript"}
BLOQUE = {"html", "body", "main", "header", "footer", "section", "article", "aside", "div", "figure", "figcaption",
          "p", "h1", "h2", "h3", "h4", "h5", "h6", "ul", "ol", "li", "table", "thead", "tbody", "tfoot", "tr", "td",
          "th", "caption", "pre", "blockquote", "hr"}
EN_LINEA = {"a", "code", "strong", "b", "em", "i", "span", "small", "kbd", "br", "img", "sup", "sub", "mark", "u",
            "s", "del", "ins", "abbr", "cite", "q", "time", "var", "samp", "tt"}
RECUADRO = {"note", "warn"}   # los recuadros de nota y de aviso: en Markdown, una cita (>)
SALTO = "\x00"                # un <br> mientras se arma una línea


class Nodo:
    __slots__ = ("tag", "attrs", "hijos", "linea")

    def __init__(self, tag, attrs, linea):
        self.tag, self.attrs, self.hijos, self.linea = tag, dict(attrs), [], linea

    def clases(self):
        return set((self.attrs.get("class") or "").split())


class Arbol(HTMLParser):
    """El árbol de la página. Con los cierres que el HTML deja sobreentender (un <li> cierra el <li> abierto de su
    lista, un <td> la celda abierta de su fila…), por si una página no los escribe."""

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.raiz = Nodo("#raiz", [], 0)
        self.pila = [self.raiz]

    def _cierra(self, cerrar, limite):
        for i in range(len(self.pila) - 1, 0, -1):
            t = self.pila[i].tag
            if t in limite:
                return
            if t in cerrar:
                del self.pila[i:]
                return

    def handle_starttag(self, tag, attrs):
        if tag == "li":
            self._cierra({"li"}, {"ul", "ol"})
        elif tag == "p" and self.pila[-1].tag == "p":
            self.pila.pop()
        elif tag in ("td", "th"):
            self._cierra({"td", "th"}, {"tr", "table"})
        elif tag == "tr":
            self._cierra({"tr"}, {"table", "thead", "tbody", "tfoot"})
        n = Nodo(tag, attrs, self.getpos()[0])
        self.pila[-1].hijos.append(n)
        if tag not in VACIAS:
            self.pila.append(n)

    def handle_startendtag(self, tag, attrs):
        self.pila[-1].hijos.append(Nodo(tag, attrs, self.getpos()[0]))

    def handle_endtag(self, tag):
        for i in range(len(self.pila) - 1, 0, -1):
            if self.pila[i].tag == tag:
                del self.pila[i:]
                return

    def handle_data(self, d):
        self.pila[-1].hijos.append(d)


class Conversor:
    """Una página, de HTML a Markdown."""

    def __init__(self, ruta, generadas):
        self.ruta = ruta                  # dentro de docs/: "en/gui.html"
        self.generadas = generadas        # las rutas con su .md: a ellas, los enlaces van al .md
        self.avisos = []

    def aviso(self, nodo, que):
        self.avisos.append("%s:%d: %s" % (self.ruta, nodo.linea, que))

    # ---- los bloques ----

    def bloques(self, nodo):
        """Los bloques de Markdown (sin líneas en blanco por fuera) de los hijos de `nodo`: lo que va en línea, junto
        en un párrafo; cada bloque, el suyo."""
        out, linea, items = [], [], []

        def vacia():
            if linea:
                t = self.parrafo(self.en_linea(linea))
                if t:
                    out.append(t)
                linea.clear()

        def vacia_items():
            if items:
                out.append("\n".join(items))
                items.clear()

        for h in nodo.hijos:
            if isinstance(h, str):
                if items and not h.strip():
                    continue   # el blanco entre dos tarjetas
                vacia_items()
                linea.append(h)
            elif (h.tag == "a" and "card" in h.clases()) or (h.tag == "span" and "badge" in h.clases()):
                # las tarjetas de la portada (un enlace cada una) y las etiquetas de su cabecera: una lista
                vacia()
                items.append("- " + self.elemento(h).strip(" " + SALTO).replace(SALTO, " "))
            elif h.tag in EN_LINEA or (h.tag not in BLOQUE and h.tag not in SALTA):
                vacia_items()
                linea.append(h)
            else:
                vacia_items()
                vacia()
                out.extend(self.bloque(h))
        vacia_items()
        vacia()
        return out

    def bloque(self, n):
        t = n.tag
        if t in SALTA:
            return []
        if t in ("h1", "h2", "h3", "h4", "h5", "h6"):
            texto = self.en_linea(n.hijos).replace(SALTO, " ").strip()
            return [self.ancla(n) + "#" * int(t[1]) + " " + texto] if texto else []
        if t == "p":
            texto = self.parrafo(self.en_linea(n.hijos))
            if not texto:
                return []
            texto = self.ancla(n) + texto
            return [self.cita(texto)] if n.clases() & RECUADRO else [texto]
        if t in ("ul", "ol"):
            return [self.lista(n, t == "ol")]
        if t == "table":
            return [self.tabla(n)]
        if t == "pre":
            return [self.pre(n)]
        if t == "hr":
            return ["---"]
        if t == "figure":
            return self.figura(n)
        if t == "blockquote":
            return [self.cita("\n\n".join(self.bloques(n)))]
        if t in ("div", "section", "article", "aside", "header", "footer", "main", "body", "html", "figcaption",
                 "li", "td", "th", "tr", "thead", "tbody", "tfoot", "caption"):
            bl = self.bloques(n)
            if n.clases() & RECUADRO and bl:
                return [self.cita("\n\n".join(bl))]
            return bl
        self.aviso(n, "etiqueta de bloque sin traducir: <%s>" % t)
        return self.bloques(n)

    def ancla(self, n):
        """Un `id` del HTML, como un ancla para los enlaces `#…` (y para buscarlo)."""
        i = n.attrs.get("id")
        return '<a id="%s"></a>\n' % i if i else ""

    def cita(self, texto):
        return "\n".join(("> " + l) if l else ">" for l in texto.split("\n"))

    def parrafo(self, texto):
        """Un párrafo: cada <br>, un salto de línea de Markdown (dos espacios al final: sin ellos, al pintarlo se juntaría
        con la siguiente); y lo que al principio de una línea sería otra cosa en Markdown (un título, una lista, una
        cita), escapado."""
        lineas = [l.strip() for l in texto.split(SALTO)]
        out = []
        for l in lineas:
            if not l:
                continue
            if re.match(r"([#>+-]|\d+[.)])(\s|$)", l):
                l = re.sub(r"^(\d+)([.)])", r"\1\\\2", l) if l[0].isdigit() else "\\" + l
            out.append(l)
        return "  \n".join(out)

    def lista(self, n, ordenada):
        lineas, k = [], 0
        for h in n.hijos:
            if isinstance(h, str):
                if h.strip():
                    self.aviso(n, "texto suelto en una lista: %r" % h.strip()[:40])
                continue
            if h.tag != "li":
                self.aviso(h, "<%s> dentro de una lista, sin <li>" % h.tag)
                continue
            k += 1
            marca = "%d. " % k if ordenada else "- "
            sangria = " " * len(marca)
            bl = self.bloques(h) or [""]
            primero = True
            for j, b in enumerate(bl):
                if j > 0 and not re.match(r"(- |\d+\. |```)", b):
                    lineas.append("")   # dos párrafos del mismo elemento: separados, o serían uno
                for l in b.split("\n"):
                    if primero:
                        lineas.append(marca + l)
                        primero = False
                    else:
                        lineas.append(sangria + l if l else "")
        return "\n".join(lineas)

    def tabla(self, n):
        filas = []

        def recoge(x):
            for h in x.hijos:
                if isinstance(h, str):
                    continue
                if h.tag == "tr":
                    filas.append(h)
                elif h.tag in ("thead", "tbody", "tfoot"):
                    recoge(h)
                else:
                    self.aviso(h, "<%s> dentro de una tabla, fuera de una fila" % h.tag)

        recoge(n)
        celdas = []
        for tr in filas:
            fila = []
            for c in tr.hijos:
                if isinstance(c, str) or c.tag not in ("td", "th"):
                    continue
                texto = "<br>".join(b.replace("  \n", "<br>").replace("\n", "<br>") for b in self.bloques(c))
                fila.append(texto.replace("|", "\\|"))
                try:
                    fila.extend([""] * (int(c.attrs.get("colspan") or 1) - 1))
                except ValueError:
                    pass
            celdas.append(fila)
        if not celdas:
            return ""
        ncol = max(len(f) for f in celdas)
        for f in celdas:
            f.extend([""] * (ncol - len(f)))
        out = ["| " + " | ".join(celdas[0]) + " |", "|" + "---|" * ncol]
        out.extend("| " + " | ".join(f) + " |" for f in celdas[1:])
        return "\n".join(out)

    def pre(self, n):
        texto = self.crudo(n)
        if texto.startswith("\n"):
            texto = texto[1:]   # el HTML no cuenta el salto de detrás de <pre>
        texto = texto.rstrip()
        valla = "```"
        while valla in texto:
            valla += "`"
        if n.attrs.get("data-bp") in ("jc", "jc-trozo"):
            lengua = "jc"
        elif "salida" in n.clases():
            lengua = "text"   # lo que imprime un programa, no código
        else:
            lengua = ""
        return valla + lengua + "\n" + texto + "\n" + valla

    def crudo(self, n):
        """El texto tal cual (lo de dentro de un <pre>): sin etiquetas, con los <br> como saltos."""
        out = []
        for h in n.hijos:
            if isinstance(h, str):
                out.append(h)
            elif h.tag == "br":
                out.append("\n")
            else:
                out.append(self.crudo(h))
        return "".join(out)

    def figura(self, n):
        out = []
        for h in n.hijos:
            if isinstance(h, str):
                if h.strip():
                    out.append(self.parrafo(self.en_linea([h])))
            elif h.tag == "img":
                out.append(self.imagen(h))
            elif h.tag == "figcaption":
                texto = self.parrafo(self.en_linea(h.hijos))
                if texto:
                    out.append(texto)
            else:
                out.extend(self.bloque(h) if h.tag in BLOQUE else [self.parrafo(self.en_linea([h]))])
        return [b for b in out if b]

    # ---- lo que va en línea ----

    def en_linea(self, nodos):
        """Lo de dentro de un párrafo, un título o una celda, en una línea (los <br>, como SALTO)."""
        partes = []
        for h in nodos:
            if isinstance(h, str):
                partes.append(self.escapa(re.sub(r"\s+", " ", h)))
            else:
                partes.append(self.elemento(h))
        texto = "".join(partes)
        texto = re.sub(r" {2,}", " ", texto)
        return re.sub(r" ?" + SALTO + " ?", SALTO, texto)

    def elemento(self, h):
        t = h.tag
        if t in SALTA:
            return ""
        if t == "br":
            return SALTO
        if t in ("code", "kbd", "samp", "tt", "var"):
            return self.codigo(self.crudo(h))
        if t in ("strong", "b"):
            return self.rodea(self.en_linea(h.hijos), "**")
        if t in ("em", "i", "cite"):
            return self.rodea(self.en_linea(h.hijos), "*")
        if t in ("s", "del"):
            return self.rodea(self.en_linea(h.hijos), "~~")
        if t == "img":
            return self.imagen(h)
        if t == "a":
            dentro = self.en_linea(h.hijos).replace(SALTO, " ")
            href = h.attrs.get("href")
            if not href:
                i = h.attrs.get("id") or h.attrs.get("name")
                return ('<a id="%s"></a>' % i if i else "") + dentro
            if not dentro.strip():
                return ""
            return "[" + dentro.strip() + "](" + self.destino(href) + ")"
        if t in EN_LINEA:
            return self.en_linea(h.hijos)
        if t in BLOQUE:
            # un bloque donde va texto en línea (un <p> dentro de un <a>…): su texto, en la misma línea
            return " " + " ".join(self.bloques(h)).replace("\n", " ") + " "
        self.aviso(h, "etiqueta sin traducir: <%s>" % t)
        return self.en_linea(h.hijos)

    def rodea(self, texto, marca):
        """`**texto**`, con los espacios de los bordes fuera de la marca (dentro, no valdría)."""
        if not texto.strip():
            return texto
        izq = " " if texto[0] in (" ", SALTO) else ""
        der = " " if texto[-1] in (" ", SALTO) else ""
        return izq + marca + texto.strip(" " + SALTO) + marca + der

    def codigo(self, texto):
        texto = re.sub(r"\s+", " ", texto)
        if not texto.strip():
            return ""
        if "`" not in texto:
            return "`" + texto + "`"
        valla = "``"
        while valla in texto:
            valla += "`"
        return valla + " " + texto + " " + valla

    def imagen(self, h):
        alt = re.sub(r"\s+", " ", h.attrs.get("alt") or "").replace("]", "\\]")
        return "![" + alt + "](" + self.destino(h.attrs.get("src") or "") + ")"

    def escapa(self, texto):
        """Lo que en el texto, fuera del código, Markdown tomaría por otra cosa."""
        texto = texto.replace("\\", "\\\\").replace("`", "\\`").replace("*", "\\*")
        texto = re.sub(r"(?<![A-Za-z0-9])_|_(?![A-Za-z0-9])", r"\\_", texto)   # el _ dentro de una palabra, no
        texto = re.sub(r"<(?=[A-Za-z/!?])", r"\\<", texto)                       # lo que parecería una etiqueta
        return re.sub(r"\[(?=[^\]]*\]\()", r"\\[", texto)                         # lo que parecería un enlace

    def destino(self, href):
        """Un enlace a una página que tiene su .md, al .md (con su ancla); los demás, tal cual."""
        if not href or re.match(r"[a-zA-Z][a-zA-Z0-9+.-]*:|#", href):
            return href
        ruta, almohadilla, ancla = href.partition("#")
        if not ruta:
            return href
        destino = os.path.normpath(os.path.join(os.path.dirname(self.ruta), ruta)).replace(os.sep, "/")
        if destino in self.generadas:
            return ruta + ".md" + almohadilla + ancla
        return href

    def convierte(self, html_texto):
        arbol = Arbol()
        arbol.feed(html_texto)
        arbol.close()
        cuerpo = "\n\n".join(b for b in self.bloques(arbol.raiz) if b.strip())
        cuerpo = re.sub(r"\n{3,}", "\n\n", cuerpo)
        return MARCA % os.path.basename(self.ruta) + "\n\n" + cuerpo.rstrip() + "\n"


# ---- llms.txt ----

def seo():
    """La tabla de seo_paginas.py (su descripción de cada página) y su dirección de la web. Con -I, la carpeta del
    script no está en sys.path: se carga por su ruta."""
    spec = importlib.util.spec_from_file_location("seo_paginas", os.path.join(RAIZ, "scripts", "seo_paginas.py"))
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod.PAGINAS, mod.WEB


def llms_txt():
    paginas, web = seo()
    falta = [r for r, _ in ORDEN if not paginas.get(r, {}).get("desc")]
    if falta:
        raise SystemExit("docs_md: sin descripción en seo_paginas.py: " + ", ".join(falta))

    def linea(ruta, nombre):
        return "- [%s](%s%s.md): %s" % (nombre, web, ruta, paginas[ruta]["desc"])

    out = ["# BasicPlus", "",
           "> " + paginas["en/index.html"]["desc"], "",
           "BasicPlus is a statically typed, object-oriented language with a modern BASIC syntax, for 32-bit "
           "microcontrollers (RP2350, ESP32, STM32), and JC is the same language with the syntax of Java and C#. One "
           "bytecode (`.mod`) runs the same on the PC, in two independent virtual machines (Java and C), and on the "
           "boards: what a program prints on the PC is what it prints on the board. It comes with a graphical "
           "interface (LVGL), SQLite with an ORM, an IDE with a debugger and a simulated micro. Part of Micro32 Suite; "
           "MIT licence. The download (Windows): https://github.com/micro32-suite/BasicPlus/releases/latest. The "
           "installation carries `AGENTS.md`, a guide for AI assistants, and `bp`, the command line (`bp build`, "
           "`bp run`, and `bp api <Module>`: the API of a library module, in BasicPlus).",
           "", "## Documentation", ""]
    out += [linea(r, nombre) for r, nombre in ORDEN if r not in OPCIONALES]
    out += ["- [%s](%s%s): %s" % (nombre, web, ruta, desc[0].upper() + desc[1:]) for ruta, nombre, desc in EN_MD]
    out += ["", "## Optional", ""]
    out += [linea(r, nombre) for r, nombre in ORDEN if r in OPCIONALES]
    return "\n".join(out) + "\n"


# ---- main ----

def lee(ruta):
    with open(ruta, encoding="utf-8", newline="") as f:
        return f.read()


def main():
    comprobar = "--comprobar" in sys.argv[1:]
    raras = [a for a in sys.argv[1:] if a != "--comprobar"]
    if raras:
        print("uso: python -I -X utf8 scripts/docs_md.py [--comprobar]")
        return 2
    rutas = [r for r, _ in ORDEN]
    en_disco = sorted("en/" + f for f in os.listdir(os.path.join(DOCS, "en")) if f.endswith(".html"))
    sin_fila = [r for r in en_disco if r not in rutas]
    if sin_fila:
        print("docs_md: páginas sin su fila en ORDEN (y nada escrito): " + ", ".join(sin_fila))
        return 1
    generadas = set(rutas)
    resultado = {}
    avisos = []
    for r in rutas:
        c = Conversor(r, generadas)
        # los finales de línea, los de Markdown: un HTML sacado por git en Windows trae CRLF, y dentro de un <pre> el CR
        # pasaba tal cual
        html_texto = lee(os.path.join(DOCS, r)).replace("\r\n", "\n").replace("\r", "\n")
        resultado[r + ".md"] = c.convierte(html_texto)
        avisos += c.avisos
    resultado["llms.txt"] = llms_txt()
    for a in avisos:
        print("aviso: " + a)

    distintos = []
    for nombre, texto in resultado.items():
        ruta = os.path.join(DOCS, nombre)
        antes = lee(ruta) if os.path.exists(ruta) else None
        if antes is not None:
            antes = antes.replace("\r\n", "\n")   # git, en Windows, los saca con CRLF: el mismo texto
        if antes != texto:
            distintos.append(nombre)
            if not comprobar:
                with open(ruta, "w", encoding="utf-8", newline="\n") as f:
                    f.write(texto)
    total = sum(len(t.encode("utf-8")) for t in resultado.values())
    if comprobar:
        if distintos:
            print("docs_md: NO al día (pasa scripts/docs_md.py): " + ", ".join(distintos))
            return 1
        print("docs_md: %d ficheros al día (%d KB)" % (len(resultado), total // 1024))
        return 0
    print("docs_md: %d ficheros, %d reescritos (%d KB)%s" % (len(resultado), len(distintos), total // 1024,
                                                              (": " + ", ".join(distintos)) if distintos else ""))
    return 0


if __name__ == "__main__":
    sys.exit(main())
