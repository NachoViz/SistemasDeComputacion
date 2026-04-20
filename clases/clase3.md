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

#### Por Registro:
	Por ejemplo para el direccionamiento MOV ah,al -> AMBOS deben ser de mismo tamaño
						       -> NO pueden destino en un direccionamiento por registro.
						       -> No es posible usar como origen y destino un registro de segmento.
#### Inmediato: 
	MOV ah, 20h
	El operando de destino, puede ser pr ́acticamente cualquier registro, excepto los registros de segmento cuya inicializaci ́on debe efectuarse mediante direccionamiento por registro.

#### Directo:
		MOV ax, 1280h
		MOV ax, [etiqueta]
	Colocar la direcci ́on entre corchetes.
	Declarar la direcci ́on como una etiqueta, y utilizarla en la instrucci ́on.

#### Indirecto: 
	En este caso la direccion no se facilita en la propia sentencia, sino que se encuentra almacenada en un registro que actua como un puntero.
		MOV al, [bx]
		MOV al, [bx+4]
	Los registros que pueden usarse como base en este tipo de direccionamiento son 
	BX
	BP
	SI
	DI

#### Indexado:
	Caso particular del indirecto
	La direccion no se obtiene de un registro sino que es calculada a partir de dos registros y, opcionalmente, un desplazamiento.
	Normalmente BX o BP, contendra una direccion base a la que se sumara el contenido de un registro ındice, DI o SI.
	EJEMPLO:
   segment Datos
Pantalla resb 25*80*2
..start:
   mov ax, 0b800h
   mov ds, ax
   xor si, si 		;DS:S1 apunta a la pantalla
   mov ax, Datos
   mov es, ax
   mov di, Pantalla 	;ES:DI apunta a nuestra variable
   mov cx, 4000
   cid 			; incrementar autom ́aticamente SI y DI
Guarda:
   movsb
   loop Guarda

# EL TAMAÑO DE LA PILA ES DE 1024Bytes, pero se puede cambiar 

# SALTOS 
	SHORT JUMP: -128 a +127 bytes de la ubicacion actual EIP
	NEAR JUMP: dentro del segmento actual, desfase de 16 o 32 bits
	FAR JUMP: selector de segmento de 16bits y un offset de 16 o 32 bits

# Anulando Segmentos Predeterminados
 El destino de las instrucciones de cadena siempre usa el segmento ES.
 
 Las instrucciones de inserci ́on y extracci ́on de pila siempre utilizan el segmento SS.

 Las b ́usquedas de instrucciones siempre usan el segmento CS.

#Instrucciones de movimiento de datos en la pila

## PUSH
	Coloca su operando en la parte superior de la pila. Primero disminuye ESP
	en 4, luego coloca su operando en el espacio de memoria de 32 bits apuntado por
	[ESP]. ESP es decrementado con push ya que la pila x86 crece hacia las direcciones
	bajas de memoria.

## POP
	Elimina el elemento de datos de 4 bytes de la parte superior de la pila y lo
	deposita en el operando especificado (registro o ubicaci ́on de memoria). Primero
	mueve los 4 bytes ubicados en la posici ́on de memoria [ESP] al registro o posici ́on
	de memoria especificada, y luego incrementa ESP en 4.

## Load Effective Address (LEA):
	 Coloca en el primer operando (un registro), la
	direcci ́on especificada por el segundo operando.
	El contenido de la posici ́on de memoria no se carga, s ́olo se calcula la direcci ́on
	efectiva y se coloca en el registro. Esto es  ́util para obtener un puntero a una
	regi ́on de memoria.
		
		lea <reg32>,<mem> ;Sintaxis de LEA

		lea edi, [ebx+4*esi] ;Ejemplos
		lea eax, [var]

## ADD:
	 Suma sus dos operandos, almacenando el resultado en el primero. Tenga
	en cuenta que, mientras que ambos operandos pueden ser registros, como m ́aximo
	un operando puede ser una posici ́on de memoria.

## SUB:
	 Almacena en el primer operando el resultado de restar el valor del segundo
	operando al valor del primero. Al igual que con add.


## INC, DEC:
	 La instrucci ́on inc incrementa el contenido de su operando en uno. La
	instrucci ́on dec disminuye el contenido de su operando en uno.

# Instrucciones Aritmeticas y Logicas

## IMUL:
	Puede trabajar con dos  ́o tres operandos. En el primer caso funciona como
	ADD  ́o SUB. La forma de tres operandos multiplica segundo y tercero y almacena
	el resultado en el primero. El tercero debe ser un valor constante.
	En ambos casos el resultado (primer operando) debe ser un registro.	

		imul <reg32>,<reg32> ; Sint ́axis
		imul <reg32>,<mem>
		imul <reg32>,<reg32>,<con>
		imul <reg32>,<mem>,<con>
	
		imul eax, [var] ; Ejemplos
 		...
		imul esi, edi, 25

## IDIV:
	Divide el contenido del entero de 64 bits EDX:EAX (EDX con los cuatro
	bytes m ́as significativos y EAX con los cuatro bytes menos significativos) por el valor
	del operando especificado. El resultado del cociente de la divisi ́on se almacena en
	EAX, mientras que el resto se coloca en EDX.

## AND, OR, XOR:
	 Operaci ́on l ́ogica especificada (bit a bit) con sus operandos,
	colocando el resultado en el primer operando.

## NOT:
	 Niega logicamente, bit a bit, el contenido del operando.
	 NEG: Realiza la negacion del complemento a dos del contenido del operando.

## SHL, SHR:
	 Desplazan los bits del contenido de su primer operando a la izquierda
	 ́o a la derecha, rellenando las posiciones vac ́ıas resultantes con ceros. El operando
	desplazado puede desplazarse hasta 31 posiciones.
	El n ́umero de bits a desplazar (segundo operando) puede ser una constante de 8
	bits o el registro CL. En cualquier caso, los recuentos de desplazamiento superiores
	a 31 se realizan en m ́odulo 32.

# Instrucciones de Control de Flujo de ejecucion
IP indica la ubicaci ́on en memoria de la siguiente instrucci ́on a ejecutar. No puede
manipularse directamente, pero se actualiza impl ́ıcitamente mediante las instrucciones
de control de flujo. Utilizamos la notaci ́on <label> para referirnos a las ubicaciones
etiquetadas en el texto del programa.

	  mov esi, [ebp+8]
    begin:
	  xor ecx, ecx
	  mov eax, [esi]
	  ...
	  jmp begin

jmp: transfiere el flujo de ejecuci ́on del programa a la instrucci ́on en la ubicaci ́on
de memoria indicada por el operando.

## j<condition>:
Saltos condicionales basados en el valor de los bits del registro de
estados. El contenido del registro de estado incluye informaci ́on sobre la  ́ultima
operaci ́on aritm ́etica realizada. Por ejemplo, un bit indica si el  ́ultimo resultado fue
cero, otro si el  ́ultimo resultado fue negativo, etc.

je <etiqueta> 		; Sint ́axis
jne <etiqueta>
jz <etiqueta>
jg <etiqueta>
jge <etiqueta>
jl <etiqueta>
jle <etiqueta>

cmp eax, ebx 		; Ejemplo
jle continuar

## cmp:
Compara los valores de los dos operandos especificados. Como resul-
tado, se modifican bits del registro de estado. Esta instrucci ́on es equivalente
a la instrucci ́on sub, salvo que el resultado de la resta se descarta.

1 cmp <reg>, <reg> ; Sint ́axis
2 cmp <reg>, <mem>
3 cmp <mem>, <reg>
4 cmp <reg>, <con>
5
bucle: ; Ejemplo
7 ...
8 cmp DWORD PTR[var], 10
9 jeq bucle
10 ...


###########################################################
call, ret - Llamada y retorno de subrutina:
call: Primero introduce la ubicaci ́on de c ́odigo actual a la pila soportada
por el hardware en la memoria (ver instrucci ́on push para m ́as detalles),
y luego realiza un salto incondicional a la ubicaci ́on de c ́odigo indicada
por el operando label. A diferencia de las instrucciones de salto simple,
la instrucci ́on call guarda la ubicaci ́on a la que se volver ́a cuando la
subrutina finalice.

ret: Implementa un mecanismo de retorno de subrutina. Esta in-
strucci ́on primero saca una posici ́on de c ́odigo de la pila (v ́ease la

instrucci ́on pop para m ́as detalles). A continuaci ́on, realiza un salto
incondicional a la posici ́on de c ́odigo recuperada.
