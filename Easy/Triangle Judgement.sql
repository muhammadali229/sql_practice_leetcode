USE leetcode;

-- Create Schema
 --CREATE TABLE triangle_judgement(
	--x INT NOT NULL,
	--y INT NOT NULL,
	--z INT NOT NULL
 --);
--INSERT INTO triangle_judgement(x, y, z)
--VALUES
--	(13, 15, 30),
--	(10, 20, 15);


-- A pupil Tim gets homework to identify whether three line segments could possibly form a triangle.
-- However, this assignment is very heavy because there are hundreds of records to calculate.
-- Could you help Tim by writing a query to judge whether these three sides can form a triangle, 
-- assuming table triangle holds the length of the three sides x, y and z.
 
-- | x  | y  | z  |
-- |----|----|----|
-- | 13 | 15 | 30 |
-- | 10 | 20 | 15 |
-- For the sample data above, your query should return the follow result:
-- | x  | y  | z  | triangle |
-- |----|----|----|----------|
-- | 13 | 15 | 30 | No       |
-- | 10 | 20 | 15 | Yes      |

-- Solution
SELECT
	x,
	y,
	z,
	CASE
		WHEN ((x + y) > z) AND ((x + z) > y) AND ((y + z) > x) THEN 'Yes' ELSE 'NO' 
	END AS triangle
FROM 
	triangle_judgement;