#Clase 1

## Concepto de maquina
4 UNidades logicas para su concepto de maquina
	Memoria
	Entrada/Salida
	ALU
	Mecanismo de decision

## Aspectos claves de la arquitectura von Neumann
1. Las instrucciones y los datos se almacenan en la misma memoria
principal.
2. Se accede a memoria por direccion
3. Ejecucion secuencia de instrucciones, a menos que se programe de otra forma 
4. UNIDIMENSIONAL

### Tipos de instrucciones 
Tres tipos basicos:
	- Movimiento de datos 
	- Transformacion de datos 
	- Control del programa

Para ejecutar instrucciones se debe seguir 2 pasos:
	La siguiente instruccion a ejecutar esta en el (PC), sale de memoria y se almacena el el (IR) [registro de instruccion] en la CPU.
	Luego, la CPU la ejecuta 
	Es decir, un ciclo de obtencion y ejecucion, se denomina ciclo de instruccion

### Limitaciones de Von Neumann
	10 ∗ V_MemPpal = V_CPU → CPU inactivo
	- Cuello de botella de memoria: la separacion de la memoria y la CPU provoca demora al acceder a memoria.
	- Cuello de botella de decodificacion: una instruccion a la vez

#### ARQUITECTURA RISC:
(Reduced Instruction Set Computer)
Es una filosofía de diseño de CPUs que utiliza un conjunto de instrucciones pequeño y altamente optimizado. En lugar de tener una sola instrucción compleja que haga mucho (como "hacer las compras"), tiene muchas instrucciones simples que hacen una sola cosa (como "caminar", "agarrar pan", "pagar").
##### CARACTERISTICAS:
	Instrucciones de tamaño fijo(ej. 32bits)
	Un ciclo por instrucción
	Arquitectura Load/Store: El procesador solo puede operar con datos que ya están en sus registros internos. Si quieres usar un dato de la RAM, primero debes "cargarlo" explícitamente.
	Hardware simple
##### ¿DONDE SE USAN?
Procesadores ARM: Los que tiene tu celular, las tablets y las nuevas Mac (M1/M2/M3).

Sistemas embebidos: Como los microcontroladores que usas en la facultad (Arduino, ESP32, LPC).
_____________________________________________________________________________________________
(PODRIA PONER LA FOTO DE LA ARQUITECTURA)
_____________________________________________________________________________________________

#### ARQUITECTURA CISC:(Complex Instruction Set Computer)
Es una filosofía de diseño de CPUs donde el objetivo es que una sola instrucción haga mucho trabajo. El hardware es más complejo porque se encarga de realizar tareas que en RISC tendría que hacer el programador con varias líneas de código.
##### CARACTERISTICAS:
	Instrucciones de longitud variable: una instrucción puede medir 2 bytes y la siguiente 15 bytes. Esto ahorra memoria.
	Instrucciones multiciclo: Una tarea demora varios ciclos en completarse
	Modos de direccionamiento complejos: La CPU busca directamente de la RAM, sumarlos y guardarlos
	Foco en el Hardware: chip "inteligente"

____________________________________________________________________
FOTO DE LA ARQUITECTURA CISC
____________________________________________________________________

#### Ejemplo concreto: La multiplicación
Imagina que quieres multiplicar dos números que están en la memoria RAM:

En RISC: Tendrías que escribir 4 órdenes: cargar el dato A, cargar el dato B, multiplicarlos en el registro, y guardar el resultado en memoria.

En CISC: Solo escribes una orden: MULT A, B. El hardware del CPU se encarga internamente de ir a buscar los datos, operarlos y devolverlos.
 
## Rendimiento 
Depende de: 
	El lenguaje de programacion
	Compilador
	SO
	Arqui de la maquina
	tecn de fabricion

## Misiones del arquitecto de computadoras es:
1. Seleccionar y organizar el HV (HiperVisor)
2. Seleccionar y organizar el SW (NOSE)
3. Elegir el lenguaje de programacion de alto nivel

### Principales Problematicas
1. Independencia entre el HV y SW 
2. La arquitectura Von Neumann

ACTUALIDAD:
1. Creciemiento exponencial de fabircacion de procesadores mas potentes
2. Problema de compatibilidad EJ: FAMILIA DE PROC INTEL x86

INVESTIGAR PORQUE!!!


## La alternativa para superar las arquitecturas von Neumann
Estas son las arquitecturas paralelas.
Se basan en el n ́umero de flujos de instrucciones y flujos de datos que posee cada sistema computador.
	SISD:.....simple... flujo de instrucciones, ...simple... flujo de datos.
	MISD:..multiples flujos de instrucciones,...simple... flujo de datos.
	SIMD: ...simple.. flujo de instrucciones, multiples flujos de datos.
	MIMD: multiples flujos de instrucciones, multiples flujos de datos.

LUEGO LLEGO
	MTMD: multiples tareas, multiples flujo de datos.

## Computadores SISD
Monoprocesadores convencionales (tipo Von Neumann).
Consiste en una  ́unica Unidad de Proceso (camino de datos) que, recibiendo una secuencia de instrucciones, opera sobre una secuencia de datos.
No presenta ning ́un tipo de paralelismo.
_____________________
FOTO (pag31)
____________________

## Computadoras MISD
(Multiple Instruction, Single Data):
Multiple Instruction (M-I): Hay varias Unidades de Control (UC). Cada una tiene su propio programa o conjunto de instrucciones. O sea, cada procesador está haciendo algo distinto.

Single Data (S-D): Todos esos procesadores están trabajando sobre el mismo y único flujo de datos.
2. ¿Cómo funciona según el diagrama?
Imagina una línea de montaje (el "macrocauce" que menciona el profe Solinas):

Un dato entra al sistema.

El Procesador 1 le aplica la Instrucción A.

El resultado pasa al Procesador 2, que le aplica la Instrucción B.

Así sucesivamente hasta el final.
Es como una cadena de producción donde el producto es el mismo dato que va siendo transformado por distintos operarios, cada uno siguiendo su propio manual de instrucciones.

3. ¿Por qué dice que "no existe una materialización real"?
En la computación moderna, si quieres hacer varias cosas a la vez, lo más eficiente es:

Hacer lo mismo con muchos datos (SIMD - como las Placas de Video/GPUs).

Hacer cosas distintas con datos distintos (MIMD - como los procesadores Multinúcleo de hoy).
Tener muchos procesadores procesando un solo dato suele ser un desperdicio de recursos y genera cuellos de botella. Es muy difícil encontrar un problema matemático que se resuelva mejor así que con las otras arquitecturas.

4. Ejemplo "teórico" (para el examen)
Si el profesor te pide un ejemplo de dónde podría usarse o qué se le parece, puedes mencionar:

Sistemas de tolerancia a fallos (Redundancia): Imagina una computadora de un transbordador espacial. Tienes 3 procesadores distintos que reciben los mismos datos de los sensores. Cada uno procesa la información con algoritmos diferentes. Si los 3 llegan al mismo resultado, el dato es correcto. Si uno difiere, se descarta.

Filtros en cascada: Algoritmos de criptografía o procesamiento de señales donde un dato debe pasar por múltiples etapas de transformación obligatoriamente.

# Resumen: Taxonomía de Flynn (Arquitecturas Paralelas)

[cite_start]A partir de la filmina 31, se detallan las categorías de procesamiento basadas en flujos de instrucciones y datos[cite: 410, 412].

### 1. Computadores SISD (Single Instruction, Single Data)
* [cite_start]**Definición**: Monoprocesadores convencionales tipo von Neumann[cite: 427].
* [cite_start]**Funcionamiento**: Una única Unidad de Proceso opera sobre una secuencia de datos bajo un solo flujo de instrucciones[cite: 428, 429].
* [cite_start]**Paralelismo**: No presenta ningún tipo de paralelismo[cite: 430].

### 2. Computadores MISD (Multiple Instruction, Single Data)
* [cite_start]**Definición**: $n$ unidades de proceso con sus propias unidades de control[cite: 445].
* [cite_start]**Funcionamiento**: Operan sobre el mismo flujo de datos; la salida de un procesador es la entrada del siguiente[cite: 445, 446].
* [cite_start]**Realidad**: No existe ninguna materialización real de esta arquitectura[cite: 472].

### 3. Computadores SIMD (Single Instruction, Multiple Data)
* [cite_start]**Definición**: Una sola Unidad de Control que maneja múltiples Unidades de Proceso[cite: 478].
* [cite_start]**Funcionamiento**: Todas las unidades reciben la misma instrucción pero operan sobre datos distintos[cite: 478].
* [cite_start]**Sincronización**: Funcionan sincronizadas por un reloj global[cite: 496].

### 4. Computadores MIMD (Multiple Instruction, Multiple Data)
* [cite_start]**Definición**: Grupo de monoprocesadores, cada uno con su propia unidad de proceso y memoria[cite: 502].
* [cite_start]**Funcionamiento**: Cada uno tiene su flujo de instrucciones y datos; trabajan en paralelo de forma asíncrona[cite: 503].

#### Clasificación de sistemas MIMD (según gestión de memoria):
* [cite_start]**Memoria compartida**: Todos los procesadores acceden a un espacio común[cite: 543].
* [cite_start]**Memoria distribuida**: Cada procesador tiene su memoria local y se comunican por red[cite: 565].
* [cite_start]**Red de interconexión**: Estructura de red entre nodos de procesamiento[cite: 553].
* [cite_start]**Memoria compartida distribuida**: Sistema híbrido entre las anteriores[cite: 574].
