FROM golang:1.26.2@sha256:b54cbf583d390341599d7bcbc062425c081105cc5ef6d170ced98ef9d047c716 AS builder

WORKDIR /app

COPY . ./

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s" -o ./gatus

FROM scratch

WORKDIR /app

COPY --from=builder /app/gatus ./gatus
COPY --from=builder /app/config.yaml ./config/config.yaml


EXPOSE 8080
USER 1001

CMD [ "./gatus" ]