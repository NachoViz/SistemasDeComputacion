# El Comando "Santo Grial" de GCC para CTFs

Este comando se utiliza en retos de *hacking* (Capture The Flag) para compilar código en C apagando todas las protecciones de seguridad modernas. Esto nos permite tener un entorno predecible y vulnerable, ideal para practicar *Buffer Overflows* y corrupción de memoria.

**Comando completo:**
`gcc -m32 -no-pie -fno-stack-protector -ggdb -mpreferred-stack-boundary=2 -z execstack -o stack1 stack1.c`
**COMANDO SIMPLE**
` gcc -Wno-implicit-function-declaration stack2.c -o stack2`
 
 `objdump -M intel -S stack1`

 (Executable and Linking Format). Con readelf -h es posible ver los campos de la cabecera del archivo, que nos dan información relevante del binario:
 `readelf -h programa` 

 Despues si quiero usar GDB 
 ´sudo apt update
sudo apt install gdb

git clone https://github.com/pwndbg/pwndbg 
  cd pwndbg && ./setup.sh´
---

## Explicación bandera por bandera

* **`gcc`**
  * **Función:** Es el compilador base. Traduce el código fuente en C a código máquina ejecutable.

* **`-m32`**
  * **Función:** Obliga a compilar el binario para la arquitectura x86 de **32 bits**. 
  * **Por qué es clave:** Mantiene el tamaño de los punteros y registros en 4 bytes y conserva la nomenclatura clásica (`EBP`, `ESP`, `EAX`).

* **`-no-pie`**
  * **Función:** Desactiva *Position Independent Executable* (PIE).
  * **Por qué es clave:** Evita que las direcciones de memoria cambien aleatoriamente cada vez que ejecutas el programa (desactiva ASLR a nivel de binario). Así, tu variable `buf` siempre estará en la misma dirección exacta.

* **`-fno-stack-protector`**
  * **Función:** Apaga el **Canario de la Pila** (*Stack Canary*).
  * **Por qué es clave:** El canario es un valor de seguridad colocado antes del *Return Address*. Si lo sobrescribes durante un *Buffer Overflow*, el programa aborta. Al apagarlo, tienes vía libre para pisar el *Return Address* sin que el programa explote prematuramente.

* **`-ggdb`**
  * **Función:** Inyecta información y símbolos de depuración específicos para el depurador **GDB** (GNU Debugger).
  * **Por qué es clave:** Te permite inspeccionar el programa paso a paso, ver el código fuente en C mientras lo ejecutas y revisar el contenido exacto de los registros y la memoria en tiempo real.

* **`-mpreferred-stack-boundary=2`**
  * **Función:** Alinea la memoria de la pila a 4 bytes (2 elevado a la 2).
  * **Por qué es clave:** Evita que el compilador agregue "espacio basura" (padding extra) por capricho de optimización. Así garantizas que los tamaños de memoria en tu diagrama (ej. los 80 bytes de tu `buf`) sean matemáticamente exactos y predecibles.

* **`-z execstack`**
  * **Función:** Hace que la memoria de la pila (*stack*) sea **ejecutable**.
  * **Por qué es clave:** Normalmente, el *stack* solo almacena datos (permisos de lectura/escritura). Esta bandera habilita el permiso de ejecución, lo que te permite inyectar tu propio código malicioso (*shellcode*) dentro de una variable y ordenarle al procesador que lo ejecute.

* **`-o stack1`**
  * **Función:** Define el archivo de salida (*output*). En este caso, el binario ejecutable final se llamará `stack1`.

* **`stack1.c`**
  * **Función:** Es tu archivo de entrada. El código fuente original escrito en C.


# Compilación Simple en Entornos CTF

Si estás resolviendo ejercicios en una máquina virtual diseñada para *hacking* (como Protostar, Exploit Education, o similares), a menudo no necesitas el comando gigante de GCC. Con este comando más simple suele ser suficiente:

**Comando:**
`gcc -Wno-implicit-function-declaration stack2.c -o stack2`

---

## ¿Qué hace este comando?

* **`gcc`**: Llama al compilador de C.
* **`-Wno-implicit-function-declaration`**: Esta es la bandera mágica. Le dice al compilador: *"No me tires errores ni canceles la compilación si uso funciones obsoletas o peligrosas que ya no están en los estándares modernos de C"*. 
  * **Caso de uso:** Es indispensable cuando el código fuente (como `stack2.c`) usa la función **`gets()`**, la cual fue eliminada oficialmente de C por ser extremadamente vulnerable a desbordamientos de búfer (*Buffer Overflows*).
* **`stack2.c`**: Tu archivo de código fuente de entrada.
* **`-o stack2`**: Genera el archivo ejecutable de salida con el nombre `stack2`.

## ¿Por qué funciona el comando simple y no el gigante?

La efectividad de este comando depende completamente de **dónde** estés compilando el programa:

1. **Entornos Vulnerables (Máquinas CTF):** En sistemas operativos antiguos o preparados específicamente para practicar *hacking*, el sistema operativo ya tiene las protecciones modernas (como ASLR o los Canarios de la Pila) **apagadas por defecto**. Por lo tanto, no necesitas pasarle banderas complejas a GCC para desactivarlas; solo necesitas silenciar el error de `gets()`.

2. **Entornos Modernos (Tu propio Kali Linux / Ubuntu actual):** Si usaras este comando simple en una computadora moderna, el programa compilaría, **pero no podrías hackearlo**. El compilador moderno inyectaría escudos de seguridad silenciosamente. Al intentar hacer el *Buffer Overflow*, en lugar de ganar, el programa detectaría el ataque y se cerraría mostrando el error: `*** stack smashing detected ***: terminated`.
