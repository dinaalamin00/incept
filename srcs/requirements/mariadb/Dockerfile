FROM debian:bookworm

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Create necessary directories with permissions
RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql && \
    chmod 755 /run/mysqld /var/lib/mysql

# Copy init script
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/init_db.sh /init_db.sh
RUN chmod +x /init_db.sh

EXPOSE 3306

# Run the init script as entrypoint
ENTRYPOINT ["/init_db.sh"]