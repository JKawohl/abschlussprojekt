#!/bin/bash
zypper update -y
zypper refresh	
zypper install -y mysql-community-server perl hostname curl curl apache2 php7 apache2-mod_php7 php7-gd php7-json php7-mysql php7-curl php7-intl php7-mcrypt php7-zip php7-xmlreader php7-xmlwriter php7-mbstring vim 
zypper install -y sudo
zypper in 'perl(Sys::Hostname)' 
mysql_install_db
mkdir /var/run/mysql
chown -R mysql:mysql /var/lib/mysql /var/run/mysql
(cd /usr; mysqld_safe ) & 
zypper addrepo --no-gpg-checks http://download.opensuse.org/repositories/server:php:extensions:php7/php7_openSUSE_Leap_42.3/server:php:extensions:php7.repo
zypper refresh
zypper install --no-gpg-checks -y  php7-imagick
rpm --import http://download.owncloud.org/download/repositories/production/openSUSE_Leap_42.3/repodata/repomd.xml.key
zypper --no-gpg-checks addrepo http://download.owncloud.org/download/repositories/production/openSUSE_Leap_42.3/ce:stable.repo
zypper refresh
zypper install -y owncloud-files
mkdir /etc/apache2/sites-available
mkdir /etc/apache2/sites-enabled
echo "IncludeOptional sites-enabled/*.conf" >> /etc/apache2/default-server.conf
#Script is written to be able to be ran after iterations. // Idempotenz  
cat <<EOT > /etc/apache2/sites-available/owncloud.conf
Alias /owncloud "/srv/www/htdocs/owncloud/"

<Directory /srv/www/htdocs/owncloud/>
  Options +FollowSymlinks
  AllowOverride All

 <IfModule mod_dav.c>
  Dav off
 </IfModule>

 SetEnv HOME /srv/www/htdocs/owncloud/
 SetEnv HTTP_HOME /srv/www/htdocs/owncloud/

</Directory>
EOT
ln -s /etc/apache2/sites-available/owncloud.conf /etc/apache2/sites-enabled/owncloud.conf
apachectl start


sleep 3

mysql -u root -e "create database owncloud"
mysql -u root -e "create user 'ownclouduser'@localhost identified by 'admin'"
mysql -u root -e "GRANT ALL PRIVILEGES ON owncloud. * TO 'ownclouduser'@'localhost'"
sudo -u wwwrun php /srv/www/htdocs/owncloud/occ maintenance:install --database "mysql" --database-name "owncloud" --database-user "ownclouduser" --database-pass "admin" --admin-user "admin" --admin-pass "admin"