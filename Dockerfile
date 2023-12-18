FROM eclipse-temurin:21-alpine
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
RUN apk add jq
RUN apk add curl
ENTRYPOINT ["/entrypoint.sh"]
