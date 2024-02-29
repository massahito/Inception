FROM	debian:bullseye
RUN	apt update &&  apt upgrade -y
RUN	apt install -y openssl nginx
COPY	./requirements/nginx/conf/default.conf /etc/nginx/conf.d/default.conf
CMD	["/usr/sbin/nginx", "-g", "daemon off;"]
