FROM	debian:bullseye
RUN	apt update &&  apt upgrade -y
RUN	apt install -y openssl php7.4-fpm nginx
RUN	touch /var/www/html/index.php
COPY	--chown=root:root ./requirements/nginx/conf/default.conf /etc/nginx/conf.d/default.conf
COPY	--chown=root:root ./requirements/nginx/conf/server.key /etc/nginx/ssl/server.key
COPY	--chown=root:root ./requirements/nginx/conf/server.crt /etc/nginx/ssl/server.crt
CMD	["/usr/sbin/nginx", "-g", "daemon off;"]

