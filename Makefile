# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bmugnol- <bmugnol-@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/13 14:40:07 by bmugnol-          #+#    #+#              #
#    Updated: 2024/03/02 18:35:34 by bmugnol-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Includes intra profile login as the variable LOGIN
include ./srcs/.env

# Docker compose command
# (for easy switch between the deprecated 'docker-compose' and 'docker compose')
COMPOSE_CMD		:=	docker-compose

# Docker compose configuration file
COMPOSE_FILE	:=	./srcs/docker-compose.yml

# Volumes folder
VOLUME_FOLDER	:=	/home/$(LOGIN)/data

# -----------------------RULES------------------------------------------------ #
.PHONY: all up stop restart down clean build fclean preclean re

all: up

up: build
	sudo $(COMPOSE_CMD) --file=$(COMPOSE_FILE) up --build --detach

stop:
	sudo $(COMPOSE_CMD) --file=$(COMPOSE_FILE) stop

restart:
	sudo $(COMPOSE_CMD) --file=$(COMPOSE_FILE) restart

down clean:
	sudo $(COMPOSE_CMD) --file=$(COMPOSE_FILE) down --rmi all --remove-orphans -v

build:
	sudo mkdir -p $(VOLUME_FOLDER)/wordpress
	sudo mkdir -p $(VOLUME_FOLDER)/mariadb
	sudo chmod -R 777 $(VOLUME_FOLDER)/mariadb
	sudo chmod -R 777 $(VOLUME_FOLDER)/wordpress
	sudo $(COMPOSE_CMD) --file=$(COMPOSE_FILE) up --build --detach
	sudo grep $(LOGIN).42.fr /etc/hosts || echo "127.0.0.1 $(LOGIN).42.fr" | sudo tee -a /etc/hosts

# Full clean: stop and remove all Docker containers
fclean: clean
	sudo rm -rf $(VOLUME_FOLDER)

preclean:
	docker ps -a -q --filter "status=exited" | xargs -r docker rm
	docker images -q -f "dangling=true" | xargs -r docker rmi

re: fclean all
