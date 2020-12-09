# MySQL

## 服务器&客户端
`MySQL`客户端进程的默认名称为`mysql`

## 客户端&服务器连接
`MySQL`采用`TCP`作为服务器和客户端之间的网络通信协议。

```shell script
#指定端口启动
mysqld -P3307
#连接
mysql -h127.0.0.1 -uroot -P3307 -p

```

[深入理解 MySQL 底层实现](https://gitbook.cn/gitchat/activity/5a07c4266a4b0d78856826ea)
[MySQL 索引与优化](https://gitbook.cn/books/5c92fd312cc79178471b68db/index.html)
[138 张图带你 MySQL 入门](https://gitbook.cn/books/5eef6f0335d2480b101d7552/index.html)
[47 张图带你 MySQL 进阶](https://gitbook.cn/gitchat/activity/5f1a8d30a50beb3089673b7a)
[MySQL 高级教程](https://gitbook.cn/gitchat/activity/5efdd8ae44dfac09f99610bb)
