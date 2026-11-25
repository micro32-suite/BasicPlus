#!/usr/bin/env python3
# placas_buses.py — 25-nov-2026 (V9 H1.10, #861): por qué pines sale cada bus en los micros donde eso es fijo —la RP2350 y
# las STM32; en las ESP32, por cualquiera—, sacado de los datos del fabricante y no copiado a mano:
#   - la RP2350, de su SDK (hardware/regs/io_bank0.h: las funciones de cada GPIO);
#   - las STM32, de los datos abiertos de ST (github.com/STMicroelectronics/STM32_open_pin_data: el XML del micro, con los
#     pines de su encapsulado, y el de sus funciones alternas), y sólo con las funciones alternas que pone la imagen
#     (bpgenvm-c/stm32/port/gpio_stm32.c: los I2C, AF4; SPI1 y SPI2, AF5, y SPI3, AF6; USART2, 3 y 6, AF7, y UART4 y 5,
#     AF8): un pin que la tiene en otra no le vale.
# Escribe scripts/placas/buses.json, que es lo que lee placas_doc.py. Se vuelve a pasar si cambia la imagen o el micro.
#
#   python -I -X utf8 scripts/placas_buses.py <pico-sdk> <carpeta con los XML de ST>
import io
import json
import os
import re
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))

# El XML de cada STM32 y el de sus funciones alternas.
ST = {
    'stm32u575': ('STM32U575ZITxQ.xml', 'GPIO-STM32U5x_gpio_v1_0_Modes.xml'),
    'stm32u5g9': ('STM32U5G9ZJTxQ.xml', 'GPIO-STM32U5FG_gpio_v1_0_Modes.xml'),
}


def af_de_la_imagen(bus, n):
    if bus == 'I2C':
        return 'AF4'
    if bus == 'SPI':
        return 'AF6' if n == 3 else 'AF5'
    return 'AF7' if n in (2, 3, 6) else 'AF8'


def de_rp2350(sdk):
    h = os.path.join(sdk, 'src', 'rp2350', 'hardware_regs', 'include', 'hardware', 'regs', 'io_bank0.h')
    t = io.open(h, encoding='utf-8').read()
    b = {}
    for m in re.finditer(r'IO_BANK0_GPIO(\d+)_CTRL_FUNCSEL_VALUE_(I2C|SPI|UART)(\d)_(\w+) _u\(0x0?([123])\)', t):
        pin, bus, n, que, _ = m.groups()
        nombre = {'SS_N': 'CS', 'SCLK': 'SCK', 'TX': 'MOSI', 'RX': 'MISO'}.get(que, que) if bus == 'SPI' else que
        if nombre in ('CTS', 'RTS', 'CS'):   # el CS lo lleva el programa con un pin cualquiera
            continue
        b.setdefault('%s%s' % (bus, n), {}).setdefault(nombre, []).append(int(pin))
    return b


def de_st(carpeta, mcu, gpio):
    m = io.open(os.path.join(carpeta, mcu), encoding='utf-8').read()
    g = io.open(os.path.join(carpeta, gpio), encoding='utf-8').read()
    # Los pines del encapsulado: PA0..PH15, por su nombre corto.
    tiene = set()
    for x in re.finditer(r'<Pin Name="(P[A-H]\d+)[^"]*" Position="[^"]+" Type="(I/O|MonoIO)"', m):
        tiene.add(x.group(1))
    b = {}
    for p in re.finditer(r'<GPIO_Pin PortName="P\w" Name="(P[A-H]\d+)[^"]*">(.*?)</GPIO_Pin>', g, re.S):
        pin, dentro = p.groups()
        if pin not in tiene:
            continue
        for s in re.finditer(r'<PinSignal Name="(\w+)">\s*<SpecificParameter Name="GPIO_AF">\s*'
                             r'<PossibleValue>GPIO_(AF\d+)_\w+</PossibleValue>', dentro):
            senal, af = s.groups()
            k = re.match(r'(I2C|SPI|USART|UART)(\d)_(SCL|SDA|SCK|MISO|MOSI|TX|RX)$', senal)
            if not k:
                continue
            bus, n, que = k.group(1), int(k.group(2)), k.group(3)
            bus = 'UART' if bus == 'USART' else bus
            if bus == 'UART' and n == 1:          # el cable del IDE
                continue
            if bus == 'SPI' and n > 3 or af != af_de_la_imagen(bus, n):
                continue
            b.setdefault('%s%d' % (bus, n), {}).setdefault(que, []).append((ord(pin[1]) - 65) * 16 + int(pin[2:]))
    return b


def main():
    if len(sys.argv) != 3:
        print('uso: placas_buses.py <pico-sdk> <carpeta con los XML de ST>')
        return 2
    d = {'rp2350': de_rp2350(sys.argv[1])}
    for micro, (mcu, gpio) in ST.items():
        d[micro] = de_st(sys.argv[2], mcu, gpio)
    for micro in d:
        for bus in d[micro]:
            for que in d[micro][bus]:
                d[micro][bus][que].sort()
    f = os.path.join(AQUI, 'placas', 'buses.json')
    os.makedirs(os.path.dirname(f), exist_ok=True)
    io.open(f, 'w', encoding='utf-8', newline='\n').write(json.dumps(d, indent=1, sort_keys=True) + '\n')
    for micro in sorted(d):
        print(micro, ', '.join(sorted(d[micro])))
    return 0


sys.exit(main())
