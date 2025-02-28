FROM honeygain/honeygain

# Switch to root to modify permissions
USER root

# Copy and set executable permissions
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch back to the original non-root user (if needed)
USER nobody

ENTRYPOINT ["/entrypoint.sh"]
