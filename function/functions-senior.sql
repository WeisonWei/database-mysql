# https://www.runoob.com/mysql/mysql-functions.html

select * from a_account a;

-- 6
select substring_index('6,0,47,47',',',1) from dual ;
-- 2
select count(if(a.trans_type = 7, 1, null)) from a_account a;
-- 73
select sum(if(a.trans_type = 2, a.amount, 0)) from a_account a;
