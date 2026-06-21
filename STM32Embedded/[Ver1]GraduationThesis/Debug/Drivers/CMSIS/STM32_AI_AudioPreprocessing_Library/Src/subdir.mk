################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/common_tables.c \
../Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/dct.c \
../Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/feature_extraction.c \
../Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/mel_filterbank.c \
../Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/window.c 

OBJS += \
./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/common_tables.o \
./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/dct.o \
./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/feature_extraction.o \
./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/mel_filterbank.o \
./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/window.o 

C_DEPS += \
./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/common_tables.d \
./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/dct.d \
./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/feature_extraction.d \
./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/mel_filterbank.d \
./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/window.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/%.o Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/%.su Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/%.cyclo: ../Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/%.c Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_PWR_LDO_SUPPLY -DUSE_HAL_DRIVER -DSTM32H743xx -DARM_MATH_CM7 -D__FPU_PRESENT=1U -c -I"D:/Code/AI/EdgeAI/GT/[Ver1]GraduationThesis/Drivers/CMSIS/DSP/Include" -I"D:/Code/AI/EdgeAI/GT/[Ver1]GraduationThesis/Drivers/CMSIS/DSP/Lib" -I../FATFS/Target -I"D:/Code/AI/EdgeAI/GT/[Ver1]GraduationThesis/Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Inc" -I../FATFS/App -I../X-CUBE-AI/App -I../X-CUBE-AI -I../Core/Inc -I../Middlewares/ST/AI/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FatFs/src -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -include"D:/Code/AI/EdgeAI/GT/[Ver1]GraduationThesis/Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Inc/feature_extraction.h" -include"D:/Code/AI/EdgeAI/GT/[Ver1]GraduationThesis/Drivers/CMSIS/DSP/Include/arm_math.h" -O0 -ffunction-sections -fdata-sections -Wall -mcpu=cortex-m7 -mfpu=fpv5-d16 -mfloat-abi=hard -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-CMSIS-2f-STM32_AI_AudioPreprocessing_Library-2f-Src

clean-Drivers-2f-CMSIS-2f-STM32_AI_AudioPreprocessing_Library-2f-Src:
	-$(RM) ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/common_tables.cyclo ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/common_tables.d ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/common_tables.o ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/common_tables.su ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/dct.cyclo ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/dct.d ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/dct.o ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/dct.su ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/feature_extraction.cyclo ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/feature_extraction.d ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/feature_extraction.o ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/feature_extraction.su ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/mel_filterbank.cyclo ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/mel_filterbank.d ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/mel_filterbank.o ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/mel_filterbank.su ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/window.cyclo ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/window.d ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/window.o ./Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Src/window.su

.PHONY: clean-Drivers-2f-CMSIS-2f-STM32_AI_AudioPreprocessing_Library-2f-Src

