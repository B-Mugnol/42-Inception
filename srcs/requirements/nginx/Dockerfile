# Nginx from Debian image
FROM debian:bullseye AS mynginx

ENV DEBIAN_FRONTEND=noninteractive

# Update and install nginx and openssl
RUN apt-get update && apt-get install -y \
	nginx=1.18.0-6.1+deb11u3 \
	openssl=1.1.1w-0+deb11u1 \
	--no-install-recommends

# Clean up after installation to reduce the size of the Docker image
RUN rm -rf /var/lib/apt/lists/*

RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Create SSL certificates
RUN mkdir -p /etc/nginx/ssl && \
	openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -utf8 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
	-subj "/C=BR/ST=SãoPaulo/L=Valinhos/O=42SP/CN=bmugnol.42.fr"

# My Nginx
FROM mynginx

COPY ./conf/nginx.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
