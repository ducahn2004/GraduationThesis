# STM32Cube_FW_H7_V1.12.1: ST Firmware Package (third-party)

An unmodified copy of **STMicroelectronics' STM32CubeH7 firmware package, version 1.12.1**. It is included so the firmware projects in [`../STM32Embedded`](../STM32Embedded/README.md) can be built offline with the exact library versions used during development.

| Folder | What the project uses from it |
|---|---|
| `Drivers/STM32H7xx_HAL_Driver/` | HAL/LL drivers: I2S, DMA, SDMMC, UART, GPIO, RCC |
| `Drivers/CMSIS/` | Cortex-M7 core headers and **CMSIS-DSP** (`arm_math.h`, biquad filters, RFFT, matrix ops) |
| `Middlewares/Third_Party/FatFs/` | FAT file system for the microSD card |
| `Middlewares/ST/STM32_Audio/` | ST audio middleware (reference) |
| `Projects/` | Official examples for Nucleo/Discovery/Eval boards (I2S, SAI, SDMMC, …) |
| `Utilities/` | BSP helpers and fonts |

- Release notes: [`Release_Notes.html`](Release_Notes.html)
- License: [`Package_license.md`](Package_license.md). Each component keeps its own license (BSD-3-Clause, Apache-2.0, ST SLA0044, …).

> STM32CubeIDE can download this package automatically (*Help → Manage embedded software packages*). If repository size matters, you can delete this folder and let the IDE fetch it.
