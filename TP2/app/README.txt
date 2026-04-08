# El Script de Python (Capa Superior)
Este código se encarga de realizar la "llamada" a la API para obtener el contenido necesario del productor (Banco Mundial).

¿Qué es lo más importante de este paso?
	La Capa Superior: Estás trabajando en el nivel más "amigable" con el programador, lejos del hardware por ahora.
	Protocolo REST: Estás cumpliendo con las reglas de arquitectura REST para interactuar con servicios web.
	Formato JSON: La información viene estructurada de una forma que Python entiende fácilmente como diccionarios y listas.
	Dato clave para tu informe: En esta instancia, simplemente estamos validando que la conexión a la URL provista funciona y que podemos extraer el número flotante (por ejemplo, 42.3) del JSON.

¿Como se que anda este codigo?
La forma más rápida de saber si la conexión con el Banco Mundial fue exitosa es mirar el código de respuesta:

200: Significa que la petición fue exitosa.
Otros (404, 500): Si ves estos números, la "Response Failed" indica un problema con la URL o el servidor.

"Response OK": Esto confirma que entraste al bloque donde la API respondió positivamente.
El valor del GINI: Si el for encontró un dato válido, verás una línea con el año y el índice (por ejemplo: 42.3)

## Ejecuta el test
	python3 app.py	-> Deberia mostrar Response OK y Año: 2020 - Indice GINI: 29.4 (Tarda un poco)

# Paso 2:(Capa Intermedia) en lenguaje C
En esta etapa, el programa en C actúa como un "puente".
Debemos usar las convenciones de llamadas para pasar parámetros. Como estamos en una arquitectura x86_64, usaremos la convención System V AMD64 ABI.

Crea un archivo llamado interm.c

	Capa Intermedia: C es el lenguaje de "alto nivel" que interactúa con el "bajo nivel" (Assembler).

	Convención de Llamadas: En x86_64, el primer argumento de punto flotante (nuestro double valor_gini) no va por el stack, sino que el compilador lo pone automáticamente en el registro %xmm0.

	Stack Frame: Al llamar a procesar_gini_asm, se creará un bloque en la memoria RAM llamado Stack Frame que contiene la dirección de retorno para volver a C.

## Codigo de prueba(maintest.c)
He incluido una función "mock" (de prueba) para simular lo que luego hará el Assembler:
	1. Compilá el programa:
		gcc -g3 -o test_gini maintest.c
	2. Corré el test con el valor que te dio la API (29.4):
		./test_gini 29.4
	3. ¿Qué deberías ver?
		Si todo está bien, la terminal te debería devolver:

		Entrada (float): 29.400000
		Resultado (Entero + 1): 30
Info:
Registros de Propósito General (%rdi, %rsi, %rdx, %rcx, etc.): Se usan exclusivamente para los primeros 6 argumentos que sean enteros o punteros.
Registros XMM (%xmm0 a %xmm7): Se usan exclusivamente para los argumentos que sean de punto flotante, como float o double.

%rax: Se usa para el valor de retorno. Por eso, después de convertir el flotante a entero, movemos el resultado ahí.
%rbp y %rsp: Se encargan de manejar el Stack Frame (el marco de la pila) para que la función sea segura y pueda volver a C correctamente.
%rdi y %rsi: En este caso quedaron vacíos porque no le pasamos ningún número entero a la función, solo el decimal del GINI.

En lugar de ponerlo en %rdi (que es para enteros), lo coloca en %xmm0, que es el registro designado para el primer parámetro de punto flotante.

"Usamos %xmm0 porque, según la convención System V, los parámetros decimales (double) se pasan por registros XMM, mientras que los registros como %rdi o %rsi quedan reservados para valores enteros o direcciones de memoria".

#Paso 3: Compilación y Linkeo
Para que esto ande en tu Debian, tenés que unir ambos mundos.
 Primero ensamblar el código ASM con info de debug:
	nasm -f elf64 -g -F dwarf procesar.asm -o procesar.o 
 Compilar el código C sin linkear:
	gcc -g3 -c interm.c -o interm.o 
 Linkear ambos para crear el ejecutable final:
	gcc -g3 -o programa_gini interm.o procesar.o 

  ¿Cómo verificamos que esto es Assembler real?
 Una vez que lo compiles, ejecutalo con el valor de la API:
	./programa_gini 29.4
 Si te devuelve 30, ¡felicitaciones! Ya tenés funcionando la integración de C con Assembler.


# .SO (Shared Object)
El .so significa Shared Object (Objeto Compartido). Es un archivo que funciona como una librería de enlace dinámico.
El .so no es un archivo que vos escribas, sino el resultado final de unir tus dos archivos (interm.c y procesar.asm) en una sola "caja" que Python pueda abrir.

En el contexto de tu trabajo, sirve para lo siguiente:

	1. Conectar Python con C
Es el formato que permite que Python "importe" y use funciones escritas en C.

Sin este archivo, Python no tendría forma de acceder a la función puente_python_asm que escribiste.

	2. Cómo se usa en el código
En la capa superior (Python), utilizás una herramienta llamada ctypes.

Mediante el comando ctypes.CDLL('./libfactorial.so'), Python carga esa librería en la memoria para poder ejecutarla.

	3. Diferencia con un ejecutable común
Un ejecutable normal (como el que intentaste linkear) necesita una función main porque el sistema operativo lo corre de principio a fin.

Un .so no necesita un main porque no es un programa que corre solo; es una caja de herramientas que Python abre para sacar una función específica cuando la necesita.

### Resumen para tu TP:
Para cumplir con la consigna de que la "capa superior entregue datos a un programa en C", necesitás compilar tu código de C y Assembler como un .so. Así, Python puede cargar esa librería y pasarle el valor del índice GINI directamente a la memoria.
## ¿Cómo se crea el .so con tus archivos?
1. Compilar el Assembler a objeto (.o):
	nasm -f elf64 -g -F dwarf procesar.asm -o procesar.o

2. Compilar el C a objeto (.o):
	Aquí usamos -fPIC, que es obligatorio para crear librerías compartidas.

		gcc -g3 -fPIC -c interm.c -o interm.o

3. Unir ambos en la librería compartida (.so):
	gcc -shared -o libgini.so interm.o procesar.o

Este comando crea el fichero shared object llamado libgini.so.

Al usar -shared, le avisás a gcc que no busque una función main, solucionando el error que te tiró antes.


3. Pasos para ejecutar y validar
Asegurate de estar en la carpeta donde tenés todos los archivos y ejecutá:

Generar el objeto ASM: nasm -f elf64 -g -F dwarf procesar.asm -o procesar.o

Generar el objeto C: gcc -g3 -fPIC -c interm.c -o interm.o


Crear la librería: gcc -shared -o libgini.so interm.o procesar.o 

Correr Python: python3 app.py


# FALTA mostrar el estado del Stack en GDB.
