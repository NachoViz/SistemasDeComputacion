# LA CAPA SUPERIOR
import requests

# URL proporcionada en el enunciado
url = "https://api.worldbank.org/v2/en/country/ar/indicator/SI.POV.GINI?format=json&date=2011:2020"
def recuperar_gini():
    res = requests.get(url , timeout=10)

	# La API del Banco Mundial devuelve una lista donde:
        # datos[0] son metadatos de la paginación.
        # datos[1] es la lista con los valores anuales.

    if res.status_code == 200:
        datos = res.json()
        # El primer elemento del JSON suele ser metadatos, el segundo es la lista
        # Buscamos el primer valor no nulo del índice GINI
        for registro in datos[1]:
            valor = registro.get('value')
            anio = registro.get('date')

            if valor is not None:
                print(f"Response OK")
                print(f"Año: {anio} - Indice GINI: {valor}")
                return float(valor)
    else:
        print(f"Response Failed: {res.status_code}")
        return None

# Probamos la recuperación
gini_actual = recuperar_gini()
