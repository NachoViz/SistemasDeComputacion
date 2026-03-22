# Registros del Procesador x86 (32 bits)

Este documento resume los registros más importantes de la arquitectura x86 de 32 bits y su rol en la memoria y ejecución de programas. La letra **"E"** al inicio de cada registro significa **"Extended"** (Extendido), indicando que son la versión de 32 bits.

> **Nota:** En arquitecturas modernas de 64 bits, la "E" se reemplaza por una "R" (por ejemplo: RBP, RSP, RAX).

---

## 1. Punteros de Pila y Control (Stack & Control Flow)

* **EBP (Extended Base Pointer)**
  * **Significado:** Puntero Base Extendido.
  * **Uso:** Sirve como un ancla fija para el *Stack Frame* (marco de pila) al llamar a una función. Permite al programa encontrar fácilmente los parámetros (arriba del EBP) y las variables locales (debajo del EBP) sin importar cómo cambie el tope de la pila.
* **ESP (Extended Stack Pointer)**
  * **Significado:** Puntero de Pila Extendido.
  * **Uso:** Apunta siempre al **tope actual** de la pila. Se actualiza constantemente al meter (`PUSH`) o sacar (`POP`) datos de la memoria.
* **EIP (Extended Instruction Pointer)**
  * **Significado:** Puntero de Instrucción Extendido.
  * **Uso:** Contiene la dirección de memoria de la **siguiente instrucción** que el procesador debe ejecutar. No se modifica manualmente; el hardware lo actualiza de forma automática.

## 2. Índices para Manejo de Memoria

* **ESI (Extended Source Index)**
  * **Significado:** Índice de Origen Extendido.
  * **Uso:** Puntero utilizado para leer datos de la memoria. Es muy común al copiar bloques completos de datos o cadenas de texto.
* **EDI (Extended Destination Index)**
  * **Significado:** Índice de Destino Extendido.
  * **Uso:** Es la pareja del ESI. Apunta a la dirección de memoria en donde se van a escribir o pegar los datos que se están copiando.

## 3. Registros de Propósito General (Cálculos y Lógica)

* **EAX (Extended Accumulator Register)**
  * **Significado:** Registro Acumulador.
  * **Uso:** Es el registro principal para operaciones aritméticas (sumas, restas, etc.). Además, **siempre almacena el valor de retorno** cuando una función termina su ejecución.
* **EBX (Extended Base Register)**
  * **Significado:** Registro Base.
  * **Uso:** Se usa comúnmente para guardar direcciones de memoria base, lo cual es útil al acceder y recorrer arreglos (arrays) o estructuras de datos complejas.
* **ECX (Extended Counter Register)**
  * **Significado:** Registro Contador.
  * **Uso:** Se utiliza como contador para bucles (`loops`). Empieza en un número y va disminuyendo hasta llegar a cero para repetir una acción.
* **EDX (Extended Data Register)**
  * **Significado:** Registro de Datos.
  * **Uso:** Funciona como apoyo directo para el EAX en operaciones matemáticas grandes (como multiplicaciones y divisiones que no caben en un solo registro) y también maneja operaciones de entrada/salida (I/O).

objdump -M intel -S stack1
