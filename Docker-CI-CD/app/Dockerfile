# 1. Imagen base de Python
FROM python:3.13-slim

# 2. Directorio de trabajo dentro del contenedor
WORKDIR /app

# 3. Copiar lista de dependencias e instalarlas
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copiar el resto del código (app.py, tests, etc.)
COPY . .

# 5. Comando para ejecutar la aplicación
CMD ["python", "app.py"]
