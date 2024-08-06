### STAGE 1: Définir le répertoire de travail ###
FROM node:20.16.0-alpine as build
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

### STAGE 2: ###
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/conf.d/
COPY --from=build /usr/src/app/dist/FormSubmit /usr/share/nginx/html
EXPOSE 80
