-- https://leetcode.com/problems/active-businesses/description/?envType=study-plan&id=sql-iii

1126. Active Businesses
Medium
239
25
company
Yelp
SQL Schema
Table: Events

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| business_id   | int     |
| event_type    | varchar |
| occurences    | int     | 
+---------------+---------+
(business_id, event_type) is the primary key of this table.
Each row in the table logs the info that an event of some type occurred at some business for a number of times.
 

The average activity for a particular event_type is the average occurences across all companies that have this event.

An active business is a business that has more than one event_type such that their occurences is strictly greater than the average activity for that event.

Write an SQL query to find all active businesses.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Events table:
+-------------+------------+------------+
| business_id | event_type | occurences |
+-------------+------------+------------+
| 1           | reviews    | 7          |
| 3           | reviews    | 3          |
| 1           | ads        | 11         |
| 2           | ads        | 7          |
| 3           | ads        | 6          |
| 1           | page views | 3          |
| 2           | page views | 12         |
+-------------+------------+------------+
Output: 
+-------------+
| business_id |
+-------------+
| 1           |
+-------------+
Explanation:  
The average activity for each event can be calculated as follows:
- 'reviews': (7+3)/2 = 5
- 'ads': (11+7+6)/3 = 8
- 'page views': (3+12)/2 = 7.5
The business with id=1 has 7 'reviews' events (more than 5) and 11 'ads' events (more than 8), so it is an active business.



-- DML 

Create table If Not Exists Events (business_id int, event_type varchar(10), occurences int)
Truncate table Events
insert into Events (business_id, event_type, occurences) values ('1', 'reviews', '7')
insert into Events (business_id, event_type, occurences) values ('3', 'reviews', '3')
insert into Events (business_id, event_type, occurences) values ('1', 'ads', '11')
insert into Events (business_id, event_type, occurences) values ('2', 'ads', '7')
insert into Events (business_id, event_type, occurences) values ('3', 'ads', '6')
insert into Events (business_id, event_type, occurences) values ('1', 'page views', '3')
insert into Events (business_id, event_type, occurences) values ('2', 'page views', '12')


-- My Long Solution 

with average as  -- find the average of event_type in the whole table 
(
    select event_type , avg(occurences)as average
    from
    events 
    group by event_type
    order by business_id
),
cte as -- Business_id and corresponding number of event_type 
(
    select business_id,count(event_type)cnt
    from events 
    group by business_id
),
cte3 as -- Joining with average where occurances > average 
(
    select business_id,a.event_type,occurences,b.average 
    from events a
    join average b on a.event_type = b.event_type 
    where a.occurences > b.average
)
-- Finally business_id for count > 1
select business_id 
from cte3 
group by business_id 
having count(business_id) > 1;
