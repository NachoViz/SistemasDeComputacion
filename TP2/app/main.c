#include <stdio.h>
#include <stdlib.h>

// Función de prueba que simula al Assembler
// Recibe el float, lo hace entero y le suma 1
long procesar_gini_simulado(double valor) {
    long entero = (long)valor; // Conversión de float a entero [cite: 25]
    return entero + 1;         // Sumamos uno (+1) [cite: 25]
}

int main(int argc, char *argv[]) {
    // Verificamos que Python (o nosotros) pase un argumento
    if (argc < 2) {
        printf("Uso: %s <valor_gini>\n", argv[0]);
        return 1;
    }

    // Convertimos el argumento de texto a double (número)
    double gini_recuperado = atof(argv[1]);

    // Llamamos a la función (aquí es donde luego irá el ASM)
    long resultado = procesar_gini_simulado(gini_recuperado);

    // Mostramos los datos obtenidos
    printf("Entrada (float): %f\n", gini_recuperado);
    printf("Resultado (Entero + 1): %ld\n", resultado);

    return 0;
}
