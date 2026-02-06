# Rust OAuth2 Proxy Demo

This project demonstrates how to secure a Rust web application using OAuth2 Proxy. The setup includes a simple Rust application that listens on port 8080 and is protected by OAuth2 Proxy using Google as the identity provider.

## Overview

- **Rust Application**: A simple web server built with Tokio and Axum that serves a basic web page
- **OAuth2 Proxy**: Provides authentication layer that sits in front of the Rust application
- **Docker Compose**: Orchestrates both services for easy deployment

## Prerequisites

Before running this project, you'll need:

1. [Docker](https://www.docker.com/get-started)
2. [Docker Compose](https://docs.docker.com/compose/install/)
3. A Google OAuth2 application (Client ID and Client Secret)
4. Access to a domain for the redirect URL

## Setup Instructions

### 1. Configure Environment Variables

- Copy the example environment file and customize it for your setup:
```bash
cp .env.example .env
```
- Update the `.env` file with required values.
- Generate a strong secret for the cookie secret, you may use either of these commands:
  ```bash
  openssl rand -base64 32
  # or
  head -c 32 /dev/urandom | base64
  # or
  python3 -c 'import os,base64; print(base64.urlsafe_b64encode(os.urandom(32)).decode())'
  ```

While this setup defaults to Google, OAuth2 Proxy supports many providers including:

- GitHub
- GitLab
- Azure AD
- OpenID Connect providers
- And more

To change the provider, update the `OAUTH2_PROXY_PROVIDER` variable in your `.env` file and adjust other provider-specific settings as needed.

### Access Control

Access can be controlled in two ways:
1. **Email Domain Restriction**: Set `OAUTH2_PROXY_EMAIL_DOMAINS` to restrict to specific domains
2. **Whitelist**: Add email addresses to `config/whitelist.txt` for fine-grained access control

## Development

- To run the Rust application locally without OAuth2 Proxy:
  ```bash
  cargo run
  ```
- You can also use `docker compose` to run the application with OAuth2 Proxy:
  ```bash
  docker compose --profile dev up
  ```
The application will be available at `http://localhost:8080`.

## Run in production:
In production, I use nginx therefore I have added some environment keys for the configuration. Also, I have added some `nginx.conf` file to configure the web server. The configuration could be used to configure nginx installed in host machine.
- To run the application in production, use `docker compose`:
  ```bash
  docker compose --profile prod up
  ```

---

That's all folks!