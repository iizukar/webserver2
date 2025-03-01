FROM bitping/bitpingd:latest

USER root

# Install Python for dummy server (adjust based on base image)
RUN if ! command -v python3 >/dev/null; then \
      (apt-get update && apt-get install -y python3) || (apk add --no-cache python3); \
    fi

# Create dummy content directory
RUN mkdir /dummy
COPY index.html /dummy/index.html

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
