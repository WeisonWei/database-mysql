UPDATE u_user a ,(
SELECT uid,SUBSTRING_INDEX(GROUP_CONCAT(pay_channel_user ORDER BY id asc), ',' ,1) as send_id
FROM o_order WHERE regtype = 1
AND `status` = 3 AND pay_channel_user>0 GROUP BY uid) b
SET a.first_order_send_id = b.send_id WHERE a.id=b.uid;