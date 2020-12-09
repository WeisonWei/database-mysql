SHOW DATABASES;
CREATE DATABASE user;
use user;
-- mysql -h localhost -u root -p123456 xiaohaizi
SHOW TABLES;

CREATE TABLE first_table
(
    first_column  INT,
    second_column VARCHAR(100)
) COMMENT '第一个表';

ALTER TABLE first_table
    COMMENT '第一个表';

CREATE TABLE student_info
(
    number          INT,
    name            VARCHAR(5),
    sex             ENUM ('男', '女'),
    id_number       CHAR(18),
    department      VARCHAR(30),
    major           VARCHAR(30),
    enrollment_time DATE
) COMMENT '学生基本信息表';


CREATE TABLE student_score
(
    number  INT,
    subject VARCHAR(30),
    score   TINYINT
) COMMENT '学生成绩表';

show tables;
-- DROP TABLE 表1, 表2, ..., 表n;

DESCRIBE second_table;
DESC student_score;
EXPLAIN student_score;
SHOW COLUMNS FROM student_score;
-- SHOW FIELDS FROM student_score;
SHOW CREATE TABLE student_score;

-- 修改表名
ALTER TABLE first_table RENAME TO second_table;
-- RENAME TABLE 旧表名1 TO 新表名1, 旧表名2 TO 新表名2, ... 旧表名n TO 新表名n;
SHOW TABLES FROM user;
ALTER TABLE second_table ADD COLUMN third_column CHAR(4) ;

ALTER TABLE second_table ADD COLUMN fourth_column CHAR(4) FIRST;

ALTER TABLE second_table ADD COLUMN fifth_column CHAR(4) AFTER first_column;

ALTER TABLE second_table DROP COLUMN fourth_column;

ALTER TABLE second_table MODIFY fourth_column VARCHAR(2);
ALTER TABLE second_table CHANGE fourth_column fourth_column1 VARCHAR(2);

ALTER TABLE second_table MODIFY fourth_column VARCHAR(2) FIRST;
ALTER TABLE second_table MODIFY fourth_column VARCHAR(2) AFTER first_column;




SELECT * FROM second_table;
INSERT INTO second_table(first_column, second_column) VALUES(1, 'aaa');
INSERT INTO second_table(first_column, second_column) VALUES(4, 'ddd'), (5, 'eee'), (6, 'fff');

drop table third_table;
CREATE TABLE third_table
(
    first_column  INT          DEFAULT NULL,
    second_column VARCHAR(100) DEFAULT 'abc',
    third_column  VARCHAR(10) not null
);

INSERT INTO third_table(first_column,third_column) VALUES(1,'a');
INSERT INTO third_table(second_column,third_column) VALUES('efg','b');
INSERT INTO third_table(third_column) VALUES('c');
SELECT * FROM third_table;
-- 两种方式之一来指定主键
drop table student_info;
CREATE TABLE student_info
(
    number          INT PRIMARY KEY,
    name            VARCHAR(5),
    sex             ENUM ('男', '女'),
    id_number       CHAR(18),
    department      VARCHAR(30),
    major           VARCHAR(30),
    enrollment_time DATE
);
select * from student_info;

-- PRIMARY KEY
-- PRIMARY KEY (列名1, 列名2, ...)

CREATE TABLE student_info1
(
    number          INT,
    name            VARCHAR(5),
    sex             ENUM ('男', '女'),
    id_number       CHAR(18),
    department      VARCHAR(30),
    major           VARCHAR(30),
    enrollment_time DATE,
    PRIMARY KEY (number, id_number)
);
select * from student_info1;
INSERT INTO student_info1(number) VALUES(NULL);


-- UNIQUE [约束名称] (列名1, 列名2, ...)
-- UNIQUE KEY [约束名称] (列名1, 列名2, ...)

CREATE TABLE student_info2
(
    number          INT,
    name            VARCHAR(5),
    sex             ENUM ('男', '女'),
    id_number       CHAR(18) UNIQUE,
    department      VARCHAR(30),
    major           VARCHAR(30),
    enrollment_time DATE,
    PRIMARY KEY (number)
);
select * from student_info2;

-- CONSTRAINT [外键名称] FOREIGN KEY(列1, 列2, ...) REFERENCES 父表名(父列1, 父列2, ...);
CREATE TABLE student_score1
(
    number  INT,
    subject VARCHAR(30),
    score   TINYINT,
    PRIMARY KEY (number, subject),
    CONSTRAINT FOREIGN KEY (number) REFERENCES student_info (number)
);

-- AUTO_INCREMENT 自动增长
-- 列名 列的类型 AUTO_INCREMENT
CREATE TABLE fourth_table
(
    id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '自增主键',
    first_column  INT COMMENT 'first_column',
    second_column VARCHAR(100) DEFAULT 'abc' COMMENT 'second_column'
);

INSERT INTO fourth_table(first_column, second_column) VALUES(1, 'aaa');
INSERT INTO fourth_table(first_column, second_column) VALUES(1, 'aaa');
INSERT INTO fourth_table(first_column, second_column) VALUES(1, 'aaa');

select * from fourth_table;

-- 在为列定义AUTO_INCREMENT属性的时候需要注意这几点：
-- 一个表中最多有一个具有AUTO_INCREMENT属性的列。
-- 具有AUTO_INCREMENT属性的列必须建立索引。主键和具有UNIQUE属性的列会自动建立索引。不过至于什么是索引，在学习MySQL进阶的时候才会介绍。
-- 拥有AUTO_INCREMENT属性的列就不能再通过指定DEFAULT属性来指定默认值。
-- 一般拥有AUTO_INCREMENT属性的列都是作为主键的属性，来自动生成唯一标识一条记录的主键值。

# ZEROFILL
-- 3的三种写法：
-- 写法一：3
-- 写法二：003
-- 写法三：000003

CREATE TABLE zerofill_table
(
    i1 INT UNSIGNED ZEROFILL,
    i2 INT UNSIGNED
);

INSERT INTO zerofill_table(i1, i2) VALUES(1, 1);

select * from zerofill_table;