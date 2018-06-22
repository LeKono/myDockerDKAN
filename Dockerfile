# Base image
FROM ubuntu:16.04

# Maintainer
MAINTAINER Andrej Konotopez <andrej.konotopez@scai.fraunhofer.de>

# Update to latest version
RUN apt-get update 
RUN apt-get upgrade -y

# Install needed packages
RUN apt-get install -y \
	git \
	apache2 \
	nano \
	wget \
	php \
	php7.0-xml \
	php7.0-gd \
	php7.0-mbstring \
	mysql-client \
	zip \
	unzip \
	php-zip \
	libapache2-mod-php \
	php-mcrypt \
	php-mysql \
	php-curl

# Add server config to apache2
RUN echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf

# Add info.php
RUN echo "<?php phpinfo();?>" >> /var/www/html/info.php

# Download latest DKAN
RUN git clone --branch master https://github.com/GetDKAN/dkan-drops-7.git /var/www/html/dkan

# Expose ports (default server port: 80)
EXPOSE 80

# Run apache server on container start
#ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
ENTRYPOINT service apache2 start && /bin/bash
