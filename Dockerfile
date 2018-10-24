#   Objectives:
    ##  1. Install Apache and php 7
    ##  2. Install Component and php extensions
    ##  3. Install Composer
    ##  4. Add User ktle-admin


##  1. Install Apache and php 7
# This Docker Image instantiate from phusion/baseimage:0.10.0 Image
# phusion/baseimage:0.10.0 is a light version of Ubuntu 16.04 with PHP 5.6 installed
FROM php:apache


##  2. Install Component and php extensions
RUN requirements="libpng12-dev libmcrypt-dev libmcrypt4 libcurl3-dev libfreetype6 libjpeg-turbo8 libjpeg-turbo8-dev libpng12-dev libfreetype6-dev libicu-dev libxslt1-dev" && \
    apt-get update && \
    apt-get install -y $requirements && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd && \
    docker-php-ext-install mcrypt && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install zip && \
    docker-php-ext-install intl && \
    docker-php-ext-install xsl && \
    docker-php-ext-install soap && \
    docker-php-ext-install bcmath && \
    requirementsToRemove="libpng12-dev libmcrypt-dev libcurl3-dev libpng12-dev libfreetype6-dev libjpeg-turbo8-dev" && \
    apt-get purge --auto-remove -y $requirementsToRemove && \
# a2enmod rewrite
    a2enmod rewrite && \
# Install Tools
    apt-get update && \
    apt-get install -y \
    nano \
    vim \
    telnet \
    netcat \
    git-core \
    zip && \
    apt-get purge -y --auto-remove && \ 
    rm -rf /var/lib/apt/lists/*
RUN apt update && \
    apt install -y nmap && \
# Update and Remove
    apt-get update -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \ 
    rm -rf /var/lib/apt/lists/* && \
#   Install SSHD KEY
    /usr/bin/ssh-keygen -A && \
##  3. Install 'Composer'
    curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin
##  4. Add User ktle-admin
COPY entrypoint.sh  /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
##  5. Set WOKR_DIR
WORKDIR /var/www


## Docker image name:                           docker-image-apache-php7.2-laravel
## Docker Hub image name:                       devtutspace/docker-image-apache-php7.2-laravel
## Build command:                               docker build -t docker-image-apache-php7.2-laravel ./
## Build Command No Cache:                      docker build --no-cache -t docker-image-apache-php7.2-laravel ./
## Docker Image Tag command:                    docker tag docker-image-apache-php7.2-laravel devtutspace/docker-image-apache-php7.2-laravel
## Docker Image Push command:                   docker push devtutspace/docker-image-apache-php7.2-laravel
## Docker Image Build, Tag, Push:               docker build -t docker-image-apache-php7.2-laravel ./ && docker tag docker-image-apache-php7.2-laravel devtutspace/docker-image-apache-php7.2-laravel && docker push devtutspace/docker-image-apache-php7.2-laravel
## Docker Image Build no cache, Tag, Push:      docker build -t --no-cachedocker-image-apache-php7.2-laravel ./ && docker tag docker-image-apache-php7.2-laravel devtutspace/docker-image-apache-php7.2-laravel && docker push devtutspace/docker-image-apache-php7.2-laravel