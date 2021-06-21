-- Question 12
-- Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.

-- CREATE DATABASE IF NOT EXISTS raising_temperature;
USE raising_temperature;
-- Create table If Not Exists Weather (Id int, RecordDate date, Temperature int);
-- Truncate table Weather;
-- insert into Weather (Id, RecordDate, Temperature) values ('1', '2015-01-01', '10');
-- insert into Weather (Id, RecordDate, Temperature) values ('2', '2015-01-02', '25');
-- insert into Weather (Id, RecordDate, Temperature) values ('3', '2015-01-03', '20');
-- insert into Weather (Id, RecordDate, Temperature) values ('4', '2015-01-04', '30');

-- +---------+------------------+------------------+
-- | Id(INT) | RecordDate(DATE) | Temperature(INT) |
-- +---------+------------------+------------------+
-- |       1 |       2015-01-01 |               10 |
-- |       2 |       2015-01-02 |               25 |
-- |       3 |       2015-01-03 |               20 |
-- |       4 |       2015-01-04 |               30 |
-- +---------+------------------+------------------+
-- For example, return the following Ids for the above Weather table:

-- +----+
-- | Id |
-- +----+
-- |  2 |
-- |  4 |
-- +----+

-- Solution
-- select a.Id
-- from weather a, weather b
-- where a.Temperature>b.Temperature and  datediff(a.recorddate,b.recorddate)=1

WITH weather_records AS 
	( SELECT *, LAG(temperature, 1) OVER(ORDER BY recorddate) AS previous_temperature, 
	LAG(recorddate, 1) OVER(ORDER BY recorddate) AS previous_date  FROM weather )
SELECT id FROM weather_records
WHERE datediff(recorddate, previous_date) = 1 AND temperature > previous_temperature