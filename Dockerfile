# Stage 1: Build the frontend application
FROM node:lts-alpine as build-stage
WORKDIR /frontend
RUN npm install -g @angular/cli
COPY ../fr-administration-front/package*.json .
RUN npm install
COPY ../fr-administration-front .
RUN npm run build

# Stage 2: Setup Nginx to serve the built frontend
FROM nginx:latest
RUN mkdir /http-server
COPY --from=build-stage frontend/dist/fr-administration-front/ /http-server

EXPOSE 80
