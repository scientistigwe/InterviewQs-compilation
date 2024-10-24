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




-- 1.	Customer Availability Check: Your inventory team has requested a check on the availability of a customer with the ID 102 in the customer_info table.