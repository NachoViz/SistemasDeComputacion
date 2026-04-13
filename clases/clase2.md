# MODELO PENTIUM

## Construir un sistema optimo 
Si decide emplear lenguaje maquina, debera:

Conocer los registros internos , direcciones, el repertorio b ́asico de instrucciones y los modos de direccionamiento

Manejar el modelo de programaci ́on del coprocesador matem ́atico.

NO TENDRA ACCESO a la gesti ́on de los recursos de la CPU 

#### Importante conocer: 
Prestaciones de la memoria virtual,

Caracterısticas de proteccion del entorno,

Mecanismos que posibilitan la conmutacion de tareas,

Tratamiento de interrupciones y excepciones, etc.

## Herramientas para los programadores: 

Para Programador de aplicaciones: 
	Blinder : no permite acceso a los mecanismos del sistema

Para Programador de Sistemas:
	Builder: control total

## Pentium 
El Pentium dispone de 32 registros en su arquitectura interna de los cuales 16 son para uso del programador de aplicaciones y se clasifican en cuatro grupos:
	
	8 Registros de Proposito General (RPG)
		- EAX -> Acumulador
		- EBX -> Base
		- ECX -> Contador 
		- EDX -> Datos
		- ESP -> Puntero de Pila
		- EBP -> Puntero de Base
		- EDI -> Indice Destino
		- ESI -> Indice Fuente

	1 Registro Puntero de Instrucciones (EIP)
		- EIP -> Puntero de Instrucciones = Gobierna implıcitamente el flujo de control de las instrucciones, las interrupciones y las excepciones.
				-> DOS MODOS:
					PROTEGIDO: 32bits - Maximo desplazamiento 4GB
					NATIVO: 16bits - Maximo desplazamiento 64KB
	
	1 Registro de Estado (o de Senializadores) (EFLAGS)
		- EFLAGS
			-> 32BITS - Controlados por ALU 
	
	6 Registros de Segmento (RS)
		- CS: Contiene en cada momento el segmento de c ́odigo que est ́a ejecutando la CPU. El desplazamiento que hay que añadir a la base del CS reside en el EIP.
		- DS: Soporta el valor del selector del segmento de datos
		- SS: Guarda el valor del selector del segmento de pila en curso. ESP contiene el desplazamiento que debe a ̃nadirse a la base del segmento de pila para determinar la cima por donde se cargan y descargan los datos.
		- ES]
		- FS|->los x86 de 32bits  
		- GS] 
	  -> LA SEGMENTACION son zonas de memoria de tamaño variable que contiene el mismo tipo de informacion

                __MODO REAL__
		BASE : Direccion de 20bits = 1MB
		DESPLAZAMIENTO : 16bits = 64KB

		__MODO PROTEGIDO__
		SELECTOR: 14Bits
		DESPLAZAMIENTO: se añade a la base para localizar la direccion. Max 4GB
	
			DESCRIPTOR DE SEGMENTOS 64bits -> residen en una tabla en MemPrinc -> Manejadas por el SO
				BASE: 32Bits = 2³² = 4GB
				LIMITE: 20Bits determina el tamaño del segmento 2²⁰= 1MB 
				ATRIBUTOS O DERECHOS DE ACCESO: 12Bits
		
