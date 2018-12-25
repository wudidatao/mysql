#!/bin/bash

vi /etc/yum.repos.d/mysql-community.repo
# Enable to use MySQL 5.7
[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql

#检查确认
yum repolist enabled | grep mysql
mysql57-community/x86_64            MySQL 5.7 Community Server               307

#安装（客户端）
yum install mysql-community-client
#安装（客户端和服务端都装）
yum install mysql-community-server
