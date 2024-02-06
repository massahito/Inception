SRC		=	srcs/docker-compose.yml
all:
	docker-compose -f ${SRC} up -d
