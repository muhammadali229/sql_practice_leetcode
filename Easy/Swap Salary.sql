-- Question 22
-- Given a table salary, such as the one below, that has m=male and f=female values. 
-- Swap all f and m values (i.e., change all f values to m and vice versa) with 
-- a single update statement and no intermediate temp table.

-- Note that you must write a single update statement, DO NOT write any select statement for this problem.

-- schema
-- create database if not exists swap_salary;
use swap_salary;
-- create table if not exists salary(id int, name varchar(100), sex char(1), salary int);
-- Truncate table salary;
-- insert into salary (id, name, sex, salary) values ('1', 'A', 'm', '2500');
-- insert into salary (id, name, sex, salary) values ('2', 'B', 'f', '1500');
-- insert into salary (id, name, sex, salary) values ('3', 'C', 'm', '5500');
-- insert into salary (id, name, sex, salary) values ('4', 'D', 'f', '500');

-- Example:

-- | id | name | sex | salary |
-- |----|------|-----|--------|
-- | 1  | A    | m   | 2500   |
-- | 2  | B    | f   | 1500   |
-- | 3  | C    | m   | 5500   |
-- | 4  | D    | f   | 500    |
-- After running your update statement, the above salary table should have the following rows:
-- | id | name | sex | salary |
-- |----|------|-----|--------|
-- | 1  | A    | f   | 2500   |
-- | 2  | B    | m   | 1500   |
-- | 3  | C    | f   | 5500   |
-- | 4  | D    | m   | 500    |

-- Solution
UPDATE salary
SET sex = (
	CASE WHEN sex = 'f' then 'm' else 'f' end
)
-- select * from salary 