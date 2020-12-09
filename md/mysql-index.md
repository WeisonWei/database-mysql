# index

```sql
CREATE TABLE person_info(
    id INT NOT NULL auto_increment,
    name VARCHAR(100) NOT NULL,
    birthday DATE NOT NULL,
    phone_number CHAR(11) NOT NULL,
    country varchar(100) NOT NULL,
    PRIMARY KEY (id),
    KEY idx_name_birthday_phone_number (name, birthday, phone_number)
);
insert into person_info values (1,'Ashburn','1990-10-27','18702966666','china'),(2,'Weison','1990-09-27','18702966667','china'),(3,'Eleen','1990-11-27','18702966668','china');


-- 全文匹配
explain SELECT * FROM person_info WHERE name = 'Ashburn' AND birthday = '1990-09-27' AND phone_number = '15123983239';
-- 最左匹配原则
explain SELECT * FROM person_info WHERE name = 'Ashburn' ;
explain SELECT * FROM person_info WHERE name = 'Ashburn' AND birthday = '1990-09-27' ;
-- 用不到索引
explain SELECT * FROM person_info WHERE phone_number = '15123983239' ;
-- 用不到，因为B+树的数据页和记录先是按照name列的值排序的，在name列的值相同的情况下才使用birthday列进行排序，也就是说name列的值不同的记录中birthday的值可能是无序的。
-- 而现在你跳过name列直接根据birthday的值去查找，臣妾做不到呀～ 那如果我就想在只使用birthday的值去通过B+树索引进行查找咋办呢？
-- 这好办，你再对birthday列建一个B+树索引就行了，创建索引的语法不用我唠叨了吧。
```

## 全值匹配
搜索条件中的列和索引列一致的话，这种情况就称为全值匹配
因为查询优化器，搜索列的顺序对查询的执行过程没有影响
## 匹配左边的列
需要特别注意的一点是，如果我们想使用联合索引中尽可能多的列，搜索条件中的各个列必须是联合索引中从最左边连续的列