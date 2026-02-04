FROM rust:latest as builder

WORKDIR /app
COPY . .
RUN cargo build --release

FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/target/release ./

EXPOSE 8080

CMD ["./rust-secure-app-oauth-proxy"]
