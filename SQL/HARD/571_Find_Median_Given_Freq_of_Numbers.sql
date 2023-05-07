https://leetcode.com/problems/find-median-given-frequency-of-numbers/description/?envType=study-plan&id=sql-iii

571. Find Median Given Frequency of Numbers
Hard
280
74
company
Pinterest
SQL Schema
Table: Numbers

+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
| frequency   | int  |
+-------------+------+
num is the primary key for this table.
Each row of this table shows the frequency of a number in the database.
 

The median is the value separating the higher half from the lower half of a data sample.

Write an SQL query to report the median of all the numbers in the database after decompressing the Numbers table. Round the median to one decimal point.

The query result format is in the following example.

 

Example 1:

Input: 
Numbers table:
+-----+-----------+
| num | frequency |
+-----+-----------+
| 0   | 7         |
| 1   | 1         |
| 2   | 3         |
| 3   | 1         |
+-----+-----------+
Output: 
+--------+
| median |
+--------+
| 0.0    |
+--------+
Explanation: 
If we decompress the Numbers table, we will get [0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3], so the median is (0 + 0) / 2 = 0.

-- DML 
Create table If Not Exists Numbers (num int, frequency int)
Truncate table Numbers
insert into Numbers (num, frequency) values ('0', '7')
insert into Numbers (num, frequency) values ('1', '1')
insert into Numbers (num, frequency) values ('2', '3')
insert into Numbers (num, frequency) values ('3', '1')


-- My Solution

with recursive cte as 
(
    select num,frequency , 1 as cnt from numbers 
    union 
    select num,frequency , cnt+1 as cnt from cte 
    where cnt < frequency 
),
row_and_count as 
(
    select num,frequency,cnt,
           row_number() over (order by num) row_num, 
           count(*) over () total_count
    from cte   
)
select case when total_count%2 = 0 then round(avg(num),1) else round(num,1) end as median
from row_and_count 
where row_num between total_count/2 and total_count/2+1;       




