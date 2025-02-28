FROM honeygain/honeygain

USER root

# Install Python and bore (Rust tool)
RUN apt-get update && apt-get install -y python3 cargo && \
    cargo install bore-cli

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
