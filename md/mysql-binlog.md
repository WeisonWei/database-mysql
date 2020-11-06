# MySQL - binlog
binglog 有两大用途：第一是主从复制，第二是数据恢复。

>binlog 是 MySQL 的二进制文件，主要包含两个文件，
一个是文件后缀为.index 的日志索引文件，
一个是文件后缀为.00000*记录所有的 DDL 和 DML 语句事件，除了查询，其他所有的操作都会记录。

-- --  

>间隙锁，主要为了满足恢复和复制的要求，
而 MySQL 的恢复和复制就是使用的 binlog，
binlog 的的所有操作记录是有序的，恢复的时候也是按照记录的顺序，在事务没提交前，其他并发事务不能插入满足锁定条件的任何记录，避免出现幻读。

```bash
#找到 my.cnf 文件，进行编辑
vi /usr/local/mysql/etc/my.cnf
#添加如下内容；log-bin=mysql-log-bin (mysql-log-bin 日志文件的前缀 )
# 重启 mysql


#查看 test 字符出现的前后 30 行，A 是前 B 是后
mysqlbinlog -vv --base64-output='decode-rows' #{binlogid} | grep test -A30 -B30
#查看 binlog 中指定 gtid 出现的前后 20 行
mysqlbinlog -vv --base64-output='decode-rows' #{binlogid} | grep '****-gtid-****' -A30 -B30
```

```bash
show variables like 'log_bin';
show variables like 'datadir';
```

-- https://www.cnblogs.com/lvnux/p/13503344.html

