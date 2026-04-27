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


