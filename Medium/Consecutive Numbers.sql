USE leetcode;

-- Create Schema
--CREATE TABLE logs_consecutive(
--	id INT IDENTITY PRIMARY KEY,
--	num INT NOT NULL
--);
--INSERT INTO logs_consecutive(num)
--VALUES
--	(1),
--	(1),
--	(1),
--	(2),
--	(1),
--	(2),
--	(2);

-- Write a SQL query to find all numbers that appear at least three times consecutively.

-- +----+-----+
-- | Id | Num |
-- +----+-----+
-- | 1  |  1  |
-- | 2  |  1  |
-- | 3  |  1  |
-- | 4  |  2  |
-- | 5  |  1  |
-- | 6  |  2  |
-- | 7  |  2  |
-- +----+-----+
-- For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+

-- checking solution
--INSERT INTO logs_consecutive(num)
--VALUES
--	(20),
--	(20),
--	(20),
--	(20),
--	(20),
--	(20);
--SELECT * FROM logs_consecutive;


--;WITH num_by_no_of_cons AS (
--	SELECT
--	num,
--	COUNT(*) no_of_cons
--	FROM
--		(
--		SELECT 
--			*
--		FROM
--			(
--			SELECT
--				num,
--				lag(num) OVER(ORDER BY id) prev_num,
--				lead(num) OVER(ORDER BY id) next_num
--			FROM
--				logs_consecutive
--			) as temp
--		WHERE 
--			num = prev_num AND num = next_num
--		) as temp2
--	GROUP BY
--		num
--)

--SELECT 
--	num
--FROM
--	logs_consecutive
--WHERE
--	num IN (
--		SELECT num FROM num_by_no_of_cons ORDER BY no_of_cons DESC
--	);

-- Solution
SELECT 
	num ConsecutiveNums
FROM
	(
		SELECT
			num,
			lag(num) OVER(ORDER BY id) prev_num,
			lead(num) OVER(ORDER BY id) next_num
		FROM
			logs_consecutive
	) as temp
	WHERE 
		num = prev_num AND num = next_num

SELECT
	curr.num ConsecutiveNums
FROM
	logs_consecutive curr JOIN logs_consecutive next_1
ON 
	curr.id = next_1.id + 1 AND curr.num = next_1.num
JOIN logs_consecutive next_2 
ON
	curr.id = next_2.id + 2 AND curr.num = next_2.num