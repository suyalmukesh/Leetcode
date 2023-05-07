-- https://leetcode.com/problems/shortest-distance-in-a-line/description/

Create Table If Not Exists Point (x int not null)
Truncate table Point
insert into Point (x) values ('-1')
insert into Point (x) values ('0')
insert into Point (x) values ('2')

SQL Schema
Table: Point

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
+-------------+------+
x is the primary key column for this table.
Each row of this table indicates the position of a point on the X-axis.
 

Write an SQL query to report the shortest distance between any two points from the Point table.


-- -----------------------------------------------------------------------------------------
-- My_Solution 

select min(sqrt(power((b.x - a.x),2))) as shortest  
from point a 
inner join point b
on a.x <> b.x;

