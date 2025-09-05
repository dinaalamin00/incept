#!/bin/bash

# Wait for MariaDB to be ready
until mysql -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1;" > /dev/null 2>&1; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# If WP not installed (volume empty), set it up
if [ ! -f /var/www/html/wp-config.php ]; then
    cd /var/www/html
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    wp core download --allow-root
    wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=mariadb --allow-root
    wp core install --url=http://${DOMAIN_NAME} --title="${WP_TITLE}" --admin_user=${MYSQL_ADMIN_USER} --admin_password=${MYSQL_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --allow-root
    wp user create ${MYSQL_USER} ${WP_USER_EMAIL} --role=editor --user_pass=${WP_USER_PASSWORD} --allow-root
fi

# Run PHP-FPM in foreground
exec php-fpm8.2 -F