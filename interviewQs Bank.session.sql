-- CREATE OR REPLACE FUNCTION check_customer_id_exists(id VARCHAR)
-- RETURNS TEXT AS $$
-- DECLARE customer_exists BOOLEAN;
-- BEGIN
-- 	SELECT EXISTS (
-- 		SELECT 1 FROM customer_info WHERE customer_id = id
-- 	) INTO customer_exists;

-- 	IF NOT customer_exists THEN
-- 		RETURN 'Customer with ID ' || id || ' does not exist.';
-- 	ELSE
-- 		RETURN 'Customer with ID ' || id || ' exist.';
-- 	END IF;
-- END;
-- $$ LANGUAGE plpgsql;


-- SELECT check_customer_id_exists('BB333422');
SELECT check_customer_exists('BB333')
