DATA_DIR = /home/${USER}/data
DB_DATA_DIR = /home/${USER}/data/mariadb_data
WP_DATA_DIR = /home/${USER}/data/wordpress

all: build up

up:
	sudo docker-compose -f srcs/docker-compose.yml up -d

build:
	mkdir -p $(DB_DATA_DIR)
	mkdir -p $(WP_DATA_DIR)
	sudo docker-compose -f srcs/docker-compose.yml build

down:
	sudo docker-compose -f srcs/docker-compose.yml down

clean: down
	sudo docker rmi -f $(shell sudo docker images -q)

fclean: down
	sudo docker volume rm $$(sudo docker volume ls -q) || true
	sudo rm -rf $(DATA_DIR)
	yes | sudo docker system prune -a --volumes

re: fclean all

.PHONY: all up build down clean fclean re
