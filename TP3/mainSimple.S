.code16
.global _start
# =========================================================
# CONSTANTES LÓGICAS
# =========================================================
    .equ CODE_SEG, 8
    .equ DATA_SEG, gdt_data - gdt_start

# =========================================================
# ENTRY
# =========================================================
_start:
    cli

    lgdt gdt_descriptor

    mov %cr0, %eax
    orl $0x1, %eax
    mov %eax, %cr0

    ljmp $CODE_SEG, $protected_mode

# =========================================================
# GDT
# =========================================================
gdt_start:

# -------------------------
# CODE SEGMENT 
# -------------------------
gdt_null:
    .long 0x0
    .long 0x0
gdt_code:
    .word 0xffff
    .word 0x0
    .byte 0x0
    .byte 0b10011010
    .byte 0b11001111
    .byte 0x0

# -------------------------
# DATA SEGMENT
# -------------------------    
gdt_data:
    .word 0xffff
    .word 0x0
    .byte 0x0
    .byte 0b10010010
    .byte 0b11001111
    .byte 0x0

gdt_end:

gdt_descriptor:
    .word gdt_end - gdt_start
    .long gdt_start

vga_current_line:
    .long 0

# =========================================================
# PROTECTED MODE
# =========================================================

.code32
protected_mode:

    mov $DATA_SEG, %ax
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs
    mov %ax, %ss

    mov $0X7000, %ebp
    mov %ebp, %esp

    sgdt gdtr_dump

    call clear_screen
    call print_message

hang:
    jmp hang

# -----------------------
# LIMPIAR PANTALLA
# -----------------------

clear_screen:
    mov $0xB8000, %edi
    mov $2000, %ecx
    mov $0x0020, %ax

clear_loop:
    mov %ax, (%edi)
    add $2, %edi
    loop clear_loop
    ret

# -----------------------
# IMPRIMIR MENSAJE
# -----------------------

print_message:

    mov $msg, %esi
    mov $0xB8000 + 160*12 + 15*2, %edi
    mov $colors, %ebx

print_loop:
    lodsb
    test %al, %al
    jz done

    mov (%ebx), %ah
    mov %ax, (%edi)

    add $1, %ebx
    add $2, %edi
    jmp print_loop

done:
    ret

# -----------------------
# DATA
# -----------------------

msg:
    .asciz "Profe estamos para un 10 no? :)"

colors:
    .byte 0x07,0x0F,0x0E,0x0A,0x0B,0x0D,0x0F,0x07,0x0E,0x0A
    .byte 0x0B,0x0D,0x0F,0x07,0x0E,0x0A,0x0B,0x0D,0x0F,0x07
    .byte 0x0E,0x0A,0x0B,0x0D,0x0F,0x07,0x0E,0x0A,0x0B,0x00

gdtr_dump:
    .space 6
