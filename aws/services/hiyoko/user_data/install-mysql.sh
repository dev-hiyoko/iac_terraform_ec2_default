#!/bin/bash

# インターネット接続を確認する
for i in {1..30}; do
    curl -Is https://www.google.com > /dev/null && break
    sleep 10
done

# 更新とMySQLのインストール
sudo rpm -Uvh https://repo.mysql.com/mysql80-community-release-el9.rpm
sudo yum update -y
sudo yum install -y mysql-community-server

# MySQLを起動して自動起動を有効化
sudo systemctl start mysqld
sudo systemctl enable mysqld

sudo mysql -u root -p"$(sudo grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')" --connect-expired-password <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${db_password}';
CREATE USER '${db_user}'@'%' IDENTIFIED BY '${db_password}';
CREATE DATABASE ${db_name};
GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'%';
FLUSH PRIVILEGES;
EOF
