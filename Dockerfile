FROM alpine:latest

# Install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    jq \
    openssl \
    libqrencode \
    libstdc++

# Download Honeygain
RUN mkdir -p /app && \
    curl -L https://download.honeygain.com/cli/linux_x86_64/honeygain \
    -o /app/honeygain && \
    chmod +x /app/honeygain

# Install dummy HTTP server to keep container alive
RUN apk add --no-cache python3 && \
    python3 -m http.server 8080 &

WORKDIR /app

# Set entrypoint
COPY honeygain.sh .
RUN chmod +x honeygain.sh
CMD ["./honeygain.sh"]
