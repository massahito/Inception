#!/bin/bash
set -eux
if [ "$(id -u)" = "0" ]; then
	usermod -u ${USER_ID} -o mysql
	groupmod -g ${GROUP_ID} -o mysql
	chown -R mysql:mysql /run/mysqld /var/lib/mysql /docker-entrypoint-initdb.d docker-my.cnf
	exec gosu mysql ${BASH_SOURCE[0]} "$@"
fi

"$@" --skip-networking --default-time-zone=SYSTEM --wsrep_on=OFF \
	--expire-logs-days=0 \
	--loose-innodb_buffer_pool_load_at_startup=0 &
PID=$!
sleep 3

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

kill $!
wait $!
exec "$@" --defaults-file=docker-my.cnf

