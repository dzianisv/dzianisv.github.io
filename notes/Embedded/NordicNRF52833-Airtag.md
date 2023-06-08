# Noridic nRF52833 Airtag

I did a first prototype on [micro:bit](https://tech.microbit.org/hardware/) development board. And it works more time in comparison witth ESP32, especially on a small battery.

![](NordicNRF52833-Airtag.md-images/microbit-airtag.webp)

Micro:bit has to nRF52833 MCU.
The nRF52833-QDAA and nRF52833-QIAA are both variants of the Nordic Semiconductor's nRF52833 System-on-Chip (SoC). These variants have some differences in terms of features and capabilities.

The main difference between the two variants lies in the radio frequency (RF) power output. The nRF52833-QDAA variant supports higher RF output power, which makes it suitable for applications that require a longer range of wireless communication. On the other hand, the nRF52833-QIAA variant has lower RF output power but can still meet the requirements of many applications.

Here is a breakdown of the key specifications for both variants:

nRF52833-QDAA:
- High RF output power
- Bluetooth Low Energy (BLE) support
- 2.4 GHz RF protocol support (including BLE, ANT, and Nordic proprietary protocols)
- Arm Cortex-M4 processor running at 64 MHz
- 512 KB flash memory
- 128 KB RAM
- USB interface
- Numerous digital and analog I/O options
- Multiple interfaces (UART, SPI, I2C, etc.)
- On-chip peripherals (timers, ADC, PWM, etc.)

nRF52833-QIAA:
- Lower RF output power compared to QDAA
- BLE support
- 2.4 GHz RF protocol support (including BLE, ANT, and Nordic proprietary protocols)
- Arm Cortex-M4 processor running at 64 MHz
- 512 KB flash memory
- 128 KB RAM
- USB interface
- Various digital and analog I/O options
- Multiple interfaces (UART, SPI, I2C, etc.)
- On-chip peripherals (timers, ADC, PWM, etc.)

