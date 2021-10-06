
USE leetcode;

-- Create Schema
--CREATE TABLE department_high_salary(
--	id INT IDENTITY PRIMARY KEY,
--	name VARCHAR(20) NOT NULL
--);
--CREATE TABLE employee_high_salary(
--	id INT IDENTITY PRIMARY KEY,
--	name VARCHAR(20) NOT NULL,
--	salary INT NOT NULL,
--	departmentid INT REFERENCES department_high_salary (id)
--);
--INSERT INTO department_high_salary(name)
--VALUES
--	('IT'),
--	('Sales');
--INSERT INTO employee_high_salary(name, salary, deptartmentid)
--VALUES 
--	('Joe', 70000, 1),
--	('Jim', 90000, 1),
--	('Henry', 80000, 2),
--	('Sam', 60000, 2),
--	('Max', 90000, 1);

-- The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

-- +----+-------+--------+--------------+
-- | Id | Name  | Salary | DepartmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 70000  | 1            |
-- | 2  | Jim   | 90000  | 1            |
-- | 3  | Henry | 80000  | 2            |
-- | 4  | Sam   | 60000  | 2            |
-- | 5  | Max   | 90000  | 1            |
-- +----+-------+--------+--------------+
-- The Department table holds all departments of the company.

-- +----+----------+
-- | Id | Name     |
-- +----+----------+
-- | 1  | IT       |
-- | 2  | Sales    |
-- +----+----------+
-- Write a SQL query to find employees who have the highest salary in each of the departments. 
-- For the above tables, your SQL query should return the following rows (order of rows does not matter).

-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Max      | 90000  |
-- | IT         | Jim      | 90000  |
-- | Sales      | Henry    | 80000  |
-- +------------+----------+--------+
-- Explanation:

-- Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.

-- Solution
WITH max_salary_by_dept AS (
	SELECT
		deptartmentid,
		MAX(salary) max_salary
	FROM
		employee_high_salary
	GROUP BY
		deptartmentid
)

SELECT 
	d.name Department, 
	e.name Employee,
	salary Salary
FROM 
	employee_high_salary e JOIN department_high_salary d
ON
	d.id = e.deptartmentid
WHERE
	salary IN (
		SELECT max_salary FROM max_salary_by_dept
	)
ORDER BY
	Department;