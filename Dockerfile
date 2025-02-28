FROM honeygain/honeygain

USER root

# Install minimal dependencies
RUN apt-get update && \
    apt-get install -y proxychains curl cron procps python3

# Copy configuration
COPY entrypoint.sh /entrypoint.sh
COPY proxychains.conf /etc/proxychains.conf

# Set up hourly proxy updates
RUN echo "0 * * * * root curl -sL 'https://raw.githubusercontent.com/r00tee/Proxy-List/main/Socks5.txt' -o /proxies.txt" > /etc/cron.d/proxy-update && \
    chmod 0644 /etc/cron.d/proxy-update

# Set permissions
RUN chmod +x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
