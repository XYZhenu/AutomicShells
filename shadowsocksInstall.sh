#install shadowsocks-libv
yum install epel-release -y
yum install gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto c-ares-devel libev-devel libsodium-devel mbedtls-devel -y
git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
git submodule update --init --recursive
./autogen.sh && ./configure && make
sudo make install
nohup ss-manager -m aes-256-cfb -u --manager-address 127.0.0.1:6001 &


scp root@45.77.210.194:/root/shadowsocks-libev/shadowsocks-libev-3.1.1.tar.gz ~/Downloads


yum -y install net-tools mariadb mariadb-server unzip zip npm git

systemctl start mariadb
echo -e "\n" "y" 'vpn.mariadb.tob.' 'wordpress.mariadb.tob.' 'y' 'y' 'y' 'y' | mysql_secure_installation
CREATE DATABASE tob;&GRANT ALL ON tob.* TO 'tobwordpress' IDENTIFIED BY "mariadb.tob.tobwordpress.";&FLUSH PRIVILEGES;&exit; | mysql -u root -p 'wordpress.mariadb.tob.'
systemctl enable mariadb
systemctl restart mariadb

firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=50000-51000/tcp --permanent
firewall-cmd --zone=public --add-port=50000-51000/udp --permanent
systemctl restart firewalld.service

git clone https://github.com/shadowsocks/shadowsocks-manager.git
cd shadowsocks-manager
npm i
# nohup ssmgr -c /root/shadowsocks-manager/config/c.yml &
nohup node server.js -c /root/shadowsocks-manager/config/c.yml &



type: m

manager:
  address: 127.0.0.1:6002
  password: '123456'

plugins:
  flowSaver:
    use: true
  user:
    use: true
  account:
    use: true
  macAccount:
    use: true
  email:
    use: true
    username: 'username'
    password: 'password'
    host: 'smtp.your-email.com'
  webgui:
    use: true
    host: '0.0.0.0'
    port: '80'
    site: 'http://yourwebsite.com'
    # cdn: 'http://xxx.xxx.com'
    # googleAnalytics: 'UA-xxxxxxxx-x'
    gcmSenderId: '456102641793'
    gcmAPIKey: 'AAAAGzzdqrE:XXXXXXXXXXXXXX'
  alipay:
    use: true
    appid: 2015012104922471
    notifyUrl: 'http://yourwebsite.com/api/user/alipay/callback'
    merchantPrivateKey: 'xxxxxxxxxxxx'
    alipayPublicKey: 'xxxxxxxxxxx'
    gatewayUrl: 'https://openapi.alipay.com/gateway.do'
  paypal:
    use: true
    mode: 'live' # sandbox or live
    client_id: 'At9xcGd1t5L6OrICKNnp2g9'
    client_secret: 'EP40s6pQAZmqp_G_nrU9kKY4XaZph'

db: 'webgui.sqlite'