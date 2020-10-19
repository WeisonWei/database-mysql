# install
OS:MAC
MYSQL:8.0

## download
https://dev.mysql.com/downloads/mysql/

## env
```shell script
vim ~/.bash_profile
export PATH=$PATH:/usr/local/mysql-8.0.21-macos10.15-x86_64/bin
export PATH=$PATH:/usr/local/mysql-8.0.21-macos10.15-x86_64/support-files
source ~/.bash_profile 
```

## status
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


#创建数据库
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

[参考](https://www.jianshu.com/p/4fc53d7d7620)