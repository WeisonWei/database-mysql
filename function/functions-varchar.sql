select * from a_account a;

-- 12
select concat(1, 2) from dual;
-- 1-2-3-4
select concat_ws('-',1, 2,3,4) from dual;
-- 6,0,47,47,42,37,32,27,27,22,22,17,17,12,7,3,0
select group_concat(a.balance order by a.id desc) from a_account a;

-- 6
select substring_index('6,0,47,47',',',1) from dual ;
-- ,0,47,47
select substring('6,0,47,47',2) from dual ;
-- ,0
select substring('6,0,47,47',2,2) from dual ;

-- 2
select count(if(a.trans_type = 7, 1, null)) from a_account a;
-- 73
select sum(if(a.trans_type = 2, a.amount, 0)) from a_account a;

-- 3 c在后续列表中的位置
select field('c','a','b','c','d','e') from dual;
-- 6 f在后续字符串中的位置
select find_in_set('f','a,b,c,d,e,f,g') from dual;

-- 3.14
select format(3.1415926,3) from dual;

-- 1234ef 将'abcdef'1～4位置的替换成'1234'
select insert('abcdef', 1, 4, '1234') from dual;

-- 0 3 '1234' 在 'abcdef' 中的位置
select locate('1234', 'abcdef') from dual;
select locate('cd', 'abcdef') from dual;

-- weison 转小写  同 lower
select lcase('WEISON') from dual;
select lcase('WE123') from dual;

-- wei 返回字符串左3个字符
select left('wei123',3) from dual;
-- 123 返回字符串右3个字符
select right('wei123',3) from dual;