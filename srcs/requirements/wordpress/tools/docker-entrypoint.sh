#!/bin/bash
set -ex

function create_wordpress_config() {
	if [ -n ${WORDPRESS_DB_NAME} ] || [ -n "${WORDPRESS_DB_USER}" ] || [ -n "${WODPRESS_DB_HOST}" ] || [ -n "${WORDPRESS_DB_HOST}" ] || [ -n "${WORDPRESS_DB_PASSWORD}" ]; then
		cd /var/www/html
		gosu wordpress wp config create --dbname="${WORDPRESS_DB_NAME:?'ERROR: WORDPRESS_DB_NAME is not set.'}" --dbuser="${WORDPRESS_DB_USER:? 'ERROR: WORDPRESS_DB_USER is not set.'}" --dbhost="${WORDPRESS_DB_HOST:?'ERROR:WORDPRESS_DB_HOST is not set'}" --dbpass="${WORDPRESS_DB_PASSWORD:?'ERROR: WORDPRESS_DB_PASSWORD is not set.'}" --path="/var/www/html"
	fi
}

function install_wordpress_core() {
	if [ -n ${WORDPRESS_ADMIN_NAME} ] || [ -n ${WORDPRESS_ADMIN_PASSWORD} ] || [ -n ${WORDPRESS_ADMIN_EMAIL} ] || [ -n ${WORDPRESS_TITLE}] || [ -n ${WORDPRESS_URL} ]; then
		cd /var/www/html
		gosu wordpress wp core install --admin_user="${WORDPRESS_ADMIN_NAME:?'ERROR: WORDPRESS_ADMIN_NAME is not set.'}" --admin_password=${WORDPRESS_ADMIN_PASSWORD:?'ERROR: WORDPRESS_ADMIN_PASSWORD is not set.'} --admin_email=${WORDPRESS_ADMIN_EMAIL:?'WORDPRESS_ADMIN_EMAIL'} --title=${WORDPRESS_TITLE:?'ERROR: WORDPRESS_TITLE is not set.'} --url=${WORDPRESS_URL:?'ERROR: WORDPRESS is not set.'} --path="/var/www/html"
	fi
}

function create_user() {
	if [ -n ${WORDPRESS_USER_NAME} ] || [ -n ${WORDPRESS_USER_PASSWORD} ] || [ -n ${WORDPRESS_USER_EMAIL} ]; then
		gosu wordpress wp user create ${WORDPRESS_USER_NAME:?'ERROR: WORDPRESS_USER_NAME is not set.'} ${WORDPRESS_USER_EMAIL:?'ERROR: WORDPRESS_USER_EMAL is not set.'} --user_pass=${WORDPRESS_USER_PASSWORD:?'ERROR: WORDPRESS_USER_PASSWORD is not set.'} --role=author
	fi
}

groupmod -g ${GROUP_ID:-1000} -o wordpress
usermod -u ${USER_ID:-1000} -g wordpress -o wordpress
chown -R wordpress:wordpress /run/php /var/www/html /var/www/wordpress /docker /var/log
if [ ! -e /var/www/html/wp-config.php ]; then
	cp -rf /var/www/wordpress/* /var/www/html/
	chown -R wordpress:wordpress /var/www/html
	create_wordpress_config
	install_wordpress_core
	create_user
fi
exec gosu wordpress "$@" -F -y /docker/docker-www.conf
