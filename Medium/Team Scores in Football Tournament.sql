USE leetcode;

-- Create Schema
--CREATE TABLE teams_football(
--	team_id INT PRIMARY KEY,
--	team_name VARCHAR(20) NOT NULL
--);
--INSERT INTO teams_football(team_id, team_name)
--VALUES
--	(10, 'Leetcode FC'),
--	(20, 'NewYork FC'),
--	(30, 'Atlanta FC'),
--	(40, 'Chicago FC'),
--	(50, 'Toronto FC');
--CREATE TABLE matches_football(
--	match_id INT IDENTITY PRIMARY KEY,
--	host_team INT REFERENCES teams_football(team_id),
--	guest_team INT REFERENCES teams_football(team_id),
--	host_goals INT NOT NULL,
--	guest_goals INT NOT NULL
--);
--INSERT INTO matches_football(host_team, guest_team, host_goals, guest_goals)
--VALUES
--	(10, 20, 3, 0),
--	(30, 10, 2, 2),
--	(10, 50, 5, 1),
--	(20, 30, 1, 0),
--	(50, 30, 1, 0);

-- Table: Teams
-- +---------------+----------+
-- | Column Name   | Type     |
-- +---------------+----------+
-- | team_id       | int      |
-- | team_name     | varchar  |
-- +---------------+----------+
-- team_id is the primary key of this table.
-- Each row of this table represents a single football team.

-- Table: Matches
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | match_id      | int     |
-- | host_team     | int     |
-- | guest_team    | int     | 
-- | host_goals    | int     |
-- | guest_goals   | int     |
-- +---------------+---------+
-- match_id is the primary key of this table.
-- Each row is a record of a finished match between two different teams. 
-- Teams host_team and guest_team are represented by their IDs in the teams table (team_id) and they scored host_goals and guest_goals goals respectively.

-- You would like to compute the scores of all teams after all matches. Points are awarded as follows:
-- A team receives three points if they win a match (Score strictly more goals than the opponent team).
-- A team receives one point if they draw a match (Same number of goals as the opponent team).
-- A team receives no points if they lose a match (Score less goals than the opponent team).
-- Write an SQL query that selects the team_id, team_name and num_points of each team in the tournament after all described matches. Result table should be ordered by num_points (decreasing order). In case of a tie, order the records by team_id (increasing order).

-- The query result format is in the following example:

-- Teams table:
-- +-----------+--------------+
-- | team_id   | team_name    |
-- +-----------+--------------+
-- | 10        | Leetcode FC  |
-- | 20        | NewYork FC   |
-- | 30        | Atlanta FC   |
-- | 40        | Chicago FC   |
-- | 50        | Toronto FC   |
-- +-----------+--------------+

-- Matches table:
-- +------------+--------------+---------------+-------------+--------------+
-- | match_id   | host_team    | guest_team    | host_goals  | guest_goals  |
-- +------------+--------------+---------------+-------------+--------------+
-- | 1          | 10           | 20            | 3           | 0            |
-- | 2          | 30           | 10            | 2           | 2            |
-- | 3          | 10           | 50            | 5           | 1            |
-- | 4          | 20           | 30            | 1           | 0            |
-- | 5          | 50           | 30            | 1           | 0            |
-- +------------+--------------+---------------+-------------+--------------+

-- Result table:
-- +------------+--------------+---------------+
-- | team_id    | team_name    | num_points    |
-- +------------+--------------+---------------+
-- | 10         | Leetcode FC  | 7             |
-- | 20         | NewYork FC   | 3             |
-- | 50         | Toronto FC   | 3             |
-- | 30         | Atlanta FC   | 1             |
-- | 40         | Chicago FC   | 0             |
-- +------------+--------------+---------------+

-- Solution
SELECT
	t.team_id,
	t.team_name,
	SUM(
		(CASE
			WHEN (team_id = host_team AND host_goals > guest_goals) OR
				 (team_id = guest_team AND guest_goals > host_goals) THEN 3 
			ELSE 0 
		END)
		+
		(CASE
			WHEN (team_id = host_team OR team_id = guest_team) AND (host_goals = guest_goals) THEN 1 ELSE 0
		END)
	) num_points
FROM
	teams_football t LEFT JOIN matches_football m
ON
	t.team_id = m.host_team OR t.team_id = m.guest_team
GROUP BY
	t.team_id, t.team_name
ORDER BY
	num_points DESC;