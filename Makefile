all: up

up:
	mkdir -p /home/${USER}/data/db
	mkdir -p /home/${USER}/data/website
	docker-compose -f srcs/docker-compose.yml up -d --build

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker volume rm $(docker volume ls -q) || true

fclean: clean
	docker-compose -f srcs/docker-compose.yml down -v --rmi all
	sudo rm -rf /home/${USER}/data
	docker network prune --force

re: fclean all