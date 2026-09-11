
TARGET = renesas_s7g2_firmware

# toolchain definitions
CC = arm-none-eabi-gcc # compiler
AS = arm-none-eabi-gcc # assembler
LD = arm-none-eabi-ld # linker
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size

# cpu & fpu flags
CPU = -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard

# compiler flags
CFLAGS = $(CPU) -O0 -g3 -Wall -Wextra -std=gnu11
CFLAGS += -ffunction-sections -fdata-sections
CFLAGS += Iinclude -DCM4
CFLAGS += -Idrivers/inc

# assembler flags
ASFLAGS = $(CPU) -x assembler-with-cpp
