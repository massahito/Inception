FROM	debian:bullseye
RUN	apt update && apt update -y
RUN	apt install -y php-fpm wordpress wget zip
RUN	wget https://wordpress.org/latest.zip && unzip -d /var/www latest.zip
COPY	./requirements/wordpress/tools/www.conf /etc/php/7.4/fpm/pool.d
COPY	./requirements/wordpress/tools/docker-entrypoint.sh /usr/local/bin/
RUN	mkdir -p /etc/php-fpm.d && echo "user = nginx\ngroup = nginx\nlisten = 127.0.0.1:9000" > /etc/php-fpm.d/www.conf
RUN	mkdir -p /run/php 
RUN	chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT	["docker-entrypoint.sh"]
CMD	["php-fpm7.4"]
