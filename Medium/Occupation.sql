-- Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

-- Note: Print NULL when there are no more names corresponding to an occupation.

-- Sample Output

-- Jenny    Ashley     Meera  Jane
-- Samantha Christeen  Priya  Julia
-- NULL     Ketty      NULL   Maria
-- Explanation

-- The first column is an alphabetically ordered list of Doctor names.
-- The second column is an alphabetically ordered list of Professor names.
-- The third column is an alphabetically ordered list of Singer names.
-- The fourth column is an alphabetically ordered list of Actor names.
-- The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) are filled with NULL values.

-- Solution 1

/*
Enter your query here.
*/

select
    min(doctor),
    min(professor),
    min(singer),
    min(actor)
from (
SELECT 
    case when occupation = 'Doctor' then name end doctor,
    case when occupation = 'Professor' then name end professor,
    case when occupation = 'Singer' then name end singer,
    case when occupation = 'Actor' then name end actor,
    ROW_NUMBER() OVER(PARTITION BY occupation order by name) rn
FROM 
    occupations
) as t
group by rn