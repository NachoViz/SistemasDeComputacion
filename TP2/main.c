#include <stdio.h>

// función definida en assembler
extern int convertir(float gini);

int main() {
    float gini = 42.7;

    int resultado = convertir(gini);

    printf("GINI original: %.2f\n", gini);
    printf("Resultado (int + 1): %d\n", resultado);

    return 0;
}
