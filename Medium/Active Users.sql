USE leetcode;

-- Create Schema
--CREATE TABLE account_active_users(
--	id INT PRIMARY KEY,
--	name VARCHAR(20) NOT NULL
--);
--CREATE TABLE login_active_users(
--	id INT NOT NULL,
--	login_date DATE NOT NULL
-- );
--INSERT INTO account_active_users(id, name)
--VALUES
--	(1, 'Winston'),
--	(7, 'Jonathan');
--INSERT INTO login_active_users(id, login_date)
--VALUES
--	(7, '2020-05-30'),
--	(1, '2020-05-30'),
--	(7, '2020-05-31'),
--	(7, '2020-06-01'),
--	(7, '2020-06-02'),
--	(7, '2020-06-02'),
--	(7, '2020-06-03'),
--	(1, '2020-06-07'),
--	(7, '2020-06-10'),
--	(1, '2020-06-11'),
--	(1, '2020-06-12'),
--	(1, '2020-06-13'),
--	(1, '2020-06-14');

-- Table Accounts:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- the id is the primary key for this table.
-- This table contains the account id and the user name of each account.

-- Table Logins:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | login_date    | date    |
-- +---------------+---------+
-- There is no primary key for this table, it may contain duplicates.
-- This table contains the account id of the user who logged in and the login date. A user may log in multiple times in the day.
 

-- Write an SQL query to find the id and the name of active users.
-- Active users are those who logged in to their accounts for 5 or more consecutive days.
-- Return the result table ordered by the id.

-- The query result format is in the following example:

-- Accounts table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 1  | Winston  |
-- | 7  | Jonathan |
-- +----+----------+

-- Logins table:
-- +----+------------+
-- | id | login_date |
-- +----+------------+
-- | 7  | 2020-05-30 |
-- | 1  | 2020-05-30 |
-- | 7  | 2020-05-31 |
-- | 7  | 2020-06-01 |
-- | 7  | 2020-06-02 |
-- | 7  | 2020-06-02 |
-- | 7  | 2020-06-03 |
-- | 1  | 2020-06-07 |
-- | 7  | 2020-06-10 |
-- +----+------------+

-- Result table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 7  | Jonathan |
-- +----+----------+
-- User Winston with id = 1 logged in 2 times only in 2 different days, so, Winston is not an active user.
-- User Jonathan with id = 7 logged in 7 times in 6 different days, five of them were consecutive days, so, Jonathan is an active user.

-- Solution 1
SELECT
	id,
	name
FROM
	account_active_users
WHERE
	id IN (
	SELECT 
		id
	FROM 
	(
		SELECT
			id,
			login_date,
			LEAD(login_date) OVER(PARTITION BY id ORDER BY login_date) next_date_1
		FROM
			login_active_users
	) as temp
	WHERE
		DATEDIFF(DAY, login_date, next_date_1) = 1
	GROUP BY
		id
	HAVING
		COUNT(DISTINCT login_date) = 4
);

-- Solution 2
SELECT
	a.id, 
	name
FROM 
	login_active_users a JOIN login_active_users b
ON
	a.id = b.id AND DATEDIFF(DAY, a.login_date, b.login_date) = 1
JOIN
	account_active_users acc
ON
	a.id = acc.id
GROUP BY
	a.id, name
HAVING
	COUNT(DISTINCT b.login_date) = 4;