FROM	debian:bullseye
RUN	apt update && apt upgrade -y
RUN	apt install -y mariadb-server gosu && apt clean

RUN	mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld && \
	chmod 1777 /run/mysqld /var/lib/mysql && \
	mkdir -p /docker-entrypoint-initdb.d
COPY	./requirements/mariadb/tools/docker-entrypoint.sh /usr/local/bin/
RUN	chmod +x /usr/local/bin/docker-entrypoint.sh

VOLUME /var/lib/mysql
ENTRYPOINT ["docker-entrypoint.sh"]
CMD	["mariadbd"]
