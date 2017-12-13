#!/bin/bash
# 主从或者主主环境添加复制账号和密码并授权

#主库1增加账号和权限
mysql_path=/usr/bin/mysql
ip=192.168.100.190
port=3306
mysql_user=root
mysql_pass=123456
add_user=repl
add_user_pass=123456
add_ip=172.17.0.%
database=*
table=*
privilege="REPLICATION SLAVE"

#创建用户并授权，如果已经有用户了，会出现无法创建的错误信息
$mysql_path -h $ip -P $port -u $mysql_user -p$mysql_pass -e "CREATE USER '$add_user'@'$add_ip' IDENTIFIED BY '$add_user_pass';"
$mysql_path -h $ip -P $port -u $mysql_user -p$mysql_pass -e "GRANT $privilege ON $database.$table TO '$add_user'@'$add_ip';" -e "FLUSH PRIVILEGES;"

#主库2增加账号和权限
mysql_path=/usr/bin/mysql
ip=192.168.100.190
port=3307
mysql_user=root
mysql_pass=123456
add_user=repl
add_user_pass=123456
add_ip=172.17.0.%
database=*
table=*
privilege="REPLICATION SLAVE"

#创建用户并授权，如果已经有用户了，会出现无法创建的错误信息
$mysql_path -h $ip -P $port -u $mysql_user -p$mysql_pass -e "CREATE USER '$add_user'@'$add_ip' IDENTIFIED BY '$add_user_pass';"
$mysql_path -h $ip -P $port -u $mysql_user -p$mysql_pass -e "GRANT $privilege ON $database.$table TO '$add_user'@'$add_ip';" -e "FLUSH PRIVILEGES;"
