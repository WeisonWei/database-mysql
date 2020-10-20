# install
OS : Deepin
MYSQL : 8.0

## download
https://dev.mysql.com/downloads/mysql/

## install
```bash
1.https://dev.mysql.com/downloads/repo/apt/ --> 下载 mysql-apt-config_0.8.15-1_all.deb
2.sudo dpkg -i mysql-apt-config_0.8.15-1_all.deb
3.选择 Debian buster
4.版本选择
5.版本选择
6.确认配置
7.执行安装

sudo apt-get update
sudo apt-get install mysql-server
--
sudo apt-get update --fix-missing -- 报错执行
sudo apt-get install mysql-server
--

9.确认下MySQL服务器版本,执行 : apt policy mysql-server
10.启动MySQL服务,执行 : sudo systemctl start mysql
11.登陆 : mysql -u root -p
11.执行sql : show databases;

```

## env
```shell script
vim ~/.bash_profile
export PATH=$PATH:/usr/local/mysql-8.0.21-macos10.15-x86_64/bin
export PATH=$PATH:/usr/local/mysql-8.0.21-macos10.15-x86_64/support-files
source ~/.bash_profile 
```

## 查看进程
- mysql的守护进程是mysqld
```bash
ps aux | grep mysqld
pidof mysqld   
chkconfig --list
```
mysql     1942  0.4  2.2 2192084 367104 ?      Ssl  07:24   0:23 /usr/sbin/mysqld
1942
```
- 查看文件安装路径
```bash
whereis mysql
``` 
- 查询运行文件所在路径
```bash
which mysql
```
## status
本方式安装，执行文件在:/usr/bin下
```bash
service mysql status
service mysql restart
```


非本方式安裝：
```shell script
#停止MySQL服务
sudo mysql.server stop
#重启MySQL服务
sudo mysql.server start
sudo mysql.server restart
#查看MySQL服务状态
sudo mysql.server status
#执行安全设置
mysql_secure_installation
```

## 创建数据库
```sql
   create database user character set utf8mb4;
   #创建用户
   create user 'wei'@'%' identified by '123123123';
   #授权用户
   grant all privileges on retail_db.* to 'retail_u'@'%';
   #刷新权限
   flush privileges;
   
   #当前所有数据库
   show databases;
   #当前数据库所有表
   show tables;
   
   #建表
   CREATE TABLE t_user(
     key_id VARCHAR(255) NOT NULL PRIMARY KEY,  -- id 统一命名为key_id
     user_name VARCHAR(255) NOT NULL ,
     password VARCHAR(255) NOT NULL ,
     phone VARCHAR(255) NOT NULL,
     deleted INT NOT NULL DEFAULT 0,  -- 逻辑删除标志默认值
     create_time   timestamp NULL default CURRENT_TIMESTAMP, -- 创建时间默认值
     update_time   timestamp NULL default CURRENT_TIMESTAMP -- 修改时间默认值
   ) ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4;
```
mysqlbinlog -vv --base64-output='decode-rows'
[参考](https://www.jianshu.com/p/4fc53d7d7620)