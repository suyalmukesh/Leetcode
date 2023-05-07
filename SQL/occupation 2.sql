-- HACKER RANK 
-- https://www.hackerrank.com/challenges/occupations/problem

Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.

Input Format

The OCCUPATIONS table is described as follows:



Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.

Sample Input



Sample Output

Jenny    Ashley     Meera  Jane
Samantha Christeen  Priya  Julia
NULL     Ketty      NULL   Maria
Explanation

The first column is an alphabetically ordered list of Doctor names.
The second column is an alphabetically ordered list of Professor names.
The third column is an alphabetically ordered list of Singer names.
The fourth column is an alphabetically ordered list of Actor names.
The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) are filled with NULL values.



-- FULL JOIN not working in MySQL 
-- So I used MS-SQL 


with doctor as 
(
    select 
           case when occupation = 'Doctor' then Name end as Doctor,
           row_number() over (order by name )R
    from occupations 
    where occupation = 'Doctor'
),
Professor as 
(
    select 
           case when occupation = 'Professor' then Name end as Professor,
           row_number() over (order by name )R
    from occupations 
    where occupation = 'Professor'
),
singer as 
(
    select 
           case when occupation = 'singer' then Name end as singer,
           row_number() over (order by name )R
    from occupations 
    where occupation = 'singer'
),
actor as 
(
    select 
           case when occupation = 'actor' then Name end as actor,
           row_number() over (order by name )R
    from occupations 
    where occupation = 'actor'
)

select b.doctor,a.professor,c.singer ,d.actor
from doctor b
full join professor a 
on a.R = b.R
full join singer c 
on a.R = c.R
full join actor d
on a.R = d.R;

-- For Explanation , contact suyalji85@gmail.com





