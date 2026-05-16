FROM node:22-alpine

RUN apk add --no-cache bash git

RUN npm install -g @angular/cli@21

WORKDIR /var/www/frontend

EXPOSE 4200

CMD ["ng", "serve", "--host=0.0.0.0", "--poll=2000"]
