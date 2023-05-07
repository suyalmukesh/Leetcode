https://leetcode.com/problems/user-purchase-platform/description/


1127. User Purchase Platform
Hard
158
119
company
LinkedIn
SQL Schema
Table: Spending

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| spend_date  | date    |
| platform    | enum    | 
| amount      | int     |
+-------------+---------+
The table logs the history of the spending of users that make purchases from an online shopping website that has a desktop and a mobile application.
(user_id, spend_date, platform) is the primary key of this table.
The platform column is an ENUM type of ('desktop', 'mobile').
 

Write an SQL query to find the total number of users and the total amount spent using the mobile only, the desktop only, and both mobile and desktop together for each date.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Spending table:
+---------+------------+----------+--------+
| user_id | spend_date | platform | amount |
+---------+------------+----------+--------+
| 1       | 2019-07-01 | mobile   | 100    |
| 1       | 2019-07-01 | desktop  | 100    |
| 2       | 2019-07-01 | mobile   | 100    |
| 2       | 2019-07-02 | mobile   | 100    |
| 3       | 2019-07-01 | desktop  | 100    |
| 3       | 2019-07-02 | desktop  | 100    |
+---------+------------+----------+--------+
Output: 
+------------+----------+--------------+-------------+
| spend_date | platform | total_amount | total_users |
+------------+----------+--------------+-------------+
| 2019-07-01 | desktop  | 100          | 1           |
| 2019-07-01 | mobile   | 100          | 1           |
| 2019-07-01 | both     | 200          | 1           |
| 2019-07-02 | desktop  | 100          | 1           |
| 2019-07-02 | mobile   | 100          | 1           |
| 2019-07-02 | both     | 0            | 0           |
+------------+----------+--------------+-------------+ 
Explanation: 
On 2019-07-01, user 1 purchased using both desktop and mobile, user 2 purchased using mobile only and user 3 purchased using desktop only.
On 2019-07-02, user 2 purchased using mobile only, user 3 purchased using desktop only and no one purchased using both platforms.


-- DML 

Create table If Not Exists Spending (user_id int, spend_date date, platform ENUM('desktop', 'mobile'), amount int)
Truncate table Spending
insert into Spending (user_id, spend_date, platform, amount) values ('1', '2019-07-01', 'mobile', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('1', '2019-07-01', 'desktop', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('2', '2019-07-01', 'mobile', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('2', '2019-07-02', 'mobile', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('3', '2019-07-01', 'desktop', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('3', '2019-07-02', 'desktop', '100')



-- Solution 

with cte as 
( 
    select spend_date , user_id , 
       sum(case platform when 'mobile' then amount else 0 end )mobile_amount, 
       sum(case platform when 'desktop' then amount else 0 end )desktop_amount
    from spending 
    group by spend_date , user_id        
),
cte2 as
(
    select spend_date , user_id,
        if(mobile_amount > 0 , if(desktop_amount>0,'both','mobile'),'desktop')platform,
        (mobile_amount + desktop_amount)amount  
    from cte                
),
cte3 as 
(
select distinct(spend_date),'desktop' platform from spending
union
select distinct(spend_date),'mobile' platform from spending
union
select distinct(spend_date),'both' platform from spending
)
select cte3.spend_date , cte3.platform,
ifnull(sum(cte2.amount),0)total_amount ,
count(cte2.user_id)total_users
from cte3 
left join cte2 on cte3.platform=cte2.platform and cte3.spend_date = cte2.spend_date 
group by spend_date,platform


-----------------------------------------------------------------------


I referred the below excellent explanation  , still need to understand a lot . 

https://leetcode.com/problems/user-purchase-platform/solutions/338776/mysql-solution-with-explanations-faster-than-100/

"""


MySQL Solution With Explanations (Faster Than 100%)
zac4
Dec LeetCoding Challenge
239
Jul 19, 2019
Let's start with a simple preprocess:

SELECT
  spend_date,
  user_id,
  SUM(CASE platform WHEN 'mobile' THEN amount ELSE 0 END) mobile_amount,
  SUM(CASE platform WHEN 'desktop' THEN amount ELSE 0 END) desktop_amount
FROM Spending
GROUP BY spend_date, user_id
For each user in each day, we fetch its mobile_amount and desktop_amount respectively and output them into a single row. In this form, we can see a user belongs to which platform very clearly:

spend_date	user_id	mobile_amount	desktop_amount	->(platform)
2019-07-01	1	100	100	-> (both)
2019-07-01	2	100	0	-> (mobile)
2019-07-01	3	0	100	-> (desktop)
2019-07-02	2	100	0	-> (mobile)
2019-07-02	3	0	100	->(desktop)
Based on the above table, we use the following SQL to bind users to their platforms and calculate the amounts spent:

SELECT
    spend_date,
    user_id,
    IF(mobile_amount > 0, IF(desktop_amount > 0, 'both', 'mobile'), 'desktop') platform,
    (mobile_amount + desktop_amount) amount
FROM (
	...
) o
Result table:

spend_date	user_id	platform	amount
2019-07-01	1	both	200
2019-07-01	2	mobile	100
2019-07-01	3	desktop	100
2019-07-02	2	mobile	100
2019-07-02	3	desktop	100
We don't wanna miss any record which has ZERO total_amount and total_users. So we need to get all combinations of spend_date and platform:

SELECT DISTINCT(spend_date), 'desktop' platform FROM Spending
UNION
SELECT DISTINCT(spend_date), 'mobile' platform FROM Spending
UNION
SELECT DISTINCT(spend_date), 'both' platform FROM Spending
The output:

spend_date	platform
2019-07-01	desktop
2019-07-01	mobile
2019-07-01	both
2019-07-02	desktop
2019-07-02	mobile
2019-07-02	both
After joinning this table to the previous one, we have our final answer:

SELECT 
    p.spend_date,
    p.platform,
    IFNULL(SUM(amount), 0) total_amount,
    COUNT(user_id) total_users
FROM 
(
    SELECT DISTINCT(spend_date), 'desktop' platform FROM Spending
    UNION
    SELECT DISTINCT(spend_date), 'mobile' platform FROM Spending
    UNION
    SELECT DISTINCT(spend_date), 'both' platform FROM Spending
) p 
LEFT JOIN (
    SELECT
        spend_date,
        user_id,
        IF(mobile_amount > 0, IF(desktop_amount > 0, 'both', 'mobile'), 'desktop') platform,
        (mobile_amount + desktop_amount) amount
    FROM (
        SELECT
          spend_date,
          user_id,
          SUM(CASE platform WHEN 'mobile' THEN amount ELSE 0 END) mobile_amount,
          SUM(CASE platform WHEN 'desktop' THEN amount ELSE 0 END) desktop_amount
        FROM Spending
        GROUP BY spend_date, user_id
    ) o
) t
ON p.platform=t.platform AND p.spend_date=t.spend_date
GROUP BY spend_date, platform

"""