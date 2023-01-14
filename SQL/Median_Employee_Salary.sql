-- https://leetcode.com/problems/median-employee-salary/description/

-- LeetCode 569. Median Employee Salary 

-- Hard ( Really Hard )

Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| company      | varchar |
| salary       | int     |
+--------------+---------+
id is the primary key column for this table.
Each row of this table indicates the company and the salary of one employee.
 

Write an SQL query to find the rows that contain the median salary of each company. While calculating the median, when you sort the salaries of the company, break the ties by id.

Return the result table in any order.

Example 1:

Input: 
Employee table:
+----+---------+--------+
| id | company | salary |
+----+---------+--------+
| 1  | A       | 2341   |
| 2  | A       | 341    |
| 3  | A       | 15     |
| 4  | A       | 15314  |
| 5  | A       | 451    |
| 6  | A       | 513    |
| 7  | B       | 15     |
| 8  | B       | 13     |
| 9  | B       | 1154   |
| 10 | B       | 1345   |
| 11 | B       | 1221   |
| 12 | B       | 234    |
| 13 | C       | 2345   |
| 14 | C       | 2645   |
| 15 | C       | 2645   |
| 16 | C       | 2652   |
| 17 | C       | 65     |
+----+---------+--------+
Output: 
+----+---------+--------+
| id | company | salary |
+----+---------+--------+
| 5  | A       | 451    |
| 6  | A       | 513    |
| 12 | B       | 234    |
| 9  | B       | 1154   |
| 14 | C       | 2645   |
+----+---------+--------+
Explanation: 
For company A, the rows sorted are as follows:
+----+---------+--------+
| id | company | salary |
+----+---------+--------+
| 3  | A       | 15     |
| 2  | A       | 341    |
| 5  | A       | 451    | <-- median
| 6  | A       | 513    | <-- median
| 1  | A       | 2341   |
| 4  | A       | 15314  |
+----+---------+--------+
For company B, the rows sorted are as follows:
+----+---------+--------+
| id | company | salary |
+----+---------+--------+
| 8  | B       | 13     |
| 7  | B       | 15     |
| 12 | B       | 234    | <-- median
| 11 | B       | 1221   | <-- median
| 9  | B       | 1154   |
| 10 | B       | 1345   |
+----+---------+--------+
For company C, the rows sorted are as follows:
+----+---------+--------+
| id | company | salary |
+----+---------+--------+
| 17 | C       | 65     |
| 13 | C       | 2345   |
| 14 | C       | 2645   | <-- median
| 15 | C       | 2645   | 
| 16 | C       | 2652   |
+----+---------+--------+
 

Follow up: Could you solve it without using any built-in or window functions?

-- My Solution ( Long but as per description )

with cte as 
(
    select id,
           company , 
           salary,
           row_number() over (partition by company order by salary)R
    from employee
),
id_count as 
(   select id,
           company,
           floor(max(R)/2)num from cte group by company 
),
odd as 
(
    select id,company,salary from cte 
    where
    (company,cte.R ) in (
        select company, 
            case when num%2 = 0 then num+1
            when num%2 != 0 then num end as numm
            from id_count)
    group by company        
),
even as 
(
    select id,company,salary from cte 
    where 
    (company,cte.R )in (select company,case when num%2 != 0 then num + 1 else -1 end as numm from id_count)
    group by company
)
select * from even
union 
select * from odd;


-- This Solution works fine Except the case where there are only 2 salaries . As per the logic 2/2 = 1 , 
-- so median should be 1 and second row.
-- But the answer is wrong 
Input
Employee =
| id | company | salary |
| -- | ------- | ------ |
| 1  | Amazon  | 80000  |
| 2  | Amazon  | 81000  |
| 3  | Dropbox | 90000  |
| 4  | Amazon  | 82000  |
6 / 9 testcases passed
Output
| id | company | salary |
| -- | ------- | ------ |
| 2  | Amazon  | 81000  |
| 1  | Amazon  | 80000  |
| 3  | Dropbox | 90000  |
Expected
| id | company | salary |
| -- | ------- | ------ |
| 2  | Amazon  | 81000  |
| 3  | Dropbox | 90000  |

-- Will analyse further on this 

-----------------------------------------------------------------------------------------------------

-- Second approach 

with cte as 
(
    select id, company, salary, 
	    row_number() over(partition by company order by salary) salaryrank, 
		count(*) over(partition by company)tte
    from employee
)
select Id, Company, Salary 
from cte 
where salaryrank >= tte/2 and salaryrank <= tte/2+1; 


-- The main LOGIC 

Employee =
| id | company | salary |
| -- | ------- | ------ |
| 1  | A       | 2341   |
| 2  | A       | 341    |
| 3  | A       | 15     |
| 4  | A       | 15314  |
| 5  | A       | 451    |
| 6  | A       | 513    |
| 7  | B       | 15     |
| 8  | B       | 13     |
| 9  | B       | 1154   |
| 10 | B       | 1345   |
| 11 | B       | 1221   |
| 12 | B       | 234    |
| 13 | C       | 2345   |
| 14 | C       | 2645   |
| 15 | C       | 2645   |
| 16 | C       | 2652   |
| 17 | C       | 65     |


-- Calculation as :

| Id | Company | Salary | salaryrank | tte/2 | tte/2 + 1 |
| -- | ------- | ------ | ---------- | ----- | --------- |
| 5  | A       | 451    | 3          | 3     | 4         |
| 6  | A       | 513    | 4          | 3     | 4         |
| 12 | B       | 234    | 3          | 3     | 4         |
| 9  | B       | 1154   | 4          | 3     | 4         |
| 14 | C       | 2645   | 3          | 2.5   | 3.5       |

-- Solution 

| id | company | salary |
| -- | ------- | ------ |
| 5  | A       | 451    |
| 6  | A       | 513    |
| 12 | B       | 234    |
| 9  | B       | 1154   |
| 14 | C       | 2645   |