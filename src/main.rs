use axum::{Router, http::HeaderMap, routing::get};
use tokio::net::TcpListener;

#[tokio::main]
async fn main() {
    let app: Router = Router::new()
        .route("/", get(handler))
        .route("/health", get(|| async { "OK" }));

    let addr = "0.0.0.0:8080";

    let listener = TcpListener::bind(addr).await.unwrap();
    println!("🚀 Rust Server starting on http://{}", addr);

    axum::serve(listener, app).await.unwrap();
}

async fn handler(headers: HeaderMap) -> String {
    let user = headers
        .get("X-WebAuth-User")
        .and_then(|h| h.to_str().ok())
        .unwrap_or("Unknown User (Direct Access)");

    format!(
        "Hello, {}! \n\nThis message is coming from a secure Rust backend.",
        user
    )
}
