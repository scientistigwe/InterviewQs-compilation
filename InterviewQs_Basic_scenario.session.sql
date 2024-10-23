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