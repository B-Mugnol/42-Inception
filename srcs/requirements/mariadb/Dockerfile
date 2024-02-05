# MariaDB from Debian image
FROM debian:bullseye AS mymariadb

# Update and install mariadb-server
RUN apt-get update && apt-get install -y \
	mariadb-server

# Clean up after installation to reduce the size of the Docker image
RUN rm -rf /var/lib/apt/lists/*

# My MariaDB
FROM mymariadb

COPY ./conf/my.conf ./my.conf
