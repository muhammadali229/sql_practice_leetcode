USE leetcode;

--Table: Activity

--+----------------+---------+
--| Column Name    | Type    |
--+----------------+---------+
--| machine_id     | int     |
--| process_id     | int     |
--| activity_type  | enum    |
--| timestamp      | float   |
--+----------------+---------+

-- Create Schema
--CREATE TABLE activity_machine (
--	machine_id INT NOT NULL,
--	process_id INT NOT NULL,
--	activity_type VARCHAR(10) NOT NULL CHECK (activity_type IN ('start', 'end')),
--	timestamp FLOAT NOT NULL
--);

--The table shows the user activities for a factory website.
--(machine_id, process_id, activity_type) is the primary key of this table.
--machine_id is the ID of a machine.
--process_id is the ID of a process running on the machine with ID machine_id.
--activity_type is an ENUM of type ('start', 'end').
--timestamp is a float representing the current time in seconds.
--'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
--The 'start' timestamp will always be before the 'end' timestamp for every (machine_id, process_id) pair.

--There is a factory website that has several machines each running the same number of processes. Write an SQL query to find the average time each machine takes to complete a process.

--The time to complete a process is the ‘end’ timestamp minus the ‘start’ timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.

--The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.

--The query result format is in the following example:

--Activity table:
--INSERT INTO activity_machine(machine_id, process_id, activity_type, timestamp)
--VALUES
--	(0, 0, 'start', 0.712),
--	(0, 0, 'end', 1.520),
--	(0, 1, 'start', 3.140),
--	(0, 1, 'end', 4.120),
--	(1, 0, 'start', 0.550),
--	(1, 0, 'end', 1.550),
--	(1, 1, 'start', 0.430),
--	(1, 1, 'end', 1.420),
--	(2, 0, 'start', 4.100),
--	(2, 0, 'end', 4.512),
--	(2, 1, 'start', 2.500),
--	(2, 1, 'end', 5.000)
--+------------+------------+---------------+-----------+
--| machine_id | process_id | activity_type | timestamp |
--+------------+------------+---------------+-----------+
--| 0          | 0          | start         | 0.712     |
--| 0          | 0          | end           | 1.520     |
--| 0          | 1          | start         | 3.140     |
--| 0          | 1          | end           | 4.120     |
--| 1          | 0          | start         | 0.550     |
--| 1          | 0          | end           | 1.550     |
--| 1          | 1          | start         | 0.430     |
--| 1          | 1          | end           | 1.420     |
--| 2          | 0          | start         | 4.100     |
--| 2          | 0          | end           | 4.512     |
--| 2          | 1          | start         | 2.500     |
--| 2          | 1          | end           | 5.000     |
--+------------+------------+---------------+-----------+

--Result table:
--+------------+-----------------+
--| machine_id | processing_time |
--+------------+-----------------+
--| 0          | 0.894           |
--| 1          | 0.995           |
--| 2          | 1.456           |
--+------------+-----------------+

--There are 3 machines running 2 processes each.
--Machine 0's average time is ((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894
--Machine 1's average time is ((1.550 - 0.550) + (1.420 - 0.430)) / 2 = 0.995
--Machine 2's average time is ((4.512 - 4.100) + (5.000 - 2.500)) / 2 = 1.456

-- Solution 1
WITH selecting_start_end_timestamp AS (
	SELECT
		machine_id,
		timestamp AS start_timestamp,
		LEAD(timestamp) OVER(PARTITION BY machine_id, process_id ORDER BY machine_id, process_id) AS end_timestamp
	FROM 
		activity_machine
)

SELECT 
	machine_id,
	AVG(end_timestamp - start_timestamp) AS processing_time
FROM
	selecting_start_end_timestamp
WHERE 
	end_timestamp IS NOT NULL
GROUP BY
	machine_id;


-- Solution 2
SELECT
	a.machine_id,
	AVG(b.timestamp - a.timestamp) AS processing_time
FROM
	activity_machine a
JOIN
	activity_machine b
ON a.machine_id = b.machine_id AND a.process_id = b.process_id
WHERE
	a.activity_type = 'start' AND b.activity_type = 'end'
GROUP BY
	a.machine_id;