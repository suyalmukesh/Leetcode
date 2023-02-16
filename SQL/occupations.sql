with cte as 
(   select Doctor from (
       select 
            case when occupation = 'Doctor' then name else 'nil' 
            end as Doctor 
       from occupations
       where name is not NULL
       order by Doctor)aa
    where Doctor <> 'nil'
),
cte2 as 
(   select Actor from (
       select 
            case when occupation = 'Actor' then name else 'nil' 
            end as Actor 
       from occupations
       where name is not NULL
       order by Actor)aa
    where Actor <> 'nil'
),
cte3 as 
(   select Singer from (
       select 
            case when occupation = 'Singer' then name else 'nil' 
            end as Singer 
       from occupations
       where name is not NULL
       order by Singer)aa
    where Singer <> 'nil'
),
cte4 as 
(   select Professor from (
       select 
            case when occupation = 'Professor' then name else 'nil' 
            end as Professor 
       from occupations
       where name is not NULL
       order by Professor)aa
    where Professor <> 'nil'
),
AA as (select row_number() over (order by Doctor)R,Doctor from cte),
BB as (select row_number() over (order by Actor)R,Actor from cte2 ),
CC as (select row_number() over (order by Singer)R,Singer from cte3), 
DD as (select row_number() over (order by Professor)R,Professor from cte4) 

select AA.Doctor,BB.Actor,CC.Singer,DD.Professor from AA  
left join BB on AA.R = BB.R
left outer join CC on AA.R = CC.R
left outer join DD on AA.R = DD.R
union 
(
select AA.Doctor,BB.Actor,CC.Singer,DD.Professor from AA  
right join BB on AA.R = BB.R
right outer join CC on AA.R = CC.R
right outer join DD on AA.R = DD.R

)


