FROM node:18 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM amazon/aws-lambda-nodejs:18
COPY --from=builder /app/dist/index.js ./
COPY package*.json ./
RUN npm install --production
CMD [ "index.handler" ]