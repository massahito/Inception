FROM	debian:bullseye
RUN	apt update &&  apt upgrade -y
RUN	apt install -y openssl nginx
CMD	["/usr/sbin/nginx", "-g", "daemon off;"]
