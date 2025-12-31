FROM node:18-alpine

WORKDIR /reddit-clone

COPY package*.json ./
RUN npm ci

COPY . .

RUN npm run build

EXPOSE 3000
CMD ["npm","start"]
