FROM golang:latest AS builder

WORKDIR /app

COPY . ./

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o ./gatus

FROM scratch

WORKDIR /app

COPY --from=builder /app/gatus ./gatus
COPY --from=builder /app/config.yaml ./config/config.yaml

EXPOSE 8080

CMD [ "./gatus" ]