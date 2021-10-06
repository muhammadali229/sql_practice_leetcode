USE leetcode;

-- Create Schema
--CREATE TABLE employee_nth_salary(
--	id INT IDENTITY PRIMARY KEY,
--	salary INT NOT NULL
--);
--INSERT INTO employee_nth_salary(salary)
--VALUES
--	(100),
--	(200),
--	(300);

-- Write a SQL query to get the nth highest salary from the Employee table.

-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.

-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+

-- Solution 1
--Go
--CREATE FUNCTION getNthHighestSalary (
--	@n INT
--) RETURNS INT AS BEGIN RETURN (
--	SELECT 
--		salary 
--	FROM (
--		SELECT 
--			salary,
--			DENSE_RANK() OVER(ORDER BY salary DESC) n
--		FROM
--			employee_nth_salary) AS e
--	WHERE
--		n = @n
--) END;
--Go
DECLARE @highest_salary INT
EXEC @highest_salary = dbo.getNthHighestSalary @n = 2
SELECT @highest_salary AS highestNthSalary;

-- Solution 2
--SELECT dbo.getNthHighestSalary (2) AS getNthHighestSalary;

SELECT 
	TOP 1 salary highestNthSalary
FROM ( 
	SELECT 
		DISTINCT TOP 2 salary 
	FROM 
		employee_nth_salary 
	ORDER BY salary DESC ) AS temp 
	ORDER BY 
		salary;