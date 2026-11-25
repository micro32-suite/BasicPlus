#!/usr/bin/env python3
# guiones_doc.py — 25-nov-2026 (V9 #891): los guiones de la instalación (guiones/*.guion) y su documentación, de acuerdo.
#
# Los valores de cada placa están en dos sitios: en su guion, que los pone, y en INSTALAR_FIRMWARE.md, que los explica a
# quien los pone a mano. Aquí se mira que sean los mismos: cada variable que pone un guion (clave=valor) y cada pack que
# graba están, tal cual, en INSTALAR_FIRMWARE, en las dos lenguas; y cada guion está en la tabla de la guía del IDE (§14.1).
#
#   python -I -X utf8 scripts/guiones_doc.py            sale con 1 si algo no está
import glob
import io
import os
import re
import sys

RAIZ = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
INSTALAR = ['docs/INSTALAR_FIRMWARE.md', 'docs/en/INSTALAR_FIRMWARE.md']
GUIA = ['docs/guia-ide.html', 'docs/en/guia-ide.html']


def lee(f):
    return io.open(os.path.join(RAIZ, f), encoding='utf-8').read()


def main():
    textos = {f: lee(f) for f in INSTALAR + GUIA}
    faltan = []
    guiones = sorted(glob.glob(os.path.join(RAIZ, 'guiones', '*.guion')))
    for g in guiones:
        nombre = os.path.basename(g)[:-len('.guion')]
        for f in GUIA:
            if '<code>%s</code>' % nombre not in textos[f]:
                faltan.append('%s: no nombra el guion %s' % (f, nombre))
        for n, linea in enumerate(io.open(g, encoding='utf-8').read().splitlines(), 1):
            m = re.match(r'entorno_poner\b.*\bclave=(\S+).*\bvalor=(\S+)', linea)
            que = '%s=%s' % m.groups() if m else None
            m = re.match(r'pack_grabar\b.*\bpack=(\S+)', linea)
            if m:
                que = m.group(1) + '.pack'
            for f in INSTALAR if que else []:
                if que not in textos[f]:
                    faltan.append('%s: no está «%s» (%s, línea %d)' % (f, que, os.path.basename(g), n))
    for x in faltan:
        print('guiones_doc: ' + x)
    if not guiones:
        print('guiones_doc: no hay guiones')
    print('guiones_doc: %d guiones, %d diferencias con su documentación' % (len(guiones), len(faltan)))
    return 1 if faltan or not guiones else 0


sys.exit(main())
