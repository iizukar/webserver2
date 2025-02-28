FROM honeygain/honeygain

USER root

# Install dependencies including procps for pgrep/pkill
RUN apt-get update && \
    apt-get install -y proxychains curl cron jq bash procps python3

# Copy configuration and scripts
COPY entrypoint.sh /entrypoint.sh
COPY update_proxies.sh /update_proxies.sh
COPY proxychains.conf /etc/proxychains.conf

# Set up cron job
RUN echo "0 * * * * root /update_proxies.sh" > /etc/cron.d/proxy-update && \
    chmod 0644 /etc/cron.d/proxy-update

# Set permissions
RUN chmod +x /entrypoint.sh /update_proxies.sh

# Explicitly expose and bind to port 8000
EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
