USE leetcode; 

-- Table: Users

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- id is the primary key for this table.
-- name is the name of the user.
 
-- Table: Rides

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | user_id       | int     |
-- | distance      | int     |
-- +---------------+---------+
-- id is the primary key for this table.
-- user_id is the id of the user who travelled the distance "distance".
 

 -- Create Schema: 
  --CREATE TABLE users_travellers (
	--id INT PRIMARY KEY,
	--name VARCHAR(20) NOT NULL
 --);

 --CREATE TABLE rides_travellers (
	--id INT PRIMARY KEY,
	--distance INT NOT NULL,
	--user_id INT REFERENCES users_travellers (id)
 --);

 -- Inserting data
 --INSERT INTO users_travellers(id, name)
 --VALUES
	--(1, 'Alice'),
	--(2, 'Bob'),
	--(3, 'Alex'),
	--(4, 'Donald'),
	--(7, 'Lee'),
	--(13, 'Jonathan'),
	--(19, 'Elvis');

--INSERT INTO rides_travellers(id, user_id, distance)
--VALUES
--	(1, 1, 120),
--	(2, 2, 317),
--	(3, 3, 222),
--	(4, 7, 100),
--	(5, 13, 312),
--	(6, 19, 50),
--	(7, 7, 120),
--	(8, 19, 400),
--	(9, 7, 230);

-- Write an SQL query to report the distance travelled by each user.

-- Return the result table ordered by travelled_distance in descending order, 
-- if two or more users travelled the same distance, order them by their name in ascending order.

-- The query result format is in the following example.

-- Users table:
-- +------+-----------+
-- | id   | name      |
-- +------+-----------+
-- | 1    | Alice     |
-- | 2    | Bob       |
-- | 3    | Alex      |
-- | 4    | Donald    |
-- | 7    | Lee       |
-- | 13   | Jonathan  |
-- | 19   | Elvis     |
-- +------+-----------+

-- Rides table:
-- +------+----------+----------+
-- | id   | user_id  | distance |
-- +------+----------+----------+
-- | 1    | 1        | 120      |
-- | 2    | 2        | 317      |
-- | 3    | 3        | 222      |
-- | 4    | 7        | 100      |
-- | 5    | 13       | 312      |
-- | 6    | 19       | 50       |
-- | 7    | 7        | 120      |
-- | 8    | 19       | 400      |
-- | 9    | 7        | 230      |
-- +------+----------+----------+

-- Result table:
-- +----------+--------------------+
-- | name     | travelled_distance |
-- +----------+--------------------+
-- | Elvis    | 450                |
-- | Lee      | 450                |
-- | Bob      | 317                |
-- | Jonathan | 312                |
-- | Alex     | 222                |
-- | Alice    | 120                |
-- | Donald   | 0                  |
-- +----------+--------------------+
-- Elvis and Lee travelled 450 miles, Elvis is the top traveller as his name is alphabetically smaller than Lee.
-- Bob, Jonathan, Alex and Alice have only one ride and we just order them by the total distances of the ride.
-- Donald didn't have any rides, the distance travelled by him is 0.

-- Solution

SELECT 
	name, 
	ISNULL(SUM(distance), 0) travelled_distance
FROM
	users_travellers u LEFT JOIN rides_travellers r
ON
	u.id = r.user_id
GROUP BY
	name
ORDER BY
	travelled_distance DESC, name