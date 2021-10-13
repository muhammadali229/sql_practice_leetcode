USE leetcode;

-- Create Schema
--CREATE TABLE stadium_human_traffic(
--	id INT NOT NULL,
--	visit_date DATE PRIMARY KEY,
--	people INT NOT NULL
--);
--INSERT INTO stadium_human_traffic(id, visit_date, people)
--VALUES
--	(1, '2017-01-01', 10),
--	(2, '2017-01-02', 109),
--	(3, '2017-01-03', 150),
--	(4, '2017-01-04', 99),
--	(5, '2017-01-05', 145),
--	(6, '2017-01-06', 1455),
--	(7, '2017-01-07', 199),
--	(8, '2017-01-09', 188);
--Table: Stadium
--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| visit_date    | date    |
--| people        | int     |
--+---------------+---------+
-- visit_date is the primary key for this table.
-- Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
-- No two rows will have the same visit_date, and as the id increases, the dates increase as well.

-- Write an SQL query to display the records with three or more rows with 
-- consecutive id’s, and the number of people is greater than or equal 
-- to 100 for each.

--Return the result table ordered by visit_date in ascending order.

--The query result format is in the following example.

--Stadium table:
--+------+------------+-----------+
--| id   | visit_date | people    |
--+------+------------+-----------+
--| 1    | 2017-01-01 | 10        |
--| 2    | 2017-01-02 | 109       |
--| 3    | 2017-01-03 | 150       |
--| 4    | 2017-01-04 | 99        |
--| 5    | 2017-01-05 | 145       |
--| 6    | 2017-01-06 | 1455      |
--| 7    | 2017-01-07 | 199       |
--| 8    | 2017-01-09 | 188       |
--+------+------------+-----------+

--Result table:
--+------+------------+-----------+
--| id   | visit_date | people    |
--+------+------------+-----------+
--| 5    | 2017-01-05 | 145       |
--| 6    | 2017-01-06 | 1455      |
--| 7    | 2017-01-07 | 199       |
--| 8    | 2017-01-09 | 188       |
--+------+------------+-----------+
-- The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
-- The rows with ids 2 and 3 are not included because we need at least three consecutive ids.

-- Solution 1
SELECT
	id,
	visit_date,
	people
FROM
(
	SELECT
		*,
		LAG(people, 1) OVER(ORDER BY id) pre_people_1, 
		LAG(people, 2) OVER(ORDER BY id) pre_people_2,
		LEAD(people, 1) OVER(ORDER BY id) next_people_1,
		LEAD(people, 2) OVER(ORDER BY id) next_people_2
	FROM
		stadium_human_traffic
) as temp
WHERE
	(people >= 100 AND next_people_1 >= 100 AND next_people_2 >= 100) OR
	(people >= 100 AND pre_people_1 >= 100 AND pre_people_2 >= 100) OR
	(people >= 100 AND pre_people_1 >= 100 AND next_people_1 >= 100)
ORDER BY
	visit_date;

-- Solution 2
SELECT
	DISTINCT s1.id,
	s1.visit_date,
	s1.people
FROM
	stadium_human_traffic s1, stadium_human_traffic s2, stadium_human_traffic s3
WHERE
	((s1.id = s2.id + 1 AND s1.id = s3.id + 2) OR
	(s1.id = s2.id - 1 AND s1.id= s3.id - 2) OR
	(s1.id = s2.id - 1 AND s1.id = s3.id + 1)) AND
	(s1.people >= 100 AND s2.people >= 100 AND s3.people >= 100)
ORDER BY
	s1.visit_date;

-- Solution 3
SELECT
	DISTINCT s1.id,
	s1.visit_date,
	s1.people
FROM
	stadium_human_traffic s1 JOIN stadium_human_traffic s2
ON
	s2.id = s1.id + 1 OR s2.id = s1.id - 1
JOIN 
	stadium_human_traffic s3
ON
	(
		(s3.id = s1.id + 2 AND s3.id = s2.id + 1) OR
		(s3.id = s1.id - 2 AND s3.id = s2.id - 1) OR
		(s3.id = s1.id - 1 AND s3.id = s2.id - 2)
	) AND (s2.id <> s3.id AND s1.id <> s3.id) 
WHERE
	s1.people >= 100 AND s2.people >= 100 AND s3.people >= 100
ORDER BY
	s1.visit_date;
