#!/bin/bash
apt-get -y update 
apt-get -y upgrade
apt-get install wget -y apache2 libapache2-mod-php7.0 \
    php7.0-gd php7.0-json php7.0-mysql php7.0-curl \
    php7.0-intl php7.0-mcrypt php-imagick \
    php7.0-zip php7.0-xml php7.0-mbstring mariadb-server

echo 'deb http://download.owncloud.org/download/repositories/10.0/Ubuntu_16.04/ /' > /etc/apt/sources.list.d/owncloud.list