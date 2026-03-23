# Benchmarks y rendimiento de computadores

## Introducción

Este trabajo analiza distintos benchmarks utilizados para evaluar el rendimiento de sistemas computacionales.
## Benchmarks

Un benchmark es una herramienta o conjunto de pruebas que se utiliza para medir el rendimiento de un sistema computacional. Permiten comparar distintos procesadores, memorias o configuraciones bajo condiciones similares, con el objetivo de evaluar cuál tiene mejor desempeño según la tarea.

Dependiendo del tipo de benchmark, se pueden medir distintos aspectos como la capacidad de cálculo, el rendimiento en tareas reales (por ejemplo compilar código), o el desempeño gráfico. Por eso no existe un único benchmark, sino que su utilidad depende de qué se quiera analizar.

## Lista de benchmarks

Algunos benchmarks conocidos y útiles son:

- **Compilación del kernel de Linux**: mide el rendimiento del procesador en una tarea real de desarrollo. Es muy utilizado porque involucra uso intensivo de CPU, memoria y acceso a disco.
  
- **Geekbench**: evalúa el rendimiento general del sistema mediante distintas pruebas sintéticas, tanto en tareas de un solo núcleo como en múltiples núcleos.
  
- **Cinebench**: se basa en el renderizado de imágenes 3D y es útil para medir el rendimiento en aplicaciones de diseño y gráficos.
  
- **Linpack**: mide la capacidad de cálculo numérico del sistema, muy usado en aplicaciones científicas e ingeniería.
  
- **Phoronix Test Suite**: es una colección de benchmarks para Linux que permite evaluar distintos aspectos del sistema, incluyendo CPU, memoria y almacenamiento.
  

## Relación con tareas diarias

Para elegir un benchmark adecuado, es importante considerar las tareas que realiza cada usuario. En este caso, se analizan las actividades más comunes de cada integrante del grupo y el benchmark que mejor las representa.

| Integrante | Tareas habituales | Benchmark representativo y justificación |
|-----------|------------------|------------------------------------------|
| Nacho (Ing. en Computación) | Programación en C/C++ y jugar al LoL | **Compilación del kernel de Linux / Geekbench**. La compilación representa bien la carga de trabajo al programar, mientras que Geekbench permite evaluar el rendimiento general del sistema y en múltiples núcleos, útil para aplicaciones exigentes. |
| Sofi (Ing. en Computación) | Desarrollo de software, uso de entornos de programación y manejo de múltiples aplicaciones en simultáneo | **Geekbench**. Este benchmark mide el rendimiento general del sistema en tareas variadas, lo que lo hace representativo para uso multitarea y desarrollo. |
| Juli (Ing. Electrónica) | Simulación de circuitos (LTspice), análisis de señales y cálculos numéricos | **Linpack**. Este benchmark mide la capacidad de cálculo numérico del procesador, que es clave en simulaciones y análisis típicos de ingeniería electrónica. |

De esta forma, se puede elegir el benchmark que mejor represente el uso real del sistema y obtener resultados más relevantes.


## Comparación de procesadores

Para analizar el rendimiento de distintos procesadores se utiliza el benchmark de compilación del kernel de Linux, el cual representa una carga de trabajo real y exigente para el sistema.

Se comparan los siguientes procesadores:

- Intel Core i5-13600K  
- AMD Ryzen 9 5900X 12-Core  

Este benchmark mide el tiempo necesario para compilar el kernel, por lo que un menor tiempo implica un mejor rendimiento.

A partir de los resultados obtenidos en la plataforma Phoronix (se buscaron otros procesadores similares), se observa que:

- Intel Core i5-12400F: aproximadamente 167 segundos
- AMD Ryzen 9 7950X: aproximadamente 59 segundos

Esto indica que el Ryzen 9 7950X presenta un rendimiento significativamente superior en la compilación del kernel de Linux, ya que requiere mucho menos tiempo para completar la tarea.

## Aceleración

Para evaluar la mejora de rendimiento al utilizar un procesador más avanzado, se calcula la aceleración tomando como referencia el tiempo de compilación del procesador base.

En este caso, se compara el Intel Core i5-12400F con el AMD Ryzen 9 7950X:

Aceleración = Tiempo base / Tiempo mejorado

Aceleración = 167 / 59 ≈ 2.83

Esto indica que el AMD Ryzen 9 7950X es aproximadamente 2.8 veces más rápido que el procesador base en la compilación del kernel de Linux.

Esta mejora se debe principalmente a la mayor cantidad de núcleos e hilos, lo que permite una mayor paralelización del proceso de compilación.

## Conclusión

A partir del análisis realizado, se puede observar que el rendimiento de un procesador depende en gran medida del tipo de tarea a ejecutar. En particular, para tareas como la compilación del kernel de Linux, los procesadores con mayor cantidad de núcleos presentan una ventaja significativa debido a la posibilidad de paralelizar el trabajo.

Asimismo, el uso de benchmarks permite tomar decisiones más informadas al momento de elegir hardware, ya que brindan una referencia objetiva del rendimiento en distintos escenarios.
