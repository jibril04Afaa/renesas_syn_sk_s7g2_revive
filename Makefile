
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

# linker flags
LDFLAGS  = $(CPU) -nostdlib -T linker/renesas_syn.ld
LDFLAGS += -Wl,--gc-sections -Wl,-Map=$(BUILD_DIR)/$(TARGET).map

# directories
BUILD_DIR = build

# source files
C_SOURCES = \
    main/src/main.c \
    drivers/src/i2c.c \
    drivers/src/spi.c \
    drivers/src/uart.c

ASM_SOURCES = \
    startup/startup_renesas_syn.s

# object files output paths
OBJECTS  = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))

# search paths for source files in subdirectories
vpath %.c main/src drivers/src
vpath %.s startup

all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).bin

$(BUILD_DIR)/%.o: %.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.s | $(BUILD_DIR)
	$(AS) $(ASFLAGS) -c $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) linker/renesas_syn.ld | $(BUILD_DIR)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@
	$(SIZE) $@

$(BUILD_DIR)/$(TARGET).bin: $(BUILD_DIR)/$(TARGET).elf
	$(OBJCOPY) -O binary $< $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)