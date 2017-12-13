#!/bin/bash
# 删除测试表
. ./base.sh

#删表
mysql -h$ip -P$port -u$user -p$pass -e "drop table test.test;"
