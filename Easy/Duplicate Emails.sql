-- Question 11
-- Write a SQL query to find all duplicate emails in a table named Person.
-- CREATE DATABASE IF NOT EXISTS duplicate_emails;
-- USE duplicate_emails;
-- Create table If Not Exists Person (Id int, Email varchar(255));
-- Truncate table Person;
-- insert into Person (Id, Email) values ('1', 'a@b.com');
-- insert into Person (Id, Email) values ('2', 'c@d.com');
-- insert into Person (Id, Email) values ('3', 'a@b.com');

-- +----+---------+
-- | Id | Email   |
-- +----+---------+
-- | 1  | a@b.com |
-- | 2  | c@d.com |
-- | 3  | a@b.com |
-- +----+---------+
-- For example, your query should return the following for the above table:

-- +---------+
-- | Email   |
-- +---------+
-- | a@b.com |
-- +---------+


-- Solution
-- Select Email
-- from
-- (Select Email, count(Email)
-- from person
-- group by Email
-- having count(Email)>1) a
SELECT DISTINCT email AS "Email" FROM person p
WHERE email IN (
    SELECT email FROM person m
    WHERE p.id <> m.id
)