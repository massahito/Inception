#!/bin/bash
set -eux
if [ ! -e /var/www/html/wp-config.php ]; then
	cp -fr /var/www/wordpress/* /var/www/html/
	wp config create --allow-root --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbhost="${WORDPRESS_DB_HOST}" --dbpass="${WORDPRESS_DB_PASSWORD}" --path="/var/www/html" --config-file="/var/www/html/wp-config.php"
fi
exec "$@" -F -R
