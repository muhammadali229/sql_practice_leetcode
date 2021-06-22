-- Question7
-- There is a table courses with columns: student and class

-- Please list out all classes which have more than or equal to 5 students.

-- Schema
-- create database if not exists classes_more_five_students;
use classes_more_five_students;
-- Create table If Not Exists courses (student varchar(255), class varchar(255));
-- Truncate table courses;
-- insert into courses (student, class) values ('A', 'Math');
-- insert into courses (student, class) values ('B', 'English');
-- insert into courses (student, class) values ('C', 'Math');
-- insert into courses (student, class) values ('D', 'Biology');
-- insert into courses (student, class) values ('E', 'Math');
-- insert into courses (student, class) values ('F', 'Computer');
-- insert into courses (student, class) values ('G', 'Math');
-- insert into courses (student, class) values ('H', 'Math');
-- insert into courses (student, class) values ('I', 'Math');
-- insert into courses (student, class) values ('I', 'Math');
-- For example, the table:

-- +---------+------------+
-- | student | class      |
-- +---------+------------+
-- | A       | Math       |
-- | B       | English    |
-- | C       | Math       |
-- | D       | Biology    |
-- | E       | Math       |
-- | F       | Computer   |
-- | G       | Math       |
-- | H       | Math       |
-- | I       | Math       |
-- +---------+------------+

-- Should output:

-- +---------+
-- | class   |
-- +---------+
-- | Math    |
-- +---------+

-- Solution
-- select class from (
-- 	select class, count(DISTINCT student) as no_of_students from  courses
-- 	group by class 
-- 	having count(*) >= 5
-- ) as courses_temp 
-- 	select class, count(DISTINCT student) as no_of_students from  courses
-- 	group by class 
-- 	having count(*) >= 5   

-- select class from (
-- 	select c1.class, COUNT(distinct c1.student) no_of_students from courses c1
-- 	join courses c2 on c1.class = c2.class and c1.student <> c2.student
-- 	group by c1.class
-- 	having count(*) >= 5
-- ) as courses_temp     
-- where no_of_students >= 5
-- select class from (
-- select class, sum(no_of_students) from (
-- 	select class, student, count(*) no_of_students from courses
-- 	group by class, student
-- 	having count(*) = 1
-- ) as courses_temp
-- group by class
-- having sum(no_of_students) >= 5 ) course_temp_2

-- select class from 
-- ( 
-- 	select class, count(distinct student) no_of_students from courses
-- 	group by class 
-- ) as temp
-- where no_of_students >= 5

-- select class from 
-- ( 
-- 	select class, count(distinct student) no_of_students from courses
-- 	group by class 
--     having count(distinct student) >= 5
-- ) as temp


select class from courses
group by class 
having count(distinct student) >= 5