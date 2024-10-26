-- customer_info table detail:
-- no of rows: 5000; columns & sample data: {
--   "customer_id": "BB112",
--   "customer_name": "Ramdin Verma",
--   "birth_date": "1966-04-08 00:00:00",
--   "marital_status": "M",
--   "annual_income": " ? 30,41,590.00 ",
--   "total_children": "2",
--   "education_level": "Bachelors",
--   "occupation": "Professional",
--   "home_owner": true
-- };


-- 1.	Customer Data Retrieval: 
-- You are a data analyst at an e-commerce company.
-- You’ve been asked to extract unique customer id,
-- name and annual income of the top 10 earners from the customers info table, 
-- in a decreasing of their annual salary,  for a marketing campaign.
-- Write the SQL query to achieve this.


SELECT DISTINCT customer_id AS "Customer ID"
                ,customer_name AS "Customer Name"
                ,annual_income AS "Annual Income"
FROM customer_info
ORDER BY annual_income DESC
LIMIT 10

-- 2.	Customer Job Title:
-- The HR department has asked you to find all customers with the occupation "Management"
-- from the customer_info table for a leadership training program.

SELECT *
FROM customer_info
WHERE occupation = 'Management'


-- 3.	Recent Customer Registrations:
-- How would you query the customer_info table to retrieve the names
-- and day of birth of all customers born in the month of April, in order
-- to organize an office birthday event for them?

SELECT customer_name
       ,EXTRACT(DAY FROM birth_date) AS "Birth Day"
FROM customer_info
WHERE EXTRACT(MONTH FROM birth_date) = 4;

-- OR

-- SELECT customer_name
--         ,DATE_PART('DAY', birth_date) AS "Birth Day"
-- FROM customer_info
-- WHERE DATE_PART('MONTH', birth_date) = 4
-- ORDER BY "Birth Day"



-- 4.	Customer Availability Check: 
-- Background: Your inventory team has approached you with
-- a request regarding customer availability. They need to confirm the existence of a specific customer
-- in the customer_info table for inventory planning purposes.

-- Task: Please write an SQL query to check the availability of the customer with the ID BB563.
-- Return a user friendly message if it does not exist.

CREATE OR REPLACE FUNCTION check_customer_id_exists(id VARCHAR)
RETURNS TEXT AS $$
DECLARE customer_exists BOOLEAN;
BEGIN
	SELECT EXISTS (
		SELECT 1 FROM customer_info WHERE customer_id = id
	) INTO customer_exists;

	IF NOT customer_exists THEN
		RETURN 'Customer with ID ' || id || ' does not exist.';
	ELSE
		RETURN 'Customer with ID ' || id || ' exist.';
	END IF;
END;
$$ LANGUAGE plpgsql;


-- SELECT check_customer_id_exists('BB333422');
SELECT check_customer_exists('BB333')

-- 5. Order Discount Calculation: 
-- Write a routine that takes an order_id, retrieves the total order amount,
-- and applies a discount based on customer loyalty, returning the final discounted amount.

CREATE OR REPLACE FUNCTION order_discount_calculator(id VARCHAR)
RETURNS INT AS $$
DECLARE
		discount_amt INT;
		total_order_amt FLOAT;
		customer_loyalty VARCHAR;
BEGIN
		SELECT total_order_amt, customer_loyalty
		INTO total_order_amt, customer_loyalty
		FROM customer_table WHERE order_id = id;

		discount_amt:= CASE 
			WHEN customer_loyalty = 'L1' then total_order_amt * 0.1
			WHEN customer_loyalty = 'L2' then total_order_amt * 0.2
			WHEN customer_loyalty = 'L3' then total_order_amt * 0.3
			WHEN customer_loyalty = 'L4' then total_order_amt * 0.4
			ELSE 0
		END AS discount_amt;

		RETURN (total_order_amt - discount_amt) AS 'Total Discounted Amount';
END;

$$ LANGUAGE plpgsql;

SELECT order_discount_calculator('order123')


-- 6. Inventory Stock Check:
-- Write code to check if an item is in stock based on item_id
-- and return a message indicating whether it’s available or out of stock.

CREATE OR REPLACE FUNCTION inventory_stock_checker(id_ VARCHAR)
RETURNS TEXT AS $$
DECLARE 
		stock BOOLEAN;
BEGIN
		SELECT EXISTS (
			SELECT 1 FROM stock_table WHERE item_id = id_
		) INTO stock;

		IF NOT stock THEN
			RETURN 'Item with ID ' || id_ || ' is out of stock.';
		ELSE
			RETURN 'Item with ID ' || id_ || ' is available in stock.';
		END IF;
END;
$$ LANGUAGE plpgsql;

SELECT inventory_stock_checker('ABC123');

-- 7. Order Status Query:
-- Write code to fetch and return the current status of an order based on order_id,
-- returning values such as "Pending", "Shipped", or "Delivered."

CREATE OR REPLACE FUNCTION order_status(id_ VARCHAR)
RETURNS TEXT AS $$
DECLARE
		current_status VARCHAR;
BEGIN
		SELECT  status
		INTO current_status
		FROM order_table
		WHERE order_id = id_;
		
		current_status:= CASE
			WHEN status = 'Pending' THEN 'Pending'
			WHEN status = 'Shipped' THEN 'Shipped'
			WHEN status = 'Delivered' THEN 'Delivered'
			ELSE 'Unknown Status'
		END;
		
		RETURN 'current_status';
END;
$$ LANGUAGE plpgsql;

SELECT order_status('order123')

-- 9.	Order Filtering: You need to generate a report of all orders placed in the last 30 days
-- from the orders table to track current sales. Write the SQL query.

CREATE OR REPLACE FUNCTION recent_orders()
RETURNS TABLE(order_id INT, customer_id INT, order_date TIMESTAMP, total_amount FLOAT) AS $$
BEGIN
	RETURN QUERY
		SELECT *
		FROM order_table
		WHERE order_date BETWEEN NOW() - INTERVAL '30 days' AND NOW();
END;
$$ LANGUAGE plpgsql;

SELECT recent_orders();


-- 10.	Sales Summary: 
-- The sales team has asked you to calculate the total sales amount
-- from the sales table for the previous quarter. Write a SQL query to calculate this.

SELECT sum(total_sales) AS 'Total Sales AMount'
FROM sales_table
WHERE order_date BETWEEN date_trunc('quarter', NOW() - INTERVAL '1 quarter') AND date_trunc('quarter', NOW())

-- 11.	Regional Customers: 
-- The marketing department wants to send a targeted email to customers in New York.
-- Write a query to retrieve all customers located in "New York" from the customers table.

SELECT customer_id
		,customer_name
		,email
FROM customer_info
WHERE region = 'New York';


-- 12.	Top Selling Products: 
-- Your manager wants to identify the top 5 selling products by revenue.
-- Write a SQL query to extract this information from the sales table.
SELECT product_id
		,product_name
		,revenue
FROM sales_table
ORDER BY revenue DESC
LIMIT 5

OR

SELECT product_id
		,product_name
		,SUM(quantity * unit_price) AS 'Revenue'
FROM sales_table
ORDER BY revenue DESC
LIMIT 5
