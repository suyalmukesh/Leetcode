-- https://leetcode.com/problems/count-student-number-in-departments/description/ 

-- 580. Count Student Number in Departments 

-- LeeCode ( Medium )


Table: Student

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| student_name | varchar |
| gender       | varchar |
| dept_id      | int     |
+--------------+---------+
student_id is the primary key column for this table.
dept_id is a foreign key to dept_id in the Department tables.
Each row of this table indicates the name of a student, their gender, and the id of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| dept_id     | int     |
| dept_name   | varchar |
+-------------+---------+
dept_id is the primary key column for this table.
Each row of this table contains the id and the name of a department.
 

Write an SQL query to report the respective department name and number of students majoring in each department for all departments in the Department table (even ones with no current students).

Return the result table ordered by student_number in descending order. In case of a tie, order them by dept_name alphabetically.

The query result format is in the following example.

Example 1:

Input: 
Student table:
+------------+--------------+--------+---------+
| student_id | student_name | gender | dept_id |
+------------+--------------+--------+---------+
| 1          | Jack         | M      | 1       |
| 2          | Jane         | F      | 1       |
| 3          | Mark         | M      | 2       |
+------------+--------------+--------+---------+
Department table:
+---------+-------------+
| dept_id | dept_name   |
+---------+-------------+
| 1       | Engineering |
| 2       | Science     |
| 3       | Law         |
+---------+-------------+
Output: 
+-------------+----------------+
| dept_name   | student_number |
+-------------+----------------+
| Engineering | 2              |
| Science     | 1              |
| Law         | 0              |
+-------------+----------------+


--------------------------------------------------------------------------------
-- DDL
Create table If Not Exists Student (student_id int,student_name varchar(45), gender varchar(6), dept_id int)
Create table If Not Exists Department (dept_id int, dept_name varchar(255))
Truncate table Student
insert into Student (student_id, student_name, gender, dept_id) values ('1', 'Jack', 'M', '1')
insert into Student (student_id, student_name, gender, dept_id) values ('2', 'Jane', 'F', '1')
insert into Student (student_id, student_name, gender, dept_id) values ('3', 'Mark', 'M', '2')
Truncate table Department
insert into Department (dept_id, dept_name) values ('1', 'Engineering')
insert into Department (dept_id, dept_name) values ('2', 'Science')
insert into Department (dept_id, dept_name) values ('3', 'Law')

-- My Solution 

select a.dept_name , coalesce(b.cnt,0) as student_number from department a 
left join (select dept_id, count(dept_id)cnt from student group by dept_id)b
on a.dept_id = b.dept_id
order by student_number desc , dept_name;


