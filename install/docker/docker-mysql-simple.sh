#!/usr/bin/env bash
# docker 中下载 mysql
docker pull mysql
#启动
docker run --name mysql-simple -p 33306:3306 -e MYSQL_ROOT_PASSWORD=123123123 -d mysql
#进入容器
#docker exec -it mysql bash
#登录mysql
#mysql -u root -p
#ALTER USER 'root'@'localhost' IDENTIFIED BY '123123123';
#添加远程登录用户
#CREATE USER 'liaozesong'@'%' IDENTIFIED WITH mysql_native_password BY 'Lzslov123!';
#GRANT ALL PRIVILEGES ON *.* TO 'liaozesong'@'%';