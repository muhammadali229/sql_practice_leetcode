USE leetcode;

-- Create Schema
--CREATE TABLE exchange_seat(
--	id INT IDENTITY PRIMARY KEY,
--	student VARCHAR(20) NOT NULL
--);
--INSERT INTO exchange_seat(student)
--VALUES	
--	('Abbot'),
--	('Doris'),
--	('Emersion'),
--	('Green'),
--	('Jeames');

-- Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids.
-- The column id is continuous increment.
-- Mary wants to change seats for the adjacent students.
-- Can you write a SQL query to output the result for Mary?
 
-- +---------+---------+
-- |    id   | student |
-- +---------+---------+
-- |    1    | Abbot   |
-- |    2    | Doris   |
-- |    3    | Emerson |
-- |    4    | Green   |
-- |    5    | Jeames  |
-- +---------+---------+
-- For the sample input, the output is:
 
-- +---------+---------+
-- |    id   | student |
-- +---------+---------+
-- |    1    | Doris   |
-- |    2    | Abbot   |
-- |    3    | Green   |
-- |    4    | Emerson |
-- |    5    | Jeames  |
-- +---------+---------+

-- Note
-- If the number of students is odd, there is no need to change the last one's seat

-- Solution

--SELECT
--	*
--FROM
--	exchange_seat;

DECLARE @no_of_students INT = (SELECT COUNT(DISTINCT id) FROM exchange_seat);

-- Solution 1
SELECT 
	ROW_NUMBER() OVER(ORDER BY (CASE 
		WHEN id % 2 = 0 THEN id - 1
		WHEN @no_of_students = id AND @no_of_students % 2 = 1 THEN id   
		ELSE id + 1 
	END)) id,
	student
FROM 
	exchange_seat;

-- Solution 2
SELECT 
	(CASE 
		WHEN id % 2 = 0 THEN id - 1
		WHEN @no_of_students = id AND @no_of_students % 2 = 1 THEN id   
		ELSE id + 1 
	END) id,
	student
FROM 
	exchange_seat
ORDER BY
	id;
	
	