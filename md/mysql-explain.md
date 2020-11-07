```.env
-- id 在一个大的查询语句中每个SELECT关键字都对应一个唯一的id
-- select_type 	SELECT关键字对应的那个查询的类型
-- 在table 	表名
-- partitions 	匹配的分区信息
-- type 	针对单表的访问方法
-- possible_keys 	可能用到的索引
-- key 	实际上使用的索引
-- key_len 	实际使用到的索引长度
-- ref 	当使用索引列等值查询时，与索引列进行等值匹配的对象信息
-- rows 	预估的需要读取的记录条数
-- filtered 	某个表经过搜索条件过滤后剩余记录条数的百分比
-- Extra 	一些额外的信息
```

## init
- table
```sql
drop table t1;
CREATE TABLE t1 (
    id INT NOT NULL AUTO_INCREMENT,
    key1 VARCHAR(100),
    key2 INT,
    key3 VARCHAR(100),
    key_part1 VARCHAR(100),
    key_part2 VARCHAR(100),
    key_part3 VARCHAR(100),
    common_field VARCHAR(100),
    PRIMARY KEY (id),
    KEY idx_key1 (key1),
    UNIQUE KEY idx_key2 (key2),
    KEY idx_key3 (key3),
    KEY idx_key_part(key_part1, key_part2, key_part3)
) Engine=InnoDB CHARSET=utf8;
```

- proc_auto_insert_data
```sql
 DELIMITER $$
    DROP PROCEDURE IF EXISTS `proc_auto_insert_data`$$
    CREATE PROCEDURE `proc_auto_insert_data`()
    BEGIN

            DECLARE init_data INTEGER DEFAULT 1;

            WHILE init_data <= 10000 DO

	INSERT INTO t1 VALUES(init_data,concat(init_data,''),init_data,concat(init_data,''),concat(init_data,''),concat(init_data,''),concat(init_data,''),concat(init_data,''));

            SET init_data = init_data + 1;

            END WHILE;
    END$$
    DELIMITER ;
    CALL proc_auto_insert_data();
```

```bash
explain select * from u_user c where c.mobile = 18702966632;
EXPLAIN SELECT 1;
```



