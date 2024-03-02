#!/bin/bash

if [[ ! -f "/var/www/html/wp-config.php" ]]; then
	echo "Downloading wordpress..."
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp-cli.phar
	echo "Setting up wordpress..."
	wp-cli.phar core download --path=$WP_PATH --allow-root
	wp-cli.phar config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD \
		--dbhost=mariadb --path=$WP_PATH --skip-check --allow-root
	wp-cli.phar core install --path=$WP_PATH --url=$WP_URL --title=Inception \
		--admin_user=$WP_ADM_USER --admin_password=$WP_ADM_PASSWORD \
		--admin_email=$WP_ADM_EMAIL --skip-email --allow-root
	wp-cli.phar user create $WP_USER $WP_EMAIL --user_pass=$WP_PASSWORD \
		--role=author --allow-root
	echo "Done!"
fi

echo "Running wordpress on port 9000..."
/usr/sbin/php-fpm7.4 -F
