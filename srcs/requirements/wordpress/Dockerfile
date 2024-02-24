FROM	debian:bullseye
RUN	apt update && apt update -y
RUN	apt install -y php-fpm wordpress wget zip
RUN	wget https://wordpress.org/latest.zip && unzip -d /var/www latest.zip
COPY	./requirements/wordpress/tools/www.conf /etc/php/7.4/fpm/pool.d
COPY	./requirements/wordpress/tools/docker-entrypoint.sh /usr/local/bin/
RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN	mkdir -p /run/php 
RUN	chmod 755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT	["docker-entrypoint.sh"]
CMD	["php-fpm7.4"]
