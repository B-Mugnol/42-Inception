# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bmugnol- <bmugnol-@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/13 14:40:07 by bmugnol-          #+#    #+#              #
#    Updated: 2024/01/13 15:12:29 by bmugnol-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Intra profile login
LOGIN	:=	bmugnol-

# Docker compose configuration file
COMPOSE_FILE	:=	srcs/docker-compose.yml

# Volumes folder
VOLUME_FOLDER	:=	/home/$(LOGIN)/data

# -----------------------RULES------------------------------------------------ #
.PHONY: all stop restart down fclean

all: up

up:
	docker compose $(COMPOSE_FILE) up

stop:
	docker compose $(COMPOSE_FILE) stop

restart:
	docker compose $(COMPOSE_FILE) restart

down clean:
	docker compose $(COMPOSE_FILE) down

# Directory making
$(VOLUME_FOLDER):
	sudo mkdir -p $@
$(VOLUME_FOLDER)/wordpress $(VOLUME_FOLDER)/mariadb : $(VOLUME_FOLDER)
	sudo mkdir -p $@

# Full clean: stop and remove all Docker containers
# fclean: down
fclean:
	@sudo rm -rf $(VOLUME_FOLDER)
