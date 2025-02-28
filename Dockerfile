FROM honeygain/honeygain

USER root

# Install dependencies (add bash)
RUN apt-get update && \
    apt-get install -y proxychains curl cron jq bash

# Copy configuration and scripts
COPY entrypoint.sh /entrypoint.sh
COPY update_proxies.sh /update_proxies.sh
COPY proxychains.conf /etc/proxychains.conf

# Set up cron job
RUN echo "0 * * * * root /update_proxies.sh" > /etc/cron.d/proxy-update && \
    chmod 0644 /etc/cron.d/proxy-update

# Set permissions
RUN chmod +x /entrypoint.sh /update_proxies.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
