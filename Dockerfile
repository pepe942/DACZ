# Usa una imagen oficial de Node.js como base
FROM node:18-bullseye as bot

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos necesarios para instalar dependencias
COPY package*.json ./

# Instala dependencias del proyecto
RUN npm install

# Copia el resto de los archivos al contenedor
COPY . .

# Añade dependencias del sistema necesarias para Puppeteer
RUN apt-get update && apt-get install -y \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    wget \
    xdg-utils \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Exponer puerto (opcional para Railway)
EXPOSE 3000

# Variables de entorno opcionales para Railway
ARG RAILWAY_STATIC_URL
ARG PUBLIC_URL
ARG PORT

# Comando para iniciar la aplicación
CMD ["npm", "start"]
