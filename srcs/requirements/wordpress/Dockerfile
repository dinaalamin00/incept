FROM debian:bookworm

# Install dependencies
RUN apt-get update && apt-get install -y php8.2-fpm php8.2-mysql wget curl mariadb-client && \
    rm -rf /var/lib/apt/lists/*
# Copy configuration
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Setup WordPress directory
RUN mkdir -p /var/www/html && \
    chown www-data:www-data /var/www/html && \
    chmod 755 /var/www/html

# Copy setup script
COPY tools/setup_wp.sh /setup_wp.sh
RUN chmod +x /setup_wp.sh

# Expose port 9000
EXPOSE 9000

ENTRYPOINT ["/setup_wp.sh"]