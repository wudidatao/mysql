
#!/bin/bash
# 创建mysql docker实例


mysql_home=/data/mysql
#5.6.42 5.7.18
mysql_version=5.6.42
mysql_port=3306
mysql_data=${mysql_home}/${mysql_version}-${mysql_port}/data
mysql_conf=${mysql_home}/${mysql_version}-${mysql_port}/conf
mysql_sock=${mysql_home}/${mysql_version}-${mysql_port}/sock
mysql_user=root
mysql_pass=123456
mysql_docker_user=mysql
mysql_description=test-mysql
mysql_container_name=${mysql_description}-${mysql_version}-${mysql_port}

mkdir -p $mysql_home $mysql_data $mysql_conf $mysql_sock
echo "已创建部署目录"

groupadd mysql
useradd mysql -g mysql
echo "已创建mysql用户"

chown -R polkitd:input $mysql_conf $mysql_data $mysql_sock
echo "已修改目录属主"

docker pull mysql:$mysql_version
echo "已下载镜像"

#docker_hostname=`ip address | grep "global e"| cut -d ' ' -f6 | cut -d '/' -f1 | cut -d '.' -f4`$mysql_port
echo "已随机定义容器内部的主机名"

docker run -d -p $mysql_port:3306 -u $mysql_docker_user:$mysql_docker_user -v $mysql_conf:/etc/mysql/conf.d -v $mysql_data:/var/lib/mysql -v $mysql_sock:/var/run/mysqld -v /etc/localtime:/etc/localtime -e MYSQL_ROOT_PASSWORD=$mysql_pass --restart=yes --restart=on-failure:3 --name $mysql_container_name mysql:$mysql_version
echo "已创建容器"

cp my.cnf_init my.cnf
docker cp my.cnf $mysql_container_name:/etc/mysql/conf.d/
echo "已创建配置文件，首次生效需要重启"

echo "已映射数据文件，配置文件，日志文件位置，完成时间同步和初始化密码设定，docker deamon启动后尝试重启3次，容器初始化完成！！！"

