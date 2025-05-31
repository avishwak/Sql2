-- Problem 2 : Exchange Seats	(https://leetcode.com/problems/exchange-seats/ )

-- solution from the class
select (
    case 
        when mod(id,2) !=0 and id=cnts then id 
        when mod(id,2) !=0 and id!=cnts then id+1
        else id-1
    end
) as 'id', student from seat, 
(select count(*) as 'cnts' from seat) as seat_counts order by id

-- I found the above counter intuitive, so I tried this:
with seat_counts as (select count(*) as cnts from seat)
select (
    case
        when mod(id,2) != 0 and id!=cnts then id+1
        when mod(id,2) != 0 and id=cnts then id
        else id-1 
    end
    ) as id, student 
from seat, seat_counts
order by id

-- i also thought of the following but realised it will be very slow 
-- because the it will run the subquery select max(id) multiple times

SELECT (
    CASE 
        WHEN MOD(id, 2) != 0 AND id = (SELECT MAX(id) FROM seat) THEN id      
        WHEN MOD(id, 2) != 0 AND id != (SELECT MAX(id) FROM seat) THEN id + 1 
        ELSE id - 1                                                           
    END
) AS 'id', student
FROM seat
ORDER BY id;

-- solution using XOR 

select s1.id, ifnull(s2.student, s1.student) as student
from seat s1 left join seat s2 on (s1.id+1)^1 - 1 = s2.id


/*

- idea: expression is (x+1)^1 - 1 which return one less when even and one more when odd (check notes)
check id, say 1 -> expression returns 2 -> go to copy, search name belonging to this value and put it with 1
create two copies of the table and make join 
- always be careful when updating the same table that the previous value is not overwritten, therfore create copy of the table

-- coalesce can be used instead of ifnull, it can handle multiple null cases one by one
-- i think order by is not needed here because of how id is provided (increment continuously)

select (id+1)^1 - 1 as id, student
from seat 
order by id

only problem is the case with odd number of rows 
*/