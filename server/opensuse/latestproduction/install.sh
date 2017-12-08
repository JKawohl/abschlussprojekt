#!/bin/bash
rpm --import http://download.owncloud.org/download/repositories/production/openSUSE_Leap_42.3/repodata/repomd.xml.key
zypper addrepo --no-gpgcheck http://download.owncloud.org/download/repositories/production/openSUSE_Leap_42.3/ce:stable.repo
zypper addrepo --no-gpgcheck http://download.opensuse.org/repositories/server:php:extensions:php7/openSUSE_Leap_42.3/server:php:extensions:php7.repo
zypper refresh
zypper install -y mysql-community-server perl hostname curl jq apache2 php7 apache2-mod_php7 php7-gd php7-json php7-mysql php7-curl php7-intl php7-mcrypt php7-zip php7-xmlreader php7-posix php7-xmlwriter php7-mbstring php7-iconv php7-zlib php7-ctype php7-imagick vim perl sudo lynx glibc-locale php7-pcntl
zypper install -y owncloud-files

mysql_install_db
mkdir /var/run/mysql
chown -R mysql:mysql /var/lib/mysql /var/run/mysql
(cd /usr; mysqld_safe ) &
#Script is written to be able to be ran after iterations. // Idempotenz
cat <<EOT > /etc/apache2/conf.d/owncloud.conf
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
a2enmod php7
apachectl start


sleep 3

mysql -u root -e "create database owncloud"
mysql -u root -e "create user 'ownclouduser'@localhost identified by 'admin'"
mysql -u root -e "GRANT ALL PRIVILEGES ON owncloud. * TO 'ownclouduser'@'localhost'"
sudo -u wwwrun php /srv/www/htdocs/owncloud/occ maintenance:install --database "mysql" --database-name "owncloud" --database-user "ownclouduser" --database-pass "admin" --admin-user "admin" --admin-pass "admin"

. /etc/os-release

(echo "SUCCESS:$(lynx --dump localhost/owncloud/status.php| jq -r .versionstring ) installed! System $PRETTY_NAME" || echo "FAIL: Installation failed! System $PRETTY_NAME") >> /logs/server.install.log 2>&1 
