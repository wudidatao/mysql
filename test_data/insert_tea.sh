#!/bin/bash

USER=root
PASSWORD=123456
#SOCKET='/tmp/mysql.sock'
MYSQLBIN="/usr/bin/mysql"

for((i=1;i<=1002;i++));
do
    name=`uuidgen |cut -c1-8`
    age=`openssl rand -base64 8 | cksum | cut -c1-2`
    stu=`$MYSQLBIN -h10.0.0.67 -u$USER -p$PASSWORD -e "select stu_id from mysql56.student order by rand() LIMIT 1;" |grep -v stu_id`
    SQL="INSERT into mysql56.teacher (tea_id,tea_name,tea_age,tea_time,tea_sex,stu_id) VALUES ($i,'$name',$age,now(),floor(1+rand()*2),$stu)"
    $MYSQLBIN -h10.0.0.67 -u$USER -p$PASSWORD -e "$SQL";
   # sleep 1;
done


#a=`$MYSQLBIN -h10.0.0.67 -u$USER -p$PASSWORD -e "select stu_id from mysql56.student order by rand() LIMIT 1;" |grep -v stu_id`
#echo $a
