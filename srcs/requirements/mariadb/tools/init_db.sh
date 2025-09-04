#!/bin/bash

echo >> $DB_CONF_ROUTE
echp "[mysqld]" >> $DB_CONF_ROUTE
echo "bind-address=0.0.0.0">> $DB_CONF_ROUTE
echo "max_connections = 200" >> $DB_CONF_ROUTE

if [ ! -d "$DB_INSTALL/mysql" ]; then
    mysql_install_db--datadir=$DB_INSTALL
fi

mysqld_safe & mysql_pid=$!

until mysqladmin ping>/dev/null2>&1; do
    echo -n ".";sleep 0.2
done

myaql -u root -e "CREATE DATABSE $DB_NAME;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
    GRAN ALL ON $DB_NAME.* TO '$DB_USER'@%'IDENTIFIED BY '$DB_PASS';
    FLUSH PRIVILEGES;"

wait $mysql_pid 