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

| | |
|---|---|
| Micro | `rp2350a`, QFN-60 |
| Los del programa | 0-29 |
| Analógicos | 26-29 |
| PWM | todos los del programa |
| Contador de pulsos | todos los del programa |
| Colector abierto | todos los del programa |
| I2C 0 | SCL 1, 5, 9, 13, 17, 21, 25, 29 · SDA 0, 4, 8, 12, 16, 20, 24, 28 |
| I2C 1 | SCL 3, 7, 11, 15, 19, 23, 27 · SDA 2, 6, 10, 14, 18, 22, 26 |
| SPI 0 | SCK 2, 6, 18, 22 · MOSI 3, 7, 19, 23 · MISO 0, 4, 16, 20 |
| SPI 1 | SCK 10, 14, 26 · MOSI 11, 15, 27 · MISO 8, 12, 24, 28 |
| UART 0 | TX 0, 12, 16, 28 · RX 1, 13, 17, 29 |
| UART 1 | TX 4, 8, 20, 24 · RX 5, 9, 21, 25 |

*(Del código de la imagen; a falta de preguntárselo a la placa.)*

Al conector salen el 0-22 y el 26-28. El 23, el 24, el 25 y el 29 son de la placa: el modo de su fuente, la presencia de VBUS, el LED y la medida de VSYS (el fichero del SDK, abajo).

Su documentación:

- [El pinout (PDF)](https://datasheets.raspberrypi.com/pico/Pico-2-Pinout.pdf)
- [Sus pines en el SDK de Raspberry Pi (texto)](https://raw.githubusercontent.com/raspberrypi/pico-sdk/master/src/boards/include/boards/pico2.h)
- [La hoja de datos de la placa, con su esquema (PDF)](https://datasheets.raspberrypi.com/pico/pico-2-datasheet.pdf)
- [La página de las Pico](https://www.raspberrypi.com/documentation/microcontrollers/pico-series.html)
- [La hoja de datos del RP2350 (PDF)](https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf)

## Adafruit Metro RP2350

La imagen: `bpvm_pico.uf2`.

| | |
|---|---|
| Micro | `rp2350b`, QFN-80 |
| Los del programa | 0-46 |
| Analógicos | 40-46 |
| PWM | todos los del programa |
| Contador de pulsos | todos los del programa |
| Colector abierto | todos los del programa |
| I2C 0 | SCL 1, 5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45 · SDA 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44 |
| I2C 1 | SCL 3, 7, 11, 15, 19, 23, 27, 31, 35, 39, 43 · SDA 2, 6, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46 |
| SPI 0 | SCK 2, 6, 18, 22, 34, 38 · MOSI 3, 7, 19, 23, 35, 39 · MISO 0, 4, 16, 20, 32, 36 |
| SPI 1 | SCK 10, 14, 26, 30, 42, 46 · MOSI 11, 15, 27, 31, 43 · MISO 8, 12, 24, 28, 40, 44 |
| UART 0 | TX 0, 12, 16, 28, 32, 44 · RX 1, 13, 17, 29, 33, 45 |
| UART 1 | TX 4, 8, 20, 24, 36, 40 · RX 5, 9, 21, 25, 37, 41 |
| Del sistema: no son para el programa | 47: la flash o la PSRAM |

*(Del código de la imagen; a falta de preguntárselo a la placa.)*

Su documentación:

- [La guía entera, en Markdown (con sus pines)](https://learn.adafruit.com/adafruit-metro-rp2350.md?view=all)
- [Sus pines](https://learn.adafruit.com/adafruit-metro-rp2350/pinouts)
- [El esquema y la placa](https://github.com/adafruit/Adafruit-Metro-RP2350-PCB)
- [La hoja de datos del RP2350 (PDF)](https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf)

## ESP32-S3-DevKitC-1

La imagen: `bpvm_esp32_merged.bin`.

| | |
|---|---|
| Micro | `esp32s3` |
| Los del programa | 0-21, 38-42, 45-48 |
| Analógicos | 1-20 |
| PWM | todos los del programa |
| Contador de pulsos | todos los del programa |
| Colector abierto | todos los del programa |
| I2C | 0, 1: cualquiera de los del programa |
| SPI | 2, 3: cualquiera de los del programa |
| UART | 1, 2: cualquiera de los del programa |
| Del sistema: no son para el programa | 26-37: la flash o la PSRAM; 43-44: el cable del IDE (el wire) |

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

La pantalla, su táctil y la ranura TF van por pines de los del programa: los de sus líneas del ENV ([las líneas del panel](INSTALAR_FIRMWARE.md#panel-spi)), y su página los nombra. El I2C 0, el único, es de la placa (el táctil y el expansor), en el 0 (SDA) y el 1 (SCL), a 400 kHz, por su línea `i2c0` del ENV, y se comparte: `I2c.HardI2C(0, 0, 1, 400000)`; o uno por software en otros dos pines.

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

El I2C 0 es de la placa (el táctil), en el 7 (SDA) y el 8 (SCL), a 100 kHz, y se comparte: `I2c.HardI2C(0, 7, 8, 100000)` lo usa con ella (sus direcciones, ya cogidas). Para un sensor tuyo, mejor el I2C 1, en otros dos: `I2c.HardI2C(1, 28, 29, 100000)`.

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

El I2C 0 es de la placa (el táctil y el sonido), en el 7 (SDA) y el 8 (SCL), a 100 kHz, y se comparte: `I2c.HardI2C(0, 7, 8, 100000)` lo usa con ella (sus direcciones, ya cogidas). Para un sensor tuyo, mejor el I2C 1, en otros dos: `I2c.HardI2C(1, 28, 29, 100000)`.

Su documentación:

- [La placa y su conector de 40 pines](https://docs.waveshare.com/ESP32-P4-WIFI6-Touch-LCD-4.3)
- [El esquema (PDF)](https://files.waveshare.com/wiki/ESP32-P4-WIFI6-Touch-LCD-4.3/ESP32-P4-WIFI6-Touch-LCD-4.3-schematic.pdf)
- [Los GPIO de la P4: cuáles tienen condiciones](https://docs.espressif.com/projects/esp-idf/en/stable/esp32p4/api-reference/peripherals/gpio.html)
- [La hoja de datos de la P4 (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-p4_datasheet_en.pdf)

## ESP32-P4X-Function-EV

La imagen: `bpvm_esp32p4x_merged.bin`.

*(a falta de preguntárselo a la placa)*

El I2C 0 es de la placa (el táctil), en el 7 (SDA) y el 8 (SCL), a 100 kHz, y se comparte: `I2c.HardI2C(0, 7, 8, 100000)` lo usa con ella (sus direcciones, ya cogidas). Para un sensor tuyo, mejor el I2C 1, en otros dos: `I2c.HardI2C(1, 28, 29, 100000)`.

Su documentación:

- [La placa y sus pines](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32p4/esp32-p4x-function-ev-board/user_guide.html)
- [Los GPIO de la P4: cuáles tienen condiciones](https://docs.espressif.com/projects/esp-idf/en/stable/esp32p4/api-reference/peripherals/gpio.html)
- [La hoja de datos de la P4 (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-p4_datasheet_en.pdf)

## Nucleo-U575ZI-Q

La imagen: `bpvm_stm32_nucleo.bin`.

| | |
|---|---|
| Micro | `stm32u575`, LQFP144 |
| Los del programa | PA0-PA8, PA11-PA15, PB0-PB11, PB13-PB15, PC0-PC3, PC6-PC15, PD0-PD15, PE0-PE15, PF0-PF15, PG0-PG10, PG12-PG15, PH0-PH1, PH3 |
| Analógicos | PA0-PA7, PB0-PB2, PC0-PC3, PD11-PD13, PF14-PF15, PG0-PG1 |
| PWM | PB7, PC7-PC8 |
| Contador de pulsos | PC6 |
| Colector abierto | todos los del programa |
| I2C 1 | SCL PB6, PB8, PG14 · SDA PB3, PB7, PB9, PG13 |
| I2C 2 | SCL PB10, PB13, PF1 · SDA PB11, PB14, PF0 |
| I2C 3 | SCL PA7, PC0, PG7 · SDA PB4, PC1, PG8 |
| I2C 4 | SCL PD12, PF14 · SDA PD13, PF15 |
| SPI 1 | SCK PA1, PA5, PB3, PE13, PG2 · MOSI PA7, PA12, PB5, PE15, PG4 · MISO PA6, PA11, PB4, PE14, PG3 |
| SPI 2 | SCK PB10, PB13, PD1 · MOSI PB15, PC3, PD4 · MISO PB14, PC2, PD3 |
| SPI 3 | SCK PB3, PC10, PG9 · MOSI PB5, PC12 · MISO PB4, PC11, PG10 |
| UART 2 | TX PA2, PD5 · RX PA3, PD6 |
| UART 3 | TX PA7, PB10, PC10, PD8 · RX PA5, PB11, PC11, PD9 |
| UART 4 | TX PA0, PC10 · RX PA1, PC11 |
| UART 5 | TX PC12 · RX PD2 |
| Del sistema: no son para el programa | PA9-PA10: el cable del IDE (el wire) |

Su documentación:

- [Los pines de la placa, en texto (Zephyr)](https://docs.zephyrproject.org/latest/boards/st/nucleo_u575zi_q/doc/index.html)
- [La placa](https://www.st.com/en/evaluation-tools/nucleo-u575zi-q.html)
- [Su manual, el UM2861, con los conectores (PDF)](https://www.st.com/resource/en/user_manual/um2861-stm32u5-nucleo144-board-mb1549-stmicroelectronics.pdf)
- [La hoja de datos del STM32U575ZI (PDF)](https://www.st.com/resource/en/datasheet/stm32u575zi.pdf)

## Discovery STM32U5G9J-DK2

La imagen: `bpvm_stm32_dk2.bin`.

| | |
|---|---|
| Micro | `stm32u5g9`, LQFP144 |
| Los del programa | PA0-PA8, PA11-PA15, PB0-PB1, PB3-PB8, PB10-PB11, PB13-PB15, PC0-PC3, PC10-PC15, PD2, PD4-PD5, PD7, PE2-PE3, PF0-PF2, PG0-PG1, PG9-PG10, PG12-PG15, PH0-PH1, PH3, PH9-PH15 |
| Analógicos | PA0-PA7, PB0-PB1, PC0-PC3, PG0-PG1 |
| PWM | PB8 |
| Contador de pulsos | PB7 |
| Colector abierto | todos los del programa |
| I2C 1 | SCL PB6, PB8, PG14 · SDA PB3, PB7, PG13 |
| I2C 2 | SCL PB10, PB13, PF1 · SDA PB11, PB14, PF0 |
| I2C 3 | SCL PA7, PC0 · SDA PB4, PC1 |
| I2C 4 | — |
| I2C 5 | — |
| SPI 1 | SCK PA1, PA5, PB3 · MOSI PA7, PA12, PB5 · MISO PA6, PA11, PB4 |
| SPI 2 | SCK PB10, PB13 · MOSI PB15, PC3, PD4 · MISO PB14, PC2 |
| SPI 3 | SCK PB3, PC10, PG9 · MOSI PB5, PC12 · MISO PB4, PC11, PG10 |
| UART 2 | TX PA2, PD5 · RX PA3 |
| UART 3 | TX PA7, PB10, PC10 · RX PA5, PB11, PC11 |
| UART 4 | TX PA0, PC10 · RX PA1, PC11 |
| UART 5 | TX PC12 · RX PD2 |
| UART 6 | TX PC3, PF0 · RX PC2, PF1 |
| Del sistema: no son para el programa | PA9-PA10: el cable del IDE (el wire); PB2, PB9, PC6-PC9, PD0-PD1, PD3, PD6, PD8-PD15, PE0, PE4-PE15: la pantalla |

El I2C 2 es de la placa (el táctil), en PF0 (SDA) y PF1 (SCL), a 100 kHz, y se comparte; los demás, del programa.

Su documentación:

- [Los pines de la placa, en texto (Zephyr)](https://docs.zephyrproject.org/latest/boards/st/stm32u5g9j_dk2/doc/index.html)
- [La placa](https://www.st.com/en/evaluation-tools/stm32u5g9j-dk2.html)
- [Su manual, el UM3223, con los conectores (PDF)](https://www.st.com/resource/en/user_manual/um3223-discovery-kit-with-stm32u5g9zj-mcu-stmicroelectronics.pdf)
- [El esquema (PDF)](https://www.st.com/resource/en/schematic_pack/mb1918-u5g9zjq-c01-schematic.pdf)
- [La hoja de datos del STM32U5G9ZJ (PDF)](https://www.st.com/resource/en/datasheet/stm32u5g9zj.pdf)
