#!/bin/bash
set -eux
groupmod -g ${GROUP_ID} -o wordpress
usermod -u ${USER_ID} -g wordpress -o wordpress
chown -R wordpress:wordpress /run/php /var/www/html /var/www/wordpress /docker /var/log/
if [ ! -e /var/www/html/wp-config.php ]; then
	mv -f /var/www/wordpress/* /var/www/html/
	cd /var/www/html
	gosu wordpress wp config create --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbhost="${WORDPRESS_DB_HOST}" --dbpass="${WORDPRESS_DB_PASSWORD}" --path="/var/www/html"
	gosu wordpress wp core install --admin_user="${WORDPRESS_ADMIN_NAME}" --admin_password=${WORDPRESS_ADMIN_PASSWORD} --admin_email=${WORDPRESS_ADMIN_EMAIL} --title=${WORDPRESS_TITLE} --url=${WORDPRESS_URL} --path="/var/www/html"
fi
exec gosu wordpress "$@" -F -y /docker/docker-www.conf
