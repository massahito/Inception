FROM	debian:latest
RUN	apt update && apt upgrade -y
RUN	apt install -y mariadb-server gosu vim
CMD	["/bin/bash"]
