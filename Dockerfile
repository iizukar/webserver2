FROM honeygain/honeygain

USER root

# Install Python + SSH client for Serveo
RUN apt-get update && apt-get install -y python3 openssh-client

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
