FROM golang:1.21.0-alpine3.18 AS builder

WORKDIR /hellohealth
COPY . .
RUN go build .

FROM alpine:3.18.3

# We need curl to hit the health check endpoint.
RUN apk --no-cache add curl

WORKDIR /hellohealth
COPY --from=builder /hellohealth /hellohealth

# Use curl to hit the healthcheck endpoint. If the hit suceeds exit with 0, 1 otherwise.
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://127.0.0.1:8080/api/health_checks/ready || exit 1

EXPOSE 8080
ENTRYPOINT ["./hellohealth"]
