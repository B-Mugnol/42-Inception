# MariaDB from Debian image
FROM debian:bullseye AS mymariadb

ENV DEBIAN_FRONTEND=noninteractive

# Update and install mariadb-server
RUN apt-get update && apt-get install -y \
	mariadb-server=1:10.5.23-0+deb11u1 \
	mariadb-client=1:10.5.23-0+deb11u1 \
	--no-install-recommends

# Clean up after installation to reduce the size of the Docker image
RUN rm -rf /var/lib/apt/lists/*

# Create mysqld directory and grant mysql ownership
RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	chown -R mysql:mysql /etc/mysql && \
	chown -R mysql:mysql /tmp

# My MariaDB
FROM mymariadb

# Copy and change ownership from root to mysql
COPY --chown=mysql:mysql ./conf/init.sql /tmp
COPY --chown=mysql:mysql ./conf/my.cnf /etc/mysql
COPY --chown=mysql:mysql ./tools/entrypoint.sh /tmp

USER mysql

EXPOSE 3306

ENTRYPOINT [ "/bin/bash", "/tmp/entrypoint.sh" ]
