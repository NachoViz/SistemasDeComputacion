# Trabajo Practico 1: El rendimiento de computadoras

## **Ejercicio 1:**

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

| Frecuencia | Tiempo (int) | Tiempo (float) |
|----------|-------------|---------------|
| 80 MHz   | 9.88 s      | 11.68 s       |
| 160 MHz  | 4.88 s      | 5.76 s        |

---

## Salida de Monitor

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

## **Ejercicio 2:**

Armar una lista de benchmarks, ¿cuales les serían más útiles a cada uno ? ¿Cuáles podrían llegar a medir mejor las tareas que ustedes realizan a diario ? 
Pensar en las tareas que cada uno realiza a diario y escribir en una tabla de dos entradas las tareas y que benchmark la representa mejor.

https://openbenchmarking.org/test/pts/build-linux-kernel-1.15.0 
https://www.tomshardware.com/reviews/cpu-hierarchy,4312.html 

cual es el rendimiento de estos procesadores para compilar el kernel
Intel Core i5-13600K (base)
AMD Ryzen 9 5900X 12-Core
Cual es la aceleración cuando usamos un AMD Ryzen 9 7950X 16-Core, cual de ellos hace un uso más eficiente de la cantidad de núcleos que tiene? y cuál es más eficiente en términos de costo (dinero y energía)  ?

Respuestas en benchmarks.md

## **Ejercicio 3:**

### Profiling con gprof:

- Con VM Kali Linux con kernel 6.12.13-amd64 gcc version 14.2.0

<img width="400" alt="gprof1" src="https://github.com/user-attachments/assets/429a80e2-491c-4b11-a15d-17133d44306d" /> <br>

<img width="400" alt="gprof2" src="https://github.com/user-attachments/assets/68b64b8d-628d-42ba-9e41-ed4fa7507691" />

- Tiempo en func1 = 9.52 s (60.23% del porcentaje total del tiempo de ejecución del programa)
- Tiempo en func2 = 5.79 s (36.64% del porcentaje total del tiempo de ejecución del programa)
- Tiempo en main = 0.4 s (2.54% del porcentaje total del tiempo de ejecución del programa)
- Tiempo en new_func1 = 0.12 s (0.76% del porcentaje total del tiempo de ejecución del programa)


Esta tabla describe el árbol de llamadas del programa y fue ordenada por la cantidad total de tiempo empleado en cada función y sus hijos.


El mismo cpu (AMD Ryzen 5 4600G with Radeon Graphics   3.70 GHz - 8 GB RAM) en la tabla de resultados da:

<img width="1000" alt="ryzen5" src="https://github.com/user-attachments/assets/4d62536e-b000-4523-8286-6558d37a8b4f" />

- Tiempo en func1 = 0.97 s 
- Tiempo en func2 = 0.52 s 
- Tiempo en main = 0.04 s 
- Tiempo en new_func1 = 0.64 s 

La diferencia significativa en los tiempos de ejecución se debe a que una de las pruebas fue realizada en una máquina virtual. En este entorno, el acceso al hardware está mediado por el hipervisor, lo que introduce sobrecarga adicional y variabilidad en la asignación de recursos de CPU. Esto provoca que los tiempos de ejecución sean mayores y menos consistentes en comparación con una ejecución en hardware nativo.


### Profiling con Linux pref:

- Con VM Kali Linux con kernel 6.12.13-amd64 y gcc version 14.2.0

Debido a limitaciones del sistema (los eventos de hardware (como cycles) no estaban disponibles o soportados en el entorno utilizado), se utilizó el evento cpu-clock, que mide el tiempo de uso de CPU mediante eventos de software. A diferencia de los eventos de hardware como cycles, este método incluye también actividad del sistema operativo, por lo que los resultados muestran mayor participación del kernel. Sin embargo, permite realizar un análisis válido del comportamiento general del programa.


```
sudo perf record -e cpu-clock ./test_gprof
sudo perf report

```

<img width="500" alt="linuxpref" src="https://github.com/user-attachments/assets/8fccea8b-19a1-48b4-baf2-4f4fa043ef17" />

## Resultados:

Para la VM Kali Linux, por más que los tiempos no sean tan bajos como en un linux nativo para este procesador puntual, se sigue viendo en ambas herramientas de profiling un cuello de botella en la func1 (57% con la VM y 45% en la tabla de resultados) , seguido por la func2 (37% con la VM y 24% en la tabla de resultados) que usa un 20% menos de tiempo pero se diferencian mucho con la new_func1 que representa tan solo un 3.7% (acá si hay diferencia grande ya que en el excel represeenta un 30% lo cual si se compara con otros procesadores si tiene sentido ya que el tiempo en esta funcion normalmente es mucho menor que en la func2). Los resultados de ambas herramientas ses verifican entre ellas. 



