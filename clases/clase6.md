# MEMORIA SEGMENTADA

## Organizacion de la Memoria
La memoria esta organizada en
	bytes
	palabras
	dobles palabras
	cuadruples palabras

Todos en una direccion multiplos de 4 para evitar que los datos usen 2 ciclos para transferirse

## Modo Real

En la memoria en Modo Real, se encuentran

	8 Registros de Proposito General de 16 bits (AX, BX, CX, DX, SP,
	BP, SI y DI),

	8 Registros Extendidos de 32 bits (EAX, EBX, ECX, EDX, ESP, EBP,
	ESI y EDI)
	
	los Registros de Segmento (CS, DS, SS, ES, FS y GS)

En este modo se contempla:

Un espacio de direcciones directamente accesibles por la CPU de 1MB;

Solo es posible aplicar la tecnica de la segmentacion;

El tamaño maximo del segmento es de 64 KB.

### Para determinar la posicion a la que se debe que acceder en un segmento se precisa de:

La base: para obtenerla se debe multiplicar el contenido del RS por 16

El desplazamiento: de 16 bits.

	DIRECCION EFECTIVA = RS x 16 + DESPLAZAMIENTO

## Modo Protegido

La memoria en este modo distingue tres espacios:

	Virtual o logico

	Lineal

	Fisico

La MMU _(Mecanismo de direccionamiento)_ traduce la direccion virtual a fısica, y en caso de no hallarse el
elemento en la memoria fısica, se genera una excepcion que maneja el SO.


### Espacio virtual o logico

Consta de dos partes:

	Selector: Campo de 16 bits, que selecciona un determinado segmento del espacio virtual.

	Desplazamiento: campo de 32 bits que determina una posicion de un segmento que puede
	alcanzar un tamaño maximo de 4 GB.

### Espacio lineal

La Unidad de Segmentacion SIEMPRE ESTA ACTIVA y se encarga de traducir la direccion logica 
en UNA direccion lineal, que coincidira con la fısica.

En caso de una excepcion(un segmento que no esta cargado en la memoria principal) el SO 
traslada el segmento desde la memoria virtual a la fısica. Luego, la rutina actualiza 
la tabla de segmentos y se da curso al acceso.

#### Conjunto de reglas que protegen a los segmentos:

	Si la direccion esta dentro del tamaño del segmento.

	Si el segmento esta presente en la memoria.

	Si el nivel de privilegio del segmento hace posible su acceso.

	Si se puede leer, escribir o ejecutar.

#### Descriptores de Segmento = NO son creados por las aplicaciones
	
Campo BASE(24bits) y LIMITE(20bits): 

 Bit de Granularidad (G):
	
	G=0, el LIMITE estara expresado en bytes y si G=1, el LIMITE estara expresado en
	paginas de 4 KB.


Respecto al resto de los ATRIBUTOS.

Bit de presencia (P): (P=1) Segmento cargado en memoria principal, (P=0) ausente.

Nivel de privilegio (DPL): Nivel de privilegio del segmento al que referencia el descriptor.
Su valor puede variar entre el 0 y el 3.

Tipo de segmento (S): Si S=1, el segmento es “normal”: segmento de codigo, datos o
pila. Si S=0, es un segmento del sistema: puerta de llamada, un segmento TSS, etc.

Tipo: Los tres bits de este campo distinguen en los normales si se trata de uno de codigo,
de datos o de pila. Ademas, determinan el acceso permitido: lectura/escritura/ejecucion.

Accedido (A): Este bit se pone automaticamente a 1 cada vez que el procesador accede
al segmento.

Defecto/Grande (D/B): En los segmentos de c ́odigo el bit es D (Defecto) y en los de
datos es B (Grande), y permiten distinguir los segmentos nativos de 32 bits para el
Pentium. As ́ı se mantiene una compatibilidad total con el SW creado para el 80286, sin
penalizar las nuevas instrucciones que aporta el Pentium. Si D=1, las direcciones efectivas
y los operandos son de 32 bits. Si D=0 se toman s ́olo 16.

Disponible (AVL): Este bit lo usan algunos SO para indicar si el segmento est ́a disponible
(AV=1) o no (AV=0) para el usuario.

## Gestion de descriptores

En la CPU existen los registros Registro Base de Tabla de Descriptores (RBTD) 
que contienen la direccion de inicio de las tablas de descriptores.

*EL PROCESADOR CARGA AUTOMATICAMENTE (BASE {32} + LIMITE {20} + ATRIBUTOS {12})*

La CPU posee dos registros internos para acceder a las tablas:

	GDTR apunta a base de una unica Global Descriptor Table (GDT).

	LDTR a la base de una Local Descriptor Table (LDT) por tarea.

Como la CPU tiene activadas dos tablas de descriptores, usa el bit TI, Indicador de
Tabla, del selector de segmento para saber a cual de ellas se refiere, TI=1 selecciona
LDTn y TI=0, a GDT.

## Modo Plano

El mecanismo de segmentacion es intrınseco al Pentium y no puede desactivarse.
En aquellas aplicaciones y sistemas en los que no se requiera se usa un procedimiento
para simular su inhabilitacion, llamandose modo Plano al modelo de memoria al
que se tiene acceso.

En resumen: La entrada 0 de la GDT se sacrifica para que el sistema tenga una forma segura de decir "este registro no apunta a nada válido" sin que el procesador se rompa al cargar el valor. En la LDT no hace falta ese sacrificio porque el bit TI ya diferencia el selector de un cero total.
