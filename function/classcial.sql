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
      from o_order a left join o_payment_pay opp on a.id = opp.oid
      where a.regtype in (1, 2, 3) and
              a.`status` = 3 and
              opp.type = 1 and
              opp.trade_type in ('jsapi', 'app', 'mweb', 'wap')
      group by a.subject, a.regtype) aa
group by subject, ordertype
order by 1, 2;

-- 科目 课程类型 支付订单总数 微信支付数 支付宝支付数 支付宝内部支付数 微信app支付数 微信H5支付数
select b.subject 科目, if(b.regtype = 1, '体验课', '系统课') 课程, sum(trailTotal), sum(systemTotal), sum(ali), sum(wx)
from (select c.subject,
             c.regtype,
             count(if(c.regtype = 1, true, null))         trailTotal,
             count(if(c.regtype != 1, true, null))        systemTotal,
             count(if(a.trade_type = 'wap', true, null))  ali,
             count(if(a.trade_type != 'wap', true, null)) wx,
             count(c.id)                                  total
      from o_order c left join o_payment_pay a on a.oid = c.id
      where c.status = 3
        and c.regtype in (1, 2, 3)
        and a.type = 1
        and a.status = 2
        and a.trade_type in ('jsapi', 'app', 'mweb', 'wap')
      group by c.subject, c.regtype, a.trade_type) b
group by b.subject;