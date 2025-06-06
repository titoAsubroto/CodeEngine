FROM quay.io/projectquay/golang:1.23 AS build-env
WORKDIR /go/src/app
COPY . .

RUN CGO_ENABLED=0 go build -o /go/bin/app app.go

# Copy the exe into a smaller base image
FROM gcr.io/distroless/static-debian12
COPY --from=build-env /go/bin/app /
COPY page.html /
COPY pictures/* /pictures/
ENTRYPOINT ["/app"]
