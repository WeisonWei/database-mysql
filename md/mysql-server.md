# MySQL

## 启动选项和配置文件
`MySQL`服务器进程的默认名称为`mysqld` 

## 服务端启动&客户端登陆

```shell script
#启动
mysql.server` --间接调用--> `mysqld_safe` --间接调用--> `mysqld` --指定--> `start`参数
#连接
mysql -hlocalhost -uroot -p123456
```

## 在命令行上使用选项

在命令行中设置启动选项只对当次启动生效

```bash
mysqld --skip-networking
#ERROR 2003 (HY000): Can't connect to MySQL server on '127.0.0.1' (61)

mysqld --default-storage-engine=MyISAM

```

```.env
长形式 	短形式 	含义
--host 	-h 	主机名
--user 	-u 	用户名
--password 	-p 	密码
--port 	-P 	端口
--version 	-V 	版本信息
```
## 配置文件中使用选项

推荐使用配置文件的方式来设置启动选项;
在类UNIX操作系统中,MySQL会按照下列路径来寻找配置文件;  



```.env
/etc/my.cnf 	
/etc/mysql/my.cnf 	
SYSCONFDIR/my.cnf 	
$MYSQL_HOME/my.cnf 	特定于服务器的选项（仅限服务器）
defaults-extra-file 	命令行指定的额外配置文件路径
~/.my.cnf 	用户特定选项
~/.mylogin.cnf 	用户特定的登录路径选项（仅限客户端）
```

与在命令行中指定启动选项不同的是,配置文件中的启动选项被划分为若干个组,每个组有一个组名,用中括号[]扩起来,像这样:
[server]
(具体的启动选项...)
[mysqld]
(具体的启动选项...)
[mysqld_safe]
(具体的启动选项...)
[client]
(具体的启动选项...)
[mysql]
(具体的启动选项...)
[mysqladmin]
(具体的启动选项...)

启动命令 	类别 	能读取的组
mysqld 	启动服务器 	[mysqld]、[server]
mysqld_safe 	启动服务器 	[mysqld]、[server]、[mysqld_safe]
mysql.server 	启动服务器 	[mysqld]、[server]、[mysql.server]
mysql 	启动客户端 	[mysql]、[client]
mysqladmin 	启动客户端 	[mysqladmin]、[client]
mysqldump 	启动客户端 	[mysqldump]、[client]



### 配置文件的优先级
```bash
比方说/etc/my.cnf文件的内容是这样的:
[server]
default-storage-engine=InnoDB
而~/.my.cnf文件中的内容是这样的:
[server]
default-storage-engine=MyISAM
又因为~/.my.cnf比/etc/my.cnf顺序靠后,所以如果两个配置文件中出现相同的启动选项,以~/.my.cnf中的为准
```

### 同一个配置文件中多个组的优先级

```bash
我们说同一个命令可以访问配置文件中的多个组,比如mysqld可以访问[mysqld]、[server]组,如果在同一个配置文件中,比如~/.my.cnf,在这些组里出现了同样的配置项,比如这样:
[server]
default-storage-engine=InnoDB
[mysqld]
default-storage-engine=MyISAM
那么,将以最后一个出现的组中的启动选项为准,比方说例子中default-storage-engine既出现在[mysqld]组也出现在[server]组,因为[mysqld]组在[server]组后边,就以[mysqld]组中的配置项为准。
```

## 字符集
```sql
SHOW CHARSET;
```
MySQL中支持的字符集和排序规则:

*   `utf8mb3`:阉割过的`utf8`字符集,只使用1～3个字节表示字符。  -- 在`MySQL`中`utf8`是`utf8mb3`的别名

*   `utf8mb4`:正宗的`utf8`字符集,使用1～4个字节表示字符。

## 字符集和比较规则的应用

### 各级别的字符集和比较规则

`MySQL`有4个级别的字符集和比较规则,分别是:

*   服务器级别
*   数据库级别
*   表级别
*   列级别

### 各级别字符集和比较规则小结

我们介绍的这4个级别字符集和比较规则的联系如下:

*   如果创建或修改列时没有显式的指定字符集和比较规则,则该列默认用表的字符集和比较规则
*   如果创建或修改表时没有显式的指定字符集和比较规则,则该表默认用数据库的字符集和比较规则
*   如果创建或修改数据库时没有显式的指定字符集和比较规则,则该数据库默认用服务器的字符集和比较规则

知道了这些规则之后,对于给定的表,我们应该知道它的各个列的字符集和比较规则是什么,从而根据这个列的类型来确定存储数据时每个列的实际数据占用的存储空间大小了。

字符`'我'`在这个过程中字符集的转换。
现在看一下在请求从发送到结果返回过程中字符集的变化:

![image_1c91mt04ll7suk01ej01fb067k9.png-89.7kB](https://user-gold-cdn.xitu.io/2018/12/6/167815b6f78145f8?w=892&h=470&f=png&s=91878)

### 字符集总结

1. `字符集`的是某个字符范围的编码规则。
2. `比较规则`是针对某个字符集中的字符比较大小的一种规则。
3. 在`MySQL`中,一个字符集可以有若干种比较规则,其中有一个默认的比较规则,一个比较规则必须对应一个字符集。
4. 查看`MySQL`中查看支持的字符集和比较规则的语句如下:
```
   SHOW (CHARACTER SET|CHARSET) [LIKE 匹配的模式];
   SHOW COLLATION [LIKE 匹配的模式];
   
```

5. MySQL有四个级别的字符集和比较规则
* 服务器级别
 `character_set_server`表示服务器级别的字符集,`collation_server`表示服务器级别的比较规则。

* 数据库级别
创建和修改数据库时可以指定字符集和比较规则:

```
  CREATE DATABASE 数据库名
      [[DEFAULT] CHARACTER SET 字符集名称]
      [[DEFAULT] COLLATE 比较规则名称];
  
  ALTER DATABASE 数据库名
      [[DEFAULT] CHARACTER SET 字符集名称]
      [[DEFAULT] COLLATE 比较规则名称];
  
```

`character_set_database`表示当前数据库的字符集,`collation_database`表示当前默认数据库的比较规则,这两个系统变量是只读的,不能修改。如果没有指定当前默认数据库,则变量与相应的服务器级系统变量具有相同的值。

* 表级别

创建和修改表的时候指定表的字符集和比较规则:

```
  CREATE TABLE 表名 (列的信息)
      [[DEFAULT] CHARACTER SET 字符集名称]
      [COLLATE 比较规则名称]]
  
  ALTER TABLE 表名
      [[DEFAULT] CHARACTER SET 字符集名称]
      [COLLATE 比较规则名称]
  
  ```

* 列级别

创建和修改列定义的时候可以指定该列的字符集和比较规则:
```
  CREATE TABLE 表名(
      列名 字符串类型 [CHARACTER SET 字符集名称] [COLLATE 比较规则名称],
      其他列...
  );
  ALTER TABLE 表名 MODIFY 列名 字符串类型 [CHARACTER SET 字符集名称] [COLLATE 比较规则名称];
  
  ```

6. 从发送请求到接收结果过程中发生的字符集转换:

   *   客户端使用操作系统的字符集编码请求字符串
   *   服务器将客户端发送来的字符串的字符集按照`chacharacter_set_client`转换为`character_set_connection`。
   *   使用`character_set_connection`进行服务器操作。
   *   将结果集字符串的字符集从`character_set_connection`转为`character_set_results`发送到客户端
   *   客户端使用操作系统的字符集解析收到的结果集字符串

   在这个过程中各个系统变量的含义如下:
   系统变量
   描述
   `character_set_client`
   服务器解码请求时使用的字符集
   `character_set_connection`
   服务器运行过程中使用的字符集
   `character_set_results`

   服务器向客户端返回数据时使用的字符集
   一般情况下要使用保持这三个变量的值和客户端使用的字符集相同。
7. 比较规则的作用通常体现比较字符串大小的表达式以及对某个字符串列进行排序中。

[深入理解 MySQL 底层实现](https://gitbook.cn/gitchat/activity/5a07c4266a4b0d78856826ea)  
[MySQL 索引与优化](https://gitbook.cn/books/5c92fd312cc79178471b68db/index.html)  
[138 张图带你 MySQL 入门](https://gitbook.cn/books/5eef6f0335d2480b101d7552/index.html)  
[47 张图带你 MySQL 进阶](https://gitbook.cn/gitchat/activity/5f1a8d30a50beb3089673b7a)  
[MySQL 高级教程](https://gitbook.cn/gitchat/activity/5efdd8ae44dfac09f99610bb)  
