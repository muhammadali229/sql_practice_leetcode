USE leetcode;

-- Create Schema
--CREATE TABLE department_invalid(
--	id INT PRIMARY KEY,
--	name VARCHAR(20) NOT NULL
--);
--ALTER TABLE department_invalid
--ALTER COLUMN name VARCHAR(50);
--CREATE TABLE student_invalid(
--	id INT PRIMARY KEY,
--	name VARCHAR(20) NOT NULL,
--	department_id INT
-- );
--INSERT INTO department_invalid(id, name)
--VALUES
--	(1, 'Electrical Engineering'),
--	(7, 'Computer Engineering'),
--	(13, 'Bussiness Administration');
--INSERT INTO student_invalid(id, name, department_id)
--VALUES
--	(23, 'Alice', 1),
--	(1, 'Bob', 7),
--	(5, 'Jennifer', 13),
--	(2, 'John', 14),
--	(4, 'Jasmine', 77),
--	(3, 'Steve', 74),
--	(6, 'Luis', 1),
--	(8, 'Jonathan', 7),
--	(7, 'Daiana', 33),
--	(11, 'Madelynn', 1);
	 
-- Table: Departments

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- id is the primary key of this table.
-- The table has information about the id of each department of a university.
 
-- Table: Students

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- | department_id | int     |
-- +---------------+---------+
-- id is the primary key of this table.
-- The table has information about the id of each student at a university and the id of the department he/she studies at.
 

-- Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exists.
-- Return the result table in any order.
-- The query result format is in the following example:

-- Departments table:
-- +------+--------------------------+
-- | id   | name                     |
-- +------+--------------------------+
-- | 1    | Electrical Engineering   |
-- | 7    | Computer Engineering     |
-- | 13   | Bussiness Administration |
-- +------+--------------------------+

-- Students table:
-- +------+----------+---------------+
-- | id   | name     | department_id |
-- +------+----------+---------------+
-- | 23   | Alice    | 1             |
-- | 1    | Bob      | 7             |
-- | 5    | Jennifer | 13            |
-- | 2    | John     | 14            |
-- | 4    | Jasmine  | 77            |
-- | 3    | Steve    | 74            |
-- | 6    | Luis     | 1             |
-- | 8    | Jonathan | 7             |
-- | 7    | Daiana   | 33            |
-- | 11   | Madelynn | 1             |
-- +------+----------+---------------+

-- Result table:
-- +------+----------+
-- | id   | name     |
-- +------+----------+
-- | 2    | John     |
-- | 7    | Daiana   |
-- | 4    | Jasmine  |
-- | 3    | Steve    |
-- +------+----------+

-- John, Daiana, Steve and Jasmine are enrolled in departments 14, 33, 74 and 77 respectively. 
-- department 14, 33, 74 and 77 doesn't exist in the Departments table.

-- Solution
SELECT
	s.id, 
	s.name
FROM
	student_invalid s LEFT JOIN department_invalid d
ON
	s.department_id = d.id
WHERE
	d.id IS NULL;