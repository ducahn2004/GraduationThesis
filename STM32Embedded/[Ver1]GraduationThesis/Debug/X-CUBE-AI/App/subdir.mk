################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../X-CUBE-AI/App/app_x-cube-ai.c \
../X-CUBE-AI/App/network.c \
../X-CUBE-AI/App/network_3.c \
../X-CUBE-AI/App/network_3_data.c \
../X-CUBE-AI/App/network_3_data_params.c \
../X-CUBE-AI/App/network_4.c \
../X-CUBE-AI/App/network_4_data.c \
../X-CUBE-AI/App/network_4_data_params.c \
../X-CUBE-AI/App/network_data.c \
../X-CUBE-AI/App/network_data_params.c 

OBJS += \
./X-CUBE-AI/App/app_x-cube-ai.o \
./X-CUBE-AI/App/network.o \
./X-CUBE-AI/App/network_3.o \
./X-CUBE-AI/App/network_3_data.o \
./X-CUBE-AI/App/network_3_data_params.o \
./X-CUBE-AI/App/network_4.o \
./X-CUBE-AI/App/network_4_data.o \
./X-CUBE-AI/App/network_4_data_params.o \
./X-CUBE-AI/App/network_data.o \
./X-CUBE-AI/App/network_data_params.o 

C_DEPS += \
./X-CUBE-AI/App/app_x-cube-ai.d \
./X-CUBE-AI/App/network.d \
./X-CUBE-AI/App/network_3.d \
./X-CUBE-AI/App/network_3_data.d \
./X-CUBE-AI/App/network_3_data_params.d \
./X-CUBE-AI/App/network_4.d \
./X-CUBE-AI/App/network_4_data.d \
./X-CUBE-AI/App/network_4_data_params.d \
./X-CUBE-AI/App/network_data.d \
./X-CUBE-AI/App/network_data_params.d 


# Each subdirectory must supply rules for building sources it contributes
X-CUBE-AI/App/%.o X-CUBE-AI/App/%.su X-CUBE-AI/App/%.cyclo: ../X-CUBE-AI/App/%.c X-CUBE-AI/App/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_PWR_LDO_SUPPLY -DUSE_HAL_DRIVER -DSTM32H743xx -DARM_MATH_CM7 -D__FPU_PRESENT=1U -c -I"D:/Code/AI/EdgeAI/GT/[Ver1]GraduationThesis/Drivers/CMSIS/DSP/Include" -I"D:/Code/AI/EdgeAI/GT/[Ver1]GraduationThesis/Drivers/CMSIS/DSP/Lib" -I../FATFS/Target -I"D:/Code/AI/EdgeAI/GT/[Ver1]GraduationThesis/Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Inc" -I../FATFS/App -I../X-CUBE-AI/App -I../X-CUBE-AI -I../Core/Inc -I../Middlewares/ST/AI/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FatFs/src -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -include"D:/Code/AI/EdgeAI/GT/[Ver1]GraduationThesis/Drivers/CMSIS/STM32_AI_AudioPreprocessing_Library/Inc/feature_extraction.h" -include"D:/Code/AI/EdgeAI/GT/[Ver1]GraduationThesis/Drivers/CMSIS/DSP/Include/arm_math.h" -O0 -ffunction-sections -fdata-sections -Wall -mcpu=cortex-m7 -mfpu=fpv5-d16 -mfloat-abi=hard -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-X-2d-CUBE-2d-AI-2f-App

clean-X-2d-CUBE-2d-AI-2f-App:
	-$(RM) ./X-CUBE-AI/App/app_x-cube-ai.cyclo ./X-CUBE-AI/App/app_x-cube-ai.d ./X-CUBE-AI/App/app_x-cube-ai.o ./X-CUBE-AI/App/app_x-cube-ai.su ./X-CUBE-AI/App/network.cyclo ./X-CUBE-AI/App/network.d ./X-CUBE-AI/App/network.o ./X-CUBE-AI/App/network.su ./X-CUBE-AI/App/network_3.cyclo ./X-CUBE-AI/App/network_3.d ./X-CUBE-AI/App/network_3.o ./X-CUBE-AI/App/network_3.su ./X-CUBE-AI/App/network_3_data.cyclo ./X-CUBE-AI/App/network_3_data.d ./X-CUBE-AI/App/network_3_data.o ./X-CUBE-AI/App/network_3_data.su ./X-CUBE-AI/App/network_3_data_params.cyclo ./X-CUBE-AI/App/network_3_data_params.d ./X-CUBE-AI/App/network_3_data_params.o ./X-CUBE-AI/App/network_3_data_params.su ./X-CUBE-AI/App/network_4.cyclo ./X-CUBE-AI/App/network_4.d ./X-CUBE-AI/App/network_4.o ./X-CUBE-AI/App/network_4.su ./X-CUBE-AI/App/network_4_data.cyclo ./X-CUBE-AI/App/network_4_data.d ./X-CUBE-AI/App/network_4_data.o ./X-CUBE-AI/App/network_4_data.su ./X-CUBE-AI/App/network_4_data_params.cyclo ./X-CUBE-AI/App/network_4_data_params.d ./X-CUBE-AI/App/network_4_data_params.o ./X-CUBE-AI/App/network_4_data_params.su ./X-CUBE-AI/App/network_data.cyclo ./X-CUBE-AI/App/network_data.d ./X-CUBE-AI/App/network_data.o ./X-CUBE-AI/App/network_data.su ./X-CUBE-AI/App/network_data_params.cyclo ./X-CUBE-AI/App/network_data_params.d ./X-CUBE-AI/App/network_data_params.o ./X-CUBE-AI/App/network_data_params.su

.PHONY: clean-X-2d-CUBE-2d-AI-2f-App

