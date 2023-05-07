-- https://leetcode.com/problems/group-sold-products-by-the-date/description/?envType=study-plan&id=sql-i

-- 1484. Group Sold Products By The Date 

Table Activities:

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| sell_date   | date    |
| product     | varchar |
+-------------+---------+
There is no primary key for this table, it may contain duplicates.
Each row of this table contains the product name and the date it was sold in a market.
 

Write an SQL query to find for each date the number of different products sold and their names.

The sold products names for each date should be sorted lexicographically.

Return the result table ordered by sell_date.

-- -------------------------------------------------------------------------------------------------------
Learn ::  GROUP_CONCAT => This function concatenates values from various rows of a columns based on the group 
-- -------------------------------------------------------------------------------------------------------

Create table If Not Exists Activities (sell_date date, product varchar(20))
insert into Activities (sell_date, product) values ('2020-05-30', 'Headphone')
insert into Activities (sell_date, product) values ('2020-06-01', 'Pencil')
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask')
insert into Activities (sell_date, product) values ('2020-05-30', 'Basketball')
insert into Activities (sell_date, product) values ('2020-06-01', 'Bible')
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask')
insert into Activities (sell_date, product) values ('2020-05-30', 'T-Shirt')


-- My Solution 

select 
sell_date , count(distinct(product))as num_sold ,
group_concat(distinct product) as products
from activities
group by sell_date;
