#!/bin.bash
echo "start download components"
rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install net-tools  mariadb mariadb-server httpd vsftpd unzip zip php70w.x86_64 php70w-mysql.x86_64 php70w-xml.x86_64 php70w-gd.x86_64 php70w-fpm.x86_64

wget https://cn.wordpress.org/wordpress-4.9.1-zh_CN.zip
unzip wordpress-4.9.1-zh_CN.zip -d /var/www/html/
echo "finished download components"

systemctl start mariadb
echo -e "\n" "y" 'wordpress.mariadb.tob.' 'wordpress.mariadb.tob.' 'y' 'y' 'y' 'y' | mysql_secure_installation
CREATE DATABASE tob;&GRANT ALL ON tob.* TO 'tobwordpress' IDENTIFIED BY "mariadb.tob.tobwordpress.";&FLUSH PRIVILEGES;&exit; | mysql -u root -p 'wordpress.mariadb.tob.'
systemctl enable mariadb
systemctl restart mariadb

useradd -d /var/www/html -g ftp -s /sbin/nologin ftpwp
passwd wordpress.ftp.tob.
systemctl enable vsftpd
systemctl restart vsftpd

firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=21/tcp --permanent
systemctl restart firewalld.service

chown -R wpvpn:wp wp-vpn/wp-content