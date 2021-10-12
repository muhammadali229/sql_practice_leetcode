USE leetcode;

-- Create Schema
--CREATE TABLE users_details_hard(
--	user_id INT PRIMARY KEY,
--	banned VARCHAR(5) NOT NULL,
--	role VARCHAR(10) NOT NULL
--	CHECK(role IN ('client', 'driver'))
--);
--INSERT INTO users_details_hard(user_id, banned, role)
--VALUES
--	(1, 'No', 'client'),
--	(2, 'Yes', 'client'),
--	(3, 'No', 'client'),
--	(4, 'No', 'client'),
--	(10, 'No', 'driver'),
--	(11, 'No', 'driver'),
--	(12, 'No', 'driver'),
--	(13, 'No', 'driver');
--CREATE TABLE trips_details_hard(
--	id INT IDENTITY PRIMARY KEY,
--	client_id INT REFERENCES users_details_hard (user_id),
--	driver_id INT REFERENCES users_details_hard (user_id),
--	city_id INT NOT NULL,
--	request_at DATE NOT NULL,
--	status VARCHAR(25) NOT NULL
--	CHECK(status IN ('completed', 'cancelled_by_driver', 'cancelled_by_client'))
--);
--INSERT INTO trips_details_hard(client_id, driver_id, city_id, request_at, status)
--VALUES
--	(1, 10, 1, '2013-10-01', 'completed'),
--	(2, 11, 1, '2013-10-01', 'cancelled_by_driver'),
--	(3, 12, 6, '2013-10-01', 'completed'),
--	(4, 13, 6, '2013-10-01', 'cancelled_by_client'),
--	(1, 10, 1, '2013-10-02', 'completed'),
--	(2, 11, 6, '2013-10-02', 'completed'),
--	(3, 12, 6, '2013-10-02', 'completed'),
--	(2, 12, 12, '2013-10-03', 'completed'),
--	(3, 10, 12, '2013-10-03', 'completed'),
--	(4, 13, 12, '2013-10-03', 'cancelled_by_driver');

-- The Trips table holds all taxi trips. Each trip has a unique Id
-- Client_Id Driver_Id are both foreign keys to the Users_Id at the Users table. 
-- Status is an ENUM type of (‘completed’, ‘cancelled_by_driver’, ‘cancelled_by_client’).
-- +----+-----------+-----------+---------+--------------------+----------+
-- | Id | Client_Id | Driver_Id | City_Id |        Status      |Request_at|
-- +----+-----------+-----------+---------+--------------------+----------+
-- | 1  |     1     |    10     |    1    |     completed      |2013-10-01|
-- | 2  |     2     |    11     |    1    | cancelled_by_driver|2013-10-01|
-- | 3  |     3     |    12     |    6    |     completed      |2013-10-01|
-- | 4  |     4     |    13     |    6    | cancelled_by_client|2013-10-01|
-- | 5  |     1     |    10     |    1    |     completed      |2013-10-02|
-- | 6  |     2     |    11     |    6    |     completed      |2013-10-02|
-- | 7  |     3     |    12     |    6    |     completed      |2013-10-02|
-- | 8  |     2     |    12     |    12   |     completed      |2013-10-03|
-- | 9  |     3     |    10     |    12   |     completed      |2013-10-03| 
-- | 10 |     4     |    13     |    12   | cancelled_by_driver|2013-10-03|
-- +----+-----------+-----------+---------+--------------------+----------+
-- The Users table holds all users. Each user has an unique Users_Id 
-- Role is an ENUM type of (‘client’, ‘driver’, ‘partner’).
-- +----------+--------+--------+
-- | Users_Id | Banned |  Role  |
-- +----------+--------+--------+
-- |    1     |   No   | client |
-- |    2     |   Yes  | client |
-- |    3     |   No   | client |
-- |    4     |   No   | client |
-- |    10    |   No   | driver |
-- |    11    |   No   | driver |
-- |    12    |   No   | driver |
-- |    13    |   No   | driver |
-- +----------+--------+--------+

-- Write a SQL query to find the cancellation rate of requests made by unbanned users 
-- (both client and driver must be unbanned) between Oct 1, 2013 and Oct 3, 2013. 
-- The cancellation rate is computed by dividing the number of canceled (by client or driver) 
-- requests made by unbanned users by the total number of requests made by unbanned users.

-- For the above tables, your SQL query should return the following rows with the cancellation 
-- rate being rounded to two decimal places.

-- +------------+-------------------+
-- |     Day    | Cancellation Rate |
-- +------------+-------------------+
-- | 2013-10-01 |       0.33        |
-- | 2013-10-02 |       0.00        |
-- | 2013-10-03 |       0.50        |
-- +------------+-------------------+

-- Credits:
-- Special thanks to @cak1erlizhou for contributing this question, writing the problem 
-- description and adding part of the test cases.

-- Solution
SELECT
	request_at Day,
	ROUND(CAST(SUM(
		(CASE 
			WHEN status <> 'completed' THEN 1 ELSE 0
		END)
	) AS FLOAT) / COUNT(*), 2
	) 'Cancellation Rate'
FROM
	trips_details_hard
WHERE
	driver_id NOT IN (SELECT user_id FROM users_details_hard WHERE banned = 'Yes') AND
	client_id NOT IN (SELECT user_id FROM users_details_hard WHERE banned = 'Yes')
GROUP BY	
	 request_at