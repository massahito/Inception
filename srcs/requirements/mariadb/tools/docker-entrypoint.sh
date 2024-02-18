#!/bin/bash
set -eux
if [ "$(id -u)" = "0" ]; then
	exec gosu mysql ${BASH_SOURCE[0]} "$@"
fi

"$@" --skip-networking --default-time-zone=SYSTEM --wsrep_on=OFF \
	--expire-logs-days=0 \
	--loose-innodb_buffer_pool_load_at_startup=0 &
PID=$!
sleep 5
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
kill $!
wait $!
exec "$@"

