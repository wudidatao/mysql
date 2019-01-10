#!/bin/bash

#官方下载yum源并安装
yum install wget -y
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm

#安装yum源
rpm -Uvh mysql57-community-release-el7-9.noarch.rpm

#enabled=0改成1，让5.7源可用
#keepcache=1，让rpm包可以存储在本地，路径在/var/cache/yum/x86_64/7/mysql57-community/，默认不保存
#这里只保存一个5.7的源，其他的备份之后去掉
vi /etc/yum.repos.d/mysql-community.repo
# Enable to use MySQL 5.7
[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=1
keepcache=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

#检查确认
yum repolist enabled | grep mysql
mysql57-community/x86_64            MySQL 5.7 Community Server               307

#安装指定版本（客户端）
yum install mysql-community-client-5.7.23-1.el7.x86_64
#安装指定版本（客户端和服务端都装）
yum install mysql-community-server-5.7.23-1.el7.x86_64
