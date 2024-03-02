# WordPress from Debian image
FROM debian:bullseye AS mywordpress

ENV DEBIAN_FRONTEND=noninteractive

# Update and install PHP and WordPress
RUN apt-get update && apt-get install -y \
	curl=7.74.0-1.3+deb11u11 \
	openssl=1.1.1w-0+deb11u1 \
	mariadb-client=1:10.5.23-0+deb11u1 \
	php=2:7.4+76 \
	php-json=2:7.4+76 \
	php-curl=2:7.4+76 \
	php-xml=2:7.4+76 \
	php-mbstring=2:7.4+76 \
	php-imagick=3.4.4+php8.0+3.4.4-2+deb11u2 \
	php-intl=2:7.4+76 \
	php-fpm=2:7.4+76 \
	php-cli=2:7.4+76 \
	php-mysql=2:7.4+76 \
	ca-certificates=20210119 \
	--no-install-recommends

# Clean up after installation to reduce the size of the Docker image
RUN rm -rf /var/lib/apt/lists/*

# Create run folder
RUN mkdir -p /run/php

# My WordPress
FROM mywordpress

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

COPY ./tools/entrypoint.sh /tmp

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT [ "/bin/bash", "/tmp/entrypoint.sh" ]
