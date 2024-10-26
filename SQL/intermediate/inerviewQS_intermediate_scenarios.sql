-- 1.	Average Order Value:
-- Your manager wants to understand the average value of orders placed in the last year.
-- Write a SQL query to calculate the average order value from the orders table.
SELECT SUM(order_amount) / COUNT(*) AS "Average Order Value"
FROM order_table
WHERE order_date >= DATE_TRUNC('year', NOW() - INTERVAL '1 year') and order_date < DATE_TRUNC('year', NOW());


-- 2.	Product Categories: 
-- The product team has asked for a list of all unique product categories in the products table.
-- Write a query to find this.
SELECT DISTINCT product_category
FROM product_table;


-- 3.	Employee-Department Join:
-- You’ve been asked to produce a list of employees along with their department names.
-- Join the employees and departments tables to create this report.
SELECT e.employee_id
		,e.employee_name
		,d.department
FROM employee_table e
INNER JOIN department_table d
ON e.employee_id = d.employee_id


-- 4.	Product Sales Count:
-- The sales department wants to know how many times each product has been sold.
-- Write a SQL query to find the number of sales for each product from the sales table.
SELECT product_name
	,COUNT(product_id) AS "Sales Count"
FROM sales_table
GROUP BY product_name
ORDER BY product_name DESC;


-- 5.	Monthly Sales Summary:
-- You’ve been asked to create a report summarizing total sales for each month in the past year. 
-- Write a SQL query to group and summarize the sales from the sales table by month.

SELECT DATE_PART('month', sales_date) AS "Month of Sale"
		,SUM(quantity * unit_price) AS "Total Sales"
FROM sales_table
WHERE sales_date >= DATE_TRUNC('year', NOW() - INTERVAL '1 year') AND sales_date < DATE_TRUNC('year', NOW());
GROUP BY DATE_PART('month', sales_date)
ORDER BY DATE_PART('month', sales_date) ASC;


-- 6.	Customer Order Report:
-- Your manager asks for a list of customers along with the total number of orders they’ve placed. 
-- Write a SQL query to generate this report.

SELECT c.customer_id
		,c.customer_name
		,COUNT(o.order_id) AS "Total Order"
FROM customer_info c
JOIN order_table o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY c.customer_name ASC;


-- 7.	High Earning Employees:
-- HR wants to know which employees earn more than the average salary in the company.
-- Write a query to find employees whose salary is above the average from the employees table.
CREATE OR REPLACE FUNCTION average_salary()
RETURNS NUMERIC AS $$
DECLARE avg_salary NUMERIC;
BEGIN
	SELECT AVG(
			CAST(
				REGEXP_REPLACE(annual_income, '[^0-9]', '', 'g') AS NUMERIC
			)
			) INTO avg_salary 
	FROM employee_table;

	RETURN avg_salary;
		
END;
$$ LANGUAGE plpgsql;

SELECT employee_id
	,employee_name
		,CAST(
			REGEXP_REPLACE(
				annual_income, '[^0-9]', '', 'g'
			) AS NUMERIC
		) AS "Annual Income"
FROM employee_table
WHERE CAST(
			REGEXP_REPLACE(
				annual_income, '[^0-9]', '', 'g'
			) AS NUMERIC
		) > average_salary()
ORDER BY "Average Salary" DESC;

-- 8.	Expired Promotions:
-- The marketing team wants a list of all expired promotions in the promotions table.
-- Write a SQL query to find promotions with an end date in the past.
SELECT promotion_id AS "Expired Promotions ID"
		,promotion_date
FROM promotion_table
WHERE promotion_date < NOW();


-- 9.	Top Customers: You’ve been asked to identify the top 3 customers by total order amount. 
-- Write a SQL query to retrieve the customers from the orders table.
SELECT customer_id
	,customer_name
	,SUM(order_amount) AS "Total Order Amount"
FROM order_table
GROUP BY customer_id, customer_name
ORDER BY "Total Order Amount" DESC
LIMIT 3;


-- 10.	Low Stock Products: 
-- The inventory team wants to know which products have stock levels below 10.
	-- Write a SQL query to find these products from the inventory table.

SELECT product_id
		,product_name
FROM stock_table
WHERE stock_level < 10
ORDER BY stock_level ASC;