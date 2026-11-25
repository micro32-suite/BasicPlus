#!/usr/bin/env python3
# placas_doc.py — 25-nov-2026 (V9 H1.10, #861): docs/PLACAS.md y docs/en/PLACAS.md, los pines de cada placa y los enlaces a
# la documentación de su fabricante. No se editan a mano: salen de
#   - scripts/placas/placas.json  el nombre de cada placa, su imagen y sus enlaces (lo que no sabe la imagen);
#   - scripts/placas/<id>.txt     lo que contesta la placa (samples/PinesPlaca.bp). Con una línea «origen: …», lo mismo sacado
#                                 del código de la imagen, hasta preguntarle: se dice debajo de su tabla y sigue faltando;
#   - scripts/placas/buses.json   por qué pines sale cada bus en la RP2350 y en las STM32 (placas_buses.py).
#
#   python -I -X utf8 scripts/placas_doc.py                   escribe los dos
#   python -I -X utf8 scripts/placas_doc.py --comprobar       dice si están al día y si faltan placas (sale con 1 si no)
#   python -I -X utf8 scripts/placas_doc.py --lee <id> <COM>  corre PinesPlaca en la placa y guarda lo que contesta
#   python -I -X utf8 scripts/placas_doc.py --mira <id> <COM> lo mismo, sin guardar: dice si es lo que hay (sale con 1 si no)
import io
import json
import os
import subprocess
import sys

RAIZ = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
DATOS = os.path.join(RAIZ, 'scripts', 'placas')
SALIDAS = {'es': os.path.join(RAIZ, 'docs', 'PLACAS.md'), 'en': os.path.join(RAIZ, 'docs', 'en', 'PLACAS.md')}

# Las claves de PinesPlaca, como se dicen en cada lengua.
CLAVES = [
    ('pines', 'Los del programa', "The program's"),
    ('analógicos', 'Analógicos', 'Analog'),
    ('pwm', 'PWM', 'PWM'),
    ('pulsos', 'Contador de pulsos', 'Pulse counter'),
    ('colector abierto', 'Colector abierto', 'Open drain'),
    ('sólo entrada', 'Sólo de entrada', 'Input only'),
]
EN = {'ninguno': 'none', 'todos los del programa': "all the program's", 'cualquiera de los del programa': "any of the program's",
      'de la flash o la PSRAM': 'the flash or the PSRAM', 'del cable del IDE (el wire)': "the IDE's cable (the wire)",
      'de la pantalla': 'the display', 'del sonido': 'the sound', 'de la radio': 'the radio'}
DEL = {'de la flash o la PSRAM': 'la flash o la PSRAM', 'del cable del IDE (el wire)': 'el cable del IDE (el wire)',
       'de la pantalla': 'la pantalla', 'del sonido': 'el sonido', 'de la radio': 'la radio'}


def lee(f):
    return io.open(os.path.join(DATOS, f), encoding='utf-8').read()


def responde(pid):
    """Lo que contesta la placa: {clave: valor}, y los del sistema aparte; None si no se le ha preguntado."""
    f = os.path.join(DATOS, pid + '.txt')
    if not os.path.isfile(f):
        return None
    d = {'sistema': []}
    for l in io.open(f, encoding='utf-8').read().splitlines():
        if ': ' not in l + ' ':
            continue
        k, v = l.split(':', 1)
        v = v.strip()
        if k == 'sistema':
            d['sistema'].append(v)
        else:
            d[k] = v
    return d


def numeros(lista):
    """«PA0-PA3, PB7» o «0-12, 23» → el conjunto de sus números."""
    def n(x):
        x = x.strip()
        return (ord(x[1]) - 65) * 16 + int(x[2:]) if x.startswith('P') else int(x)
    s = set()
    for t in lista.split(','):
        t = t.strip()
        if not t or t == 'ninguno':
            continue
        a, _, b = t.partition('-')
        s.update(range(n(a), n(b or a) + 1))
    return s


def nombre(n, st):
    return 'P%s%d' % (chr(65 + n // 16), n % 16) if st else str(n)


def de_buses(placa, r, st):
    """Los buses de la placa y sus pines: los fijos del micro que le quedan al programa; en las ESP32, cualquiera."""
    libres = numeros(r['pines'])
    out = []
    fijos = json.loads(lee('buses.json')).get(placa.get('buses')) if placa.get('buses') else None
    for clave, bus in (('i2c', 'I2C'), ('spi', 'SPI'), ('uart', 'UART')):
        ids = [x.strip() for x in r.get(clave, '').split(',') if x.strip().isdigit()]
        if not ids:
            continue
        if fijos is None:
            out.append((bus, ', '.join(ids), None))
            continue
        for i in ids:
            quien = fijos.get(bus + i, {})
            orden = [q for q in ('SCL', 'SDA', 'SCK', 'MOSI', 'MISO', 'TX', 'RX') if q in quien]
            txt = []
            for q in orden:
                ps = [nombre(p, st) for p in quien[q] if p in libres]
                txt.append('%s %s' % (q, ', '.join(ps)) if ps else None)
            if txt and all(txt):
                out.append((bus, i, ' · '.join(txt)))
            else:
                out.append((bus, i, '—'))
    return out


def tabla(placa, r, en):
    st = r.get('fabricante') == 'STMicroelectronics'

    def di(v):
        return EN.get(v, v) if en else v
    f = ['| | |', '|---|---|']
    f.append('| %s | `%s`%s |' % ('Microcontroller' if en else 'Micro', r['micro'],
                                  ', ' + r['paquete'] if r.get('paquete') else ''))
    for k, es_, en_ in CLAVES:
        v = r.get(k, 'ninguno')
        if k != 'pines' and v == r['pines']:
            v = 'todos los del programa'
        if k == 'sólo entrada' and v == 'ninguno':
            continue
        f.append('| %s | %s |' % (en_ if en else es_, di(v)))
    for bus, i, pines in de_buses(placa, r, st):
        if pines is None:
            f.append('| %s | %s: %s |' % (bus, i, di('cualquiera de los del programa')))
        else:
            f.append('| %s | %s |' % (bus + ' ' + i, pines))
    porque = {}
    for s in r['sistema']:
        p, _, q = s.partition(' (')
        porque.setdefault(q[:-1] if q.endswith(')') else q, []).append(p)
    sis = ['%s: %s' % (', '.join(ps), EN.get(q, q) if en else DEL.get(q, q)) for q, ps in porque.items()]
    if sis:
        f.append('| %s | %s |' % ("The system's: not for the program" if en else 'Del sistema: no son para el programa',
                                  '; '.join(sis)))
    return f


TEXTO = {
    'es': '''# Las placas y sus pines

<!-- Lo escribe scripts/placas_doc.py: no se edita a mano. -->
> 🇬🇧 [English version](en/PLACAS.md)

Por cada placa, lo que contesta ella —los pines que tu programa puede usar y para qué sirve cada uno, los buses y los pines
del sistema— y los enlaces a la documentación de su fabricante, donde está lo que la placa lleva soldado: el LED, el botón,
la pantalla, los conectores. **No te inventes un número de pin**: mira aquí o pregúntaselo a tu placa, con
`samples/PinesPlaca.bp`, que es de donde sale lo de aquí.

- **El número de un pin** es el del GPIO del micro. En las STM32 es puerto × 16 + número: `PA5` es el 5; `PB5`, el 21;
  `PC13`, el 45.
- **Los buses.** En las ESP32 salen por cualquier pin de los del programa. En la RP2350 y en las STM32, cada bus sale por los
  suyos: los de la tabla, ya sin los del sistema; con otro pin, el bus no contesta. Si no queda ninguno que cuadre, un I2C
  por software (`modSoftI2C.SoftI2C(sda, scl)`) vale en dos pines cualesquiera ([referencia §14.3](referencia.html#stdlib-i2c)).
- **Los del sistema** —la flash, la PSRAM, el cable del IDE; en algunas, la pantalla, el sonido y la radio— no son del
  programa: pedir uno es un `RuntimeError` que lo dice.
- Que un pin sea del programa no quiere decir que esté libre en la placa: puede llevar algo soldado, o no salir a ningún
  conector. Eso lo dice el fabricante.

''',
    'en': '''# The boards and their pins

<!-- Written by scripts/placas_doc.py: not edited by hand. -->
> 🇪🇸 [Versión en español](../PLACAS.md)

For each board, what the board itself answers —the pins your program can use and what each one is good for, the buses and the
system's pins— and the links to its manufacturer's documentation, which has what is soldered on the board: the LED, the
button, the display, the connectors. **Do not invent a pin number**: look here, or ask your board with
`samples/PinesPlaca.bp`, which is where all this comes from.

- **A pin's number** is that of the microcontroller's GPIO. On STM32 it is port × 16 + number: `PA5` is 5; `PB5`, 21;
  `PC13`, 45.
- **The buses.** On ESP32 they go out through any of the program's pins. On RP2350 and STM32 each bus goes out through its own:
  those in the table, already without the system's; with any other pin, the bus does not answer. If none of them fits, a
  software I2C (`modSoftI2C.SoftI2C(sda, scl)`) works on any two pins ([reference §14.3](referencia.html#stdlib-i2c)).
- **The system's** —the flash, the PSRAM, the IDE's cable; on some, the display, the sound and the radio— are not the
  program's: asking for one is a `RuntimeError` that says so.
- A pin being the program's does not mean it is free on the board: it may have something soldered, or not reach any
  connector. That is up to the manufacturer.

''',
}


def escribe(en):
    d = json.loads(lee('placas.json'))
    out = [TEXTO['en' if en else 'es']]
    faltan = []
    for p in d['placas']:
        out.append('## %s\n' % p['nombre'])
        out.append(('Image: `%s`.\n' if en else 'La imagen: `%s`.\n') % p['imagen'])
        r = responde(p['id'])
        if r is None or 'origen' in r:
            faltan.append(p['id'])
        if r is None:
            out.append('*(to be read from the board)*\n' if en else '*(a falta de preguntárselo a la placa)*\n')
        else:
            out.append('\n'.join(tabla(p, r, en)) + '\n')
            if 'origen' in r:
                out.append("*(From the image's code; still to be read from the board.)*\n" if en
                           else '*(Del código de la imagen; a falta de preguntárselo a la placa.)*\n')
        nota = p.get('nota_en' if en else 'nota_es')
        if nota:
            out.append(nota + '\n')
        out.append('Its documentation:\n' if en else 'Su documentación:\n')
        out.append('\n'.join('- [%s](%s)' % ((e[1] if en else e[0]), e[2]) for e in p['enlaces']) + '\n')
    return '\n'.join(out).replace('\n\n\n', '\n\n'), faltan


def corre(com):
    bp = os.path.join(RAIZ, 'bp')
    r = subprocess.run(['bash', bp, 'run', '--placa=' + com, os.path.join(RAIZ, 'samples', 'PinesPlaca.bp')],
                       stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=RAIZ)
    t = r.stdout.decode('utf-8', 'replace').replace('\r\n', '\n')
    ls = [l for l in t.split('\n') if ': ' in l and l.split(':', 1)[0] in
          ('micro', 'paquete', 'fabricante', 'uart', 'i2c', 'spi', 'sistema') + tuple(k[0] for k in CLAVES)
          or l in ('paquete:', 'paquete: ')]
    if r.returncode != 0 or not any(l.startswith('micro: ') for l in ls):
        print('placas_doc: la placa no ha contestado (código %d)' % r.returncode)
        print(r.stderr.decode('utf-8', 'replace')[-600:])
        return None
    return '\n'.join(l.rstrip() for l in ls) + '\n'


def main():
    a = sys.argv[1:]
    if a and a[0] in ('--lee', '--mira') and len(a) == 3:
        ids = [p['id'] for p in json.loads(lee('placas.json'))['placas']]
        if a[1] not in ids:
            print('placas_doc: no conozco %s (%s)' % (a[1], ', '.join(ids)))
            return 2
        t = corre(a[2])
        if t is None:
            return 1
        f = os.path.join(DATOS, a[1] + '.txt')
        hay = io.open(f, encoding='utf-8').read() if os.path.isfile(f) else None
        if hay is not None:   # lo sacado del código se compara con lo que contesta, sin su línea
            hay = ''.join(l for l in hay.splitlines(True) if not l.startswith('origen:'))
        if a[0] == '--lee':
            io.open(f, 'w', encoding='utf-8', newline='\n').write(t)
            print('placas_doc: %s, %s' % (a[1], 'igual' if hay == t else 'nuevo' if hay is None else 'CAMBIA'))
            return 0
        print('placas_doc: %s %s' % (a[1], 'contesta lo que hay' if hay == t else 'contesta OTRA COSA:\n' + t))
        return 0 if hay == t else 1
    mal = 0
    for lengua in ('es', 'en'):
        t, faltan = escribe(lengua == 'en')
        f = SALIDAS[lengua]
        hay = io.open(f, encoding='utf-8', newline='').read().replace('\r\n', '\n') if os.path.isfile(f) else None
        if '--comprobar' in a:
            if hay != t:
                print('placas_doc: %s no está al día' % os.path.relpath(f, RAIZ))
                mal = 1
        elif hay != t:
            io.open(f, 'w', encoding='utf-8', newline='\n').write(t)
            print('placas_doc: escrito', os.path.relpath(f, RAIZ))
    if faltan:
        print('placas_doc: faltan por preguntar: ' + ', '.join(faltan))
        mal = 1 if '--comprobar' in a else mal
    if '--comprobar' in a and not mal:
        print('placas_doc: las %d placas, al día' % len(json.loads(lee('placas.json'))['placas']))
    return mal


sys.exit(main())
