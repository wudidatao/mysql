#!/bin/bash
#主从单向同步或主主相互同步

mysql_path=/usr/bin/mysql
master_ip=192.168.100.190
master_port=3307
master_mysql_user=root
master_mysql_pass=123456

slave_ip=192.168.100.190
slave_port=3306
slave_mysql_user=root
slave_mysql_pass=123456
repl_user=repl
repl_pass=123456

#主库获取主库位置信息
master_log_file=`$mysql_path -h $master_ip -P $master_port -u $master_mysql_user -p$master_mysql_pass -e "show master status\G" | grep File | awk '{print $2}'`
master_log_pos=`$mysql_path -h $master_ip -P $master_port -u $master_mysql_user -p$master_mysql_pass -e "show master status\G" | grep Position | awk '{print $2}'`

#先停止同步，再让从库和主库同步信息,并开始同步
$mysql_path -h $slave_ip -P $slave_port -u $slave_mysql_user -p$slave_mysql_pass -e "stop slave;" -e "change master to master_host='$master_ip',master_port=$master_port,master_user='$repl_user',master_password='$repl_pass',master_log_file='$master_log_file',master_log_pos=$master_log_pos;" -e "start slave;"

#从库同步验证，成功或失败返回信息提示
Slave_IO_Running=`$mysql_path -h $slave_ip -P $slave_port -u $slave_mysql_user -p$slave_mysql_pass -e "show slave status\G" | grep Slave_IO_Running | awk '{print $2}'`
Slave_SQL_Running=`$mysql_path -h $slave_ip -P $slave_port -u $slave_mysql_user -p$slave_mysql_pass -e "show slave status\G" | grep Slave_SQL_Running: | awk '{print $2}'`
echo "Slave_IO_Running:"$Slave_IO_Running
echo "Slave_SQL_Running:"$Slave_SQL_Running
