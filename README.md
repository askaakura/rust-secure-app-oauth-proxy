# Generic Rust app to test OAuth2 Proxy behind reverse proxy like Nginx

This is a generic rust application where it listens on port 8080 and serves a simple web page. It uses tokio and axum.

I will be running this application behind an OAuth2 Proxy using Docker Compose. The OAuth2 Proxy will be configured to use Google as the identity provider.
