#! /bin/bash
yum update -y
yum install -y sudo 
yum install -y  epel-release
yum -y install yum-utils
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install  -y curl  sudo 	wget mariadb-server mariadb mariadb-server php70w php70w-dom php70w-mbstring php70w-gd php70w-pdo php70w-json php70w-xml php70w-zip php70w-curl php70w-mcrypt php70w-pear php70w-mysql setroubleshoot-server \
yum install httpd 
    
    #</dev/null
rpm --import https://download.owncloud.org/download/repositories/production/CentOS_7/repodata/repomd.xml.key
wget http://download.owncloud.org/download/repositories/production/CentOS_7/ce:stable.repo -O /etc/yum.repos.d/ce:stable.repo
yum clean expire-cache
yum install -y owncloud-files
mkdir /etc/httpd/sites-available
mkdir /etc/httpd/sites-enabled
echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf

httpd -k start

sleep 2

/usr/libexec/mariadb-prepare-db-dir mariadb.service
/usr/bin/mysqld_safe &

#Script is written to be able to be ran after iterations. // Idempotenz  
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

httpd -k restart
sleep 3

mysql -u root -e "create database owncloud"
mysql -u root -e "create user 'ownclouduser'@localhost identified by 'admin'"
mysql -u root -e "GRANT ALL PRIVILEGES ON owncloud. * TO 'ownclouduser'@'localhost'"

sudo -u apache php /var/www/html/owncloud/occ maintenance:install --database "mysql" --database-name "owncloud" --database-user "ownclouduser" --database-pass "admin" --admin-user "admin" --admin-pass "admin"