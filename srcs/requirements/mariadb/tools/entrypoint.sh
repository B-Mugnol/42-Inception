#!/bin/bash

INIT_FILE="/tmp/init.sql"

# Injects environment variables
sed -i -e "s/\$DB_NAME/$DB_NAME/g" $INIT_FILE
sed -i -e "s/\$DB_USER/$DB_USER/g" $INIT_FILE
sed -i -e "s/\$DB_PASSWORD/$DB_PASSWORD/g" $INIT_FILE
sed -i -e "s/\$DB_ROOT_PASSWORD/$DB_ROOT_PASSWORD/g" $INIT_FILE

# Setup mysql database if it doesn't exist
if [ -d "/var/lib/mysql/$DB_NAME" ]; then
	mysqld_safe
else
	echo "Setting up $DB_NAME database..."
	mysqld --init-file=$INIT_FILE
fi
