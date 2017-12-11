#! /bin/bash
#update repo list
yum update -y
#install dependencies
yum install -y sudo 
yum install -y  epel-release
yum -y install yum-utils
#add third party repo // needed for php7
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install  -y curl  sudo 	wget mariadb-server mariadb mariadb-server php70w php70w-dom php70w-mbstring php70w-gd php70w-pdo php70w-json php70w-xml php70w-zip jq php70w-curl php70w-mcrypt php70w-pear php70w-mysql lynx setroubleshoot-server \
yum install httpd 
#import ownCloud signing key    
rpm --import https://download.owncloud.org/download/repositories/production/CentOS_7/repodata/repomd.xml.key
#import ownCloud repo
wget http://download.owncloud.org/download/repositories/production/CentOS_7/ce:stable.repo -O /etc/yum.repos.d/ce:stable.repo
#update and clean repo cache
yum clean expire-cache
#install owncloud
yum install -y owncloud-files

#apache configuration
mkdir /etc/httpd/sites-available
mkdir /etc/httpd/sites-enabled
echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf

#start apache
httpd -k start

sleep 2
#hacky hacky start of mysql service
/usr/libexec/mariadb-prepare-db-dir mariadb.service
/usr/bin/mysqld_safe &


#more apache config
cat <<EOT > /etc/httpd/sites-available/owncloud.conf
Alias /owncloud "/var/www/html/owncloud/"

<Directory /var/www/html/owncloud/>
  Options +FollowSymlinks
  AllowOverride All

 <IfModule mod_dav.c>
  Dav off
 </IfModule>

 SetEnv HOME /var/www/html/owncloud/
 SetEnv HTTP_HOME /var/www/html/owncloud/

</Directory>
EOT
ln -s /etc/httpd/sites-available/owncloud.conf /etc/httpd/sites-enabled/owncloud.conf
#restart apache
httpd -k restart
sleep 3

#create database owncloud database, database user
mysql -u root -e "create database owncloud"
mysql -u root -e "create user 'ownclouduser'@localhost identified by 'admin'"
mysql -u root -e "GRANT ALL PRIVILEGES ON owncloud. * TO 'ownclouduser'@'localhost'"

#install owncloud
sudo -u apache php /var/www/html/owncloud/occ maintenance:install --database "mysql" --database-name "owncloud" --database-user "ownclouduser" --database-pass "admin" --admin-user "admin" --admin-pass "admin"

#check if install worked (lynx is a text webbrowserm jq parses json output /etc/os-release outputs the distro)

. /etc/os-release

(echo "SUCCESS:$(lynx --dump localhost/owncloud/status.php| jq -r .versionstring ) installed! System $PRETTY_NAME" || echo "FAIL: Installation failed! System $PRETTY_NAME") >> /logs/server.install.log 2>&1 