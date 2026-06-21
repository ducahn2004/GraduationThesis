################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_bitreversal.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_f32.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q15.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q31.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_f32.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_f32.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q15.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q31.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q15.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q31.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_f32.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_f32.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_f32.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q15.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q31.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q15.c \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q31.c 

S_UPPER_SRCS += \
../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_bitreversal2.S 

OBJS += \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_bitreversal.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_bitreversal2.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_f32.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q15.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q31.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_f32.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_f32.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q15.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q31.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q15.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q31.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_f32.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_f32.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_f32.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q15.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q31.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q15.o \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q31.o 

S_UPPER_DEPS += \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_bitreversal2.d 

C_DEPS += \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_bitreversal.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_f32.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q15.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q31.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_f32.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_f32.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q15.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q31.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q15.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q31.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_f32.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_f32.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_f32.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q15.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q31.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q15.d \
./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q31.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/%.o Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/%.su Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/%.cyclo: ../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/%.c Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m7 -std=gnu11 -g3 -DDEBUG -DUSE_PWR_LDO_SUPPLY -DUSE_HAL_DRIVER -DSTM32H743xx -D__FPU_PRESENT=1U -DARM_MATH_CM7 -c -I../Drivers/CMSIS/Include -I"D:/Code/AI/EdgeAI/GT/TestSTM32H7LED/LogmeLProject/Drivers/CMSIS_DSP/DSP/Include" -I"D:/Code/AI/EdgeAI/GT/TestSTM32H7LED/LogmeLProject/Drivers/CMSIS_DSP/STM32_AI_AudioPreprocessing_Library/Inc" -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/%.o: ../Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/%.S Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m7 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Drivers-2f-CMSIS_DSP-2f-DSP-2f-Source-2f-TransformFunctions

clean-Drivers-2f-CMSIS_DSP-2f-DSP-2f-Source-2f-TransformFunctions:
	-$(RM) ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_bitreversal.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_bitreversal.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_bitreversal.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_bitreversal.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_bitreversal2.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_bitreversal2.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_f32.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_f32.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_f32.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_f32.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q15.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q15.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q15.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q15.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q31.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q31.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q31.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_q31.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_f32.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_f32.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q15.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_init_q31.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q15.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix2_q31.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_f32.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_f32.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q15.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_init_q31.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q15.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix4_q31.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_cfft_radix8_f32.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_f32.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_f32.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_f32.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_f32.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_f32.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_f32.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_f32.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_f32.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q15.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q15.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q15.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q15.su
	-$(RM) ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q31.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q31.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q31.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_init_q31.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q15.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q15.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q15.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q15.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q31.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q31.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q31.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_dct4_q31.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_f32.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_f32.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_f32.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_f32.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_f32.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_f32.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_f32.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_f32.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_fast_init_f32.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_f32.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_f32.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_f32.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_f32.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q15.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q15.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q15.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q15.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q31.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q31.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q31.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_init_q31.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q15.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q15.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q15.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q15.su ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q31.cyclo ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q31.d ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q31.o ./Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/arm_rfft_q31.su

.PHONY: clean-Drivers-2f-CMSIS_DSP-2f-DSP-2f-Source-2f-TransformFunctions

