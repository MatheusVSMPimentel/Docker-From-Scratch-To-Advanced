FROM node:20-alpine AS build-stage
WORKDIR /app
COPY package-lock.json package.json /app/
RUN npm install
COPY . /app
RUN npm run build
FROM nginx:alpine AS publish-stage
ARG appname=angular-app
COPY --from=build-stage /app/dist/$appname/browser/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
