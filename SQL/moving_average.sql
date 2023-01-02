create table stock_price (date date , price int);

insert into stock_price values ('2020-01-07',1320);
insert into stock_price values ('2020-01-08',1300);
insert into stock_price values ('2020-01-09',1300);
insert into stock_price values ('2020-01-10',1300);

insert into stock_price values ('2020-01-11',1308);
insert into stock_price values ('2020-01-12',1200);
insert into stock_price values ('2020-01-13',1390);
insert into stock_price values ('2020-01-14',1367);
insert into stock_price values ('2020-01-15',1100);
insert into stock_price values ('2020-01-16',1167);
insert into stock_price values ('2020-01-17',1189);
insert into stock_price values ('2020-01-18',1183);
insert into stock_price values ('2020-01-19',1198);
insert into stock_price values ('2020-01-20',1189);
insert into stock_price values ('2020-01-21',1288);
insert into stock_price values ('2020-01-22',1300);
insert into stock_price values ('2020-01-23',1190);

insert into stock_price values ('2020-06-24',1086);
insert into stock_price values ('2020-06-25',1095);
insert into stock_price values ('2020-06-26',1067);
insert into stock_price values ('2020-06-27',1067);
insert into stock_price values ('2020-06-28',1076);
insert into stock_price values ('2020-06-29',1067);
insert into stock_price values ('2020-06-30',1067);


-- https://learnsql.com/blog/moving-average-in-sql/

select *,
  avg(Price) OVER(ORDER BY Date
     ROWS BETWEEN 2 PRECEDING AND CURRENT ROW )
     as moving_average
from stock_price;