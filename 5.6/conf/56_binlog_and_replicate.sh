#!/bin/bash

echo "#-----二进制和复制配置----
log-bin=mysql-bin
log_bin_index=mysql-bin.index
#log_bin_use_v1_row_events=OFF
#log-slave-updates=OFF
binlog_format=mixed
expire_logs_days=7
#max_binlog_size=1G

auto_increment_offset=1
auto_increment_increment=1
server-id=1
" >> my.cnf
