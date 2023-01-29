-- https://leetcode.com/problems/rectangles-area/description/?envType=study-plan&id=sql-ii

-- LeetCode 1459 : Rectangles Area | Medium |
Table: Points

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| x_value       | int     |
| y_value       | int     |
+---------------+---------+
id is the primary key for this table.
Each point is represented as a 2D coordinate (x_value, y_value).
 

Write an SQL query to report all possible axis-aligned rectangles with a non-zero area that can be formed by any two points from the Points table.

Each row in the result should contain three columns (p1, p2, area) where:

p1 and p2 are the ids of the two points that determine the opposite corners of a rectangle.
area is the area of the rectangle and must be non-zero.
Return the result table ordered by area in descending order. If there is a tie, order them by p1 in ascending order. If there is still a tie, order them by p2 in ascending order.

The query result format is in the following table.

 

Example 1:


Input: 
Points table:
+----------+-------------+-------------+
| id       | x_value     | y_value     |
+----------+-------------+-------------+
| 1        | 2           | 7           |
| 2        | 4           | 8           |
| 3        | 2           | 10          |
+----------+-------------+-------------+
Output: 
+----------+-------------+-------------+
| p1       | p2          | area        |
+----------+-------------+-------------+
| 2        | 3           | 4           |
| 1        | 2           | 2           |
+----------+-------------+-------------+
Explanation: 
The rectangle formed by p1 = 2 and p2 = 3 has an area equal to |4-2| * |8-10| = 4.
The rectangle formed by p1 = 1 and p2 = 2 has an area equal to |2-4| * |7-8| = 2.
Note that the rectangle formed by p1 = 1 and p2 = 3 is invalid because the area is 0.

-- DML 
Create table If Not Exists Points (id int, x_value int, y_value int)
Truncate table Points
insert into Points (id, x_value, y_value) values ('1', '2', '7')
insert into Points (id, x_value, y_value) values ('2', '4', '8')
insert into Points (id, x_value, y_value) values ('3', '2', '10')

-- My Solution

with cte as 
(
    select a.id as p1 ,b.id as p2 ,abs(a.x_value-b.x_value) * abs(a.y_value-b.y_value) as area 
    from points a , points b 
    where a.id <> b.id 
),
cte2 as 
(
    select a.p1 , a.p2 , a.area,
           row_number() over(partition by a.p1,a.p2 order by a.p1,a.p2)R
    from cte a
    inner join cte b 
    on
        a.p1 <> b.p2 and a.p2 <> b.p1
    and a.p1 < a.p2
    and a.area <> 0
)
select b.p1 as P1 ,
       b.p2 as P2 ,
       b.area as AREA from cte2 b
where b.R = 1
order by AREA desc,P1,P2;



