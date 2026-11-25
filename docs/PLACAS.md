# Las placas y sus pines

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

## Raspberry Pi Pico 2

La imagen: `bpvm_pico.uf2`.

*(a falta de preguntárselo a la placa)*

Su documentación:

- [El pinout (PDF)](https://datasheets.raspberrypi.com/pico/Pico-2-Pinout.pdf)
- [La hoja de datos de la placa, con su esquema (PDF)](https://datasheets.raspberrypi.com/pico/pico-2-datasheet.pdf)
- [La página de las Pico](https://www.raspberrypi.com/documentation/microcontrollers/pico-series.html)
- [La hoja de datos del RP2350 (PDF)](https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf)

## Adafruit Metro RP2350

La imagen: `bpvm_pico.uf2`.

*(a falta de preguntárselo a la placa)*

Su documentación:

- [La guía entera, en Markdown (con sus pines)](https://learn.adafruit.com/adafruit-metro-rp2350.md?view=all)
- [Sus pines](https://learn.adafruit.com/adafruit-metro-rp2350/pinouts)
- [El esquema y la placa](https://github.com/adafruit/Adafruit-Metro-RP2350-PCB)
- [La hoja de datos del RP2350 (PDF)](https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf)

## ESP32-S3-DevKitC-1

La imagen: `bpvm_esp32_merged.bin`.

*(a falta de preguntárselo a la placa)*

Su documentación:

- [La placa y sus pines (la v1.0: el LED RGB, en el GPIO48)](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32s3/esp32-s3-devkitc-1/user_guide_v1.0.html)
- [La v1.1 (el LED RGB, en el GPIO38)](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32s3/esp32-s3-devkitc-1/user_guide_v1.1.html)
- [Los GPIO de la S3: cuáles tienen condiciones](https://docs.espressif.com/projects/esp-idf/en/stable/esp32s3/api-reference/peripherals/gpio.html)
- [La hoja de datos de la S3 (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-s3_datasheet_en.pdf)

## ESP32-C3

La imagen: `bpvm_esp32c3_merged.bin`.

*(a falta de preguntárselo a la placa)*

Su documentación:

- [La ESP32-C3-DevKitM-1 y sus pines](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c3/esp32-c3-devkitm-1/user_guide.html)
- [La ESP32-C3-DevKitC-02 y sus pines](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c3/esp32-c3-devkitc-02/user_guide.html)
- [Los GPIO de la C3: cuáles tienen condiciones](https://docs.espressif.com/projects/esp-idf/en/stable/esp32c3/api-reference/peripherals/gpio.html)
- [La hoja de datos de la C3 (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-c3_datasheet_en.pdf)

## Waveshare ESP32-C5-Touch-LCD-2.8

La imagen: `bpvm_esp32c5_merged.bin`.

| | |
|---|---|
| Micro | `esp32c5` |
| Los del programa | 0-12, 23-28 |
| Analógicos | 1-6 |
| PWM | todos los del programa |
| Contador de pulsos | todos los del programa |
| Colector abierto | todos los del programa |
| I2C | 0: cualquiera de los del programa |
| SPI | 2: cualquiera de los del programa |
| UART | 1: cualquiera de los del programa |
| Del sistema: no son para el programa | 13-14: el cable del IDE (el wire); 15-22: la flash o la PSRAM |

La pantalla, su táctil y la ranura TF van por pines de los del programa: los de sus líneas del ENV ([las líneas del panel](INSTALAR_FIRMWARE.md#panel-spi)), y su página los nombra.

Su documentación:

- [La placa, sus periféricos y sus pines](https://docs.waveshare.com/ESP32-C5-Touch-LCD-2.8)
- [El esquema y las hojas de datos](https://docs.waveshare.com/ESP32-C5-Touch-LCD-2.8/Resources-And-Documents)
- [Los GPIO de la C5: cuáles tienen condiciones](https://docs.espressif.com/projects/esp-idf/en/stable/esp32c5/api-reference/peripherals/gpio.html)
- [La hoja de datos de la C5 (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-c5_datasheet_en.pdf)

## Waveshare ESP32-C6-LCD-1.3

La imagen: `bpvm_esp32c6_merged.bin`.

*(a falta de preguntárselo a la placa)*

La pantalla y la ranura TF van por pines de los del programa: los de sus líneas del ENV ([las líneas del panel](INSTALAR_FIRMWARE.md#panel-spi)), y su esquema los nombra.

Su documentación:

- [La placa](https://docs.waveshare.com/ESP32-C6-LCD-1.3)
- [El esquema, con sus pines (PDF)](https://files.waveshare.com/wiki/ESP32-C6-LCD-1.3/ESP32C6-1.3.pdf)
- [Los GPIO de la C6: cuáles tienen condiciones](https://docs.espressif.com/projects/esp-idf/en/stable/esp32c6/api-reference/peripherals/gpio.html)
- [La hoja de datos de la C6 (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-c6_datasheet_en.pdf)

## ESP32-P4-Function-EV

La imagen: `bpvm_esp32p4_merged.bin`.

*(a falta de preguntárselo a la placa)*

Su documentación:

- [La placa y sus pines](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32p4/esp32-p4-function-ev-board/user_guide.html)
- [El esquema (PDF)](https://dl.espressif.com/dl/schematics/esp32-p4-function-ev-board-schematics_v1.5.2.pdf)
- [Los GPIO de la P4: cuáles tienen condiciones](https://docs.espressif.com/projects/esp-idf/en/stable/esp32p4/api-reference/peripherals/gpio.html)
- [La hoja de datos de la P4 (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-p4_datasheet_en.pdf)

## Waveshare ESP32-P4-WIFI6-Touch-LCD-4.3

La imagen: `bpvm_esp32p4_merged.bin`.

| | |
|---|---|
| Micro | `esp32p4` |
| Los del programa | 0-8, 11, 20-25, 28-36, 39-52 |
| Analógicos | 20-23, 49-52 |
| PWM | todos los del programa |
| Contador de pulsos | todos los del programa |
| Colector abierto | todos los del programa |
| I2C | 0, 1: cualquiera de los del programa |
| SPI | 2, 3: cualquiera de los del programa |
| UART | 1, 2: cualquiera de los del programa |
| Del sistema: no son para el programa | 9-10, 12-13, 53: el sonido; 14-19, 54: la radio; 26-27: la pantalla; 37-38: el cable del IDE (el wire) |

Su documentación:

- [La placa y su conector de 40 pines](https://docs.waveshare.com/ESP32-P4-WIFI6-Touch-LCD-4.3)
- [El esquema (PDF)](https://files.waveshare.com/wiki/ESP32-P4-WIFI6-Touch-LCD-4.3/ESP32-P4-WIFI6-Touch-LCD-4.3-schematic.pdf)
- [Los GPIO de la P4: cuáles tienen condiciones](https://docs.espressif.com/projects/esp-idf/en/stable/esp32p4/api-reference/peripherals/gpio.html)
- [La hoja de datos de la P4 (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-p4_datasheet_en.pdf)

## ESP32-P4X-Function-EV

La imagen: `bpvm_esp32p4x_merged.bin`.

*(a falta de preguntárselo a la placa)*

Su documentación:

- [La placa y sus pines](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32p4/esp32-p4x-function-ev-board/user_guide.html)
- [Los GPIO de la P4: cuáles tienen condiciones](https://docs.espressif.com/projects/esp-idf/en/stable/esp32p4/api-reference/peripherals/gpio.html)
- [La hoja de datos de la P4 (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-p4_datasheet_en.pdf)

## Nucleo-U575ZI-Q

La imagen: `bpvm_stm32_nucleo.bin`.

*(a falta de preguntárselo a la placa)*

Su documentación:

- [Los pines de la placa, en texto (Zephyr)](https://docs.zephyrproject.org/latest/boards/st/nucleo_u575zi_q/doc/index.html)
- [La placa](https://www.st.com/en/evaluation-tools/nucleo-u575zi-q.html)
- [Su manual, el UM2861, con los conectores (PDF)](https://www.st.com/resource/en/user_manual/um2861-stm32u5-nucleo144-board-mb1549-stmicroelectronics.pdf)
- [La hoja de datos del STM32U575ZI (PDF)](https://www.st.com/resource/en/datasheet/stm32u575zi.pdf)

## Discovery STM32U5G9J-DK2

La imagen: `bpvm_stm32_dk2.bin`.

*(a falta de preguntárselo a la placa)*

Su documentación:

- [Los pines de la placa, en texto (Zephyr)](https://docs.zephyrproject.org/latest/boards/st/stm32u5g9j_dk2/doc/index.html)
- [La placa](https://www.st.com/en/evaluation-tools/stm32u5g9j-dk2.html)
- [Su manual, el UM3223, con los conectores (PDF)](https://www.st.com/resource/en/user_manual/um3223-discovery-kit-with-stm32u5g9zj-mcu-stmicroelectronics.pdf)
- [El esquema (PDF)](https://www.st.com/resource/en/schematic_pack/mb1918-u5g9zjq-c01-schematic.pdf)
- [La hoja de datos del STM32U5G9ZJ (PDF)](https://www.st.com/resource/en/datasheet/stm32u5g9zj.pdf)
