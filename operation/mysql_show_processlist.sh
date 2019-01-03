#!/bin/bash

. ./var.sh
#. ./mysql_login.sh

##查看指定ip的连接情况
#$mysql_path -u $mysql_user -S $mysql_sock -e "show processlist\G;" | grep "Host: $1" -A 5 -B 2

##查看指定ip的连接情况和数量
##$mysql_path -u $mysql_user -S $mysql_sock -e "show processlist\G;" | grep "Host: $1" -A 5 -B 2 | wc -l

##查看指定ip的连接情况和数量
##b=`$mysql_path -u $mysql_user -S $mysql_sock -e "show processlist\G;" | grep "Host: $1" -A 5 -B 2 | wc -l`
##expr $b / 9


#查看指定ip的连接指定状态的情况和数量

#echo "连接状态"
#$mysql_connect -e "show processlist\G;" | grep "Host: $1" -A 5 -B 2 | grep "$2" -A 5 -B 2
#sleep 3
#info=`$mysql_connect -e "show processlist\G;" | grep "Host: $1" -A 5 -B 2 | grep "$2" -A 5 -B 2 | wc -l`
#c=`expr $info / 9`
#c=`expr $c + 1`

#echo "连接数量"
#echo $c

#---------------------

#查看指定ip的连接指定状态的情况和数量

echo "连接状态"
$mysql_connect -e "show processlist\G;" | grep "Host: $1" -A 5 -B 2 | grep "$2" -A 5 -B 2 | grep "Time: $3" -A 3 -B 6
info=`$mysql_connect -e "show processlist\G;" | grep "Host: $1" -A 5 -B 2 | grep "$2" -A 5 -B 2 | grep "Time: $3" -A 3 -B 6 | wc -l`
c=`expr $info / 9`
c=`expr $c + 1`

echo "连接数量"
echo $c
