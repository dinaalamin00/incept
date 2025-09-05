all: up

up:
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker volume rm $(docker volume ls -q) || true

fclean: clean
	docker compose -f srcs/docker-compose.yml down -v --rmi all
re: clean all