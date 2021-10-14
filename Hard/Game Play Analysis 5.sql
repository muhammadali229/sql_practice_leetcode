USE leetcode;

-- Create Schema
--CREATE TABLE activity_game_analysis_five(
--	player_id INT,
--	device_id INT NOT NULL,
--	event_date DATE,
--	games_played INT NOT NULL,
--	PRIMARY KEY (player_id, event_date)
--);
--INSERT INTO activity_game_analysis_five(player_id, device_id, event_date, games_played)
--VALUES
--	(1, 2, '2016-03-01', 5),
--	(1, 2, '2016-03-02', 6),
--	(2, 3, '2017-06-25', 1),
--	(3, 1, '2016-03-01', 0),
--	(3, 4, '2016-07-03', 5);

-- Table: Activity

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
-- Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.
 

-- We define the install date of a player to be the first login day
-- of that player.

-- We also define day 1 retention of some date X to be the number of players 
-- whose install date is X and they logged back in on the day right after X 
-- divided by the number of players whose install date is X 
-- rounded to 2 decimal places.

-- Write an SQL query that reports for each install date, the number of players
-- that installed the game on that day and the day 1 retention.

-- The query result format is in the following example:

-- Activity table:
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-03-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-01 | 0            |
-- | 3         | 4         | 2016-07-03 | 5            |
-- +-----------+-----------+------------+--------------+

-- Result table:
-- +------------+----------+----------------+
-- | install_dt | installs | Day1_retention |
-- +------------+----------+----------------+
-- | 2016-03-01 | 2        | 0.50           |
-- | 2017-06-25 | 1        | 0.00           |
-- +------------+----------+----------------+
-- Player 1 and 3 installed the game on 2016-03-01 but only player 1 logged back in on 2016-03-02 so the
-- day 1 retention of 2016-03-01 is 1 / 2 = 0.50
-- Player 2 installed the game on 2017-06-25 but didn't log back in on 2017-06-26 so the day 1 retention of 2017-06-25 is 0 / 1 = 0.00

-- Solution
SELECT
	event_date install_dt,
	COUNT(*) installs,
	(CAST(SUM(
		CASE	
			WHEN DATEDIFF(DAY, event_date, next_login_date) = 1 THEN 1 ELSE 0
		END
	)AS DECIMAL (10, 2)) / COUNT(*)) Day1_retention
FROM
(
	SELECT
		event_date,
		RANK() OVER(PARTITION BY player_id ORDER BY event_date) rk_install,
		LEAD(event_date) OVER(PARTITION BY player_id ORDER BY event_date) next_login_date
	FROM	
		activity_game_analysis_five
) as temp
WHERE 
	rk_install = 1
GROUP BY
	event_date
