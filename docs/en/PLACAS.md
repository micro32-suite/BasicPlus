# The boards and their pins

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

## Raspberry Pi Pico 2

Image: `bpvm_pico.uf2`.

*(to be read from the board)*

Its documentation:

- [The pinout (PDF)](https://datasheets.raspberrypi.com/pico/Pico-2-Pinout.pdf)
- [The board's datasheet, with its schematic (PDF)](https://datasheets.raspberrypi.com/pico/pico-2-datasheet.pdf)
- [The Pico page](https://www.raspberrypi.com/documentation/microcontrollers/pico-series.html)
- [The RP2350 datasheet (PDF)](https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf)

## Adafruit Metro RP2350

Image: `bpvm_pico.uf2`.

*(to be read from the board)*

Its documentation:

- [The whole guide, in Markdown (with its pins)](https://learn.adafruit.com/adafruit-metro-rp2350.md?view=all)
- [Its pinouts](https://learn.adafruit.com/adafruit-metro-rp2350/pinouts)
- [The schematic and the board](https://github.com/adafruit/Adafruit-Metro-RP2350-PCB)
- [The RP2350 datasheet (PDF)](https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf)

## ESP32-S3-DevKitC-1

Image: `bpvm_esp32_merged.bin`.

| | |
|---|---|
| Microcontroller | `esp32s3` |
| The program's | 0-21, 38-42, 45-48 |
| Analog | 1-20 |
| PWM | all the program's |
| Pulse counter | all the program's |
| Open drain | all the program's |
| I2C | 0, 1: any of the program's |
| SPI | 2, 3: any of the program's |
| UART | 1, 2: any of the program's |
| The system's: not for the program | 26-37: the flash or the PSRAM; 43-44: the IDE's cable (the wire) |

Its documentation:

- [The board and its pins (v1.0: the RGB LED, on GPIO48)](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32s3/esp32-s3-devkitc-1/user_guide_v1.0.html)
- [v1.1 (the RGB LED, on GPIO38)](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32s3/esp32-s3-devkitc-1/user_guide_v1.1.html)
- [The S3's GPIOs: which ones have conditions](https://docs.espressif.com/projects/esp-idf/en/stable/esp32s3/api-reference/peripherals/gpio.html)
- [The S3 datasheet (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-s3_datasheet_en.pdf)

## ESP32-C3

Image: `bpvm_esp32c3_merged.bin`.

*(to be read from the board)*

Its documentation:

- [The ESP32-C3-DevKitM-1 and its pins](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c3/esp32-c3-devkitm-1/user_guide.html)
- [The ESP32-C3-DevKitC-02 and its pins](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32c3/esp32-c3-devkitc-02/user_guide.html)
- [The C3's GPIOs: which ones have conditions](https://docs.espressif.com/projects/esp-idf/en/stable/esp32c3/api-reference/peripherals/gpio.html)
- [The C3 datasheet (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-c3_datasheet_en.pdf)

## Waveshare ESP32-C5-Touch-LCD-2.8

Image: `bpvm_esp32c5_merged.bin`.

| | |
|---|---|
| Microcontroller | `esp32c5` |
| The program's | 0-12, 23-28 |
| Analog | 1-6 |
| PWM | all the program's |
| Pulse counter | all the program's |
| Open drain | all the program's |
| I2C | 0: any of the program's |
| SPI | 2: any of the program's |
| UART | 1: any of the program's |
| The system's: not for the program | 13-14: the IDE's cable (the wire); 15-22: the flash or the PSRAM |

The display, its touch and the TF slot go through pins of the program's: those of its ENV lines ([the panel lines](INSTALAR_FIRMWARE.md#panel-spi)), and its page names them.

Its documentation:

- [The board, its peripherals and their pins](https://docs.waveshare.com/ESP32-C5-Touch-LCD-2.8)
- [The schematic and the datasheets](https://docs.waveshare.com/ESP32-C5-Touch-LCD-2.8/Resources-And-Documents)
- [The C5's GPIOs: which ones have conditions](https://docs.espressif.com/projects/esp-idf/en/stable/esp32c5/api-reference/peripherals/gpio.html)
- [The C5 datasheet (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-c5_datasheet_en.pdf)

## Waveshare ESP32-C6-LCD-1.3

Image: `bpvm_esp32c6_merged.bin`.

*(to be read from the board)*

The display and the TF slot go through pins of the program's: those of its ENV lines ([the panel lines](INSTALAR_FIRMWARE.md#panel-spi)), and its schematic names them.

Its documentation:

- [The board](https://docs.waveshare.com/ESP32-C6-LCD-1.3)
- [The schematic, with its pins (PDF)](https://files.waveshare.com/wiki/ESP32-C6-LCD-1.3/ESP32C6-1.3.pdf)
- [The C6's GPIOs: which ones have conditions](https://docs.espressif.com/projects/esp-idf/en/stable/esp32c6/api-reference/peripherals/gpio.html)
- [The C6 datasheet (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-c6_datasheet_en.pdf)

## ESP32-P4-Function-EV

Image: `bpvm_esp32p4_merged.bin`.

*(to be read from the board)*

Its documentation:

- [The board and its pins](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32p4/esp32-p4-function-ev-board/user_guide.html)
- [The schematic (PDF)](https://dl.espressif.com/dl/schematics/esp32-p4-function-ev-board-schematics_v1.5.2.pdf)
- [The P4's GPIOs: which ones have conditions](https://docs.espressif.com/projects/esp-idf/en/stable/esp32p4/api-reference/peripherals/gpio.html)
- [The P4 datasheet (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-p4_datasheet_en.pdf)

## Waveshare ESP32-P4-WIFI6-Touch-LCD-4.3

Image: `bpvm_esp32p4_merged.bin`.

| | |
|---|---|
| Microcontroller | `esp32p4` |
| The program's | 0-8, 11, 20-25, 28-36, 39-52 |
| Analog | 20-23, 49-52 |
| PWM | all the program's |
| Pulse counter | all the program's |
| Open drain | all the program's |
| I2C | 0, 1: any of the program's |
| SPI | 2, 3: any of the program's |
| UART | 1, 2: any of the program's |
| The system's: not for the program | 9-10, 12-13, 53: the sound; 14-19, 54: the radio; 26-27: the display; 37-38: the IDE's cable (the wire) |

Its documentation:

- [The board and its 40-pin header](https://docs.waveshare.com/ESP32-P4-WIFI6-Touch-LCD-4.3)
- [The schematic (PDF)](https://files.waveshare.com/wiki/ESP32-P4-WIFI6-Touch-LCD-4.3/ESP32-P4-WIFI6-Touch-LCD-4.3-schematic.pdf)
- [The P4's GPIOs: which ones have conditions](https://docs.espressif.com/projects/esp-idf/en/stable/esp32p4/api-reference/peripherals/gpio.html)
- [The P4 datasheet (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-p4_datasheet_en.pdf)

## ESP32-P4X-Function-EV

Image: `bpvm_esp32p4x_merged.bin`.

*(to be read from the board)*

Its documentation:

- [The board and its pins](https://docs.espressif.com/projects/esp-dev-kits/en/latest/esp32p4/esp32-p4x-function-ev-board/user_guide.html)
- [The P4's GPIOs: which ones have conditions](https://docs.espressif.com/projects/esp-idf/en/stable/esp32p4/api-reference/peripherals/gpio.html)
- [The P4 datasheet (PDF)](https://www.espressif.com/sites/default/files/documentation/esp32-p4_datasheet_en.pdf)

## Nucleo-U575ZI-Q

Image: `bpvm_stm32_nucleo.bin`.

| | |
|---|---|
| Microcontroller | `stm32u575`, LQFP144 |
| The program's | PA0-PA8, PA11-PA15, PB0-PB11, PB13-PB15, PC0-PC3, PC6-PC15, PD0-PD15, PE0-PE15, PF0-PF15, PG0-PG10, PG12-PG15, PH0-PH1, PH3 |
| Analog | PA0-PA7, PB0-PB2, PC0-PC3, PD11-PD13, PF14-PF15, PG0-PG1 |
| PWM | PB7, PC7-PC8 |
| Pulse counter | PC6 |
| Open drain | all the program's |
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
| The system's: not for the program | PA9-PA10: the IDE's cable (the wire) |

Its documentation:

- [The board's pins, as text (Zephyr)](https://docs.zephyrproject.org/latest/boards/st/nucleo_u575zi_q/doc/index.html)
- [The board](https://www.st.com/en/evaluation-tools/nucleo-u575zi-q.html)
- [Its manual, UM2861, with the connectors (PDF)](https://www.st.com/resource/en/user_manual/um2861-stm32u5-nucleo144-board-mb1549-stmicroelectronics.pdf)
- [The STM32U575ZI datasheet (PDF)](https://www.st.com/resource/en/datasheet/stm32u575zi.pdf)

## Discovery STM32U5G9J-DK2

Image: `bpvm_stm32_dk2.bin`.

| | |
|---|---|
| Microcontroller | `stm32u5g9`, LQFP144 |
| The program's | PA0-PA8, PA11-PA15, PB0-PB1, PB3-PB8, PB10-PB11, PB13-PB15, PC0-PC3, PC10-PC15, PD2, PD4-PD5, PD7, PE2-PE3, PF0-PF2, PG0-PG1, PG9-PG10, PG12-PG15, PH0-PH1, PH3, PH9-PH15 |
| Analog | PA0-PA7, PB0-PB1, PC0-PC3, PG0-PG1 |
| PWM | PB8 |
| Pulse counter | PB7 |
| Open drain | all the program's |
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
| The system's: not for the program | PA9-PA10: the IDE's cable (the wire); PB2, PB9, PC6-PC9, PD0-PD1, PD3, PD6, PD8-PD15, PE0, PE4-PE15: the display |

Its documentation:

- [The board's pins, as text (Zephyr)](https://docs.zephyrproject.org/latest/boards/st/stm32u5g9j_dk2/doc/index.html)
- [The board](https://www.st.com/en/evaluation-tools/stm32u5g9j-dk2.html)
- [Its manual, UM3223, with the connectors (PDF)](https://www.st.com/resource/en/user_manual/um3223-discovery-kit-with-stm32u5g9zj-mcu-stmicroelectronics.pdf)
- [The schematic (PDF)](https://www.st.com/resource/en/schematic_pack/mb1918-u5g9zjq-c01-schematic.pdf)
- [The STM32U5G9ZJ datasheet (PDF)](https://www.st.com/resource/en/datasheet/stm32u5g9zj.pdf)
