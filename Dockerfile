FROM honeygain/honeygain

# Switch to root for installations
USER root

# Install Python + Ngrok (for tunneling)
RUN apt-get update && apt-get install -y python3 wget unzip && \
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && \
    tar -xvzf ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin && \
    chmod +x /usr/local/bin/ngrok

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Render requires port exposure
EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
