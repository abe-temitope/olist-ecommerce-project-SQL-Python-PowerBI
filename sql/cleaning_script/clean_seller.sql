-- Inspect table
SELECT * FROM sellers LIMIT 5;


-- Check for duplicate
SELECT
COUNT(DISTINCT seller_id) AS unique_seller,
COUNT(seller_id) AS total_seller,
COUNT(seller_id) - COUNT(DISTINCT seller_id) AS duplicate_seller_id
FROM sellers;


-- Null columns
SELECT
    COUNT(CASE WHEN seller_id IS NULL THEN 1 END) AS seller_id_nulls,
    COUNT(CASE WHEN seller_zip_code_prefix IS NULL THEN 1 END) AS zip_code_nulls,
    COUNT(CASE WHEN seller_city IS NULL THEN 1 END) AS seller_city_nulls,
    COUNT(CASE WHEN seller_state IS NULL THEN 1 END) AS seller_state_nulls
FROM sellers;