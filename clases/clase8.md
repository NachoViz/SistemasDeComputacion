# Mecanismos de proteccion

Modo REAL => NO necesita proteccion

Modo Protegido => Requiere proteccion al ser multitarea	

## OBJETIVO

Defender la integridad y las funciones vitales del sistema de explotacion ante posibles intrusiones
de las aplicaciones sin excluir una comunicacion controlada.

## Anillos de proteccion

SEGMENTACION

	PL = 0
	Segmentos y programas del n ́ucleo del SO. Seguridad m ́axima.

	PL = 1
	Programas que requieren seguridad alta.

	PL = 2
	Programas que requieren seguridad media.

	PL = 3
	Programas que requieren seguridad m ́ınima.

PAGINACION 

	SUPERVISOR
	Nivel maximo
	Anillo PL = 0 al 2 

	USUARIO
	Nivel mınimo
	Anillo PL = 3

El mecanismo de proteccion en la paginacion es mas sencillo pero menos riguroso
que el de segmentacion. Un sistema ideal emplea:

	Segmentacion para soportar la proteccion y
	
	Paginacion para el manejo de memoria.

## Pentium tiene un mecanismo potente de proteccion que incluye 

Proteccion de: 
	
	Tareas

	Los Segmentos

	Las Paginas

	Las Instrucciones

Si se quiere desactivar el mecanismo de proteccion se debe poner el flag WP del registro CR0 a 0. 
Luego poner los flags R/W y U/S	en 1 en el Directorio de Paginas y Tabla de Paginas.



## Reglas de acceso

Se determinan mediante la relacion del registro *CPL* del segmento de codigo en curso 
y el *DPL* del segmento al que se quiere acceder

### 1° Regla : acceso a segmentos de codigo

Solo se puede acceder a *CS* que tengan el *MISMO* *PL* que el CS peticinario

### 2° Regla : acceso a segmentos de datos

Solo se permite el acceso desde CS con un determinado *CPL* a otros DS de *IGUAL O MENOR* *PL*
(jerarquico). Para ello	se usan instrucciones tipo *MOV* o similares. Considere que un DS se puede R o W

### 3° Regla : acceso a segmentos de pila

Solo se puede acceder a segmentos de pila con el *MISMO* PL que el del segmento de codigo que los solicita
