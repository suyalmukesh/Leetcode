
create  table projects 
(
  task_id int,
  start_date date,
  end_date date
); 



insert into projects values (1,'2015-10-01','2015-10-02');
insert into projects  values  (2,'2015-10-02','2015-10-03');
insert into projects  values (3,'2015-10-03','2015-10-04');
insert into projects  values (4,'2015-10-13','2015-10-14');
insert into projects  values (5,'2015-10-14','2015-10-15');
insert into projects  values  (6,'2015-10-28','2015-10-29');
insert into projects  values (7,'2015-10-30','2015-10-31');

-- My Solution 


with cte as 
(
    select 
        start_date,
        end_date,
        coalesce(datediff(end_date,lag(end_date,1) over (order by end_date)),1) diff,
        row_number() over (order by end_date)R
     from projects    
),
cte2 as 
(
    select 
    diff, start_date , end_date, R,
    sum(diff) over (order by end_date),
     (sum(diff) over (order by end_date) - R )num
    from cte 
 ),
 cte3 as 
 (
select min(start_date)as start_date,
       max(end_date)as end_date
from cte2 
group by num
     )
select start_date,end_date  from cte3      
order by datediff(end_date,start_date) , start_date
