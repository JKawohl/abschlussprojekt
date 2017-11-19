#ImageName

FROM ubuntu:16.04
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y apt-utils wget apache2 libapache2-mod-php7.0 \
    php7.0-gd php7.0-json php7.0-mysql php7.0-curl \
    php7.0-intl php7.0-mcrypt php-imagick \ 
    php7.0-zip php7.0-xml php7.0-mbstring mariadb-server 

RUN echo 'deb http://download.owncloud.org/download/repositories/10.0/Ubuntu_16.04/ /' > /etc/apt/sources.list.d/owncloud.list
RUN apt-get update
RUN apt-get -y -q --allow-unauthenticated install owncloud-files 
