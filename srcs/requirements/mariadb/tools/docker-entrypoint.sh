#!/bin/bash
set -ex
if [ "$(id -u)" = "0" ]; then
	usermod -u ${USER_ID:-1000} -o mysql
	groupmod -g ${GROUP_ID:-1000} -o mysql
	mkdir -p /var/lib/docker-mysql/data
	chown -R mysql:mysql /run/mysqld /var/lib/mysql /docker-entrypoint-initdb.d docker-my.cnf /var/lib/docker-mysql
	mariadb-install-db --user=mysql --datadir=/var/lib/docker-mysql/data
	exec gosu mysql ${BASH_SOURCE[0]} "$@"
fi

if [ ! "$(ls -R /var/lib/docker-mysql/data)" ]; then
	mariadb-install-db --user=mysql --datadir=/var/lib/docker-mysql/data
fi

"$@" --datadir=/var/lib/docker-mysql/data --skip-networking --default-time-zone=SYSTEM --wsrep_on=OFF \
	--expire-logs-days=0 \
	--loose-innodb_buffer_pool_load_at_startup=0 &
PID=$!
sleep 3

if [ ! -n ${MYSQL_ROOT_PASSWORD} ]; then
	echo "MYSQL_ROOT_PASSWORD is unset." >&2
	exit 1
fi

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

if [ -n ${MYSQL_USER} ] || [ -n ${MYSQL_PASSWORD} ]; then
	mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER:?'ERROR: MYSQL_USER is unset.'}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD:?'ERROR: MYSQL_PASSWORD is unset.'}';"
fi

if [ -n ${MYSQL_DATABASE} ]; then
	mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}"
fi

if [ -n ${MYSQL_USER} ] && [ -n ${MYSQL_PASSWORD} ]; then
	mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
fi
mysql -e "FLUSH PRIVILEGES;"

kill $!
wait $!
exec "$@" --defaults-file=docker-my.cnf

