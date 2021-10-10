USE leetcode;

-- Create Schema
--CREATE TABLE players_grand_slam_titles(
--	player_id INT IDENTITY PRIMARY KEY,
--	player_name VARCHAR(20) NOT NULL
--);
--INSERT INTO players_grand_slam_titles(player_name)
--VALUES
--	('Nadal'),
--	('Federer'),
--	('Novak');
--CREATE TABLE championships_grand_slam_titles(
--	year INT PRIMARY KEY,
--	wimbledon INT NOT NULL,
--	fr_open INT NOT NULL,
--	us_open INT NOT NULL,
--	au_open INT NOT NULL
--);
--INSERT INTO championships_grand_slam_titles(year, wimbledon, fr_open, us_open, au_open)
--VALUES
--	(2018, 1, 1, 1, 1),
--	(2019, 1, 1, 2, 2),
--	(2020, 2, 1, 2, 2);

--Table: Players

--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| player_id      | int     |
--| player_name    | varchar |
--+----------------+---------+
--player_id is the primary key for this table.
--Each row in this table contains the name and the ID of a tennis player.

--Table: Championships

--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| year          | int     |
--| Wimbledon     | int     |
--| Fr_open       | int     |
--| US_open       | int     |
--| Au_open       | int     |
--+---------------+---------+
--year is the primary key for this table.
--Each row of this table containts the IDs of the players who won one each tennis tournament of the grand slam.

--Write an SQL query to report the number of grand slam tournaments won by each player. Do not include the players who did not win any tournament.

--Return the result table in any order.

--The query result format is in the following example:

--Players table:
--+-----------+-------------+
--| player_id | player_name |
--+-----------+-------------+
--| 1         | Nadal       |
--| 2         | Federer     |
--| 3         | Novak       |
--+-----------+-------------+

--Championships table:
--+------+-----------+---------+---------+---------+
--| year | Wimbledon | Fr_open | US_open | Au_open |
--+------+-----------+---------+---------+---------+
--| 2018 | 1         | 1       | 1       | 1       |
--| 2019 | 1         | 1       | 2       | 2       |
--| 2020 | 2         | 1       | 2       | 2       |
--+------+-----------+---------+---------+---------+

--Result table:
--+-----------+-------------+-------------------+
--| player_id | player_name | grand_slams_count |
--+-----------+-------------+-------------------+
--| 2         | Federer     | 5                 |
--| 1         | Nadal       | 7                 |
--+-----------+-------------+-------------------+

--Player 1 (Nadal) won 7 titles: Wimbledon (2018, 2019), Fr_open (2018, 2019, 2020), US_open (2018), and Au_open (2018).
--Player 2 (Federer) won 5 titles: Wimbledon (2020), US_open (2019, 2020), and Au_open (2019, 2020).
--Player 3 (Novak) did not win anything, we did not include them in the result table.

SELECT
	p.player_id,
	p.player_name,
	SUM(
		(CASE 
			WHEN p.player_id = c.wimbledon THEN 1 ELSE 0  
		END)
		+
		(CASE 
			WHEN p.player_id = c.fr_open THEN 1 ELSE 0  
		END)
		+
		(CASE 
			WHEN p.player_id = c.us_open THEN 1 ELSE 0  
		END)
		+
		(CASE 
			WHEN p.player_id = c.au_open THEN 1 ELSE 0  
		END)
	) grand_slams_count
FROM
	players_grand_slam_titles p JOIN championships_grand_slam_titles c
ON 
	p.player_id = c.wimbledon OR p.player_id = c.fr_open OR
	p.player_id = c.us_open OR p.player_id = c.au_open
GROUP BY
	p.player_id, p.player_name;