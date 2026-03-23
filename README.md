# Trabajo Practico 1: El rendimiento de computadoras

## **Consigna:**

Conseguir un esp32 o cualquier procesador al que se le pueda cambiar la frecuencia.
Ejecutar un código que demore alrededor de 10 segundos. Puede ser un bucle for con sumas de enteros por un lado y otro con suma de floats por otro lado.
¿Qué sucede con el tiempo del programa al duplicar la frecuencia ? 

## Objetivo
Analizar cómo afecta la frecuencia del procesador al tiempo de ejecución de un programa, utilizando operaciones con enteros y números flotantes.

---

## Metodología

Se utilizó una placa ESP32, en la cual se ejecutó un programa que realiza una gran cantidad de iteraciones sumando valores:

- Suma de enteros (`int`)
- Suma de números flotantes (`float`)

Se midió el tiempo de ejecución utilizando la función `millis()` y se repitió el experimento con dos frecuencias distintas:

- 80 MHz
- 160 MHz

---

## Resultados

<img src="https://github.com/user-attachments/assets/bf45e428-d217-4e37-84c4-1be5ba0dcff6" width="300">


| Frecuencia | Tiempo (int) | Tiempo (float) |
|----------|-------------|---------------|
| 80 MHz   | 9.88 s      | 11.68 s       |
| 160 MHz  | 4.88 s      | 5.76 s        |

---

## Salida del Monitor

```
=== INICIANDO EXPERIMENTO ===
Se evaluara el tiempo de ejecucion con distintas frecuencias de CPU

>>> Configurando CPU a 80 MHz... 

=================================== 
Frecuencia actual de la CPU: 80 MHz 
=================================== 

[PRUEBA ENTEROS] 
Realizando sumas de enteros... 
Resultado final (int): 70000000 
Tiempo de ejecucion (int): 9.88 segundos 

[PRUEBA FLOTANTES] 
Realizando sumas de numeros flotantes... 
Resultado final (float): 33554432.00 
Tiempo de ejecucion (float): 11.68 segundos 

----------------------------------- 
Fin de pruebas para esta frecuencia 
----------------------------------- 

>>> Configurando CPU a 160 MHz... 

=================================== 
Frecuencia actual de la CPU: 160 MHz 
=================================== 
[PRUEBA ENTEROS] Realizando sumas de enteros... 
Resultado final (int): 70000000 
Tiempo de ejecucion (int): 4.88 segundos 

[PRUEBA FLOTANTES] 
Realizando sumas de numeros flotantes... 
Resultado final (float): 33554432.00 
Tiempo de ejecucion (float): 5.76 segundos 

----------------------------------- 
Fin de pruebas para esta frecuencia 
----------------------------------- 

=== EXPERIMENTO FINALIZADO ===

```

---

## Análisis

Se observa que al duplicar la frecuencia del procesador (de 80 MHz a 160 MHz), el tiempo de ejecución del programa se reduce aproximadamente a la mitad tanto para enteros como para flotantes.

Esto ocurre porque al aumentar la frecuencia, el procesador puede ejecutar más instrucciones por segundo. Sin embargo, la reducción no es exactamente proporcional debido a factores como el acceso a memoria y la sobrecarga del sistema.

También se puede notar que las operaciones con números flotantes tardan más que las de enteros, ya que requieren mayor complejidad de cálculo.

Además, el resultado final de los valores flotantes presenta pérdida de precisión, lo cual es una limitación propia del tipo de dato. Esto se debe a que los float se representan en formato de 32 bits, lo que implica que no pueden almacenar todos los valores con exactitud, especialmente cuando los números son muy grandes. A medida que aumentan las iteraciones, se acumulan pequeños errores de redondeo, lo que termina generando una diferencia notable en el resultado final. Por eso, los valores obtenidos con flotantes no coinciden exactamente con el valor esperado.

---

## Conclusión

Al aumentar la frecuencia del procesador, el tiempo de ejecución del programa disminuye significativamente, aproximadamente de forma proporcional. Esto demuestra la relación directa entre la frecuencia de CPU y el rendimiento.

Sin embargo, existen pequeñas diferencias debido a limitaciones del hardware y del sistema. También se comprobó que las operaciones con números flotantes son más costosas y menos precisas en comparación con las operaciones con enteros.
