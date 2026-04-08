#include <stdio.h>

// Declaramos la función que vamos a escribir en Assembler.
// Recibe un double (64 bits) y devuelve un long (64 bits).
extern long procesar_gini_asm(double valor);

// Esta función es la que llamará Python usando ctypes.
long puente_python_asm(double valor_gini) {
    // Aquí llamamos a la rutina de bajo nivel.
    long resultado = procesar_gini_asm(valor_gini);
    return resultado;
}
int main() {
    double valor_test = 29.4;
    long res = puente_python_asm(valor_test);
    printf("Resultado: %ld\n", res);
    return 0;
}
