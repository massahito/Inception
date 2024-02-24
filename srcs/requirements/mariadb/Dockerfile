FROM	debian:bullseye
RUN	apt update && apt upgrade -y
RUN	apt install -y mariadb-server gosu && apt clean

RUN	mkdir -p /run/mysqld && \
	chmod 755 /run/mysqld /var/lib/mysql && \
	mkdir -p /docker-entrypoint-initdb.d
COPY	./requirements/mariadb/tools/docker-my.cnf docker-my.cnf
COPY	./requirements/mariadb/tools/docker-entrypoint.sh /usr/local/bin/
RUN	chmod +x /usr/local/bin/docker-entrypoint.sh
COPY	./requirements/mariadb/tools/init.sql /docker-entrypoint-initdb.d/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD	["mariadbd"]
