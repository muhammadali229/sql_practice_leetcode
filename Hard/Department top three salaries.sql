USE leetcode

-- Create Schema
--CREATE TABLE department_top_3_salaries(
--	id INT IDENTITY PRIMARY KEY,
--	name VARCHAR(20) NOT NULL
--);
--CREATE TABLE employee_top_3_salaries(
--	id INT IDENTITY PRIMARY KEY,
--	name VARCHAR(20) NOT NULL,
--	salary INT NOT NULL,
--	departmentid INT REFERENCES department_top_3_salaries (id)
--);
--INSERT INTO department_top_3_salaries(name)
--VALUES
--	('IT'),
--	('Sales');
--INSERT INTO employee_top_3_salaries(name, salary, departmentid)
--VALUES 
--	('Joe', 85000, 1),
--	('Henry', 80000, 2),
--	('Sam', 60000, 2),
--	('Max', 90000, 1),
--	('Janet', 69000, 1), 
--	('Randy', 85000, 1),
--	('Will', 70000, 1);

-- The Employee table holds all employees. Every employee has an Id, and there is also a column for the department Id.
-- +----+-------+--------+--------------+
-- | Id | Name  | Salary | DepartmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 85000  | 1            |
-- | 2  | Henry | 80000  | 2            |
-- | 3  | Sam   | 60000  | 2            |
-- | 4  | Max   | 90000  | 1            |
-- | 5  | Janet | 69000  | 1            |
-- | 6  | Randy | 85000  | 1            |
-- | 7  | Will  | 70000  | 1            |
-- +----+-------+--------+--------------+

-- The Department table holds all departments of the company.
-- +----+----------+
-- | Id | Name     |
-- +----+----------+
-- | 1  | IT       |
-- | 2  | Sales    |
-- +----+----------+

-- Write a SQL query to find employees who earn the top three salaries in each of the department. For the above tables, your SQL query should return the following rows (order of rows does not matter).
-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Max      | 90000  |
-- | IT         | Randy    | 85000  |
-- | IT         | Joe      | 85000  |
-- | IT         | Will     | 70000  |
-- | Sales      | Henry    | 80000  |
-- | Sales      | Sam      | 60000  |
-- +------------+----------+--------+

-- Explanation:
-- In IT department, Max earns the highest salary, both Randy and Joe earn the second highest salary, 
-- and Will earns the third highest salary. 
-- There are only two employees in the Sales department, 
-- Henry earns the highest salary while Sam earns the second highest salary.

-- Solution
SELECT
	department, 
	employee,
	salary
FROM
(
	SELECT 
		d.name Department,
		e.name Employee,
		salary Salary,
		DENSE_RANK() OVER(PARTITION BY d.name ORDER BY salary DESC) rk
	FROM
		department_top_3_salaries d JOIN employee_top_3_salaries e
	ON
		d.id = e.departmentid
) as temp
WHERE
	rk <= 3;