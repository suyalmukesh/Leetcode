https://leetcode.com/problems/running-total-for-different-genders/description/?envType=study-plan&id=sql-iii

1308. Running Total for Different Genders
Medium
189
53
SQL Schema
Table: Scores

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| player_name   | varchar |
| gender        | varchar |
| day           | date    |
| score_points  | int     |
+---------------+---------+
(gender, day) is the primary key for this table.
A competition is held between the female team and the male team.
Each row of this table indicates that a player_name and with gender has scored score_point in someday.
Gender is 'F' if the player is in the female team and 'M' if the player is in the male team.
 

Write an SQL query to find the total score for each gender on each day.

Return the result table ordered by gender and day in ascending order.

The query result format is in the following example.

 

Example 1:

Input: 
Scores table:
+-------------+--------+------------+--------------+
| player_name | gender | day        | score_points |
+-------------+--------+------------+--------------+
| Aron        | F      | 2020-01-01 | 17           |
| Alice       | F      | 2020-01-07 | 23           |
| Bajrang     | M      | 2020-01-07 | 7            |
| Khali       | M      | 2019-12-25 | 11           |
| Slaman      | M      | 2019-12-30 | 13           |
| Joe         | M      | 2019-12-31 | 3            |
| Jose        | M      | 2019-12-18 | 2            |
| Priya       | F      | 2019-12-31 | 23           |
| Priyanka    | F      | 2019-12-30 | 17           |
+-------------+--------+------------+--------------+
Output: 
+--------+------------+-------+
| gender | day        | total |
+--------+------------+-------+
| F      | 2019-12-30 | 17    |
| F      | 2019-12-31 | 40    |
| F      | 2020-01-01 | 57    |
| F      | 2020-01-07 | 80    |
| M      | 2019-12-18 | 2     |
| M      | 2019-12-25 | 13    |
| M      | 2019-12-30 | 26    |
| M      | 2019-12-31 | 29    |
| M      | 2020-01-07 | 36    |
+--------+------------+-------+
Explanation: 
For the female team:
The first day is 2019-12-30, Priyanka scored 17 points and the total score for the team is 17.
The second day is 2019-12-31, Priya scored 23 points and the total score for the team is 40.
The third day is 2020-01-01, Aron scored 17 points and the total score for the team is 57.
The fourth day is 2020-01-07, Alice scored 23 points and the total score for the team is 80.

For the male team:
The first day is 2019-12-18, Jose scored 2 points and the total score for the team is 2.
The second day is 2019-12-25, Khali scored 11 points and the total score for the team is 13.
The third day is 2019-12-30, Slaman scored 13 points and the total score for the team is 26.
The fourth day is 2019-12-31, Joe scored 3 points and the total score for the team is 29.
The fifth day is 2020-01-07, Bajrang scored 7 points and the total score for the team is 36.

-- DML
Create table If Not Exists Scores (player_name varchar(20), gender varchar(1), day date, score_points int)
Truncate table Scores
insert into Scores (player_name, gender, day, score_points) values ('Aron', 'F', '2020-01-01', '17')
insert into Scores (player_name, gender, day, score_points) values ('Alice', 'F', '2020-01-07', '23')
insert into Scores (player_name, gender, day, score_points) values ('Bajrang', 'M', '2020-01-07', '7')
insert into Scores (player_name, gender, day, score_points) values ('Khali', 'M', '2019-12-25', '11')
insert into Scores (player_name, gender, day, score_points) values ('Slaman', 'M', '2019-12-30', '13')
insert into Scores (player_name, gender, day, score_points) values ('Joe', 'M', '2019-12-31', '3')
insert into Scores (player_name, gender, day, score_points) values ('Jose', 'M', '2019-12-18', '2')
insert into Scores (player_name, gender, day, score_points) values ('Priya', 'F', '2019-12-31', '23')
insert into Scores (player_name, gender, day, score_points) values ('Priyanka', 'F', '2019-12-30', '17')

-- My Solution 


with female as 
(
    select gender,day,
    sum(score_points) over(order by gender,day)total 
    from scores 
    where gender = 'F'
),
male as 
(
select gender,day,
sum(score_points) over(order by gender,day)total 
from scores 
where gender = 'M'
) 
select * from female union select * from male


-- My Solution ( more optimised)

select gender,day,sum(score_points) over (partition by gender order by day ) as total
from scores 
group by day,gender
order by gender,day;




