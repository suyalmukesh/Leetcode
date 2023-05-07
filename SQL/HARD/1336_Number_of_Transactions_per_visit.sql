https://leetcode.com/problems/number-of-transactions-per-visit/description/
1336. Number of Transactions per Visit
Hard
81
293
Machine Zone
MachineZone
SQL Schema
Table: Visits

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| visit_date    | date    |
+---------------+---------+
(user_id, visit_date) is the primary key for this table.
Each row of this table indicates that user_id has visited the bank in visit_date.
 

Table: Transactions

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| user_id          | int     |
| transaction_date | date    |
| amount           | int     |
+------------------+---------+
There is no primary key for this table, it may contain duplicates.
Each row of this table indicates that user_id has done a transaction of amount in transaction_date.
It is guaranteed that the user has visited the bank in the transaction_date.(i.e The Visits table contains (user_id, transaction_date) in one row)
 

A bank wants to draw a chart of the number of transactions bank visitors did in one visit to the bank and the corresponding number of visitors who have done this number of transaction in one visit.

Write an SQL query to find how many users visited the bank and did not do any transactions, how many visited the bank and did one transaction and so on.

The result table will contain two columns:

transactions_count which is the number of transactions done in one visit.
visits_count which is the corresponding number of users who did transactions_count in one visit to the bank.
transactions_count should take all values from 0 to max(transactions_count) done by one or more users.

Return the result table ordered by transactions_count.

The query result format is in the following example.

 

Example 1:


Input: 
Visits table:
+---------+------------+
| user_id | visit_date |
+---------+------------+
| 1       | 2020-01-01 |
| 2       | 2020-01-02 |
| 12      | 2020-01-01 |
| 19      | 2020-01-03 |
| 1       | 2020-01-02 |
| 2       | 2020-01-03 |
| 1       | 2020-01-04 |
| 7       | 2020-01-11 |
| 9       | 2020-01-25 |
| 8       | 2020-01-28 |
+---------+------------+
Transactions table:
+---------+------------------+--------+
| user_id | transaction_date | amount |
+---------+------------------+--------+
| 1       | 2020-01-02       | 120    |
| 2       | 2020-01-03       | 22     |
| 7       | 2020-01-11       | 232    |
| 1       | 2020-01-04       | 7      |
| 9       | 2020-01-25       | 33     |
| 9       | 2020-01-25       | 66     |
| 8       | 2020-01-28       | 1      |
| 9       | 2020-01-25       | 99     |
+---------+------------------+--------+
Output: 
+--------------------+--------------+
| transactions_count | visits_count |
+--------------------+--------------+
| 0                  | 4            |
| 1                  | 5            |
| 2                  | 0            |
| 3                  | 1            |
+--------------------+--------------+
Explanation: The chart drawn for this example is shown above.
* For transactions_count = 0, The visits (1, "2020-01-01"), (2, "2020-01-02"), (12, "2020-01-01") and (19, "2020-01-03") did no transactions so visits_count = 4.
* For transactions_count = 1, The visits (2, "2020-01-03"), (7, &quo;2020-01-11"), (8, "2020-01-28"), (1, "2020-01-02") and (1, "2020-01-04") did one transaction so visits_count = 5."
* For transactions_count = 2, No customers visited the bank and did two transactions so visits_count = 0.
* For transactions_count = 3, The visit (9, "2020-01-25") did three transactions so visits_count = 1.
* For transactions_count >= 4, No customers visited the bank and did more than three transactions so we will stop at transactions_count = 3

-- DML 

Create table If Not Exists Visits (user_id int, visit_date date)
Create table If Not Exists Transactions (user_id int, transaction_date date, amount int)
Truncate table Visits
insert into Visits (user_id, visit_date) values ('1', '2020-01-01')
insert into Visits (user_id, visit_date) values ('2', '2020-01-02')
insert into Visits (user_id, visit_date) values ('12', '2020-01-01')
insert into Visits (user_id, visit_date) values ('19', '2020-01-03')
insert into Visits (user_id, visit_date) values ('1', '2020-01-02')
insert into Visits (user_id, visit_date) values ('2', '2020-01-03')
insert into Visits (user_id, visit_date) values ('1', '2020-01-04')
insert into Visits (user_id, visit_date) values ('7', '2020-01-11')
insert into Visits (user_id, visit_date) values ('9', '2020-01-25')
insert into Visits (user_id, visit_date) values ('8', '2020-01-28')
Truncate table Transactions
insert into Transactions (user_id, transaction_date, amount) values ('1', '2020-01-02', '120')
insert into Transactions (user_id, transaction_date, amount) values ('2', '2020-01-03', '22')
insert into Transactions (user_id, transaction_date, amount) values ('7', '2020-01-11', '232')
insert into Transactions (user_id, transaction_date, amount) values ('1', '2020-01-04', '7')
insert into Transactions (user_id, transaction_date, amount) values ('9', '2020-01-25', '33')
insert into Transactions (user_id, transaction_date, amount) values ('9', '2020-01-25', '66')
insert into Transactions (user_id, transaction_date, amount) values ('8', '2020-01-28', '1')
insert into Transactions (user_id, transaction_date, amount) values ('9', '2020-01-25', '99')
OK

-- My Solution 

with total_visits as 
(
  select user_id,visit_date , count(user_id)visit from visits group by visit_date,user_id
),
total_transactions  as 
(
  select user_id,transaction_date , count(user_id)transact from transactions group by transaction_date,user_id
),
transactions_visits as 
(
  select a.visit_date , a.visit , coalesce(b.transact,0)transact from total_visits a 
  left join total_transactions b
  on a.visit_date = b.transaction_date 
  and a.user_id = b.user_id
),
all_visits_counts as 
    (   with recursive cte as (
            select 0 as cnt from transactions_visits 
            union 
            select cnt+1 as cnt from cte
            where cnt < (select max(transact) from transactions_visits)
    ) 
    select * from cte 
),
given_snapshot_result as 
(
    select transact as transactions_count, 
           count(transact) as visits_count 
    from transactions_visits 
    group by transact
)
select a.cnt as transactions_count,
       coalesce(b.visits_count,0) as visits_count 
from all_visits_counts a
left join given_snapshot_result b 
on a.cnt = b.transactions_count;