USE leetcode;

--Table: Products
--+-------------+---------+
--| Column Name | Type    |
--+-------------+---------+
--| product_id  | int     |
--| low_fats    | enum    |
--| recyclable  | enum    |
--+-------------+---------+
--product_id is the primary key for this table.
--low_fats is an ENUM of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
--recyclable is an ENUM of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.

-- create schema
--CREATE TABLE products_recycle(
--	product_id INT,
--	low_fats CHAR(1),
--	recyclable CHAR(1)
--);
--INSERT INTO products_recycle(product_id, low_fats, recyclable) VALUES (0, 'Y', 'N')
--INSERT INTO products_recycle(product_id, low_fats, recyclable) VALUES (1, 'Y', 'Y')
--INSERT INTO products_recycle(product_id, low_fats, recyclable) VALUES (2, 'N', 'Y')
--INSERT INTO products_recycle(product_id, low_fats, recyclable) VALUES (3, 'Y', 'Y')
--INSERT INTO products_recycle(product_id, low_fats, recyclable) VALUES (4, 'N', 'N');
ALTER TABLE products_recycle
ADD CONSTRAINT low_fats_check CHECK (low_fats IN ('Y', 'N')),
CONSTRAINT recyclable_check CHECK (recyclable IN ('Y', 'N'));

--Write an SQL query to find the ids of products that are both low fat and recyclable.

--Return the result table in any order.

--The query result format is in the following example:

--Products table:
--+-------------+----------+------------+
--| product_id  | low_fats | recyclable |
--+-------------+----------+------------+
--| 0           | Y        | N          |
--| 1           | Y        | Y          |
--| 2           | N        | Y          |
--| 3           | Y        | Y          |
--| 4           | N        | N          |
--+-------------+----------+------------+
--Result table:
--+-------------+
--| product_id  |
--+-------------+
--| 1           |
--| 3           |
--+-------------+
--Only products 1 and 3 are both low fat and recyclable.

-- Solution 1
SELECT
	product_id
FROM
	products_recycle
WHERE
	low_fats = 'Y' AND recyclable = 'Y';