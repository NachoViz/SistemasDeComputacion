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

