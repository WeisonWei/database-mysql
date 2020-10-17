#!/usr/bin/env bash
sudo docker run -p 23306:3306 --name mysql-volum \
-v /Users/admin/mysql/conf:/etc/mysql \
-v /Users/admin/mysql/logs:/var/log/mysql \
-v /Users/admin/mysql/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123123123 \
-d mysql


#命令说明：

#-p 3306:3306：将容器的3306端口映射到主机的3306端口
#-v /opt/docker_v/mysql/conf:/etc/mysql/conf.d：将主机/opt/docker_v/mysql/conf目录挂载到容器的/etc/mysql/conf.d
#-e MYSQL_ROOT_PASSWORD=123456：初始化root用户的密码
#-d: 后台运行容器，并返回容器ID
#imageID: mysql镜像ID


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