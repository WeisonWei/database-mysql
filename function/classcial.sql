select a.uid                                                               as '用户id',
       substring_index(group_concat(a.balance order by a.id desc), ',', 1) as '账户内持有金币数',
       count(if(a.trans_type = 5, true, null))                             as '已兑换次数',
       sum(if(a.trans_type = 5, a.amount, 0))                              as '已兑换金币数'
from a_account a
where a.account_type = 2
  and a.balance > 0
group by a.uid;
