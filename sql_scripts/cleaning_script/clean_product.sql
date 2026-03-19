SELECT * FROM products;


-- Check for duplicate product records
SELECT
    COUNT(DISTINCT product_id) AS unique_products,
    COUNT(product_id) AS total_products,
    COUNT(product_id) - COUNT(DISTINCT product_id) AS duplicate_products
FROM products;


-- Check NULL values across all columns
SELECT
    COUNT(CASE WHEN product_id IS NULL THEN 1 END) AS product_id_nulls,
    COUNT(CASE WHEN product_category_name IS NULL THEN 1 END) AS product_category_name_nulls,
    COUNT(CASE WHEN product_name_length IS NULL THEN 1 END) AS product_name_length_nulls,
    COUNT(CASE WHEN product_description_length IS NULL THEN 1 END) AS product_description_length_nulls,
    COUNT(CASE WHEN product_photos_qty IS NULL THEN 1 END) AS product_photos_qty_nulls,
    COUNT(CASE WHEN product_weight_g IS NULL THEN 1 END) AS product_weight_nulls,
    COUNT(CASE WHEN product_length_cm IS NULL THEN 1 END) AS product_length_nulls,
    COUNT(CASE WHEN product_height_cm IS NULL THEN 1 END) AS product_height_nulls,
    COUNT(CASE WHEN product_width_cm IS NULL THEN 1 END) AS product_width_nulls
FROM products;


-- Identify products with missing category
SELECT
    product_id,
    product_category_name
FROM products
WHERE product_category_name IS NULL;


-- Count products with missing category
SELECT
    COUNT(*) AS missing_product_categories
FROM products
WHERE product_category_name IS NULL;


-- Check if the same rows are missing all product metadata
SELECT
    COUNT(*) AS rows_missing_all_metadata
FROM products
WHERE product_category_name IS NULL
AND product_name_length IS NULL
AND product_description_length IS NULL
AND product_photos_qty IS NULL;


-- Replace missing product categories
UPDATE products
SET product_category_name = 'unknown'
WHERE product_category_name IS NULL;


-- Replace missing product photo quantities
UPDATE products
SET product_photos_qty = 0
WHERE product_photos_qty IS NULL;

SET SQL_SAFE_UPDATES = 1;



