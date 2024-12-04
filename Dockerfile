FROM bitnami/node:16 as builder
ENV NODE_ENV="production"

COPY . /app

WORKDIR /app

USER root
RUN npm install

FROM bitnami/node:16
ENV NODE_ENV="production"
COPY --from=builder /app /app
WORKDIR /app

ENV PORT 5000
EXPOSE 5000

CMD [ "npm", "start" ]
