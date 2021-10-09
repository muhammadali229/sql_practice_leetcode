USE leetcode;

-- Create Schema
--CREATE TABLE activities_activity_participants(
--	id INT IDENTITY PRIMARY KEY,
--	name VARCHAR(20) NOT NULL
--);
--INSERT INTO activities_activity_participants(name)
--VALUES
--	('Eating'),
--	('Singing'),
--	('Horse Riding');
--CREATE TABLE friends_activity_participants(
--	id INT IDENTITY PRIMARY KEY,
--	name VARCHAR(20) NOT NULL,
--	activity VARCHAR(20)
--);
--INSERT INTO friends_activity_participants(name, activity)
--VALUES
--	('Jonathan D.', 'Eating'),
--	('Jade W.', 'Singing'),
--	('Victor J.', 'Singing'),
--	('Elvis Q.', 'Eating'),
--	('Daniel A.', 'Eating'),
--	('Bob B.', 'Horse Riding');

-- Table: Friends

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- | activity      | varchar |
-- +---------------+---------+
-- id is the id of the friend and primary key for this table.
-- name is the name of the friend.
-- activity is the name of the activity which the friend takes part in.

-- Table: Activities

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- id is the primary key for this table.
-- name is the name of the activity.
 
-- Write an SQL query to find the names of all the activities with neither maximum, nor minimum number of participants.
-- Return the result table in any order. Each activity in table Activities is performed by any person in the table Friends.
-- The query result format is in the following example:

-- Friends table:
-- +------+--------------+---------------+
-- | id   | name         | activity      |
-- +------+--------------+---------------+
-- | 1    | Jonathan D.  | Eating        |
-- | 2    | Jade W.      | Singing       |
-- | 3    | Victor J.    | Singing       |
-- | 4    | Elvis Q.     | Eating        |
-- | 5    | Daniel A.    | Eating        |
-- | 6    | Bob B.       | Horse Riding  |
-- +------+--------------+---------------+

-- Activities table:
-- +------+--------------+
-- | id   | name         |
-- +------+--------------+
-- | 1    | Eating       |
-- | 2    | Singing      |
-- | 3    | Horse Riding |
-- +------+--------------+

-- Result table:
-- +--------------+
-- | activity     |
-- +--------------+
-- | Singing      |
-- +--------------+

-- Eating activity is performed by 3 friends, maximum number of participants, (Jonathan D. , Elvis Q. and Daniel A.)
-- Horse Riding activity is performed by 1 friend, minimum number of participants, (Bob B.)
-- Singing is performed by 2 friends (Victor J. and Jade W.)

-- Solution 
WITH no_of_participants_by_activity AS (
	SELECT 
		activity,
		COUNT(id) no_of_participants
	FROM
		friends_activity_participants
	GROUP BY
		activity
)

SELECT 
	activity
FROM
	no_of_participants_by_activity
WHERE
	no_of_participants NOT IN (
		SELECT 
			MIN(no_of_participants) participant
		FROM 
			no_of_participants_by_activity
		UNION
		SELECT 
			MAX(no_of_participants) participant
		FROM 
			no_of_participants_by_activity
	);