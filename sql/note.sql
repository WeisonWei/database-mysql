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
 a.uid