# Instalamos dependencias 

	sudo apt install qemu-system-x86

Luego cree un archivo con el comando:
	
	printf '\364%509s\125\252' > main.img

El cual me devuelve la imagen main, para simularla con el virtualizador instalado

	qemu-system-x86_64 --drive file=main.img,format=raw,index=0,media=disk

# CORRER EN EL HW

Colocamos un pendrive en mi caso de 32GB, lo localizo en mi terminal con el comando lsblk y determino
que esta ubicado en el bloque SDC1

En este pendrive yo tenia una configuracion buteable para instalar el sistema Debian Linux
por lo que necesito usar el comando: 

	sudo umount /dev/sdc1

#### Observacion
Si el pendrive está montado (como aparecía en tu lsblk bajo /media/nacho/...), el sistema operativo cree que tiene el control de los archivos ahí dentro. Si intentás sobrescribir todo el disco bit por bit con dd mientras está montado, podrías causar errores de escritura o archivos corruptos. Al desmontarlo, dejas el dispositivo "libre" para que dd trabaje sin interferencias.
umount no borra absolutamente nada.Pensalo como avisarle al sistema: "Che, dejá de usar esta partición un ratito porque voy a hacer algo importante". Es como desenchufar el pendrive de forma segura pero por software, para que Debian no intente leer o escribir archivos mientras vos trabajás.Lo que sí va a borrar los datos es el siguiente paso: el comando dd.
Diferencia clave:umount: Solo "desconecta" la partición del sistema de archivos. Tus carpetas y archivos siguen ahí, pero ocultos hasta que se vuelva a montar.dd: Este es el que hace la "limpieza". Como escribe tu imagen bit por bit directamente sobre el dispositivo físico (/dev/sdc), pisa cualquier tabla de particiones o archivo que hubiera antes para poner tu sector de arranque de 512 bytes al principio del disco.

# Montamos el archivo main.img en el pendrive

Para esto utilizamos el comando:

	sudo dd if=main.img of=/dev/sdc status=progress

# Con el pendrive montado
Me dirijo a la victima (la notebook vieja), y entro a la BIOS

Cambiar el Boot Mode: Seleccioná donde dice [UEFI] y lo cambio a [Legacy Support]

Prioridad de arranque: Una vez que cambies a Legacy, es probable que aparezca una opción nueva
llamada "Boot Priority". Ponela en [Legacy First].

Guardar y Reiniciar: Presioná F10 para guardar los cambios y salir.

Menú de Arranque: Al reiniciar, volvé a entrar al menú de booteo. Ahora debería aparecer tu pendrive (probablemente como "USB HDD" o con el nombre de la marca) bajo una sección que diga "Legacy". 

## Al activar el Legacy Support, la BIOS finalmente puede ver ese sector de arranque de 512 bytes que grabaste
1. Seleccioná el dispositivo correcto
En la sección Legacy, el que nos interesa es:

USB HDD : KingstonDataTraveler 3.0

2. Por qué "Legacy" y no "UEFI"Modo Real:
 Los procesadores x86 arrancan siempre en modo real para asegurar compatibilidad.

BIOS: Las funciones de la BIOS (como las que usaste en tu código) solo son accesibles en este modo.

Arranque: Como tu trabajo consiste en "evolucionar" desde el modo real al protegido,
 necesitás que la PC arranque de la forma tradicional (Legacy) para que lea tu MBR

3. Pasos finales
Prioridad: Asegurate de que el USB HDD esté primero en la lista de "Legacy" si querés que arranque automático, o simplemente usá la tecla de Boot Menu (probablemente F12 o F11) ni bien salgas de acá.

Guardar: Presioná F10 (Save and Exit) para confirmar los cambios.


El momento de la verdad: Si todo sale bien, la PC leerá tu pendrive y verás el resultado de tu 
código assembler en la pantalla física.
# NO ME SALIO, TUVE QUE PASAR A PROBAR EL HELLO WORD SIGUIENDO LOS PASOS DE LAS FILMINAS

# ME SALIO, PRUEBA EN EL GRUPO DE WPP
Fallo al intentar configurar la bios de la notebook porque parece que la seguridad que tiene no permitia 
que el codigo en el pendrive modifique 


# ¿Qué es UEFI?
Es una especificación que define la interfaz entre el sistema operativo y el firmware.
A diferencia de la BIOS tradicional, que está limitada a 16 bits y código assembler crudo, la UEFI:

Corre en 32 o 64 bits desde el inicio.

Está escrita mayormente en C.

No usa el sector de arranque (MBR) de 512 bytes; en su lugar, lee archivos de una partición especial
llamada ESP (EFI System Partition) formateada en FAT32.

## ¿Cómo puedo usarlo?
Para "programar" algo que bootee en modo UEFI puro, ya no hacés un binario plano de 512 bytes. Tenés que seguir estos pasos:

Formato PE: Tenés que compilar tu código como un ejecutable de Windows (formato .efi o PE/COFF).

Ubicación: Guardarlo en el pendrive dentro de la carpeta /EFI/BOOT/ con el nombre BOOTX64.EFI.

Tablas de Servicios: En lugar de llamar a interrupciones con int $0x10, la UEFI te pasa una estructura de datos al arrancar llamada System Table. Esta tabla contiene punteros a funciones (servicios) que ya están programados en el firmware.

¿Cómo se llama a una función?
A diferencia del Modo Real, acá tenés que seguir la Convención de Llamadas de Microsoft x64: los argumentos se pasan por registros (%rcx, %rdx, %r8, %r9) y tenés que reservar espacio en el stack ("shadow space").

### Función de ejemplo: OutputString

Si querés imprimir tu "Que onda perrin" en modo UEFI, ya no usás la interrupción 0x10. Usarías el servicio de salida de texto (Simple Text Output Protocol).

La dinámica sería algo así en pseudocódigo/C (que es como se programa UEFI):

	// SystemTable tiene un puntero a ConOut (Consola de Salida)
	// ConOut tiene un puntero a la función OutputString
	SystemTable->ConOut->OutputString(SystemTable->ConOut, L"Que onda perrin\r\n");

# UEFI

la UEFI es básicamente un sistema operativo en miniatura (tiene drivers, sistema de archivos, soporte de red y hasta interfaz gráfica), tiene un montón de código donde los programadores pueden mandar mocos.

A diferencia de la BIOS vieja, que era simple y "muda", la complejidad de UEFI la hace un blanco gigante para ataques.

## 1. LogoFAIL (Vulnerabilidad en Parsers de Imágenes)

Este es de los más recientes y "elegantes". Resulta que casi todas las UEFI permiten
que el fabricante ponga su logo (Lenovo, Dell, etc.) cuando arranca la compu.

El Bug: 
Los programadores usaron librerías de terceros para leer imágenes (BMP, JPEG) que tenían errores 
de desbordamiento de búfer (Buffer Overflow).

El Exploit:
Un atacante puede reemplazar el logo por una imagen maliciosa. Cuando la UEFI intenta 
"dibujar" el logo, el código malicioso se ejecuta con los privilegios más altos del sistema,
 antes de que Windows o Linux siquiera existan.

Por qué es un garrón: 
Saltarse el Secure Boot es trivial así, porque el código corre desde el mismo corazón del firmware.

## 2. BlackLotus (Bootkit de UEFI)

Este fue el primer malware que se encontró en el "mundo real" capaz de saltear por completo el Secure Boot.

El Bug: 
Explotaba una vulnerabilidad vieja (CVE-2022-21894) en el cargador de arranque de Windows que 
Microsoft no había parchado bien en las listas de revocación de la UEFI.

El Exploit: 
Lograba instalarse en la partición ESP (la que buscamos hoy en tu disco) y 
desactivaba las protecciones de la CPU.

Persistencia: 
Una vez adentro, puede reinstalarse aunque formatees el disco, porque vive en la interacción entre 
el hardware y el cargador.

## 3. Ataques a SMM (System Management Mode)

El SMM es el "Anillo -2" (Ring -2). Es un modo de ejecución ultra-privilegiado que interrumpe todo 
lo demás (incluso a tu kernel) para manejar cosas como la temperatura o la energía.

El Bug: 
Los "SMM Handlers" a veces no validan bien quién les manda información.

El Exploit:
Si un atacante logra meter código en la RAM de SMM (llamada SMRAM), se vuelve invisible. Ni el antivirus ni el sistema operativo pueden ver ese código porque el procesador "congela" 
todo lo demás cuando entra en ese modo.

## 4. CosmicStrand y MoonBounce (SPI Flash Implants)
Estos no son bugs de software per se, sino exploits que aprovechan cómo la UEFI se guarda en el hardware.

El Bug/Vulnerabilidad: 
Falta de protección de escritura en el chip SPI Flash (donde vive físicamente la UEFI).

El Exploit:
El malware sobreescribe una parte del firmware original.

Resultado: 
Es el "sueño" del hacker. Podés tirar la computadora a un río, cambiar el disco duro, ponerle RAM 
nueva... y el virus sigue ahí, porque vive en la placa madre.

# ¿Qué es Converged Security and Management Engine (CSME)?

con el CSME estamos hablando de lo que hay debajo del hardware que vos podés ver. Es el famoso "Anillo -3"
Es un subsistema autónomo que vive dentro del chipset de Intel (en el PCH). No es un programa; es básicamente una computadora chiquita y secreta que corre adentro de tu computadora principal.

Es independiente: Tiene su propio procesador (generalmente un núcleo tipo Intel Quark o un 486 modificado), su propia memoria RAM y su propio sistema operativo (una versión de MINIX 3).

Anillo -3: Si tu código assembler de hoy corre en el Anillo 0 (Kernel), el CSME corre en el Anillo -3. Tiene acceso total a la memoria RAM, a la red y al hardware, sin que tu sistema operativo se entere.

Sus funciones principales:

Seguridad: Maneja el TPM (Trusted Platform Module), las llaves de cifrado y el Secure Boot que te estuvo bloqueando el pendrive.

DRM: Se encarga de que no puedas "piratear" contenido en 4K (como Netflix) protegiendo la ruta del video.

Autenticación: Maneja tecnologías como Intel Boot Guard para verificar que el firmware no haya sido alterado.

## 2. ¿Qué es el Intel MEBx? (Management Engine BIOS Extension)

Es la interfaz de configuración (el menú) que te permite interactuar con el motor de administración (Intel ME/CSME) antes de que cargue el sistema operativo.

Cómo se ve: Es esa pantalla azul o gris medio "vintage" que a veces aparece después del logo de Lenovo y que dice algo como "Press Ctrl+P to enter MEBx".

Su función: Sirve para configurar el Intel AMT (Active Management Technology). Esto permite que un administrador de IT pueda:

Prender, apagar o reiniciar tu compu de forma remota (aunque esté apagada, siempre que tenga cable de corriente).

Ver tu pantalla de forma remota a nivel de hardware.

Formatear el disco o actualizar la BIOS a distancia.

#### SUPER INTERESANTE 

1. El concepto de "Apagado" es relativo
En las computadoras modernas, cuando le das a "Apagar", la máquina no se queda con 0 voltios de energía. Entra en un estado llamado S5 (Soft Off).

Mientras la fuente esté enchufada a la pared (o la laptop tenga batería), hay una línea de tensión de 5V Standby que alimenta partes críticas del chipset.

El CSME (el motor de Intel) es una de esas partes. Él nunca se apaga; es como el sereno de un edificio que se queda despierto cuando todos los empleados se van a su casa.

2. El "Cable" que nunca se desconecta
Para que vos puedas controlar la compu desde otra provincia, el CSME tiene su propia conexión a la red:

NIC Compartida: El CSME usa la misma placa de red (Ethernet) que usás vos en Debian.

El Truco: Cuando la compu está "apagada", el chip de red sigue energizado. Si llega un paquete especial (un "Magic Packet" o una consulta AMT), la placa de red no se la pasa al procesador principal (que está durmiendo), se la pasa directamente al CSME.

3. ¿Qué podés hacer exactamente con Intel AMT/MEBx?
Si configurás el Intel AMT a través del menú MEBx (ese que entrás con Ctrl+P), un administrador de red puede hacer cosas de locos:

KVM Remoto (Keyboard, Video, Mouse): Podés ver la pantalla, mover el mouse y entrar a la BIOS de una compu que está a 500km, incluso si el disco rígido se rompió y no tiene sistema operativo.

IDE Redirection: Podés "montar" una imagen .iso que tenés en TU compu como si fuera un pendrive enchufado en LA OTRA compu. Así podés instalarle Debian de forma remota a una máquina que está apagada.

Power Control: Literalmente tiene un cable físico conectado al pin de encendido. El CSME puede mandarle la señal de "Power On" al procesador principal.

¿Por qué esto es polémico?
Como te imaginarás, esto es el sueño de cualquier administrador de sistemas (como los pibes de La PI en la UNC que manejan cientos de servidores), pero también es la pesadilla de la ciberseguridad.

El "Backdoor" perfecto: Si alguien encuentra un bug en el CSME (como los que vimos de UEFI), puede controlar tu compu sin que vos te enteres, porque el código corre debajo de tu firewall, de tu antivirus y de tu kernel de Debian.

Invisible: Como el CSME tiene su propia RAM y procesador, no deja rastros en los logs de tu sistema operativo.

# ¿Que es Coreboot?
Es un proyecto de software libre destinado a reemplazar el firmware propietario (BIOS/UEFI) que viene de fábrica en las placas madre. Su filosofía es el minimalismo:

Lógica de "Payload": A diferencia de una BIOS común que intenta hacer todo, coreboot solo hace la inicialización mínima indispensable del hardware (CPU, memoria, registros) y luego le pasa la posta a un "payload" (carga útil).

Payloads famosos: Podés elegir que el payload sea SeaBIOS (para que se comporte como una BIOS vieja), TianoCore (para que sea una UEFI abierta) o incluso un Kernel de Linux (LinuxBoot), para que la compu arranque directamente en Linux en menos de un segundo.

¿Qué productos lo incorporan?
Históricamente, instalar coreboot era un riesgo (podías dejar la compu como un ladrillo), pero hoy hay marcas que lo traen de serie o comunidades que lo mantienen para modelos específicos:

Chromebooks: Casi todos los Google Chromebooks usan coreboot por debajo para lograr ese arranque tan rápido.

System76: Esta marca de laptops con Linux (como las Thelio o Lemur Pro) usa coreboot para asegurar que no haya blobs binarios cerrados estorbando.

Purism (Librem): Enfocadas totalmente en la privacidad, vienen con coreboot y el Intel ME neutralizado (muy relacionado con lo que hablábamos del CSME).

Star Labs: Otra marca europea que ofrece firmware abierto en sus notebooks.

Hardware antiguo (Modding): Es muy popular en modelos viejos de ThinkPads (como el X220, T420 o T440p). Los usuarios reemplazan el chip físico o lo flashean con pinzas para "liberar" la máquina.

PC Engines: Placas tipo embebidas (línea APU) muy usadas para routers y firewalls.

Ventajas de su utilización
1. Velocidad Absurda
Como coreboot no tiene que cargar miles de drivers de hardware que quizás ni tenés, el tiempo de arranque se reduce drásticamente. Hay máquinas que pasan del botón de encendido al prompt de login en 3 o 4 segundos.

2. Auditoría y Seguridad
Al ser código abierto, la comunidad puede revisar que no haya backdoors (puertas traseras) ni telemetría oculta enviando datos al fabricante. Es la única forma real de saber qué está haciendo el procesador en el "segundo cero".

3. Personalización Total
Podés eliminar funciones que no usás y agregar las que quieras. Por ejemplo, podés integrar un verificador de firmas propio para que la compu solo arranque si el sistema operativo está firmado por vos, sin depender de las llaves de Microsoft.

4. Limpieza del Intel ME
Es la herramienta principal para usar scripts como me_cleaner. Con coreboot, podés indicarle al Intel Management Engine que se apague después de inicializar el hardware, quitándole ese "poder de espionaje" o control remoto que mencionábamos antes.

