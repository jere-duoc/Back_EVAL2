#Construccion del dockerfile

FROM node:18 as build
WORKDIR /workspace

COPY package*.json ./
RUN npm install --only=production

#Ejecucion del programa
FROM node:18-slim
WORKDIR /app

# Usuario para minimo privilegio
RUN useradd -m ev2user

# Copiar las libs
COPY --from=build /workspace/node_modules ./node_modules
COPY . .

# Permisos al usuario 
RUN chown -R ev2useruser:ev2user /app
USER ev2user

EXPOSE 3000

# Punto de entrada
ENTRYPOINT ["node", "server.js"]