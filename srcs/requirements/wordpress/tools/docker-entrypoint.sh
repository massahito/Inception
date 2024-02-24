#!/bin/bash
set -eux
if [ ! -e /var/www/html/wp-config.php ]; then
	cd /var/www/html
	cp -fr /var/www/wordpress/* /var/www/html/
	wp config create --allow-root --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbhost="${WORDPRESS_DB_HOST}" --dbpass="${WORDPRESS_DB_PASSWORD}" --path="/var/www/html"
	wp core install --allow-root --admin_user="${WORDPRESS_ADMIN_NAME}" --admin_password=${WORDPRESS_ADMIN_PASSWORD} --admin_email=${WORDPRESS_ADMIN_EMAIL} --title=${WORDPRESS_TITLE} --url=${WORDPRESS_URL} --path="/var/www/html"
fi
exec "$@" -F -R
