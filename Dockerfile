# Use the ultra-small BusyBox image
FROM busybox:stable-musl

# Create a non-root user for security
RUN adduser -D staticuser
USER staticuser
WORKDIR /home/staticuser

# Copy your files
COPY . .

# Run the BusyBox HTTP daemon 
# -f: stay in foreground
# -p 8080: listen on port 8080
# -h: home directory
CMD ["httpd", "-f", "-p", "8080", "-h", "."]