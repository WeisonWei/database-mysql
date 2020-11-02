select version();
-- time_zone
show variables like '%time_zone%';
-- system_time_zone,UTC
-- time_zone,SYSTEM
set time_zone = '+8:00';
set global time_zone = '+8:00';


set @currentHourBeginStr = concat(date_format(now(), '%Y:%m:%d %H'),':00:00');
select @currentHourStr;
set @currentHourEndStr = date_add(@currentHourBeginStr, interval '01:00:00' hour_second);

set @currentHourBegin= concat(unix_timestamp(@currentHourBeginStr),'000');
set @currentHourEnd= concat(unix_timestamp(@currentHourEndStr),'000');
select @currentHourBegin ,@currentHourEnd ;

select now() from dual;
select unix_timestamp() from dual;
select curdate() from dual;
select sysdate() from dual;
select from_unixtime(unix_timestamp()) from dual;
select from_unixtime(1218169800, '%Y %D %M %h:%i:%s %x'); -- '2008 8th August 12:30:00 2008'

select now(), sleep(3), now();
select sysdate(), sleep(3), sysdate();
select current_timestamp, current_timestamp();

select date_format('2008-08-08 22:23:01', '%Y%m%d%H%i%s');
select concat(date_format(now(), '%Y:%m:%d %H'),':00:00');
select concat(date_format(now(), '%Y:%m:%d %H'),':00:00');
select time_format('2008-08-08 22:23:01', '%Y%m%d%H%i%s');

select str_to_date('08/09/2008', '%m/%d/%Y'); -- 2008-08-09
select str_to_date('08/09/08' , '%m/%d/%y'); -- 2008-08-09
select str_to_date('08.09.2008', '%m.%d.%Y'); -- 2008-08-09
select str_to_date('08:09:30', '%h:%i:%s'); -- 08:09:30
select str_to_date('08.09.2008 08:09:30', '%m.%d.%Y %h:%i:%s'); -- 2008-08-09 08:09:30

select to_days('0000-00-00'); -- 0
select to_days('2008-08-08'); -- 733627

select time_to_sec('01:00:05'); -- 3605
select sec_to_time(3605); -- '01:00:05'

select makedate(2001,31); -- '2001-01-31'
select makedate(2001,32); -- '2001-02-01'
select maketime(12,15,30); -- '12:15:30'

set @dt = '2008-08-09 12:12:33';
select @dt;
select date_add(@dt, interval '01:15:30' hour_second);
select date_sub(@dt, interval '01:15:30' hour_second);

select datediff('2008-08-08', '2008-08-01'); -- 7

select convert_tz('2008-08-08 12:00:00', '+08:00', '+00:00'); -- 2008-08-08 04:00:00
