-- Preview customers table
SELECT *
FROM customers;



-- Compare total rows with distinct customer IDs
SELECT
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(customer_id) AS total_customers,
    COUNT(customer_id) - COUNT(DISTINCT customer_id) AS duplicate_customers
FROM customers;

-- Identify duplicated customer records
SELECT
    customer_id,
    COUNT(customer_id) AS customer_count
FROM customers
GROUP BY customer_id
HAVING COUNT(customer_id) > 1;

-- Preview standardized city and state formatting
SELECT
    LOWER(TRIM(customer_city)) AS clean_customer_city,
    UPPER(TRIM(customer_state)) AS clean_customer_state
FROM customers;

-- Check for invalid ZIP code prefixes
SELECT
    customer_zip_code_prefix,
    LENGTH(customer_zip_code_prefix) AS zip_code_length
FROM customers
WHERE LENGTH(customer_zip_code_prefix) <> 5;