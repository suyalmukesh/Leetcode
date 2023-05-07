-- https://leetcode.com/problems/shortest-distance-in-a-plane/description/

Create Table If Not Exists Point2D (x int not null, y int not null)
Truncate table Point2D
insert into Point2D (x, y) values ('-1', '-1')
insert into Point2D (x, y) values ('0', '0')
insert into Point2D (x, y) values ('-1', '-2')

Table: Point2D

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
+-------------+------+
(x, y) is the primary key column for this table.
Each row of this table indicates the position of a point on the X-Y plane.
 

The distance between two points p1(x1, y1) and p2(x2, y2) is sqrt((x2 - x1)2 + (y2 - y1)2).

Write an SQL query to report the shortest distance between any two points from the Point2D table. Round the distance to two decimal points.

-- --------------------------------------------------------------------------------------------------------------------

My_Solution :

select 
    round(min(sqrt(power((a.x - b.x),2) + power((a.y-b.y),2))),2) as   shortest
from point2d a 
inner join point2d b 
on a.x + b.y <>  b.x + a.y;    