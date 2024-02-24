SRC		=	srcs/docker-compose.yml
all:
	docker compose -f ${SRC} up --build
clean:
	docker compose -f ${SRC} down 
fclean: clean
	sudo rm -rf ${HOME}/data
