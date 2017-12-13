#!/bin/bash
#创建测试表
. ./base.sh

#建库
mysql -h$ip -P$port -u$user -p$pass -e "create database test;"

#建表
mysql -h$ip -P$port -u$user -p$pass -e "create table test.test (id int(10) AUTO_INCREMENT,name varchar(20) NULL,PRIMARY KEY (id) );"
