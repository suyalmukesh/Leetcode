--  https://leetcode.com/problems/get-highest-answer-rate-question/description/

Leetcode : 578. Get Highest Answer Rate Question ( Medium ) 


with cte as 
(
    select question_id , action , count(action)cnt
    from  SurveyLog 
    group by question_id,action
),
calc as 
(
    select question_id,
           case when action = "show" then cnt 
           else 0 end as "show_count",
           case when action = "answer" then cnt 
           else 0 end as "answer_count"
    from cte      
),
final as 
(
   select question_id , sum(answer_count)/sum(show_count) as log
   from calc 
   group by question_id
),
solution as 
(
    select question_id as survey_log, 
          row_number() over (order by question_id)R
    from final
    where final.log = (select max(final.log) from final)
)
select survey_log from solution where R = 1;


=================

Solution 2 : Copied 

SELECT  question_id as survey_log
FROM SurveyLog
GROUP BY 1
ORDER BY (count(answer_id) / count(case when action = 'show' then question_id ELSE null end )) desc, 1 asc
LIMIT 1


====================

