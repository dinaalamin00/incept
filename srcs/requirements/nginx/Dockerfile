FROM debian:bookworm

# Install NGINX and OpenSSL for self-signed certificate
RUN apt-get update && apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Create directories for SSL and configure permissions
RUN mkdir -p /etc/nginx/ssl && \
    chown -R www-data:www-data /etc/nginx/ssl && \
    chmod 700 /etc/nginx/ssl

# Generate self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/CN=diahmed.42.fr" 

# Copy NGINX configuration and startup script
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/start_nginx.sh /start_nginx.sh
RUN chmod +x /start_nginx.sh

# Expose port 443
EXPOSE 443

# Run NGINX via script
ENTRYPOINT ["/start_nginx.sh"]