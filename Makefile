SRC		=	srcs/docker-compose.yml
all:
	docker compose -f ${SRC} up --build
clean:
	docker compose -f ${SRC} down 
flcean:
	rm -rf ./requirements/wordoress/data
