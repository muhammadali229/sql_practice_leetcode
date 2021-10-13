USE leetcode;

-- Create Schema
--CREATE TABLE user_activity_second_recent(
--	username VARCHAR(20) NOT NULL,
--	activity VARCHAR(20) NOT NULL,
--	startDate DATE NOT NULL,
--	endDate DATE NOT NULL
--);
--INSERT INTO user_activity_second_recent(username, activity, startDate, endDate)
--VALUES
--	('Alice', 'Travel', '2020-02-12', '2020-02-20'),
--	('Alice', 'Dancing', '2020-02-21', '2020-02-23'),
--	('Alice', 'Travel', '2020-02-24', '2020-02-28'),
--	('Bob', 'Travel', '2020-02-11', '2020-02-18');

--Table: UserActivity
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| username      | varchar |
--| activity      | varchar |
--| startDate     | Date    |
--| endDate       | Date    |
--+---------------+---------+
--This table does not contain primary key.
--This table contain information about the activity performed of each user in a 
-- period of time.
--A person with username performed a activity from startDate to endDate.

--Write an SQL query to show the second most recent activity of each user.
--If the user only has one activity, return that one.
--A user can’t perform more than one activity at the same time. 
--Return the result table in any order.

--The query result format is in the following example:

--UserActivity table:
--+------------+--------------+-------------+-------------+
--| username   | activity     | startDate   | endDate     |
--+------------+--------------+-------------+-------------+
--| Alice      | Travel       | 2020-02-12  | 2020-02-20  |
--| Alice      | Dancing      | 2020-02-21  | 2020-02-23  |
--| Alice      | Travel       | 2020-02-24  | 2020-02-28  |
--| Bob        | Travel       | 2020-02-11  | 2020-02-18  |
--+------------+--------------+-------------+-------------+

--Result table:
--+------------+--------------+-------------+-------------+
--| username   | activity     | startDate   | endDate     |
--+------------+--------------+-------------+-------------+
--| Alice      | Dancing      | 2020-02-21  | 2020-02-23  |
--| Bob        | Travel       | 2020-02-11  | 2020-02-18  |
--+------------+--------------+-------------+-------------+

--The most recent activity of Alice is Travel from 2020-02-24 to 2020-02-28 
--before that she was dancing from 2020-02-21 to 2020-02-23.
--Bob only has one record, we just take that one.

-- Solution
SELECT
	username, 
	activity,
	startDate,
	endDate
FROM
(
	SELECT
		*,
		COUNT(activity) OVER(PARTITION BY username, startDate) act_cnt,
		(
			CASE 
				WHEN COUNT(*) OVER(PARTITION BY username) = 1 THEN 2 ELSE
				RANK() OVER(PARTITION BY username ORDER BY startDate DESC)
			END
		) rk
	FROM
		user_activity_second_recent
) as temp
WHERE 
	rk = 2 AND act_cnt = 1;