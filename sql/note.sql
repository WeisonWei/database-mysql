select count(1)
from a_task_log a;
select REPLACE(REPLACE(REPLACE(REPLACE(a.status, '2', '进行中'), '3', '完成未领取'), '4', '完成已领取'), '5', '已失效'),
       count(1)
from a_task_log a
group by a.status
order by 1;


select DATE_FORMAT(FROM_UNIXTIME(c.utime / 1000), '%Y-%m-%d %H:%i:%S'),
       from_unixtime(1583589986848 / 1000, '%Y-%m-%d %H:%i:%S'),
       c.utime
from c_invite c;
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

select *
from a_transaction c
where c.id = '318';

-- 1 任务未领取 2 任务已领取进行中  3 任务完成,奖励已领取 4 任务完成,奖励已领取 5 已失效，完成任务，奖励超过3天未领取
select c.task_id, a.name, count(1)
from a_task_log c,
     a_task a
where c.status = '3'  -- 任务状态
  and c.task_id = '1' -- 任务id
  and c.task_id = a.id
group by c.task_id;


-- 任务总条数 任务完成数

select a.task_id,
       b.name,
       a.status,
       count(1)                                                               数量,
       sum(a.task_id)                                                         总量,
       CONCAT(CAST(round((count(1) / sum(a.task_id)) * 100, 2) AS CHAR), '%') 完成百分比
from a_task_log a,
     a_task b
where exists(select 1 from tg_student_trial_course c where c.term = '3' and c.student_id = a.uid)
  and a.task_id = b.id
  and a.status = '3'
group by a.task_id, b.name, a.status
order by 1, 2, 3, 4;

-- 459
select count(distinct (c.student_id))
from tg_student_trial_course c
where c.term = '3';
-- 29
select count(1)
from a_task_log a
where a.uid in (select student_id from tg_student_trial_course c where c.term = '3')
  and a.status = '3';


select c.task_id, a.name, count(1)
from a_task_log c,
     a_task a
where c.status = '3'  -- 任务状态
  and c.task_id = '3' -- 任务id
  and c.task_id = a.id
  and exists(select 1 from tg_student_trial_course b where b.term = '4' and b.student_id = c.uid)
group by c.task_id;

select distinct b.term
from tg_student_trial_course b
where b.student_id in
      (select c.uid
       from a_task_log c,
            a_task a
       where c.status = '3'
         and c.task_id = '3');


select a.uid                                                               as '用户id',
       substring_index(group_concat(a.balance order by a.id desc), ',', 1) as '账户内持有金币数',
       count(if(a.trans_type = 5, true, null))                             as '已兑换次数',
       sum(if(a.trans_type = 5, a.amount, 0))                              as '已兑换金币数'
from a_account a
where a.account_type = 2
  and a.balance > 0
group by a.uid;

select version();
show variables;
show session variables;

-- 当前小时 各科目 订单各状态数量
select date_format(now(), '%H')        小时,
       if(c.subject = 0, '美术', '写字')   科目,
       if(c.status = 3, '支付完成', '待支付') 支付状态,
       count(id)                       数量
from o_order c
where c.ctime >= concat(unix_timestamp(concat(date_format(now(), '%Y-%m-%d %H'), ':00:00')), '000')
group by c.subject, c.status
order by 2, 3;

-- 当前小时 各科目 支付成功的课程情况
select date_format(now(), '%H')          小时,
       a.subject                         科目,
       sum(if(a.regtype = 1, a.num, 0))  体验课支付完成数,
       sum(if(a.regtype != 1, a.num, 0)) 系统课支付完成数
from (select c.subject,
             c.regtype,
             count(id) num
      from o_order c
      where c.status = 3
        and c.regtype in (1, 2, 3)
        and c.ctime >= concat(unix_timestamp(concat(date_format(now(), '%Y-%m-%d %H'), ':00:00')), '000')
      group by c.subject, c.regtype) a
group by a.subject
order by a.subject;

-- 科目 体验课支付完成 系统课支付完成 总量 体验课占比 系统课占比
select date_format(now(), '%H')      小时,
       if(a.subject = 0, '美术', '写字') 科目,
       sum(a.trailNum)               体验课订单,
       sum(a.systemNum)              系统课订单
from (select c.subject,
             count(if(c.regtype = 1, true, null))  trailNum,
             count(if(c.regtype != 1, true, null)) systemNum
      from o_order c
      where c.status = 3
        and c.regtype in (1, 2, 3)
        and c.ctime >= concat(unix_timestamp(concat(date_format(now(), '%Y-%m-%d %H'), ':00:00')), '000')
      group by c.subject, c.regtype) a
group by a.subject;


-- 各科目 各支付类型的支付数量
select subject          as 科目,
       ordertype        as '课程类型',
       sum(allcount)    as '课程总支付单数',
       sum(weixincount) as '微信支付总数',
       sum(alicount)    as '支付宝支付总数',
       sum(jsapi)       as '微信内部jsapi支付总数',
       sum(app)         as '微信app支付总数',
       sum(mweb)        as '微信浏览器支付总数'
from (select if(a.subject = 0, '美术课', '写字课')                                   as subject,
             a.regtype,
             if(a.regtype = 1, '体验课', '系统课')                                   as ordertype,
             count(a.id)                                                       as allcount,
             count(if(opp.trade_type in ('jsapi', 'app', 'mweb'), true, null)) as weixincount,
             count(if(opp.trade_type in ('wap'), true, null))                  as alicount,
             count(if(opp.trade_type in ('jsapi'), true, null))                as jsapi,
             count(if(opp.trade_type in ('app'), true, null))                  as app,
             count(if(opp.trade_type in ('mweb'), true, null))                 as mweb
      from o_order a
               left join o_payment_pay opp on a.id = opp.oid
      where a.regtype in (1, 2, 3)
        and a.`status` = 3
        and opp.type = 1
        and opp.trade_type in ('jsapi', 'app', 'mweb', 'wap')
      group by a.subject, a.regtype) aa
group by subject, ordertype
order by 1, 2;

UPDATE u_user a ,(
    SELECT uid, SUBSTRING_INDEX(GROUP_CONCAT(pay_channel_user ORDER BY id asc), ',', 1) as send_id
    FROM o_order
    WHERE regtype = 1
      AND `status` = 3
      AND pay_channel_user > 0
    GROUP BY uid) b
SET a.first_order_send_id = b.send_id
WHERE a.id = b.uid;

select c.weixin_openid, case when c.weixin_openid != '' then '已绑定' else '未绑定' end
from u_user c;


SELECT a.uid                                                               as '用户ID',
       SUBSTRING_INDEX(GROUP_CONCAT(a.balance ORDER BY a.id DESC), ",", 1) AS '账户内持有金币数',
       COUNT(
               IF
                   (a.trans_type = 5, TRUE, NULL))                         AS '已兑换次数',
       SUM(
               IF
                   (a.trans_type = 5, a.amount, 0))                        AS '已兑换金币数',
       CASE b.`weixin_openid`
           WHEN 1 THEN '已购买体验课'
           WHEN 2 THEN '已体验课'
           when 3 THEN '已系统课'
           when 4 THEN '已系统课'
           when 5 THEN '已系统课'
           when 6 THEN '已系统课'
           when 7 THEN '已系统课'
           when 9 THEN '已系统课'
           when 10 THEN '已系统课'
           when 11 THEN '已系统课'
           when 12 THEN '已系统课'
           WHEN 0 THEN '已注册' END                                           as '是否绑定公众号',
FROM a_account a,
     u_user b
WHERE a.uid = b.id
  AND b.`status` > 1
  AND a.account_type = 2
  AND a.balance > 0
GROUP BY a.uid;

-- 两表强一致 关联
-- 两表不一致 连接
select subject          as 科目,
       orderType        as '课程类型',
       sum(allcount)    as '课程总支付单数',
       sum(weixincount) as '微信支付总数',
       sum(alicount)    as '支付宝支付总数',
       sum(jsapi)       as '微信内部jsapi支付总数',
       sum(app)         as '微信app支付总数',
       sum(mweb)        as '微信浏览器支付总数'
from (select if(a.subject = 0, '美术课', '写字课')                                   as subject,
             a.regtype,
             if(a.regtype = 1, '体验课', '系统课')                                   as orderType,
             count(a.id)                                                       as allcount,
             count(if(opp.trade_type in ('JSAPI', 'APP', 'MWEB'), true, null)) as weixincount,
             count(if(opp.trade_type in ('WAP'), true, null))                  as alicount,
             count(if(opp.trade_type in ('JSAPI'), true, null))                as jsapi,
             count(if(opp.trade_type in ('APP'), true, null))                  as app,
             count(if(opp.trade_type in ('MWEB'), true, null))                 as mweb
      from o_order a
               left join o_payment_pay opp on a.id = opp.oid
      where a.regtype in (1, 2, 3)
        and a.`status` = 3
        and opp.type = 1
        and opp.trade_type in ('JSAPI', 'APP', 'MWEB', 'WAP')
      group by a.subject, a.regtype) aa
group by subject, orderType
order by 1, 2;

select count(id)
from u_user_extends c
where c.subject = 0
  and c.send_id > 0
  and not exists(select id from o_order a where a.uid = c.u_id and a.status = 3 and a.regtype in (1, 2, 3))
  and exists(select id
             from u_user_logindata b
             where b.uid = c.u_id
               and b.login_time between 1603382400000 and 1603987200000);

-- 科目 课程类型 支付订单总数 微信支付数 支付宝支付数 支付宝内部支付数 微信app支付数 微信H5支付数
select b.subject 科目, if(b.regtype = 1, '体验课', '系统课') 课程, sum(trailTotal), sum(systemTotal), sum(ali), sum(wx)
from (select c.subject,
             c.regtype,
             count(if(c.regtype = 1, true, null))         trailTotal,
             count(if(c.regtype != 1, true, null))        systemTotal,
             count(if(a.trade_type = 'wap', true, null))  ali,
             count(if(a.trade_type != 'wap', true, null)) wx,
             count(c.id)                                  total
      from o_order c
               left join o_payment_pay a on a.oid = c.id
      where c.status = 3
        and c.regtype in (1, 2, 3)
        and a.type = 1
        and a.status = 2
        and a.trade_type in ('jsapi', 'app', 'mweb', 'wap')
      group by c.subject, c.regtype, a.trade_type) b
group by b.subject;