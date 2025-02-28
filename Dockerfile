FROM honeygain/honeygain

USER root

# Install Python + Latest Rust via rustup (not apt)
RUN apt-get update && apt-get install -y python3 curl && \
    # Install Rust using rustup (to get modern cargo)
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    # Add Cargo to PATH for current RUN command
    export PATH="/root/.cargo/bin:$PATH" && \
    # Install bore-cli with modern Rust
    cargo install bore-cli

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
