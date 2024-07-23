FROM golang:1.21 as base

WORKDIR /app

COPY go.mod . 

RUN go.mod download  #download dependencies

COPY ..

RUN go build -o main .
#stage distroless image

FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

CMD ["./main"]

EXPOSE 8080