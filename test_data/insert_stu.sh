#!/bin/bash

USER=root
PASSWORD=123456
#SOCKET='/tmp/mysql.sock'
MYSQLBIN="/usr/bin/mysql"

for((i=1;i<500000;i++));
do
    #SQL="INSERT into mysql56.student (stu_id) VALUES ($i)"
    name=`uuidgen |cut -c1-8`
    age=`openssl rand -base64 8 | cksum | cut -c1-2`
    
    SQL="INSERT into mysql56.student (stu_id,stu_name,stu_age,stu_time,stu_sex) VALUES ($i,'$name',$age,now(),floor(1+rand()*2))"
    $MYSQLBIN -h10.0.0.67 -u$USER -p$PASSWORD -e "$SQL";
    #sleep 1;
done
