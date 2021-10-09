USE leetcode;
-- Create Schema
--CREATE TABLE customers_trusted_contracts(
--	customer_id INT PRIMARY KEY,
--	customer_name VARCHAR(20) NOT NULL,
--	email VARCHAR(100) NOT NULL
--);
--CREATE TABLE contacts_trusted_contracts(
--	user_id INT,
--	contact_name VARCHAR(20) NOT NULL,
--	contact_email VARCHAR(100),
--	PRIMARY KEY (user_id, contact_email)
--);
--CREATE TABLE invoices_trusted_contracts(
--	invoice_id INT PRIMARY KEY,
--	price INT NOT NULL,
--	user_id INT
--);
--INSERT INTO customers_trusted_contracts(customer_id, customer_name, email)
--VALUES
--	(1, 'Alice', 'alice@leetcode.com'),
--	(2, 'Bob', 'bob@leetcode.com'),
--	(13, 'John', 'john@leetcode.com'),
--	(6, 'Alex', 'alex@leetcode.com');
--INSERT INTO contacts_trusted_contracts(user_id, contact_name, contact_email)
--VALUES
--	(1, 'Bob', 'bob@leetcode.com'),
--	(1, 'John', 'john@leetcode.com'),
--	(1, 'Jal', 'jal@leetcode.com'),
--	(2, 'Omar', 'omar@leetcode.com'),
--	(2, 'Meir', 'meir@leetcode.com'),
--	(6, 'Alice', 'alice@leetcode.com');
--INSERT INTO invoices_trusted_contracts(invoice_id, price, user_id)
--VALUES
--	(77, 100, 1),
--	(88, 200, 1),
--	(99, 300, 2),
--	(66, 400, 2),
--	(55, 500, 13),
--	(44, 60, 6);

--Table: Customers

--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| customer_id   | int     |
--| customer_name | varchar |
--| email         | varchar |
--+---------------+---------+
--customer_id is the primary key for this table.
--Each row of this table contains the name and the email of a customer of an online shop.

--Table: Contacts

--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| user_id       | id      |
--| contact_name  | varchar |
--| contact_email | varchar |
--+---------------+---------+
--(user_id, contact_email) is the primary key for this table.
--Each row of this table contains the name and email of one contact of customer with user_id.
--This table contains information about people each customer trust. The contact may or may not exist in the Customers table.

--Table: Invoices

--+--------------+---------+
--| Column Name  | Type    |
--+--------------+---------+
--| invoice_id   | int     |
--| price        | int     |
--| user_id      | int     |
--+--------------+---------+
--invoice_id is the primary key for this table.
--Each row of this table indicates that user_id has an invoice with invoice_id and a price.

--Write an SQL query to find the following for each invoice_id:

--customer_name: The name of the customer the invoice is related to.
--price: The price of the invoice.
--contacts_cnt: The number of contacts related to the customer.
--trusted_contacts_cnt: The number of contacts related to the customer and at the same time they are customers to the shop. (i.e His/Her email exists in the Customers table.)
--Order the result table by invoice_id.

--The query result format is in the following example:

--Customers table:
--+-------------+---------------+--------------------+
--| customer_id | customer_name | email              |
--+-------------+---------------+--------------------+
--| 1           | Alice         | alice@leetcode.com |
--| 2           | Bob           | bob@leetcode.com   |
--| 13          | John          | john@leetcode.com  |
--| 6           | Alex          | alex@leetcode.com  |
--+-------------+---------------+--------------------+

--Contacts table:
--+-------------+--------------+--------------------+
--| user_id     | contact_name | contact_email      |
--+-------------+--------------+--------------------+
--| 1           | Bob          | bob@leetcode.com   |
--| 1           | John         | john@leetcode.com  |
--| 1           | Jal          | jal@leetcode.com   |
--| 2           | Omar         | omar@leetcode.com  |
--| 2           | Meir         | meir@leetcode.com  |
--| 6           | Alice        | alice@leetcode.com |
--+-------------+--------------+--------------------+

--Invoices table:
--+------------+-------+---------+
--| invoice_id | price | user_id |
--+------------+-------+---------+
--| 77         | 100   | 1       |
--| 88         | 200   | 1       |
--| 99         | 300   | 2       |
--| 66         | 400   | 2       |
--| 55         | 500   | 13      |
--| 44         | 60    | 6       |
--+------------+-------+---------+

--Result table:
--+------------+---------------+-------+--------------+----------------------+
--| invoice_id | customer_name | price | contacts_cnt | trusted_contacts_cnt |
--+------------+---------------+-------+--------------+----------------------+
--| 44         | Alex          | 60    | 1            | 1                    |
--| 55         | John          | 500   | 0            | 0                    |
--| 66         | Bob           | 400   | 2            | 0                    |
--| 77         | Alice         | 100   | 3            | 2                    |
--| 88         | Alice         | 200   | 3            | 2                    |
--| 99         | Bob           | 300   | 2            | 0                    |
--+------------+---------------+-------+--------------+----------------------+
--Alice has three contacts, two of them are trusted contacts (Bob and John).
--Bob has two contacts, none of them is a trusted contact.
--Alex has one contact and it is a trusted contact (Alice).
--John doesn't have any contacts.

-- Solution
SELECT
	invoice_id,
	customer_name,
	price,
	contacts_cnt,
	trusted_contacts_cnt
FROM
(
	SELECT
		cust.customer_id,
		cust.customer_name,
		COUNT(user_id) contacts_cnt,
		COUNT(cust_trust.email) trusted_contacts_cnt
	FROM
		customers_trusted_contracts cust LEFT JOIN contacts_trusted_contracts cont
	ON
		cust.customer_id = cont.user_id
	LEFT JOIN 
		 customers_trusted_contracts cust_trust
	ON
		cont.contact_email = cust_trust.email
	GROUP BY
		cust.customer_id, cust.customer_name 
) as contracts JOIN invoices_trusted_contracts invoice
ON
	contracts.customer_id = invoice.user_id;