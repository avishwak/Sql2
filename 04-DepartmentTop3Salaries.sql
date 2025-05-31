-- Problem 4 : Deparment Top 3 Salaries	(https://leetcode.com/problems/department-top-three-salaries/)

with cte as (select d.name as Department, e.name as Employee, salary, 
dense_rank() over (partition by d.name order by salary desc) as rnk
from employee e 
left join department d 
on e.departmentId = d.id)
select Department, Employee, salary 
from cte where rnk <=3