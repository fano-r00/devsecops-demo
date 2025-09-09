# Build stage
FROM node:20-alpine AS build  
# Aca se especifica la imagen de node y como se llama, en este caso "build"
WORKDIR /app 
# Establece el directorio de trabajo dentro del contenedor
COPY package*.json ./ 
# Copia los archivos de dependencias
RUN npm ci 
# Instala las dependencias de manera limpia
COPY . . 
# Copia el resto de los archivos de la aplicación
RUN npm run build 
# Construye la aplicación

# Production stage
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
# Add nginx configuration if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]