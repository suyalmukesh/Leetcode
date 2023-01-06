-- https://leetcode.com/problems/find-cumulative-salary-of-an-employee/description/

Create table If Not Exists Employee (id int, month int, salary int);
--Truncate table Employee;
insert into Employee (id, month, salary) values ('1', '1', '20');
insert into Employee (id, month, salary) values ('2', '1', '20');
insert into Employee (id, month, salary) values ('1', '2', '30');
insert into Employee (id, month, salary) values ('2', '2', '30');
insert into Employee (id, month, salary) values ('3', '2', '40');
insert into Employee (id, month, salary) values ('1', '3', '40');
insert into Employee (id, month, salary) values ('3', '3', '60');
insert into Employee (id, month, salary) values ('1', '4', '60');
insert into Employee (id, month, salary) values ('3', '4', '70');
insert into Employee (id, month, salary) values ('1', '7', '90');
insert into Employee (id, month, salary) values ('1', '8', '90');

"""
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| month       | int  |
| salary      | int  |
+-------------+------+
(id, month) is the primary key for this table.
Each row in the table indicates the salary of an employee in one month during the year 2020.
 

Write an SQL query to calculate the cumulative salary summary for every employee in a single unified table.

The cumulative salary summary for an employee can be calculated as follows:

For each month that the employee worked, sum up the salaries in that month and the previous two months. This is their 3-month sum for that month. If an employee did not work for the company in previous months, their effective salary for those months is 0.
Do not include the 3-month sum for the most recent month that the employee worked for in the summary.
Do not include the 3-month sum for any month the employee did not work.
Return the result table ordered by id in ascending order. In case of a tie, order it by month in descending order.

The query result format is in the following example.

"""
-----------------------------------------------------------------------------------------------------

-- My Solution 

with cte as 
(
    select  id , 
        month ,
        lead(month,1) over (partition by id order by month desc )next_1,
        lead(month,2) over (partition by id order by month desc )next_2,
        lead(salary,1) over (partition by id order by month desc )next_1_sal,
        lead(salary,2) over (partition by id order by month desc )next_2_sal, 
        row_number() over(partition by id order by month desc)R,
        salary 
    from employee 
    order by id , month desc 
),

exclude_latest as 
(   select * from cte where R > 1),

calculation as 
(     
    select 
        id,
        month ,
        salary as A , 
        case when next_1 = month - 1 then next_1_sal else 0 end as B,
        case when next_2 = month - 2 then next_2_sal else 0 end as C
    from exclude_latest 
)
select id, month, A+B+C as salary from calculation;

---------------------------------------------------------------------------------------------
-- Leetcode official solution

SELECT
    E1.id,
    E1.month,
    (IFNULL(E1.salary, 0) + IFNULL(E2.salary, 0) + IFNULL(E3.salary, 0)) AS Salary
FROM
    (SELECT
        id, MAX(month) AS month
    FROM
        Employee
    GROUP BY id
    HAVING COUNT(*) > 1) AS maxmonth
        LEFT JOIN
    Employee E1 ON (maxmonth.id = E1.id
        AND maxmonth.month > E1.month)
        LEFT JOIN
    Employee E2 ON (E2.id = E1.id
        AND E2.month = E1.month - 1)
        LEFT JOIN
    Employee E3 ON (E3.id = E1.id
        AND E3.month = E1.month - 2)
ORDER BY id ASC , month DESC
;

-- ============================================================================