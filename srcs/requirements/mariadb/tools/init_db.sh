#!/bin/bash

echo >> $DB_CONF_ROUTE
echp "[mysqld]" >> $DB_CONF_ROUTE
echo "bind-address=0.0.0.0">> $DB_CONF_ROUTE