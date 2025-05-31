-- Problem 3 : Tree Node (https://leetcode.com/problems/tree-node/)

/*
solved before class, thought process: 
- when pid is null then root
- when both in id and pid then inner 
- if only in id then leaf
*/
select id, (
    case 
        when p_id is null then 'Root'
        when id not in (select distinct p_id from tree where p_id is not null)  then 'Leaf'
        else 'Inner'
    end
) as 'type'
from tree

-- from class 
select id, 'Root' as type from tree where p_id is null
union 
select id, 'Leaf' as type from tree where id not in
    (select distinct p_id from tree where p_id is not null) and p_id is not null 
union
select id, 'Inner' as type from tree where id in
    (select distinct p_id from tree) and p_id is not null 

-- case was also covered in class and same solution

-- with nested if 
select id, 
if ( isnull(p_id), 'Root',
    if(id in (select distinct p_id from tree), 'Inner', 'Leaf'
    )
) as type from tree

/*
- if (expression, true, false)
- if (expression1, true, if (expression2, true, false) )

- short-circuiting: in both case and nested if the condition 
is satifies in 1st case it will bot be checked in the next one
but in union it is not the case so we have to write all the conditions again (p_id is not null)

- union will return single entry however union all will return all the values with duplicated value 
as well
*/