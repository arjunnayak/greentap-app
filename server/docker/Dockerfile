FROM node:12.16.1-stretch
EXPOSE 3001 9229

WORKDIR /app

COPY ./package.json /app/
COPY ./package-lock.json /app/

RUN npm ci
RUN npm i -g nodemon

COPY . /app

CMD npm run server