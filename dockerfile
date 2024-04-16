# Usa una imagen base de Node.js
FROM node:14

# Establece el directorio de trabajo en la imagen (el lugar donde estará tu aplicación dentro del contenedor)
WORKDIR /usr/src/app

# Copia el package.json y package-lock.json (si existen) para instalar dependencias
COPY package*.json ./

# Instala las dependencias de la aplicación
RUN npm install

# Copia el resto de la aplicación
COPY . .

# Expón el puerto en el que se ejecutará tu aplicación
EXPOSE 3000

# Comando para ejecutar la aplicación cuando se inicie el contenedor
CMD ["node", "app.js"]
