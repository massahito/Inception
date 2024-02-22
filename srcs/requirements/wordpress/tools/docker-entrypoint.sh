#!/bin/bash
cp -r /var/www/wordpress/* /var/www/html/
wp core download --allow-root
wp config create --allow-root --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbhost="${WORDPRESS_DB_HOST}" --dbpass="${WORDPRESS_DB_PASSWORD}" --config-file="/var/www/html/wp-config.php"
exec "$@" -F -R
