# 🛠️ Cheat Sheet: Herramientas para Escritura de Exploits
*Basado en la Guía de la Fundación Sadosky*

---

## 1. GCC (Compilador GNU C)
Se utiliza para compilar el código. Para prácticas de explotación, es crucial usar banderas que desactiven las protecciones modernas de Linux.

* **Compilar un binario ejecutable normal:**
  `gcc -o ejecutable codigo.c`

* **Generar código Assembler (sin compilar el ejecutable):**
  `gcc -S -masm=intel -o programa.s codigo.c`

* **Compilar un binario VULNERABLE (Ideal para exploits):**
  `gcc -m32 -fno-stack-protector -ggdb -mpreferred-stack-boundary=2 -z execstack -o programa programa.c`
  
  *Explicación de las flags:*
  * `-m32`: Compila el programa en arquitectura de 32 bits.
  * `-fno-stack-protector`: Desactiva la protección contra *buffer overflow* (Stack Canary).
  * `-z execstack`: Hace que la pila (stack) sea ejecutable (desactiva NX).
  * `-ggdb`: Agrega símbolos de depuración para que GDB pueda leer el código fuente.

---

## 2. Objdump (Desensamblador)
Permite pasar del código binario (ceros y unos) a código Assembler legible, y ver la estructura interna del archivo.

* **Ver el código Assembler de un binario:**
  `objdump -D -M intel programa`

* **Ver el código fuente intercalado con Assembler (si se compiló con `-ggdb`):**
  `objdump -S -M intel programa`

* **Inspeccionar los encabezados y las secciones del binario (.text, .data, etc.):**
  `objdump -h programa`

* **Ver el contenido en crudo de todas las secciones (ej. ver strings en .rodata):**
  `objdump -s programa`

* **Ver las entradas de la tabla GOT (Global Offset Table) y reubicaciones:**
  `objdump --dynamic-reloc programa`

---

## 3. GDB (GNU Debugger)
La herramienta principal para análisis dinámico. Permite frenar la ejecución, inyectar payloads y ver la memoria.

* **Iniciar el debugger con un programa:**
  `gdb ./programa`

**Comandos útiles DENTRO de GDB:**
* `break main`: Pone un punto de ruptura al inicio del programa.
* `run`: Ejecuta el programa.
* `disas /m main`: Desensambla la función main intercalando el código fuente en C.
* `x/wx &cookie`: Examina (x) la memoria en formato hexadecimal (x) por palabras/words (w) en la dirección de la variable cookie.
* `set {int}0xbffff684 = 0x41424344`: Modifica el valor en una dirección de memoria en vivo (útil para simular un exploit antes de escribirlo).

**Inyección de Payloads en GDB:**
* **Por entrada estándar (stdin):** (ej. para un `gets`)
  `run < archivo_con_payload`
* **Por argumentos:** (ej. para un `strcpy(buf, argv[1])`)
  `run "$(cat payload.txt)"` o usando un script en python `run "$(./script.py)"`

---

## 4. Checksec
Un script que analiza rápidamente qué protecciones (mitigaciones) están activadas en un ejecutable.

* **Verificar las mitigaciones de un binario:**
  `checksec.sh --file programa`
  *(Buscamos que RELRO, Stack Canary, NX y PIE estén desactivados o en rojo).*

---

## 5. Strace (Rastreador de Syscalls)
Muestra todas las llamadas al sistema operativo (syscalls) que hace un programa en tiempo real.

* **Ver las llamadas al sistema de un programa:**
  `strace ./programa`
  *(Útil para ver si un `printf` termina llamando a `write`, o si el programa intenta abrir archivos ocultos).*

---

## 6. Readelf y otras utilidades menores
* **`readelf -S programa`**: Muestra los encabezados de sección del binario (similar a `objdump -h` pero nativo para archivos ELF).
* **`file programa`**: Te dice qué tipo de archivo es (arquitectura, si está linkeado estática o dinámicamente).
* **`strings programa`**: Extrae todo el texto legible oculto dentro del binario (ej. contraseñas quemadas en el código, mensajes de error).
* **`hexdump programa`**: Muestra el contenido del binario en valores hexadecimales puros.
* **`nm programa`**: Lista los símbolos (funciones, variables globales) del archivo.
