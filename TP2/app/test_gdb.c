#include <stdio.h>

extern long procesar_gini_asm(double valor);

int main() {
    double valor_test = 29.4;
    long resultado = procesar_gini_asm(valor_test);
    printf("Resultado: %ld\n", resultado);
    return 0;
}

