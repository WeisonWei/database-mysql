## 登录
## 重置密码


## 字符串类函数
```sql
CHARSET(str) //返回字符串字符集
CONCAT (string2 [,… ]) //连接字符串
INSTR (string ,substring ) //返回substring首次在字符串中出现的位置,不存在返回0
LCASE (string ) //字符串转换成小写
LEFT (string ,length ) //从字符串中的左边起取length个字符
LENGTH (string ) //字符串长度
LOAD_FILE (file_name ) //从文件读取内容
LOCATE (substring , string [,start_position ] ) 同INSTR,但可指定开始位置
LPAD (string ,length ,pad ) //重复用pad加在字符串开头,直到字串长度为length
LTRIM (string2) //去除字符串前端空格
REPEAT (string ,count ) //重复count次
REPLACE (str ,search_str ,replace_str ) //在str中用replace_str替换search_str
RPAD (string ,length ,pad) //在字符串后用pad补充,直到长度为length
RTRIM (string) //去除字符串后端空格
STRCMP (string1 ,string2 ) //逐字符比较两字串大小,
SUBSTRING (str , position [,length ]) //从字符串的position开始,取length个字符，SUBSTR和SUBSTRIN函数功能一样。
注：MySQL中处理字符串时，默认第一个字符下标为1，即参数position必须大于等于1，position支持负数，如果为负数则从后面开始截取。

mysql> select substring(‘abcd’,0,2);
+———————–+
| substring(‘abcd’,0,2) |
+———————–+
| |
+———————–+
1 row in set (0.00 sec)
mysql> select substring(‘abcd’,1,2);
+———————–+
| substring(‘abcd’,1,2) |
+———————–+
| ab |
+———————–+
1 row in set (0.02 sec)
TRIM([[BOTH|LEADING|TRAILING] [padding] FROM]string2) //去除指定位置的指定字符
UCASE (string2 ) //转换成大写
RIGHT(string2,length) //取string2最后length个字符
SPACE(count) //生成count个空格
```
## 数学类函数
```sql
ABS (number2 ) //绝对值
BIN (decimal_number ) //十进制转二进制
CEILING (number2 ) //向上取整
CONV(number2,from_base,to_base) //进制转换
FLOOR (number2 ) //向下取整
FORMAT (number,decimal_places ) //保留小数位数
HEX (DecimalNumber ) //转十六进制
注：HEX()中可传入字符串，则返回其ASC-11码，如HEX(‘DEF’)返回4142143
也可以传入十进制整数，返回其十六进制编码，如HEX(25)返回19
LEAST (number , number2 [,..]) //求最小值
MOD (numerator ,denominator ) //求余
POWER (number ,power ) //求指数
RAND([seed]) //随机数
ROUND (number [,decimals ]) //四舍五入,decimals为小数位数,支持负数，则从小数点前面的四舍五入。
注：返回类型并非均为整数，如：
(1)默认变为整形值
mysql> select round(1.23);
+————-+
| round(1.23) |
+————-+
| 1 |
+————-+
1 row in set (0.00 sec)
mysql> select round(1.56);
+————-+
| round(1.56) |
+————-+
| 2 |
+————-+
1 row in set (0.00 sec)
(2)可以设定小数位数，返回浮点型数据
mysql> select round(1.567,2);
+—————-+
| round(1.567,2) |
+—————-+
| 1.57 |
+—————-+
1 row in set (0.00 sec)
SIGN (number2 ) //函数返回参数的符号
```
## 日期时间类函数
```sql
ADDTIME (date2 ,time_interval ) //将time_interval加到date2
CONVERT_TZ (datetime2 ,fromTZ ,toTZ ) //转换时区
CURRENT_DATE ( ) //当前日期
CURRENT_TIME ( ) //当前时间
CURRENT_TIMESTAMP ( ) //当前时间戳
DATE (datetime ) //返回datetime的日期部分
DATE_ADD (date2 , INTERVAL d_value d_type ) //在date2中加上日期或时间
DATE_FORMAT (datetime ,FormatCodes ) //使用formatcodes格式显示datetime
DATE_SUB (date2 , INTERVAL d_value d_type ) //在date2上减去一个时间
DATEDIFF (date1 ,date2 ) //两个日期差
DAY (date ) //返回日期的天
DAYNAME (date ) //英文星期
DAYOFWEEK (date ) //星期(1-7) ,1为星期天
DAYOFYEAR (date ) //一年中的第几天
EXTRACT (interval_name FROM date ) //从date中提取日期的指定部分
MAKEDATE (year ,day ) //给出年及年中的第几天,生成日期串
MAKETIME (hour ,minute ,second ) //生成时间串
MONTHNAME (date ) //英文月份名
NOW ( ) //当前时间
SEC_TO_TIME (seconds ) //秒数转成时间
STR_TO_DATE (string ,format ) //字串转成时间,以format格式显示
TIMEDIFF (datetime1 ,datetime2 ) //两个时间差
TIME_TO_SEC (time ) //时间转秒数]
WEEK (date_time [,start_of_week ]) //第几周
YEAR (datetime ) //年份
DAYOFMONTH(datetime) //月的第几天
HOUR(datetime) //小时
LAST_DAY(date) //date的月的最后日期
MICROSECOND(datetime) //微秒
MONTH(datetime) //月
MINUTE(datetime) //分返回符号,正负或0
SQRT(number2) //开平方

```

## 聚合函数
```sql
AVG([DISTINCT] expr )返回平均值。 DISTINCT 选项可用于返回 expr 的不同值的平均值。
COUNT(expr )统计。若找不到匹配的行，则COUNT() 返回0。
MIN([DISTINCT] expr ), MAX([DISTINCT] expr )返回 expr 的最小值和最大值。 MIN() 和 MAX() 的取值可以是一个字符串参数；在这些情况下， 它们返回最小或最大字符串值。
SUM([DISTINCT] expr )返回expr 的总数。 若返回集合中无任何行，则 SUM() 返回NULL 。
```


## 案例

```sql
elect distinct(c.source_uid)                                                   邀请人UID,
               c.source_name                                                    邀请人昵称,
               count(c.target_uid)                                              邀请人数,
               sum(c.base_amount)                                               基础收益,
               GROUP_CONCAT(c.extra_amount)                                     红包收益,
               sum(c.base_amount + c.extra_amount)                              邀请总收益,
               b.amount                                                         已提现金额,
               GROUP_CONCAT(a.target_uid)                                       被邀请人UID,
               GROUP_CONCAT(FROM_UNIXTIME(c.utime / 1000, '%Y-%m-%d %H:%i:%s')) 受邀请时间
from c_invite c
         LEFT JOIN c_invite a on c.target_uid = a.target_uid
   , a_account b
where c.source_uid in (select distinct(source_uid) from c_invite where account_type = '1')
  and c.account_type = '1' -- 1邀请有奖 3 推荐有礼
  and c.target_uid = a.target_uid
  and c.source_uid = b.uid
  and b.trans_type = '4'
group by c.source_uid
order by c.source_uid;
```