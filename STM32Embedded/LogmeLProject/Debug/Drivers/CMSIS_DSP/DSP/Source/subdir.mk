################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/CMSIS_DSP/DSP/Source/math_helper.c 

OBJS += \
./Drivers/CMSIS_DSP/DSP/Source/math_helper.o 

C_DEPS += \
./Drivers/CMSIS_DSP/DSP/Source/math_helper.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/CMSIS_DSP/DSP/Source/%.o Drivers/CMSIS_DSP/DSP/Source/%.su Drivers/CMSIS_DSP/DSP/Source/%.cyclo: ../Drivers/CMSIS_DSP/DSP/Source/%.c Drivers/CMSIS_DSP/DSP/Source/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_PWR_LDO_SUPPLY -DUSE_HAL_DRIVER -DSTM32H743xx -D__FPU_PRESENT=1U -DARM_MATH_CM7 -c -I../Drivers/CMSIS/Include -I"D:/Code/AI/EdgeAI/GT/TestSTM32H7LED/LogmeLProject/Drivers/CMSIS_DSP/DSP/Include" -I"D:/Code/AI/EdgeAI/GT/TestSTM32H7LED/LogmeLProject/Drivers/CMSIS_DSP/STM32_AI_AudioPreprocessing_Library/Inc" -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-CMSIS_DSP-2f-DSP-2f-Source

clean-Drivers-2f-CMSIS_DSP-2f-DSP-2f-Source:
	-$(RM) ./Drivers/CMSIS_DSP/DSP/Source/math_helper.cyclo ./Drivers/CMSIS_DSP/DSP/Source/math_helper.d ./Drivers/CMSIS_DSP/DSP/Source/math_helper.o ./Drivers/CMSIS_DSP/DSP/Source/math_helper.su

.PHONY: clean-Drivers-2f-CMSIS_DSP-2f-DSP-2f-Source

