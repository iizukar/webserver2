FROM honeygain/honeygain

USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3

# Copy configuration
COPY entrypoint.sh /entrypoint.sh
COPY proxychains.conf /etc/proxychains.conf

# Set permissions
RUN chmod +x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
