-- Question 32
-- Write a SQL query to delete all duplicate email entries in a table named Person, keeping only unique emails based on its smallest Id.

-- CREATE DATABASE IF NOT EXISTS delete_duplicate_emails;
USE delete_duplicate_emails;
-- Create table If Not Exists Person (Id int, Email varchar(255));
-- Truncate table Person;
-- insert into Person (Id, Email) values ('1', 'john@example.com');
-- insert into Person (Id, Email) values ('2', 'bob@example.com');
-- insert into Person (Id, Email) values ('3', 'john@example.com');

-- +----+------------------+
-- | Id | Email            |
-- +----+------------------+
-- | 1  | john@example.com |
-- | 2  | bob@example.com  |
-- | 3  | john@example.com |
-- +----+------------------+
-- Id is the primary key column for this table.
-- For example, after running your query, the above Person table should have the following rows:

-- +----+------------------+
-- | Id | Email            |
-- +----+------------------+
-- | 1  | john@example.com |
-- | 2  | bob@example.com  |
-- +----+------------------+

-- Solution
DELETE p2 FROM person p1 JOIN person p2
ON p1.email = p2.email AND p1.id < p2.id