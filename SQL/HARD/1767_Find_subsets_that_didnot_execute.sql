https://leetcode.com/problems/find-the-subtasks-that-did-not-execute/?envType=study-plan&id=sql-iii

1767. Find the Subtasks That Did Not Execute
Hard
132
12
company
Google
SQL Schema
Table: Tasks

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| task_id        | int     |
| subtasks_count | int     |
+----------------+---------+
task_id is the primary key for this table.
Each row in this table indicates that task_id was divided into subtasks_count subtasks labeled from 1 to subtasks_count.
It is guaranteed that 2 <= subtasks_count <= 20.
 

Table: Executed

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| task_id       | int     |
| subtask_id    | int     |
+---------------+---------+
(task_id, subtask_id) is the primary key for this table.
Each row in this table indicates that for the task task_id, the subtask with ID subtask_id was executed successfully.
It is guaranteed that subtask_id <= subtasks_count for each task_id.
 

Write an SQL query to report the IDs of the missing subtasks for each task_id.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Tasks table:
+---------+----------------+
| task_id | subtasks_count |
+---------+----------------+
| 1       | 3              |
| 2       | 2              |
| 3       | 4              |
+---------+----------------+
Executed table:
+---------+------------+
| task_id | subtask_id |
+---------+------------+
| 1       | 2          |
| 3       | 1          |
| 3       | 2          |
| 3       | 3          |
| 3       | 4          |
+---------+------------+
Output: 
+---------+------------+
| task_id | subtask_id |
+---------+------------+
| 1       | 1          |
| 1       | 3          |
| 2       | 1          |
| 2       | 2          |
+---------+------------+
Explanation: 
Task 1 was divided into 3 subtasks (1, 2, 3). Only subtask 2 was executed successfully, so we include (1, 1) and (1, 3) in the answer.
Task 2 was divided into 2 subtasks (1, 2). No subtask was executed successfully, so we include (2, 1) and (2, 2) in the answer.
Task 3 was divided into 4 subtasks (1, 2, 3, 4). All of the subtasks were executed successfully.

-- DML 

Create table If Not Exists Tasks (task_id int, subtasks_count int)
Create table If Not Exists Executed (task_id int, subtask_id int)
Truncate table Tasks
insert into Tasks (task_id, subtasks_count) values ('1', '3')
insert into Tasks (task_id, subtasks_count) values ('2', '2')
insert into Tasks (task_id, subtasks_count) values ('3', '4')
Truncate table Executed
insert into Executed (task_id, subtask_id) values ('1', '2')
insert into Executed (task_id, subtask_id) values ('3', '1')
insert into Executed (task_id, subtask_id) values ('3', '2')
insert into Executed (task_id, subtask_id) values ('3', '3')
insert into Executed (task_id, subtask_id) values ('3', '4')
OK

-- My Solution 1


WITH RECURSIVE id AS (
    SELECT task_id, subtasks_count, 1 AS subtask_id 
    FROM Tasks
    UNION ALL 
    SELECT task_id, subtasks_count, subtask_id + 1 AS subtask_id 
    FROM id WHERE subtask_id < (SELECT MAX(subtasks_count) FROM Tasks)
),
extra as 
(
    select distinct a.task_id,a.subtask_id from id a 
    where (a.task_id,a.subtask_id) not in (select task_id,subtask_id from executed)
)
select a.task_id , a.subtask_id from extra a
inner join tasks b 
on a.task_id = b.task_id 
and a.subtask_id <= b.subtasks_count;


-- My Solution 2

with RECURSIVE CTE AS 
(
   SELECT TASK_ID,SUBTASKS_COUNT , 1 AS SUBTASK FROM TASKS
   UNION 
   SELECT TASK_ID,SUBTASKS_COUNT,SUBTASK+1 FROM CTE 
   WHERE SUBTASK < SUBTASKS_COUNT 
)
SELECT a.task_id,a.subtask as subtask_id from cte a 
where (a.task_id,a.subtask) not in (select task_id,subtask_id from executed);