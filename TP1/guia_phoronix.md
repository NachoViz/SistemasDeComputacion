# Guía de Phoronix Test Suite: Benchmark de CPU en Linux

Esta guía explica cómo instalar y ejecutar el test de compilación del kernel de Linux usando Phoronix Test Suite. Es una prueba de estrés puro para el procesador (CPU).

## ⚠️ Advertencias Previas
- **No ejecutar mientras se trabaja:** Esta prueba pone el uso de la CPU al **100%**. La PC se pondrá lenta y puede trabarse si tienes otras aplicaciones pesadas abiertas.
- **Temperatura:** Es normal que los ventiladores suenen fuerte y la PC levante temperatura (especialmente en notebooks).

## Paso 1: Instalación de dependencias
Abre la terminal y ejecuta el siguiente comando para descargar el software de benchmarking y las herramientas de compilación de C/C++ necesarias:

sudo apt update
wget https://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_10.8.4_all.deb
SINO FUNCIONA 
sudo apt install ./phoronix-test-suite_10.8.4_all.deb

SINO MOVER TODO A TMP
### Movemos el archivo a una zona neutral
cp /home/nacho/phoronix-test-suite_10.8.4_all.deb /tmp/

### Instalamos desde ahí
sudo apt install /tmp/phoronix-test-suite_10.8.4_all.deb

### Preguntamos la version
phoronix-test-suite version
_____________
sudo apt update
sudo apt install build-essential php-cli php-xml
___________________
sudo apt install libncurses-dev flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf

## Paso 2: Ejecutar el Test
Para iniciar la prueba específica de compilación del kernel, ejecuta:

phoronix-test-suite benchmark build-linux-kernel

### Durante la configuración inicial del test:
1. El programa puede hacerte preguntas sobre aceptar términos o compartir resultados anónimos (puedes responder `n` a todo).
2. Te preguntará qué configuración del kernel usar: elige la opción por defecto (`defconfig`).

## Paso 3: Resultados
La prueba descargará el código fuente y comenzará a compilar. Cuando termine, el resultado se mostrará en **segundos**. 
- **Regla de oro:** En este benchmark, *Lower is Better* (menos tiempo significa un procesador más potente).
