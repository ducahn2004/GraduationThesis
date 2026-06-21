################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include Drivers/STM32H7xx_HAL_Driver/Src/subdir.mk
-include Drivers/CMSIS_DSP/STM32_AI_AudioPreprocessing_Library/Src/subdir.mk
-include Drivers/CMSIS_DSP/STM32_AI_AudioPreprocessing_Library/Examples/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Source/TransformFunctions/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Source/SupportFunctions/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Source/StatisticsFunctions/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Source/MatrixFunctions/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Source/FilteringFunctions/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Source/FastMathFunctions/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Source/ControllerFunctions/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Source/ComplexMathFunctions/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Source/CommonTables/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Source/BasicMathFunctions/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Source/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Examples/ARM/arm_variance_example/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Examples/ARM/arm_sin_cos_example/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Examples/ARM/arm_signal_converge_example/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Examples/ARM/arm_matrix_example/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Examples/ARM/arm_linear_interp_example/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Examples/ARM/arm_graphic_equalizer_example/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Examples/ARM/arm_fir_example/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Examples/ARM/arm_fft_bin_example/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Examples/ARM/arm_dotproduct_example/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Examples/ARM/arm_convolution_example/subdir.mk
-include Drivers/CMSIS_DSP/DSP/Examples/ARM/arm_class_marks_example/subdir.mk
-include Core/Startup/subdir.mk
-include Core/Src/subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

OPTIONAL_TOOL_DEPS := \
$(wildcard ../makefile.defs) \
$(wildcard ../makefile.init) \
$(wildcard ../makefile.targets) \


BUILD_ARTIFACT_NAME := LogmeLProject
BUILD_ARTIFACT_EXTENSION := elf
BUILD_ARTIFACT_PREFIX :=
BUILD_ARTIFACT := $(BUILD_ARTIFACT_PREFIX)$(BUILD_ARTIFACT_NAME)$(if $(BUILD_ARTIFACT_EXTENSION),.$(BUILD_ARTIFACT_EXTENSION),)

# Add inputs and outputs from these tool invocations to the build variables 
EXECUTABLES += \
LogmeLProject.elf \

MAP_FILES += \
LogmeLProject.map \

SIZE_OUTPUT += \
default.size.stdout \

OBJDUMP_LIST += \
LogmeLProject.list \


# All Target
all: main-build

# Main-build Target
main-build: LogmeLProject.elf secondary-outputs

# Tool invocations
LogmeLProject.elf LogmeLProject.map: $(OBJS) $(USER_OBJS) D:\Code\AI\EdgeAI\GT\TestSTM32H7LED\LogmeLProject\STM32H743VITX_FLASH.ld makefile objects.list $(OPTIONAL_TOOL_DEPS)
	arm-none-eabi-gcc -o "LogmeLProject.elf" @"objects.list" $(USER_OBJS) $(LIBS) -mcpu=cortex-m7 -T"D:\Code\AI\EdgeAI\GT\TestSTM32H7LED\LogmeLProject\STM32H743VITX_FLASH.ld" --specs=nosys.specs -Wl,-Map="LogmeLProject.map" -Wl,--gc-sections -static -L"D:\Code\AI\EdgeAI\GT\TestSTM32H7LED\LogmeLProject\Drivers\CMSIS_DSP\STM32_AI_AudioPreprocessing_Library\Inc" -L"D:\Code\AI\EdgeAI\GT\TestSTM32H7LED\LogmeLProject\Drivers\CMSIS_DSP\Lib\GCC" -L"D:\Code\AI\EdgeAI\GT\TestSTM32H7LED\LogmeLProject\Drivers\CMSIS_DSP\DSP\Include" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -u _scanf_float -Wl,--start-group -lc -lm -Wl,--end-group
	@echo 'Finished building target: $@'
	@echo ' '

default.size.stdout: $(EXECUTABLES) makefile objects.list $(OPTIONAL_TOOL_DEPS)
	arm-none-eabi-size  $(EXECUTABLES)
	@echo 'Finished building: $@'
	@echo ' '

LogmeLProject.list: $(EXECUTABLES) makefile objects.list $(OPTIONAL_TOOL_DEPS)
	arm-none-eabi-objdump -h -S $(EXECUTABLES) > "LogmeLProject.list"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) LogmeLProject.elf LogmeLProject.list LogmeLProject.map default.size.stdout
	-@echo ' '

secondary-outputs: $(SIZE_OUTPUT) $(OBJDUMP_LIST)

fail-specified-linker-script-missing:
	@echo 'Error: Cannot find the specified linker script. Check the linker settings in the build configuration.'
	@exit 2

warn-no-linker-script-specified:
	@echo 'Warning: No linker script specified. Check the linker settings in the build configuration.'

.PHONY: all clean dependents main-build fail-specified-linker-script-missing warn-no-linker-script-specified

-include ../makefile.targets
