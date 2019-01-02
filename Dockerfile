FROM node:8.9.1 as builder

WORKDIR /app
COPY package.json /app

RUN npm install

COPY . /app

RUN npm run build

FROM nginx:1.15.8

COPY --from=builder /app/dist /usr/share/nginx/html
COPY --from=builder /app/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD nginx -g 'daemon off;'
