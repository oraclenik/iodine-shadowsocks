FROM alpine:latest

# Install iodine from Alpine packages
RUN apk add --no-cache iodine

# Expose DNS UDP port
EXPOSE 53/udp

# Copy entrypoint script
COPY iodined.sh /usr/local/bin/iodined.sh
RUN chmod +x /usr/local/bin/iodined.sh

# Use environment variables set by docker-compose
ENTRYPOINT ["/usr/local/bin/iodined.sh"]
