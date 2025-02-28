FROM honeygain/honeygain

# Switch to root for package installation
USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3 tor torsocks curl

# Configure Tor
RUN echo "ExitPolicy reject *:*" >> /etc/tor/torrc && \
    echo "SocksPort 0.0.0.0:9050" >> /etc/tor/torrc

# Copy files and set permissions
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose required ports
EXPOSE 8000 9050

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
