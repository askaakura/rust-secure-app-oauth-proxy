# build stage
FROM rust:1.93.0-alpine3.23 AS builder

WORKDIR /app

RUN apk add --no-cache musl-dev

COPY Cargo.toml Cargo.lock ./

# create a dummy main.rs to allow cargo to download and compile dependencies
RUN mkdir src && \
  echo "fn main() { println!(\"dummy\"); }" > src/main.rs
RUN cargo build --release && rm src/*.rs

COPY src ./src/

# yeah, seems unnecessary but it does reduce the image size
RUN touch -a -m src/*.rs && cargo build --release

# runtime stage
FROM alpine:3.23

RUN apk add --no-cache ca-certificates tzdata

WORKDIR /app

COPY --from=builder /app/target/release/rust-secure-app-oauth-proxy ./

RUN addgroup -g 1001 -S appuser && \
  adduser -u 1001 -S appuser -G appuser

USER appuser

EXPOSE 8080

CMD ["./rust-secure-app-oauth-proxy"]
