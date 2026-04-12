#Clase3
# Introduccion al lenguaje ensamblador

## Dos razones fundamentales por las que se continua utilizando:
Eficiencia: que tan “bueno” es un programa para lograr un objetivo dado.

	1. Eficiencia del espacio: Requisitos de memoria de un programa, el tamaño del codigo ejecutable.
	2. Eficiencia del tiempo: Tiempo necesario para ejecutar un programa. Un programa cuidadosamente elaborado en lenguaje ensamblador, tendera a ejecutarse mas rapido que su equivalente en lenguaje de alto nivel.

Accesibilidad al hardware del sistema: Como no impone ninguna restricci ́on, se puede tener control directo sobre el hw del sistema, a diferencia de los lenguajes de alto nivel que proporcionan una vista restringida (abstracta) del hardware.

#### Ensambladores disponibles para los Pentium:
NASM: Netwide Assembler
MASM: Microsoft Assembler
TASM: Borland Turbo Assembler

## Instrucciones
Se crean a partir de tres clases diferentes de sentencias.

	Intrucciones ejecutables o intrucciones: Esta clase de sentencias le dicen al procesador qu ́e hacer.

## Directivas
Directivas de ensamblador o pseudo-ops: Una directiva es un artificio
Se usan generalmente para decirle al ensamblador que haga alguna cosa o informarle al ensamblador de algo.
No se ejecutan, no se traducen en codigo de maquina.
Los usos comunes de las directivas son:
	Definir constantes.
	Definir memoria para almacenar datos en ella.
	Agrupar la memoria en segmentos
	Incluir c ́odigo fuente condicionalmente
	Incluir otros archivos
La directiva __EQU__ se puede utilizar para definir un s ́ımbolo. Los s ́ımbolos son constantes con nombre que se pueden emplear en el programa ensamblador.
El formato es:

	´'sımbolo equ valor'´

Esta directiva es parecida a la __#define__ de lenguaje C. Se utiliza normalmente
para definir macros de una sola l ́ınea tal como en C.
	%define SIZE 100
	 mov eax, SIZE

Macros: un grupo de sentencias.
	%macro imprime 2
		 mov edx,%1
		 mov ecx,%2
		 mov ebx,1
		 mov eax,4
		 int 80h
	%endmacro

## Modos de Direccionamiento
1. por Registro
2. Inmediato
3. Directo
4. Indirecto
5. Indexado

#### Observaciones:
	Por ejemplo para el direccionamiento MOV ah,al -> AMBOS deben ser de mismo tamaño
						       -> NO pueden destino en un direccionamiento por registro.
						       -> No es posible usar como origen y destino un registro de segmento.
