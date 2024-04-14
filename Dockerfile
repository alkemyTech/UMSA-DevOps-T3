# Usa la imagen oficial de Node.js como base
FROM node:14

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /usr/src/app

# Copia los archivos package.json y package-lock.json (si existe)
COPY package*.json ./

# Instala las dependencias de la aplicación
RUN npm install

# Copia el resto de los archivos de la aplicación
COPY . .

# Expone el puerto en el que la aplicación se ejecuta dentro del contenedor
EXPOSE 3000

# Comando para ejecutar la aplicación cuando se inicie el contenedor
CMD ["node", "app.js"]
