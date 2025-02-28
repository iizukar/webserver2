FROM honeygain/honeygain

USER root

# Install Python and ensure Honeygain is executable
RUN apt-get update && apt-get install -y python3 && \
    chmod +x /usr/local/bin/honeygain  # Adjust path if necessary

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Render uses $PORT, so EXPOSE is optional but can match default
EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
