ENTRY(Reset_Handler)

MEMORY
{
    FLASH(rx): ORIGIN = 0x00000000, LENGTH = 4M /* On-chip flash (program flash) */
    SRAM(rwx): ORIGIN = 0x20000000, LENGTH = 512KB  /* SRAM0(224KB) + SRAM1 (256KB) +SRAM0 DED area (32KB) */
}

SECTIONS
{
    /* .text sections contains program code & read-only data */
    .text:
    {
        KEEP(*(.isr_vector))
        *(.text*)   /* Program code */
        *(.rodata*) /* Read-only data */
        . = ALIGN(4);
        _etext = .; /* Define a symbol for the end of the text section */
    } > FLASH

    .data:
    {
        _sdata = .; /* symbol for the start of the .data section */
        *(.data*)
        . = ALIGN(4);
        _edata = .; /* symbol for the end of the .data section */
    } > SRAM AT > FLASH /* execution address is SRAM, storage address is FLASH */

    .bss:
    {
        _sbss = .; /* start of .bss section */
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .; /* end of .bss section */
    } > SRAM

    _estack = ORIGIN(SRAM) + LENGTH(SRAM);
}