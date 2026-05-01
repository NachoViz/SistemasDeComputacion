.code16
.global _start

.equ CODE_SEG, 0x08
.equ DATA_SEG, 0x10

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

gdt_null:
    .long 0x0
    .long 0x0

# -------------------------
# CODE (0 → 2GB)
# -------------------------
gdt_code:
    .word 0xffff
    .word 0x0000
    .byte 0x00
    .byte 0x9A
    .byte 0xC7
    .byte 0x00

# -------------------------
# DATA (2GB → 4GB) READ ONLY
# -------------------------
gdt_data:
    .word 0xffff
    .word 0x0000
    .byte 0x80
    .byte 0x90     
    .byte 0xC7
    .byte 0x00

gdt_end:

gdt_descriptor:
    .word gdt_end - gdt_start - 1
    .long gdt_start


# =========================================================
# PROTECTED MODE
# =========================================================

.code32
protected_mode:

    # DS → datos (READ ONLY)
    mov $DATA_SEG, %ax
    mov %ax, %ds
    mov %ax, %ss

    # ES → base 0
    mov $CODE_SEG, %ax
    mov %ax, %es

    mov $0x7000, %esp

    # guardar GDTR en memoria baja
    sgdt %es:gdtr_dump

    call clear_screen
    call print_message

    call romper

hang:
    jmp hang


# =========================================================
# ROMPER (genera #GP)
# =========================================================

romper:

    mov $0x00000000, %edi

    movb $0x41, (%edi)

    ret

# =========================================================
# LIMPIAR PANTALLA
# =========================================================

clear_screen:
    mov $0xB8000, %edi
    mov $2000, %ecx
    mov $0x0720, %ax

clear_loop:
    mov %ax, %es:(%edi)
    add $2, %edi
    loop clear_loop
    ret


# =========================================================
# PRINT
# =========================================================

print_message:

    mov $msg, %esi
    mov $0xB8000 + 160*12 + 15*2, %edi

print_loop:
    mov %es:(%esi), %al
    inc %esi
    test %al, %al
    jz done

    mov $0x07, %ah
    mov %ax, %es:(%edi)

    add $2, %edi
    jmp print_loop

done:
    ret


# =========================================================
# DATA
# =========================================================

msg:
    .asciz "Antes del fallo (#GP)"

gdtr_dump:
    .space 6
