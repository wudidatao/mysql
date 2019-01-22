#!/bin/bash

#官方下载yum源并安装
yum install wget -y
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm

#安装yum源
rpm -Uvh mysql57-community-release-el7-9.noarch.rpm

#enabled=0改成1，让5.7源可用
#keepcache=1，让rpm包可以存储在本地，路径在/var/cache/yum/x86_64/7/mysql57-community/，默认不保存
#这里只保存一个5.7的源，其他的备份之后去掉
“
[mysql-connectors-community]
name=MySQL Connectors Community
baseurl=http://repo.mysql.com/yum/mysql-connectors-community/el/7/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

[mysql-tools-community]
name=MySQL Tools Community
baseurl=http://repo.mysql.com/yum/mysql-tools-community/el/7/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=1
keepcache=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

[mysql-tools-preview]
name=MySQL Tools Preview
baseurl=http://repo.mysql.com/yum/mysql-tools-preview/el/7/$basearch/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql
” > /etc/yum.repos.d/mysql-community.repo

#安装指定版本（客户端）
#yum install mysql-community-client

#安装指定版本（客户端和服务端都装）
yum install mysql-community-server

#登录密码
cat /var/log/mysqld.log | grep 'temporary password'
