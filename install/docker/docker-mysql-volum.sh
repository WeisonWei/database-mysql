#!/usr/bin/env bash
dir=`pwd`
docker run -p 23306:3306 --name mysql-volum \
-v ${dir}/volum/mysql1/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf \
-v ${dir}/volum/mysql1/logs:/var/log/mysql \
-v ${dir}/volum/mysql1/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123123123 \
-d mysql


#命令说明：

#-p 3306:3306：将容器的3306端口映射到主机的3306端口
#-v /opt/docker_v/mysql/conf:/etc/mysql/conf.d：将主机/opt/docker_v/mysql/conf目录挂载到容器的/etc/mysql/conf.d
#-e MYSQL_ROOT_PASSWORD=123456：初始化root用户的密码
#-d: 后台运行容器，并返回容器ID
#imageID: mysql镜像ID
#@–restart always：开机启动
#–privileged=true：提升容器内权限
#-v /opt/mysql/config/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf：映射配置文件
#-v /opt/mysql/data:/var/lib/mysql：映射数据目录
#-e MYSQL_USER=”fengwei”：添加用户fengwei
#-e MYSQL_PASSWORD=”pwd123”：设置fengwei的密码伟pwd123
#-e MYSQL_ROOT_PASSWORD=”rootpwd123”：设置root的密码伟rootpwd123

#登陆验证
#sudo docker exec -it mysql bash
#mysql -uroot -p123456

# 容器运行正常，但是无法访问到MySQL
# 开放端口：
#$ systemctl status firewalld
#$ firewall-cmd  --zone=public --add-port=3306/tcp -permanent
#$ firewall-cmd  --reload
# 关闭防火墙：
#$ sudo systemctl stop firewalld

#设置远程访问账号
#$ sudo docker exec -it mysql bash
#$ mysql -uroot -p123456
#mysql> grant all privileges on *.* to root@'%' identified by "password";