# Usa una imagen base oficial de Python
FROM python:3.12-slim

# Instala dependencias necesarias del sistema
RUN apt-get update && apt-get install -y \
    libpq-dev gcc zlib1g-dev libjpeg-dev && \
    apt-get clean

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia solo los archivos de configuración primero (para aprovechar el cacheo de Docker)
COPY requirements.txt /app/

# Instala las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo el proyecto
COPY . /app/

# Cambia al directorio donde está manage.py
WORKDIR /app/webpersonal

# Expone el puerto 8000
EXPOSE 8000

# Comando por defecto para ejecutar Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
