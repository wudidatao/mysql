#!/bin/bash
# 循环插入测试表
. ./base.sh

#先获取插入的自增id位置
n=`mysql -h$ip -P$port -u$user -p$pass -e "SELECT Auto_increment FROM information_schema.tables WHERE table_schema='test' and table_schema='test';" | sed -n '2p'`

#循环插入数据
for((i=n;i<=10000;i++));
do
    sleep 1s
    #sql="insert into test.test (id,name) value ($i,\"test${i}\");"
    sql="insert into test.test (name) value (\"test${i}\");"
    mysql -h$ip -P$port -u$user -p$pass -e "$sql"
done;
