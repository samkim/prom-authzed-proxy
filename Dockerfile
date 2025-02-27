FROM golang:1.16-alpine3.13 AS build

WORKDIR /go/src/prom-authzed-proxy

COPY ./go.mod ./go.sum .
RUN go mod download

COPY ./ /go/src/prom-authzed-proxy
RUN go build .

FROM alpine:3.14.0
COPY --from=build /go/src/prom-authzed-proxy/prom-authzed-proxy /usr/local/bin/
CMD ["prom-authzed-proxy"]
