USE leetcode

-- Create Schema
--CREATE TABLE employee_emp_bonus(
--	empId INT IDENTITY PRIMARY KEY,
--	name VARCHAR(20) NOT NULL,
--	supervisor INT,
--	salary INT NOT NULL
--);
--CREATE TABLE bonus_emp_bonus(
--	empId INT NOT NULL REFERENCES employee_emp_bonus (empId),
--	bonus INT NOT NULL
--);
--INSERT INTO employee_emp_bonus(name, supervisor, salary)
--VALUES
--	('John', 3, 1000),
--	('Dan', 3, 2000),
--	('Brad', null, 4000),
--	('Thomas', 3, 4000);
--INSERT INTO bonus_emp_bonus(empId, bonus)
--VALUES
--	(2, 500),
--	(4, 2000);

-- Select all employee's name and bonus whose bonus is < 1000.

-- Table:Employee

-- +-------+--------+-----------+--------+
-- | empId |  name  | supervisor| salary |
-- +-------+--------+-----------+--------+
-- |   1   | John   |  3        | 1000   |
-- |   2   | Dan    |  3        | 2000   |
-- |   3   | Brad   |  null     | 4000   |
-- |   4   | Thomas |  3        | 4000   |
-- +-------+--------+-----------+--------+
-- empId is the primary key column for this table.

-- Table: Bonus
	 
-- +-------+-------+
-- | empId | bonus |
-- +-------+-------+
-- | 2     | 500   |
-- | 4     | 2000  |
-- +-------+-------+
-- empId is the foregin key column for this table.
-- Example ouput:

-- +-------+-------+
-- | name  | bonus |
-- +-------+-------+
-- | John  | null  |
-- | Dan   | 500   |
-- | Brad  | null  |
-- +-------+-------+


-- Solution
SELECT 
	name,
	bonus
FROM
	employee_emp_bonus e LEFT JOIN bonus_emp_bonus b
ON
	e.empId = b.empId
WHERE
	bonus < 1000 OR bonus IS NULL;
	--ISNULL(bonus, 0) < 1000;