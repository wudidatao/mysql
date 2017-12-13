#!/bin/bash
# 创建mysql docker实例

read -p '安装目录,默认/data/mysql:' mysql_home_set
if [ -z $mysql_home_set ];then
    mysql_home=/data/mysql
else
    mysql_home=$mysql_home_set
fi

read -p 'mysql版本,默认5.7.18:' mysql_version_set
if [ -z $mysql_version_set ];then
    mysql_version=5.7.18
else
    mysql_version=$mysql_version_set
fi

read -p '端口,默认3306:' mysql_port_set
if [ -z $mysql_port_set ];then
    mysql_port=3306
else
    mysql_port=$mysql_port_set
fi

read -p '数据文件位置,默认mysql_home/version-mysql_port/data:' mysql_data_set
if [ -z $mysql_data_set ];then
    mysql_data=${mysql_home}/${mysql_version}-${mysql_port}/data
else
    mysql_data=$mysql_data_set
fi

read -p '配置文件位置,默认mysql_home/version-mysql_port/conf:' mysql_conf_set
if [ -z $mysql_conf_set ];then
    mysql_conf=${mysql_home}/${mysql_version}-${mysql_port}/conf
else
    mysql_conf=$mysql_conf_set
fi

read -p '日志文件位置,默认mysql_home/mysql_port/logs:' mysql_logs_set
if [ -z $mysql_logs_set ];then
    mysql_logs=${mysql_home}/${mysql_version}-${mysql_port}/logs
else
    mysql_logs=$mysql_logs_set
fi

read -p '默认登录用户,默认root:' mysql_user_set
if [ -z $mysql_user_set ];then
    mysql_user=root
else
    mysql_user=$mysql_user_set
fi

read -p '默认登录密码,默认123456:' mysql_pass_set
if [ -z $mysql_pass_set ];then
    mysql_pass=123456
else
    mysql_pass=$mysql_pass_set
fi

read -p '默认docker进程启动使用的用户,默认mysql:' mysql_docker_user_set
if [ -z $mysql_docker_user_set ];then
    mysql_docker_user=mysql
else
    mysql_docker_user=$mysql_docker_user_set
fi

read -p '服务描述,默认test:' mysql_description_set
if [ -z $mysql_description_set ];then
    mysql_description=test
else
    mysql_description=$mysql_description_set
fi

read -p '容器名,默认mysql-version-port-description:' mysql_container_name_set
if [ -z $mysql_container_name_set ];then
    mysql_container_name=mysql-$mysql_version-$mysql_port-$mysql_description
else
    mysql_container_name=$mysql_container_name_set
fi

mkdir -p $mysql_home $mysql_data $mysql_conf $mysql_logs
echo "已创建部署目录"

groupadd mysql
useradd mysql -g mysql
echo "已创建mysql用户"

chown -R mysql:mysql $mysql_conf 
chown -R systemd-bus-proxy:input $mysql_data $mysql_logs
echo "已修改目录属主"

docker pull mysql:$mysql_version
echo "已下载镜像"

docker_hostname=`ip address | grep "global e"| cut -d ' ' -f6 | cut -d '/' -f1 | cut -d '.' -f4`$mysql_port
echo "已定义容器主机名"

docker run -d -p $mysql_port:3306 -v $mysql_conf:/etc/mysql/conf.d -v $mysql_logs:/var/log/mysql -v $mysql_data:/var/lib/mysql/ -v /etc/localtime:/etc/localtime -e MYSQL_ROOT_PASSWORD=$mysql_pass --restart=yes --restart=on-failure:3 --name $mysql_container_name -h $docker_hostname mysql:$mysql_version
echo "已映射数据文件，配置文件，日志文件位置，完成时间同步和初始化密码设定，docker deamon启动后尝试重启3次，容器初始化完成！！！"
