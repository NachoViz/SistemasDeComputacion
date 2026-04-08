section .text
    global procesar_gini_asm ; Exportamos la función para que C la vea 

procesar_gini_asm:
    ; --- PRÓLOGO ---
    push rbp            ; Guardamos el marco de la pila anterior
    mov rbp, rsp        ; Establecemos nuestro propio Stack Frame

    ; --- LÓGICA ---
    ; cvttsd2si: Convierte double (xmm0) a entero de 64 bits (rax) truncando la parte decimal.
    cvttsd2si rax, xmm0 
    
    ; Sumamos uno (+1) al índice como pide la consigna
    inc rax             

    ; --- EPÍLOGO ---
    pop rbp             ; Restauramos el puntero base del llamador
    ret                 ; Volvemos a C con el resultado en RAX 
