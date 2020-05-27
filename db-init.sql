create table ai_app_test.a_task
(
    id            bigint auto_increment
        primary key,
    cid           bigint         default 0    null,
    ctime         bigint         default 0    null,
    del           bigint         default 0    null,
    mid           bigint         default 0    null,
    utime         bigint         default 0    null,
    amount        decimal(10, 2) default 0.00 null,
    buy_url       varchar(255)   default ''   null,
    check_buy     int            default 0    null,
    courses       varchar(255)   default ''   null,
    `desc`        varchar(255)   default ''   null,
    is_repeatable int            default 0    null,
    name          varchar(255)   default ''   null,
    note          varchar(255)   default ''   null,
    star_value    int            default 0    null,
    status        int            default 0    null,
    tag           int            default 0    null,
    task_url      varchar(255)   default ''   null,
    type          int            default 0    null,
    need_fetch    int            default 0    null
);

create index idx_type
    on ai_app_test.a_task (type);




create table ai_app_test.a_task_log
(
    id           bigint auto_increment
        primary key,
    cid          bigint         default 0    null,
    ctime        bigint         default 0    null,
    del          bigint         default 0    null,
    mid          bigint         default 0    null,
    utime        bigint         default 0    null,
    amount       decimal(10, 2) default 0.00 null,
    buy_url      varchar(255)   default ''   null,
    is_sign      int            default 0    null,
    note         varchar(255)   default ''   null,
    signed_count int            default 0    null,
    source       bigint         default 0    null,
    status       int            default 0    null,
    task_id      bigint         default 0    null,
    task_url     varchar(255)   default ''   null,
    type         int            default 0    null,
    uid          bigint         default 0    null,
    update_date  varchar(255)   default ''   null,
    `desc`       varchar(255)   default ''   null
);

create index idx_task_id_uid
    on ai_app_test.a_task_log (task_id, uid);



create table ai_app_test.a_account
(
    id              bigint auto_increment
        primary key,
    cid             bigint         default 0    null,
    ctime           bigint         default 0    null,
    del             bigint         default 0    null,
    mid             bigint         default 0    null,
    utime           bigint         default 0    null,
    account_type    int            default 0    null,
    amount          decimal(10, 2) default 0.00 null,
    balance         decimal(10, 2) default 0.00 null,
    `desc`          varchar(255)   default ''   null,
    expected_amount decimal        default 0    null,
    link            varchar(255)   default ''   null,
    note            varchar(255)   default ''   null,
    source          bigint         default 0    null,
    target          bigint         default 0    null,
    trans_type      int            default 0    null,
    uid             bigint         default 0    null,
    update_date     varchar(255)   default ''   null
);

create index idx_uid_account_type
    on ai_app_test.a_account (uid, account_type);

