echo "[mysqld]
#-----常规基础配置-----
#innodb_adaptive_hash_index=ON
#innodb_data_file_path=ibdata1:12M:autoextend
#innodb_doublewrite=ON
#innodb_file_per_table = 1
#innodb_flush_neighbors=1
#innodb_old_blocks_pct=37
#innodb_old_blocks_time=1000
#innodb_page_size=16K
#innodb_purge_batch_size=300
innodb_purge_threads=4
#innodb_use_native_aio=on
socket=/var/run/mysqld/mysqld.sock
pid_file=/var/run/mysqld/mysqld.pid
" >> my.cnf
