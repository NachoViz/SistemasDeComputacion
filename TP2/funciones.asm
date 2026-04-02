section .text
    global convertir

convertir:
    push ebp
    mov ebp, esp

    sub esp, 4          ; reservar espacio en el stack

    fld dword [ebp+8]   ; cargar float
    fistp dword [esp]   ; convertir a int y guardar

    mov eax, [esp]      ; mover resultado a eax
    add eax, 1

    mov esp, ebp
    pop ebp
    ret
