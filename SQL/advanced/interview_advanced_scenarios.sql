-- 1.	Employee Reporting Hierarchy:
-- Your manager asks you to create a report showing each employee and their direct reports.
-- Use a recursive query to list all employees from the employees table, along with their direct reports.

WITH RECURSIVE employeeHierarchy AS (
    -- Anchor member: select top-level employees (e.g., employees managed by a specific manager)
    SELECT employee_id, manager_id, employee_name
    FROM employee_table
    WHERE manager_id = 1  -- Assuming 1 is the ID of the top-level manager

    UNION ALL

    -- Recursive member: find employees who report to the previous level
    SELECT e.employee_id, e.manager_id, e.employee_name
    FROM employee_table e
    INNER JOIN employeeHierarchy eh ON e.manager_id = eh.employee_id
)

SELECT * FROM employeeHierarchy;


-- 2.	Running Total:
-- The finance department wants to see the running total of sales over the last year.
-- Write a SQL query to calculate a running total of sales from the sales table.

SELECT order_id
	,sales_amount
	,SUM(sales_amount) OVER(ORDER BY order_date) AS "Running Total Sales"
FROM sales_table
WHERE order_date >= DATE_TRUNC('YEAR', NOW() - INTERVAL '1 YEAR') AND order_date < DATE_TRUNC('YEAR', NOW())
ORDER BY order_date


-- 3.	Sales by Region:
-- Your company operates in multiple regions, and you’ve been asked to summarize total sales by region for the last quarter.
-- Write a SQL query to achieve this.

SELECT region
	,SUM(sales_amount) AS "Total Sales"
FROM sales_table
WHERE order_date >= DATE_TRUNC('quarter', NOW() - INTERVAL '1 quarter') AND order_date < DATE_TRUNC('quarter', NOW())
GROUP BY region
ORDER BY "Total Sales" DESC;


-- 4.	Customer Retention Rate:
-- The marketing team wants to know the customer retention rate for the last year.
-- Write a SQL query to calculate how many customers have made repeat purchases.

WITH repeat_customers AS (
    SELECT customer_id
        ,COUNT(order_id) AS "purchase_count"
    FROM customer_table
    WHERE order_date >= DATE_TRUNC('year', NOW() - INTERVAL '1 year') 
      AND order_date < DATE_TRUNC('year', NOW())
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
)

SELECT 
    (COUNT(DISTINCT rc.customer_id) * 100.0 / COUNT(DISTINCT c.customer_id)) AS "Customer Retention Rate"
FROM customer_table c
LEFT JOIN repeat_customers rc
ON c.customer_id = rc.customer_id
WHERE order_date >= DATE_TRUNC('year', NOW() - INTERVAL '1 year') 
  AND order_date < DATE_TRUNC('year', NOW());
