FROM alpine:3.8 

RUN apk add --no-cache curl

COPY app .

EXPOSE 8080

# HEALTHCHECK --interval=5s --timeout=2s --retries=12 CMD curl --silent --fail http://localhost:8080/health || exit 1
HEALTHCHECK --interval=5s --timeout=2s --retries=12 CMD curl -sS http://0.0.0.0:8080/health || exit 1

CMD ["/app"]
