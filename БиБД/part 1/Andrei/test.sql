use test_db;

CREATE TABLE IF NOT EXISTS phones (
    idm INTEGER NOT NULL PRIMARY KEY,
    gr_name INT,
    phone TEXT
);


INSERT INTO phones
values
    (1, 820601, 'iphone'),
    (2, 820602, 'samsung'),
    (3, 820602, 'samsung'),
    (4, 820602, 'samsung'),
    (5, 820602, 'huawei'),
    (6, 820601, 'xiaomi'),
    (7, 820603, 'xiaomi'),
    (8, 820603, 'xiaomi'),
    (9, 820603, 'iphone'),
    (10, 820604, 'xiaomi'),
    (11, 820604, 'samsung'),
    (12, 820604, 'xiaomi'),
    (13, 820605, 'iphone');

select * from phones



select gr_name, phone, COUNT(*) as winner_count from phones
GROUP BY gr_name, phone
having winner_count = (
    select max(tmp.count2) as max 
    from (
        select gr_name as gr_name2, phone, count(*) as count2
        from phones
        GROUP BY gr_name2, phone
    ) as tmp
    where gr_name = tmp.gr_name2
)
ORDER BY gr_name


drop table phones;