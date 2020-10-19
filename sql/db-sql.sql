select count(1) from a_task_log a ;
select REPLACE(REPLACE(REPLACE(REPLACE(a.status,'2','进行中'),'3','完成未领取'),'4','完成已领取'),'5','已失效'),count(1)
from a_task_log a group by a.status order by 1;


select DATE_FORMAT(FROM_UNIXTIME(c.utime/1000), '%Y-%m-%d %H:%i:%S'),from_unixtime(1583589986848/1000, '%Y-%m-%d %H:%i:%S'),c.utime from c_invite c;
-- 408447537633300480
select distinct(c.source_uid)                                                   邀请人UID,
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

select * from a_transaction c where c.id='318';

-- 1 任务未领取 2 任务已领取进行中  3 任务完成,奖励已领取 4 任务完成,奖励已领取 5 已失效，完成任务，奖励超过3天未领取
select c.task_id,a.name,count(1)
from a_task_log c,a_task a
where c.status = '3'  -- 任务状态
  and c.task_id = '1'  -- 任务id
  and c.task_id = a.id
group by c.task_id;


-- 任务总条数 任务完成数

select a.task_id,b.name,a.status,count(1) 数量,sum(a.task_id) 总量,CONCAT(CAST(round((count(1)/sum(a.task_id))*100,2) AS CHAR),'%') 完成百分比
from a_task_log a,a_task b
where exists(select 1 from tg_student_trial_course c where c.term = '3'   and c.student_id = a.uid )
and a.task_id = b.id
and a.status = '3'
group by a.task_id,b.name,a.status
order by 1,2,3,4;

-- 459
select count(distinct(c.student_id)) from tg_student_trial_course c where c.term = '3';
-- 29
select count(1) from a_task_log a
where a.uid in (select student_id from tg_student_trial_course c where c.term = '3')
and a.status = '3';


select c.task_id,a.name,count(1)
from a_task_log c,a_task a
where c.status = '3'  -- 任务状态
  and c.task_id = '3'  -- 任务id
  and c.task_id = a.id
and exists(select 1 from tg_student_trial_course b where b.term = '4'   and b.student_id = c.uid )
group by c.task_id;

select distinct  b.term from tg_student_trial_course b where  b.student_id in
(select c.uid
from a_task_log c,a_task a
where c.status = '3'
  and c.task_id = '3' );
