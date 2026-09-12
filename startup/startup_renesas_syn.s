/* startup_renesas_syn.s startup code */

.syntax unified
.cpu cortex-m4
.thumb

.global g_pfnVectors
.global Reset_Handler

/* linker script symbols
    .word   _estack
    .word   Reset_Handler
 */

.section .isr_vector
.type g_pfnVectors, %object
g_pfnVectors:
    .word   _estack             /* Stack top */
    .word   Reset_Handler       /* Reset Handler */
    .word   NMI_Handler         /* NMI Handler */
    .word   HardFault_Handler   /* Hard Fault Handler */

.size g_pfnVectors, .-g_pfnVectors

.section .text.Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
    /* copy .data section from Flash to SRAM */
    ldr     r0, =_sdata
    ldr     r1, =_edata
    ldr     r2, =_sidata
    movs    r3, #0
    b       .LC_data_check

.LC_data_copy:
    ldr     r4, [r2, r3]
    str     r4, [r0, r3]
    adds    r3, r3, #4

.LC_data_check:
    adds    r4, r0, r3
    cmp     r4, r1
    bcc     .LC_data_copy

    /* zero initialize .bss section in SRAM */
    ldr     r0, =_sbss
    ldr     r1, =_ebss
    movs    r2, #0
    b       .LC_bss_check

.LC_bss_zero:
    str     r2, [r0]
    adds    r0, r0, #4

.LC_bss_check:
    cmp     r0, r1
    bcc     .LC_bss_zero

    /* branch directly to main */
    bl      main

    /* infinite loop if main ever returns */
.L_infinite_loop:
    b       .L_infinite_loop
.size Reset_Handler, .-Reset_Handler

/* default weak handlers for unhandled faults */
.weak NMI_Handler
.thumb_set NMI_Handler, Default_Handler

.weak HardFault_Handler
.thumb_set HardFault_Handler, Default_Handler

.section .text.Default_Handler,"ax",%progbits
Default_Handler:
    b       .
.size Default_Handler, .-Default_Handler