SRC		=	srcs/docker-compose.yml
all:
	docker compose -f ${SRC} up --build
clean:
	docker compose -f ${SRC} down -v
fclean: clean
	rm -rf ${HOME}/data/wordpress/* ${HOME}/data/mysql/*
