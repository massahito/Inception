FROM	debian:latest
RUN	apt update &&  apt upgrade -y
RUN	apt install -y openssl nginx
COPY	--chmod=777 ./requirements/nginx/conf/default.conf /etc/nginx/conf.d/default.conf
COPY	--chmod=777 ./requirements/nginx/conf/server.key /etc/nginx/ssl/server.key
COPY	--chmod=777 ./requirements/nginx/conf/server.crt /etc/nginx/ssl/server.crt
CMD	["/usr/sbin/nginx", "-g", "daemon off;"]

