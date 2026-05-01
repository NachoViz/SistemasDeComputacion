.code16
.global _start

.equ CODE_SEG, 0x08
.equ DATA_SEG, 0x10

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

gdt_null:
    .long 0x0
    .long 0x0

# -------------------------
# CODE SEGMENT (0 → 2GB)
# -------------------------
gdt_code:
    .word 0xffff
    .word 0x0000
    .byte 0x00
    .byte 0x9A
    .byte 0xC7   # 2GB
    .byte 0x00

# -------------------------
# DATA SEGMENT (2GB → 4GB)
# -------------------------
gdt_data:
    .word 0xffff
    .word 0x0000
    .byte 0x80   # base = 0x80000000
    .byte 0x92
    .byte 0xC7   # 2GB
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

    # DATA (alto)
    mov $DATA_SEG, %ax
    mov %ax, %ds
    mov %ax, %ss

    # CODE (base 0)
    mov $CODE_SEG, %ax
    mov %ax, %es

    mov $0x7000, %ebp
    mov %ebp, %esp

    # guardar GDTR
    sgdt %es:gdtr_dump

    call clear_screen
    call print_message

hang:
    jmp hang


# =========================================================
# LIMPIAR PANTALLA
# =========================================================

clear_screen:
    mov $0xB8000, %edi
    mov $2000, %ecx
    mov $0x0720, %ax

clear_loop:
    mov %ax, %es:(%edi)   # usaso de es para base 0
    add $2, %edi
    loop clear_loop
    ret


# =========================================================
# IMPRIMIR MENSAJE
# =========================================================

print_message:

    mov $msg, %esi
    mov $0xB8000 + 160*12 + 15*2, %edi

print_loop:
    mov %es:(%esi), %al   # leer desde segmento de código
    inc %esi
    test %al, %al
    jz done

    mov $0x07, %ah        # color fijo
    mov %ax, %es:(%edi)

    add $2, %edi
    jmp print_loop

done:
    ret


# =========================================================
# DATA
# =========================================================

msg:
    .asciz "Segmentacion 2GB codigo / 2GB datos OK"

gdtr_dump:
    .space 6
