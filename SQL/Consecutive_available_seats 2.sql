
LeetCode 603 : Consecutive Available Seats 
--------------------------------------------------------------------

+-------------+------+
| Column Name | Type |
+-------------+------+
| seat_id     | int  |
| free        | bool |
+-------------+------+
seat_id is an auto-increment primary key column for this table.
Each row of this table indicates whether the ith seat is free or not. 1 means free while 0 means occupied.

Write an SQL query to report all the consecutive available seats in the cinema.

Return the result table ordered by seat_id in ascending order.

The test cases are generated so that more than two seats are consecutively available.

Input: 
Cinema table:
+---------+------+
| seat_id | free |
+---------+------+
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |
+---------+------+
Output: 
+---------+
| seat_id |
+---------+
| 3       |
| 4       |
| 5       |
+---------+

-- ---------------------------------------------------------------------------------------------------------------------------------
-- Exceute DML 

Create table If Not Exists Cinema (seat_id int primary key auto_increment, free bool);
-- Truncate table Cinema;
insert into Cinema (seat_id, free) values ('1', '1');
insert into Cinema (seat_id, free) values ('2', '0');
insert into Cinema (seat_id, free) values ('3', '1');
insert into Cinema (seat_id, free) values ('4', '1');
insert into Cinema (seat_id, free) values ('5', '1');

-- Solution 

with cte as 
(
  select 
      seat_id,
      free,
      coalesce(lag(free,1) over (order by seat_id),0)as prev_seat,
      coalesce(lead(free,1)over (order by seat_id),0) as next_seat      
from cinema 
)
select seat_id from cte 
where free = 1 and (next_seat = 1 or prev_seat = 1)
order by seat_id;
