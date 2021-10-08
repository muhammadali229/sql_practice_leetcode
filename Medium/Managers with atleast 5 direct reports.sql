USE leetcode;

-- Create Schema
--CREATE TABLE employee_managers_report(
--	id INT IDENTITY(101, 1) PRIMARY KEY,
--	name VARCHAR(20) NOT NULL,
--	department CHAR(1) NOT NULL,
--	managerid INT,
--);
--INSERT INTO employee_managers_report(name, department, managerid)
--VALUES
--	('John', 'A', null),
--	('Dan', 'A', 101),
--	('James', 'A', 101),
--	('Amy', 'A', 101),
--	('Anne', 'A', 101),
--	('Ron', 'B', 101);
--INSERT INTO employee_managers_report(name, department, managerid)
--VALUES
--	('Jennifer', 'B', 102);

-- The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

-- +------+----------+-----------+----------+
-- |Id    |Name 	  |Department |ManagerId |
-- +------+----------+-----------+----------+
-- |101   |John 	  |A 	      |null      |
-- |102   |Dan 	      |A 	      |101       |
-- |103   |James 	  |A 	      |101       |
-- |104   |Amy 	      |A 	      |101       |
-- |105   |Anne 	  |A 	      |101       |
-- |106   |Ron 	      |B 	      |101       |
-- +------+----------+-----------+----------+
-- Given the Employee table, write a SQL query that finds out managers with at least 5 direct report. For the above table, your SQL query should return:

-- +-------+
-- | Name  |
-- +-------+
-- | John  |
-- +-------+
-- Note:
-- No one would report to himself.

-- Solution

WITH managers_have_5_employees AS (
	SELECT
		managerid,
		COUNT(DISTINCT id) no_of_employees
	FROM
		employee_managers_report 
	WHERE 
		managerid IS NOT NULL
	GROUP BY
		managerid
	HAVING
		COUNT(id) >= 5
)

SELECT 
	name Name
FROM
	employee_managers_report
WHERE
	id IN (
		SELECT managerid FROM managers_have_5_employees
	);