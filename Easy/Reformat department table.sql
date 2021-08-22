use leetcode
-- Question 44
-- Table: Department

-- creaete schema
--Create table Department (id int, revenue int, month varchar(5))
--Truncate table Department
--insert into Department (id, revenue, month) values ('1', '8000', 'Jan')
--insert into Department (id, revenue, month) values ('2', '9000', 'Jan')
--insert into Department (id, revenue, month) values ('3', '10000', 'Feb')
--insert into Department (id, revenue, month) values ('1', '7000', 'Feb')
--insert into Department (id, revenue, month) values ('1', '6000', 'Mar');

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | revenue       | int     |
-- | month         | varchar |
-- +---------------+---------+
-- (id, month) is the primary key of this table.
-- The table has information about the revenue of each department per month.
-- The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
 
-- Write an SQL query to reformat the table such that there is a department id column and a revenue column for each month.

-- The query result format is in the following example:

-- Department table:
-- +------+---------+-------+
-- | id   | revenue | month |
-- +------+---------+-------+
-- | 1    | 8000    | Jan   |
-- | 2    | 9000    | Jan   |
-- | 3    | 10000   | Feb   |
-- | 1    | 7000    | Feb   |
-- | 1    | 6000    | Mar   |
-- +------+---------+-------+

-- Result table:
-- +------+-------------+-------------+-------------+-----+-------------+
-- | id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
-- +------+-------------+-------------+-------------+-----+-------------+
-- | 1    | 8000        | 7000        | 6000        | ... | null        |
-- | 2    | 9000        | null        | null        | ... | null        |
-- | 3    | null        | 10000       | null        | ... | null        |
-- +------+-------------+-------------+-------------+-----+-------------+

-- Note that the result table has 13 columns (1 for the department id + 12 for the months).

-- Solution 1

SELECT
	id,
	SUM(CASE
		WHEN month = 'Jan' THEN revenue END) AS Jan_Revenue,
	SUM(CASE
		WHEN month = 'Feb' THEN revenue END) AS Feb_Revenue,
	SUM(CASE
		WHEN month = 'Mar' THEN revenue END) AS Mar_Revenue,
	SUM(CASE
		WHEN month = 'Apr' THEN revenue END) AS Apr_Revenue,
	SUM(CASE
		WHEN month = 'May' THEN revenue END) AS May_Revenue,
	SUM(CASE
		WHEN month = 'Jun' THEN revenue END) AS Jun_Revenue,
	SUM(CASE
		WHEN month = 'Jul' THEN revenue END) AS Jul_Revenue,
	SUM(CASE
		WHEN month = 'Aug' THEN revenue END) AS Aug_Revenue,
	SUM(CASE
		WHEN month = 'Sep' THEN revenue END) AS Sep_Revenue,
	SUM(CASE
		WHEN month = 'Oct' THEN revenue END) AS Oct_Revenue,
	SUM(CASE
		WHEN month = 'Nov' THEN revenue END) AS Nov_Revenue,
	SUM(CASE
		WHEN month = 'Dec' THEN revenue END) AS Dec_Revenue
FROM 
	department
GROUP BY
	id;

-- Solution 2
SELECT 
    id,
    Jan AS Jan_Revenue,
    Feb AS Feb_Revenue, 
    Mar AS Mar_Revenue, 
    Apr AS Apr_Revenue,
    May AS May_Revenue,
    Jun AS Jun_Revenue,
    Jul AS Jul_Revenue,
    Aug AS Aug_Revenue,
    Sep AS Sep_Revenue,
    Oct AS Oct_Revenue,
    Nov AS Nov_Revenue,
    Dec AS Dec_Revenue
FROM Department
PIVOT 
(
    SUM(revenue)
    FOR month IN (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec)        
) AS MonthsRevenue