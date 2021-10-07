
USE leetcode;

-- Create Schema
--CREATE TABLE activity_game_analysis_four(
--	player_id INT,
--	device_id INT NOT NULL,
--	event_date DATE,
--	games_played INT NOT NULL,
--	PRIMARY KEY (player_id, event_date)
--);
--INSERT INTO activity_game_analysis_four(player_id, device_id, event_date, games_played)
--VALUES
--	(1, 2, '2016-03-01', 5),
--	(1, 2, '2016-03-02', 6),
--	(2, 3, '2017-06-25', 1),
--	(3, 1, '2016-03-02', 0),
--	(3, 4, '2018-07-03', 5);

--Table: Activity

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | player_id    | int     |
-- | device_id    | int     |
-- | event_date   | date    |
-- | games_played | int     |
-- +--------------+---------+
-- (player_id, event_date) is the primary key of this table.
-- This table shows the activity of players of some game.
-- Each row is a record of a player who logged in and played a number of games (possibly 0) 
-- before logging out on some day using some device.
 

-- Write an SQL query that reports the fraction of players that logged in again 
-- on the day after the day they first logged in, rounded to 2 decimal places. 
-- In other words, you need to count the number of players that logged in for at least two consecutive 
-- days starting from their first login date, then divide that number by the total number of players.

-- The query result format is in the following example:

-- Activity table:
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-03-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-02 | 0            |
-- | 3         | 4         | 2018-07-03 | 5            |
-- +-----------+-----------+------------+--------------+

-- Result table:
-- +-----------+
-- | fraction  |
-- +-----------+
-- | 0.33      |
-- +-----------+
-- Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33

-- Solution

DECLARE @no_of_players FLOAT = (SELECT COUNT(DISTINCT player_id) FROM activity_game_analysis_four);

SELECT 
	ROUND(COUNT(*) / @no_of_players, 2) fraction
FROM (
	SELECT 
		player_id,
		event_date curr_date,
		LEAD(event_date) OVER(PARTITION BY player_id ORDER BY event_date) next_date
	FROM
		activity_game_analysis_four
) as temp
WHERE
	DATEDIFF(DAY, curr_date, next_date) = 1;

-- Solution 2
SELECT
	ROUND(COUNT(DISTINCT b.player_id) / CAST(COUNT(DISTINCT a.player_id) AS FLOAT), 2) fraction
FROM (
	SELECT 
		player_id, 
		MAX(event_date) as max_date
	FROM
		activity_game_analysis_four
	GROUP BY 
		player_id
) as a LEFT JOIN activity_game_analysis_four b
ON 
	a.player_id = b.player_id AND DATEDIFF(DAY, event_date, max_date) = 1;