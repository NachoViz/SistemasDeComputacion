# Para compilar en 32 bits en tu Debian, pero te faltan las librerías estándar de C para esa arquitectura.
sudo apt update
sudo apt install gcc-multilib

# La herramienta strace no viene instalada por defecto.
sudo apt install strace

# Instalar NASM
sudo apt install nasm

## Despues de ensamblar 
nasm -f elf holaMundo.asm

**LINKEAMOS**
ld -m elf_i386 -o holaMundo holaMundo.o

# ShellCode
El shellcode no es un programa ejecutable como cualquier otro, sus instrucciones deben ser autocontenidas para lograr su ejecución por parte del procesador sin importar el estado actual del programa vulnerable. El shellcode no va a ser linkeado ni va a ser cargado en memoria como un proceso por el sistema operativo. Es por ello que los ejemplos de llamadas al sistema deben ser retocados para cumplir ciertos criterios:
	1. No disponemos del segmento data: no es posible utilizar el segmento de datos en el código assembler del shellcode como se hizo con “Hola mundo” en el ejemplo anterior holaMundo.asm. El shellcode no se ejecutará como un programa corriente ni sus segmentos serán cargados en memoria por el sistema operativo. Es por ello que veremos maneras de manipular un string sin recurrir a la sección .data.
	2. Evitar caracteres especiales: el shellcode no debe tener caracteres especiales como \x00 entre sus bytes porque se copia en memoria con funciones que manipulan strings como strcpy(). Usarlos provocaría que el shellcode quede truncado. (Es posible por prueba y error detectar qué caracter finaliza el copiado del shellcode en memoria, según la función vulnerable de la que se trate).
	3. Mínima longitud: el shellcode debe tener la mínima longitud posible porque en la mayoría de los casos no contamos con demasiado espacio en el búfer para almacenarlo.
