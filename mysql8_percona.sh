#!/bin/bash

#systemctl start firewalld > /dev/null
#systemctl enable firewalld > /dev/null
#firewall-cmd --add-port 3306/tcp --permanent && firewall-cmd --reload > /dev/null
#echo "Firewall enabled and 3306/tcp added"

yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm rsync htop expect -y
percona-release setup ps80 -y
yum install percona-server-server -y

systemctl start mysqld && systemctl enable mysqld > /dev/null
echo "Installation completed"
echo "mysql_secure_installation"

grep 'temporary password' /var/log/mysqld.log
