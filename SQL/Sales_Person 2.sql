LeetCode : 607 Sales person 
https://leetcode.com/problems/sales-person/description/

Remarks : Good Question , best for understanding joins 

-- My Solution 

with cte as 
(
    select a.sales_id , a.name as person , coalesce(c.name , "alpha") as company from salesperson a 
    left join orders b 
    on a.sales_id = b.sales_id 
    left join company c
    on b.com_id = c.com_id
),
cnt as (
    select person,company,count(company)ccnt from cte group by person
)
select person as name from cnt 
where company not in ("RED") ; 

