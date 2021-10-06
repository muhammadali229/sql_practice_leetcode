USE leetcode;

-- Create Schema
--CREATE TABLE orders_customer_place_largest(
--	order_number INT PRIMARY KEY,
--	customer_number INT NOT NULL,
--	order_date DATE NOT NULL,
--	required_date DATE NOT NULL,
--	shipped_date DATE NOT NULL,
--	status CHAR(15) NOT NULL,
--	comment CHAR(200)
--);
--INSERT INTO orders_customer_place_largest(order_number, customer_number, order_date, required_date, shipped_date, status, comment)
--VALUES
--	(1, 1, '2017-04-09', '2017-04-13', '2017-04-12', 'Closed', ''),
--	(2, 2, '2017-04-15', '2017-04-20', '2017-04-18', 'Closed', ''),
--	(3, 3, '2017-04-16', '2017-04-25', '2017-04-20', 'Closed', ''),
--	(4, 3, '2017-04-18', '2017-04-28', '2017-04-25', 'Closed', '');

-- Query the customer_number from the orders table for the customer who has placed the largest number of orders.
-- It is guaranteed that exactly one customer will have placed more orders than any other customer.
-- The orders table is defined as follows:

-- | Column            | Type      |
-- |-------------------|-----------|
-- | order_number (PK) | int       |
-- | customer_number   | int       |
-- | order_date        | date      |
-- | required_date     | date      |
-- | shipped_date      | date      |
-- | status            | char(15)  |
-- | comment           | char(200) |

-- Sample Input

-- | order_number | customer_number | order_date | required_date | shipped_date | status | comment |
-- |--------------|-----------------|------------|---------------|--------------|--------|---------|
-- | 1            | 1               | 2017-04-09 | 2017-04-13    | 2017-04-12   | Closed |         |
-- | 2            | 2               | 2017-04-15 | 2017-04-20    | 2017-04-18   | Closed |         |
-- | 3            | 3               | 2017-04-16 | 2017-04-25    | 2017-04-20   | Closed |         |
-- | 4            | 3               | 2017-04-18 | 2017-04-28    | 2017-04-25   | Closed |         |

-- Sample Output

-- | customer_number |
-- |-----------------|
-- | 3               |

-- Explanation

-- The customer with number '3' has two orders, 
-- which is greater than either customer '1' or '2' because each of them  only has one order. 
-- So the result is customer_number '3'.

-- Solution

WITH total_orders_by_customer AS (
	SELECT 
		customer_number,
		COUNT(DISTINCT order_number) total_orders
	FROM
		orders_customer_place_largest
	GROUP BY 
		customer_number
)

SELECT
	customer_number
FROM
	total_orders_by_customer	
WHERE
	total_orders = (SELECT MAX(total_orders) FROM total_orders_by_customer);