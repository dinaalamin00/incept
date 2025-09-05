#!/bin/bash

# If DB volume is empty, initialize
if [ ! -d /var/lib/mysql/wordpress ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Create initialization SQL file
    cat > /tmp/init.sql <<EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
CREATE USER IF NOT EXISTS '${MYSQL_ADMIN_USER}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN_USER}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

    # Start MariaDB with initialization file and wait for completion
    mysqld --user=mysql --init-file=/tmp/init.sql --console
    
    # Clean up
    rm -f /tmp/init.sql
fi

# Run MariaDB server in foreground
exec mysqld --user=mysql --console