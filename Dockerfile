FROM bitnami/node:16 as builder
ENV NODE_ENV="production"

COPY ./app /app

WORKDIR /app

RUN npm install

FROM bitnami/node:16-prod
ENV NODE_ENV="production"
COPY --from=builder /app /app
ENV PORT 5006
EXPOSE 5006

CMD [ "npm", "start" ]
