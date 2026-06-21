################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/Code/AI/EdgeAI/GT/TestSTM32H7LED/SDCard/FATFS/Target/bsp_driver_sd.c \
D:/Code/AI/EdgeAI/GT/TestSTM32H7LED/SDCard/FATFS/Target/sd_diskio.c 

OBJS += \
./Application/User/FATFS/Target/bsp_driver_sd.o \
./Application/User/FATFS/Target/sd_diskio.o 

C_DEPS += \
./Application/User/FATFS/Target/bsp_driver_sd.d \
./Application/User/FATFS/Target/sd_diskio.d 


# Each subdirectory must supply rules for building sources it contributes
Application/User/FATFS/Target/bsp_driver_sd.o: D:/Code/AI/EdgeAI/GT/TestSTM32H7LED/SDCard/FATFS/Target/bsp_driver_sd.c Application/User/FATFS/Target/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_PWR_LDO_SUPPLY -DUSE_HAL_DRIVER -DSTM32H743xx -c -I../../FATFS/Target -I../../FATFS/App -I../../Core/Inc -I../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../../Middlewares/Third_Party/FatFs/src -I../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
Application/User/FATFS/Target/sd_diskio.o: D:/Code/AI/EdgeAI/GT/TestSTM32H7LED/SDCard/FATFS/Target/sd_diskio.c Application/User/FATFS/Target/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_PWR_LDO_SUPPLY -DUSE_HAL_DRIVER -DSTM32H743xx -c -I../../FATFS/Target -I../../FATFS/App -I../../Core/Inc -I../../Drivers/STM32H7xx_HAL_Driver/Inc -I../../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../../Middlewares/Third_Party/FatFs/src -I../../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Application-2f-User-2f-FATFS-2f-Target

clean-Application-2f-User-2f-FATFS-2f-Target:
	-$(RM) ./Application/User/FATFS/Target/bsp_driver_sd.cyclo ./Application/User/FATFS/Target/bsp_driver_sd.d ./Application/User/FATFS/Target/bsp_driver_sd.o ./Application/User/FATFS/Target/bsp_driver_sd.su ./Application/User/FATFS/Target/sd_diskio.cyclo ./Application/User/FATFS/Target/sd_diskio.d ./Application/User/FATFS/Target/sd_diskio.o ./Application/User/FATFS/Target/sd_diskio.su

.PHONY: clean-Application-2f-User-2f-FATFS-2f-Target

