# Clase 5
# Memoria Virtual

Utiliza la Memoria Principal como Cache
Permite: 
	Compartir la memoria de manera eficiente y segura por todos los programas
	
	Eliminar inconvenientes en la programacion asociados a una memoria principal cuya capacidad sea pequeña y limitada

## Seguridad y Proteccion

Consiste en mecanismos que aislan los procesos y al sistema operativo de los procesos de usuario

	INTEGRIDAD DISPONIBILIDAD CONFIDENCIBILIDAD AUTENTICACION

## VMWare o Proxmox
Son sistemas operativos montados en una misma computadora, para aislar los funcionamientos

Conceptos importantes: 
	
	Localidad espacial y temporal ayudan y habilitan esta posibilidad

	Cada maquina requiere que se compile en su propio espacio de direcciones

	Bloque de memoria principal -> PAGINA
	
	Fallo de memoria principal -> PAGE FAULT

	MAPEO : El procesador produce una __Direccion virtual__ que se traduce con ayuda del HYPERVISOR Y EL SWITCH en una __Direccion Fisica__

## MAPEO DE UNA DIRECCION VIRTUAL A UNA FISICA 

La direccion virtual se divide en: 
	
	Un numero de pagina 

	Un desplazamiento de pagina (construye Low-Signi-Bit y su n° de bits determinan el TAMAÑO de pagina)


	*1 direcciones fisica -> muchas direcciones virtuales*

## Diseño de sistemas de memoria virtual

Muchas elecciones en los sistemas de memoria virtual estan motivadas por el alto
*costo* de un **fallo de pagina**

Un fallo en el disco tardara millones de ciclos de reloj en resolverse. Esta enorme
penalizacion, conduce a varias decisiones clave en el diseño:

	Las paginas deben ser lo suficientemente grandes para tratar de amortizar el largo
	tiempo de acceso. Los tamaños que se encuentran hoy van de 4 KiB a 64 KiB.

	LA TECNICA PRINCIPAL PARA REDUCIR LOS FALLOS DE PAGINA CONSISTE EN PERMITIR EL 
	EMPLAZAMIENTO TOTALMENTE ASOCIATIVO DE PAGINAS DE MEMORIA 

	Los fallos de pagina se pueden manejar en el SW

	La escritura directa no funciona para la memoria virtual → las escrituras tardan
	demasiado ⇒ estos sistemas utilizan la ESCRITURA RETRAZADA.

## Emplazamiento de pagina y volver a encontrarla

Se reduce la frecuencia de fallos al optimizar la ubicacion de la pagina.

La dificultad de utilizar el emplazamiento completamente asociativo esta
en lo costosos de los mecanismos para localizar la entrada que contiene la
informacion, ya que esta se puede encontrar en cualquier lugar del nivel mas
alto de la jerarquıa. Una busqueda completa no es practica, salvo caso de
cache pequeñas..!!

	En los sistemas de Memoria Virtual, las paginas se localizan usando una tabla que 
	indexa la MPpal → **tabla de paginas**

	Cada programa tiene su propia tabla de paginas,

	Para indicar la ubicacion de la tabla de p ́aginas en la memoria, el HW
	incluye un registro que apunta al inicio de dicha tabla.


El HW utiliza el registro de la tabla de paginas, la direccion virtual y la tabla de
paginas para indicar como formar una direccion fısica.

bit = 0 -> NO Presente el MPpal → **excepcion**
bit = 1 -> Presente en MPpal

## Page Faults - tareas del SO

Crear espacio en memoria flash/disco para todas las paginas de un proceso cuando 
crea el proceso → **swap space**

En caso de que todas las paginas de la MPpal esten llenas se deshace de la que lleve mas tiempo sin utilizar 
por el concepto de LRU -> Last reciently used

## Para grandes cantidades de direcciones virtuales

Con:

	Direccion virtual de 32 bits,				El tamano de la tabla	
	Paginas de 4 KB y				==>	 de paginas serıa de
	4 bytes p/entrada de tabla de paginas,				4 MB 	--->	(por proceso)


# Tecnica UNO: Registro lımite

Objetivo: reducir al mınimo el almacenamiento maximo total requerido de memoria
principal para Tabla de Paginas.

Mantener un registro lımite que restringe el tamaño de la tabla de
paginas para un proceso dado.

# Tecnicas DOS: Dos registros lımite y dos direcciones de crecimiento

No es suficiente permitir el crecimiento en una sola direccion, se requieren dos areas
que se puedan expandir: una para la pila y otra para la memoria dinamica o heap.

Es conveniente _dividir_ la tabla de paginas y dejarla crecer desde la direccion mas
alta hacia abajo y desde la mas baja hacia arriba.

	Habra dos tablas de paginas separadas y dos lımites separados.


# Tecnicas TRES: Tabla de paginas invertidas o hash map

Se aplica una funcion hash a la direccion virtual para que la tabla de paginas
solo tenga el tamaño de la cantidad de paginas fısicas en la memoria
principal.

Un proceso de busqueda mas complejo porque ya no podemos simplemente
indexar la tabla de paginas.

# Tecnicas CUATRO: Multiniveles

El primer nivel asigna bloques de paginas del espacio de direccionamiento
virtual que son grandes y de tamaño fijo, quizas de 64 a 256 paginas en total.

La traduccion de direcciones se produce primeramente a traves del acceso
a la tabla de segmentos, haciendo uso de los bits mas significativos de la
direccion. Si la direccion del segmento es valida, el siguiente conjunto de bits
mas significativo se utiliza para indexar la tabla de paginas indicada por la
entrada de la tabla de segmentos.

# Tecnicas CINCO: Paginar las tablas de paginas

Simplemente se permite que las tablas de paginas residan en el espacio de direccionamiento virtual.

	Existen algunos pequeños problemas, aunque crıticos, que deben ser evitados,
	como las series interminables de fallos de paginas.

	La forma de resolver estos problemas es muy minuciosa, ası como altamente
	dependiente del procesador.

Estos problemas se evitan mediante el emplazamiento de todas las tablas de paginas
en el espacio de direccionamiento del sistema operativo, ası como del emplazamiento 
de al menos algunas de las tablas de paginas del sistema en una parte
de la memoria principal que se direcciona fısicamente y est a siempre presente en
memoria principal, y por lo tanto, nunca en disco.

# ¿Que pasa con las escrituras?
	RAPIDEZ	
		Cache >> Principal

Deben utilizar la reescritura, realizando las escrituras individuales en la
pagina en la memoria y copiando la pagina nuevamente a la memoria secundaria
cuando se reemplaza en la memoria principal. 

# Una traduccion de direcciones rapida: TLB

La clave para mejorar el rendimiento del acceso es confiar en la *localidad temporal*
*y espacial* de la tabla de paginas.

Los procesadores modernos incluyen una cache especial que guarda las traducciones
utilizadas recientemente: 
	
	Bufer de Busqueda de Traduccion o Translation Lookaside Buffer ( TLB )

# LA CACHE TLB

Necesita incluir otros bits, tales como los bits de consistencia y los de referencia (o de uso):

	bit de VALIDEZ

	bit de CONSISTENCIA
	
	bit de REFERENCIA

La TLB carga la direccion fısica y las etiquetas de proteccion de la tabla de paginas
del ultimo nivel. 
En cada acceso a memoria, buscamos el n° de pagina virtual en la TLB.

Si obtenemos un _acierto_ :

	El numero de pagina fısica se utiliza para formar la direccion y
	Se activa el bit de referencia correspondiente.

Si ocurre un _fallo_ :
Hay que determinar si es:
	un Fallo de Pagina:
			
			Si la pagina existe en la memoria, el TLB miss indica solo que falta la traduccion.
	
	O un Fallo de TLB:

			Si la pagina no esta presente en la memoria, entonces el fallo de TLB indica un
			verdadero fallo de pagina. ===> EXCEPCION

Despues de resuelto el fallo de TLB recuperando la traduccion faltante de la tabla
de paginas, hay que seleccionar una entrada de TLB para reemplazar.

### Algunos valores tıpicos para una TLB podrıan ser:
	
	TamaÑo de TLB: 16–512 entradas
	Tamaño de bloque: 1 a 2 entradas de la tabla de p ́aginas (normalmente de 4 a 8 bytes cada una)
	Tiempo de acierto: 0,5–1 ciclo de reloj
	Penalizacion por falla: 10–100 ciclos de reloj
	Tasa de fallos: 0.01

# Integracion de memoria virtual, TLB y caches

Los sistemas de cache y memoria virtual funcionan juntos como una jerarquıa

Los datos no pueden estar en el cache a menos que esten presentes en la
memoria principal.

	El SO mantiene esta jerarquıa al vaciar el contenido de cualquier pagina de la
	cache cuando decide migrar esa pagina al disco.
	
	Al mismo tiempo, el SO modifica las tablas de paginas y la TLB, de modo
	que un intento de acceder a los datos de la pagina migrada generara un error
	de pagina.

# Implementacion de proteccion con MV
	
	→ La funcion mas importante de la memoria virtual en la actualidad es permitir 
	que multiples procesos compartan una sola memoria principal, al mismo
	tiempo que brinda proteccion de memoria entre estos procesos y el sistema
	operativo.

# Interface Hardware / Software
Para permitir que el SO implemente la protecci ́on en el sistema de memoria virtual,
el hardware debe:

	1. Admitir al menos dos modos que indican si el proceso en ejecucion es un proceso de usuario o 
un proceso del sistema operativo.

# Manejo de fallos de TLB y fault page

Una excepcion de *fallo de TLB o de pagina* debe activarse al *final* del mismo
ciclo de reloj en el que se produce el acceso a la memoria.

Si no, una instruccion de carga podrıa sobrescribir un registro,esto podrıa 
ser desastroso al intentar reiniciar la instruccion.

En los almacenamientos
	Cuando hay un fallo de pagina debemos evitar que la escritura en la memoria se
	complete realmente;

	Esto se logra desactivando la l ́ınea de control de escritura de memoria.

### Las excepciones de fallos de pagina para accesos a datos son difıciles de implementar correctamente en un procesador debido a que:

Se producen en el medio de una instrucci ́on, no como en los fallos de p ́aginas
cuando se accede a instrucciones
En una arquitectura como la RISC-V es relativamente f ́acil hacer que las instruc-
ciones sean reiniciables,

Como cada instrucci ́on escribe solo un elemento de datos y lo hace al final del
ciclo de instrucci ́on,

Simplemente hay que evitar que la instrucci ́on se complete (al no escribir) y
reiniciar la instrucci ́on desde el principio.

