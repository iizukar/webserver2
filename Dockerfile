FROM honeygain/honeygain

USER root

# Install Python + Localtonet
RUN apt-get update && apt-get install -y python3 wget

# Download Localtonet binary
RUN wget https://localtonet.com/download/linux -O /usr/local/bin/localtonet && \
    chmod +x /usr/local/bin/localtonet

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
