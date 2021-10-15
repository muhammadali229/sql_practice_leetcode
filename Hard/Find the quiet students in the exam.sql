USE leetcode;

-- Create Schema
--CREATE TABLE student_find_quiet(
--	student_id INT IDENTITY PRIMARY KEY,
--	student_name VARCHAR(20) NOT NULL
--);
--INSERT INTO student_find_quiet(student_name)
--VALUES
--	('Daniel'),
--	('Jade'),
--	('Stella'),
--	('Jonathan'),
--	('Will');
--CREATE TABLE exam_find_quiet(
--	exam_id INT,
--	student_id INT,
--	score INT NOT NULL,
--	PRIMARY KEY (exam_id, student_id)
-- );
--INSERT INTO exam_find_quiet(exam_id, student_id, score)
--VALUES
--	(10, 1, 70),
--	(10, 2, 80),
--	(10, 3, 90),
--	(20, 1, 80),
--	(30, 1, 70),
--	(30, 3, 80),
--	(30, 4, 90),
--	(40, 1, 60),
--	(40, 2, 70),
--	(40, 4, 80);

-- Table: Student
-- +---------------------+---------+
-- | Column Name         | Type    |
-- +---------------------+---------+
-- | student_id          | int     |
-- | student_name        | varchar |
-- +---------------------+---------+
-- student_id is the primary key for this table.
-- student_name is the name of the student.
 
-- Table: Exam
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | exam_id       | int     |
-- | student_id    | int     |
-- | score         | int     |
-- +---------------+---------+
-- (exam_id, student_id) is the primary key for this table.
-- Student with student_id got score points in exam with id exam_id.

-- A "quite" student is the one who took at least one exam and didn't score 
-- neither the high score nor the low score.

-- Write an SQL query to report the students (student_id, student_name) 
-- being "quiet" in ALL exams.

-- Don't return the student who has never taken any exam. Return the 
-- result table ordered by student_id.

-- The query result format is in the following example.

-- Student table:
-- +-------------+---------------+
-- | student_id  | student_name  |
-- +-------------+---------------+
-- | 1           | Daniel        |
-- | 2           | Jade          |
-- | 3           | Stella        |
-- | 4           | Jonathan      |
-- | 5           | Will          |
-- +-------------+---------------+

-- Exam table:
-- +------------+--------------+-----------+
-- | exam_id    | student_id   | score     |
-- +------------+--------------+-----------+
-- | 10         |     1        |    70     |
-- | 10         |     2        |    80     |
-- | 10         |     3        |    90     |
-- | 20         |     1        |    80     |
-- | 30         |     1        |    70     |
-- | 30         |     3        |    80     |
-- | 30         |     4        |    90     |
-- | 40         |     1        |    60     |
-- | 40         |     2        |    70     |
-- | 40         |     4        |    80     |
-- +------------+--------------+-----------+

-- Result table:
-- +-------------+---------------+
-- | student_id  | student_name  |
-- +-------------+---------------+
-- | 2           | Jade          |
-- +-------------+---------------+
-- For exam 1: Student 1 and 3 hold the lowest and high score respectively.
-- For exam 2: Student 1 hold both highest and lowest score.
-- For exam 3 and 4: Studnet 1 and 4 hold the lowest and high score respectively.
-- Student 2 and 5 have never got the highest or lowest in any of the exam.
-- Since student 5 is not taking any exam, he is excluded from the result.
-- So, we only return the information of Student 2.

-- Solution
WITH student_id_not_in_min_max AS (
	SELECT
		student_id
	FROM
	(
		SELECT
			*,
			MIN(score) OVER(PARTITION BY exam_id) min_score,
			MAX(score) OVER(PARTITION BY exam_id) max_score	
		FROM
			exam_find_quiet
	) as temp
	GROUP BY 
		student_id
	HAVING
		SUM(
			CASE 
				WHEN score IN (min_score, max_score) THEN 1 ELSE 0
			END
		) = 0
)

SELECT
	student_id,
	student_name
FROM
	student_find_quiet
WHERE
	student_id IN (
		SELECT student_id FROM student_id_not_in_min_max
	);