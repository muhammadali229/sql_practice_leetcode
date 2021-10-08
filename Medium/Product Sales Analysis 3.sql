USE leetcode;

-- Create Schema
--CREATE TABLE products_product_analysis_3(
--	product_id INT PRIMARY KEY,
--	product_name VARCHAR(20) NOT NULL
--);
--CREATE TABLE sales_product_analysis_3(
--	sale_id INT PRIMARY KEY,
--	product_id INT REFERENCES products_product_analysis_3 (product_id),
--	year INT NOT NULL,
--	price INT NOT NULL
--);
--INSERT INTO products_product_analysis_3(product_id, product_name)
--VALUES
--	(100, 'Nokia'),
--	(200, 'Apple'),
--	(300, 'Samsung');
--ALTER TABLE sales_product_analysis_3
--ADD quantity INT;
--ALTER TABLE sales_product_analysis_3
--ALTER COLUMN quantity
--SET NOT NULL;
--INSERT INTO sales_product_analysis_3(sale_id, product_id, year, quantity, price)
--VALUES
--	(1, 100, 2008, 10, 5000),
--	(2, 100, 2009, 12, 5000),
--	(7, 200, 2011, 15, 9000);

-- Table: Sales

-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | sale_id     | int   |
-- | product_id  | int   |
-- | year        | int   |
-- | quantity    | int   |
-- | price       | int   |
-- +-------------+-------+
-- sale_id is the primary key of this table.
-- product_id is a foreign key to Product table.
-- Note that the price is per unit.
-- Table: Product

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- +--------------+---------+
-- product_id is the primary key of this table.
 

-- Write an SQL query that selects the product id, year, quantity, and price for the first year of every product sold.
-- The query result format is in the following example:

-- Sales table:
-- +---------+------------+------+----------+-------+
-- | sale_id | product_id | year | quantity | price |
-- +---------+------------+------+----------+-------+ 
-- | 1       | 100        | 2008 | 10       | 5000  |
-- | 2       | 100        | 2009 | 12       | 5000  |
-- | 7       | 200        | 2011 | 15       | 9000  |
-- +---------+------------+------+----------+-------+

-- Product table:
-- +------------+--------------+
-- | product_id | product_name |
-- +------------+--------------+
-- | 100        | Nokia        |
-- | 200        | Apple        |
-- | 300        | Samsung      |
-- +------------+--------------+

-- Result table:
-- +------------+------------+----------+-------+
-- | product_id | first_year | quantity | price |
-- +------------+------------+----------+-------+ 
-- | 100        | 2008       | 10       | 5000  |
-- | 200        | 2011       | 15       | 9000  |
-- +------------+------------+----------+-------+

-- Solution

WITH first_year_product_id AS (
	SELECT
		product_id,
		MIN(year) first_year
	FROM
		sales_product_analysis_3
	GROUP BY 
		product_id
)
SELECT 
	f.product_id,
	f.first_year,
	s.quantity,
	s.price
FROM
	sales_product_analysis_3 s JOIN first_year_product_id f
ON
	s.product_id = f.product_id AND f.first_year = s.year;