-- https://www.hackerrank.com/challenges/symmetric-pairs/problem?isFullScreen=true

You are given a table, Functions, containing two columns: X and Y.



Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.

Sample Input



Sample Output

20 20
20 21
22 23

--

create table functions (x int , y int );

insert into functions values (20,20);
insert into functions values (20,20);
insert into functions values (20,21);
insert into functions values (23,22);
insert into functions values (22,23);
insert into functions values (21,20);
insert into functions values (27,27);

with cte as 
(   select a.x,a.y
    from functions a 
    inner join functions b 
    on a.x = b.y and a.y = b.x
    order by a.x
 ),
 cte2 as 
 (
 select case when x < y then x else y end as x,
        case when x < y then y else x end as y
 from cte     
 ),
 final as 
 (
   select x,y,count(x)cnt,row_number() over (partition by cte2.x,cte2.y order by cte2.x)R
   from cte2
   group by x,y
 )
 select x,y from final where cnt <> 1;


