# making a multi stage Dockerfile to decrease the size of container.
#1st:
FROM golang:1.16-buster as builder

WORKDIR /app

COPY main.go db.go go.sum go.mod /app/

RUN go mod download 

RUN CGO_ENABLED=0 GOOS=linux go build -o webapp 


#2nd:
FROM alpine:latest

WORKDIR /app

#RUN apt-get update && apt-get install -y bash

COPY --from=builder /app/webapp /app/

EXPOSE 9090

CMD ["./webapp"]
