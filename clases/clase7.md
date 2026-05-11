# EL MECANISMO DE PAGINACION 

La paginacion solo opera en Modo Protegido

## Administracion de la paginacion

¿Como habilitar la paginacion?

	Poner en 1 el bit PG del registro de control CR0

	PG solo puede modificarse en Modo Protegido

¿ Como elegir el tamaño de pagina ?

	Mediante el bit PSE del registro CR4
		
		PSE=1 → paginas de 4MB.

		PSE=0 → de 4KB.


#### La Unidad de Segmentacíon se divide en paginas sucesivas de 4 KB o 4MB.

Luego la Unidad de Paginacion carga y distribuye, de forma aleatoria, las paginas
que se precisan en cada momento, sobre el espacio de la memoria fısica.

Los algoritmos usados en la transferencia de bloques desde/hacia la memoria principal,
son mas sencillos y efectivos que en la segmentacion, ya que manipular *bloques*
*de tamaño fijo y reducido* , optimiza el aprovechamiento del espacio de memoria.

La *paginacion* descompone 4GB en un millon de paginas de 4KB,
guarda el conteniendo la base (20 bits) y los derechos de acceso (12 bits) de cada
pagina en la memoria principal.

	Si cada entrada tiene 32 bits, tendrıa un tamaño de 1M x 4bytes = 4MB.

*La Unidad de Paginacion* maneja una *Tabla de Paginas* con un millon de entradas que
contienen los descriptores de todas las p ́aginas de memoria principal.


## Unidad de paginacion

Las paginas en un microprocesador de 32 bits quedan definidas por 3 parametros:
	
	Base Lımite Atributos

De los tres, _Lımite_ no es necesario porque el tamaño de la pagina es fijo.

La Base tiene 32 bits, de los cuales los ultimos 12 son ceros, ya que las paginas
son de 4K y sus bases seran multiplos de 4KB → solo son necesarios 20 bits.

La *Tabla de Descriptores de Paginas* debe residir en la memoria principal

Para reducir el espacio de memoria que ocupan estas tablas, Intel recurri ́o a una
traducci ́on de dos niveles:

### El primer nivel de traduccion :

Lo soporta una tabla Directorio de Tablas de Paginas (DTP), que consta de 1K de 
entradas de 32 bits c/u y reside en memoria principal.
Cada entrada de (DTP) apunta a otra pagina que se llama Tabla de Paginas.

La Base del Directorio de Tabla de P ́aginas de una Tarea, es fija y est ́a almacenada en
el Registro de Control CR3.

NO OLVIDAR: El Directorio de Tablas de P ́aginas es propio de cada tarea y su base es
apuntada por el Registro de Control CR3, el que se modifica con cada conmutaci ́on de
tarea.

