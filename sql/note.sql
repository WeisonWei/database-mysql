UPDATE u_user a ,(
SELECT uid,SUBSTRING_INDEX(GROUP_CONCAT(pay_channel_user ORDER BY id asc), ',' ,1) as send_id
FROM o_order WHERE regtype = 1
AND `status` = 3 AND pay_channel_user>0 GROUP BY uid) b
SET a.first_order_send_id = b.send_id WHERE a.id=b.uid;

select c.weixin_openid, case when c.weixin_openid != '' then '已绑定' else '未绑定' end
from u_user c;


SELECT
 a.uid as '用户ID',
 SUBSTRING_INDEX( GROUP_CONCAT( a.balance ORDER BY a.id DESC ), ",", 1 ) AS '账户内持有金币数',
 COUNT(
 IF
 ( a.trans_type = 5, TRUE, NULL )) AS '已兑换次数',
 SUM(
 IF
 ( a.trans_type = 5, a.amount, 0 )) AS '已兑换金币数' ,
 CASE b.`weixin_openid` WHEN 1  THEN '已购买体验课' WHEN 2  THEN '已体验课' when 3 THEN '已系统课' when 4 THEN '已系统课' when 5 THEN '已系统课'
         when 6 THEN '已系统课' when 7 THEN '已系统课' when 9 THEN '已系统课' when 10 THEN '已系统课' when 11 THEN '已系统课'
         when 12 THEN '已系统课' WHEN 0 THEN '已注册'END as '是否绑定公众号',
FROM
 a_account a,
 u_user b
WHERE
 a.uid = b.id
 AND b.`status` > 1
 AND a.account_type = 2
 AND a.balance > 0
GROUP BY
 a.uid;

-- 两表强一致 关联
-- 两表不一致 连接
select
    subject as 科目,
    orderType as '课程类型',
    sum(allcount) as '课程总支付单数',
    sum(weixincount) as '微信支付总数',
    sum(alicount) as '支付宝支付总数',
    sum(jsapi) as '微信内部jsapi支付总数',
    sum(app) as '微信app支付总数',
    sum(mweb) as '微信浏览器支付总数'
from (select if(a.subject = 0, '美术课', '写字课') as subject,a.regtype,
             if(a.regtype = 1, '体验课', '系统课') as orderType,
             count(a.id) as allcount,
             count(if(opp.trade_type in ('JSAPI','APP','MWEB'), true, null )) as weixincount,
             count(if(opp.trade_type in ('WAP'), true, null )) as alicount,
             count(if(opp.trade_type in ('JSAPI'), true, null )) as jsapi,
             count(if(opp.trade_type in ('APP'), true, null )) as app,
             count(if(opp.trade_type in ('MWEB'), true, null )) as mweb
      from o_order a left join o_payment_pay opp on a.id = opp.oid
      where a.regtype in (1, 2, 3) and a.`status` = 3 and  opp.type=1 and opp.trade_type in ('JSAPI','APP','MWEB','WAP') group by a.subject,a.regtype) aa group by subject,orderType
order by 1,2;

select count(id) from u_user_extends c where c.subject =0  and c.send_id >0
                                         and not exists(select id from o_order a where a.uid = c.u_id and a.status = 3 and a.regtype in (1,2,3))
                                         and exists(select id from u_user_logindata b where b.uid = c.u_id and b.login_time between 1603382400000 and 1603987200000);
