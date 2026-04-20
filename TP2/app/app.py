import requests # Se recomienda el uso de requests para API Rest [cite: 23, 75]
import ctypes   # Se utiliza ctypes para extender Python con código de C [cite: 98, 107]

# URL del Banco Mundial para el índice GINI de Argentina [cite: 23]
url = "https://api.worldbank.org/v2/en/country/ar/indicator/SI.POV.GINI?format=json&date=2011:2020"

def recuperar_gini():
    """Recupera la información del Banco Mundial (Capa Superior)"""
    try:
        res = requests.get(url, timeout=10)
        
        if res.status_code == 200:
            print('Response OK')
            datos = res.json()
            
            # datos[1] contiene la lista con los valores anuales 
            for registro in datos[1]:
                valor = registro.get('value')
                anio = registro.get('date')

                # Buscamos el primer valor no nulo del índice GINI 
                if valor is not None:
                    print(f"Año: {anio} - Indice GINI: {valor}")
                    return float(valor)
        else:
            print(f'Response Failed: {res.status_code}')
    except Exception as e:
        print(f"Error al conectar con la API: {e}")
    return None

def main():
    # 1. Recuperar el dato de la Capa Superior
    gini_actual = recuperar_gini()

    if gini_actual is not None:
        try:
            # 2. Cargar la librería de la Capa Intermedia (C + ASM) [cite: 109]
            # Asegúrate de haber compilado el .so previamente
            lib = ctypes.CDLL('./libgini.so')

            # 3. Definir los tipos de datos según la convención de llamadas [cite: 11, 110]
            # El argumento es un double y el retorno un long (64 bits) [cite: 111, 112]
            lib.puente_python_asm.argtypes = (ctypes.c_double,)
            lib.puente_python_asm.restype = ctypes.c_long

            # 4. Entregar los datos al programa en C y obtener el resultado (+1) 
            resultado = lib.puente_python_asm(gini_actual)

            print(f"\n--- RESULTADO DEL TRABAJO PRÁCTICO ---")
            print(f"Valor original de la API: {gini_actual}")
            print(f"Resultado final calculado en ASM (Entero + 1): {resultado}")

        except OSError:
            print("Error: No se encontró 'libgini.so'. Verificá la compilación.")

if __name__ == "__main__":
    main()
