FROM	debian:bullseye
RUN	apt update && apt update -y
RUN	apt install -y php-fpm wordpress wget zip gosu
RUN	wget https://wordpress.org/latest.zip && mkdir -p /var/www && unzip -d /var/www latest.zip
RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
COPY	./tools/www.conf /docker/docker-www.conf
COPY	./tools/docker-entrypoint.sh /usr/local/bin/
RUN	chmod 755 /usr/local/bin/docker-entrypoint.sh
RUN	mkdir -p /run/php 
RUN	groupadd wordpress && useradd -g wordpress wordpress

ENTRYPOINT	["docker-entrypoint.sh"]
CMD	["php-fpm7.4"]
