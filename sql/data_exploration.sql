
-- FIRST 5 ROW PREVIEW
SELECT * FROM customers LIMIT 5;
SELECT * FROM orders LIMIT 5;

SELECT * FROM order_payments LIMIT 5;
SELECT * FROM order_reviews LIMIT 5;
SELECT * FROM products LIMIT 5;
SELECT * FROM sellers LIMIT 5;
SELECT * FROM geolocation LIMIT 5;
SELECT * FROM product_category_name_translation LIMIT 5;


-- TOTAL ROWS PER TABLE
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_orders FROM orders;
SELECT COUNT(*) AS total_order_items FROM order_items;
SELECT COUNT(*) AS total_payments FROM order_payments;
SELECT COUNT(*) AS total_reviews FROM order_reviews;
SELECT COUNT(*) AS total_products FROM products;
SELECT COUNT(*) AS total_sellers FROM sellers;
SELECT COUNT(*) AS total_locations FROM geolocation;
SELECT COUNT(*) AS total_categories FROM product_category_name_translation;


-- CHECKING FOR MISSING VALUES
-- Customers table
SELECT COUNT(*) AS missing_customer_id FROM customers WHERE customer_id IS NULL;
-- Orders table
SELECT COUNT(*) AS missing_order_id FROM orders WHERE order_id IS NULL;
SELECT COUNT(*) AS missing_customer_id FROM orders WHERE customer_id IS NULL;
-- Order Items table
SELECT COUNT(*) AS missing_order_id FROM order_items WHERE order_id IS NULL;
SELECT COUNT(*) AS missing_product_id FROM order_items WHERE product_id IS NULL;
SELECT COUNT(*) AS missing_seller_id FROM order_items WHERE seller_id IS NULL;
-- Order Payments table
SELECT COUNT(*) AS missing_order_id FROM order_payments WHERE order_id IS NULL;
SELECT COUNT(*) AS missing_payment_type FROM order_payments WHERE payment_type IS NULL;
-- Order Reviews table
SELECT COUNT(*) AS missing_order_id FROM order_reviews WHERE order_id IS NULL;
-- Products table
SELECT COUNT(*) AS missing_product_id FROM products WHERE product_id IS NULL;
-- Sellers table
SELECT COUNT(*) AS missing_seller_id FROM sellers WHERE seller_id IS NULL;
-- Geolocation table
SELECT COUNT(*) AS missing_geolocation_id FROM geolocation WHERE geolocation_zip_code_prefix IS NULL;
-- Product Category Name Translation table
SELECT COUNT(*) AS missing_category_name FROM product_category_name_translation 
WHERE product_category_name_english IS NULL;


-- EXPLORE UNIQUE VALUES / CORDINALITY
-- Orders table: unique statuses
SELECT
	order_status,
    COUNT(*) AS total_count,
    CONCAT(ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2), '%') AS percentage
FROM orders
GROUP BY order_status
ORDER BY total_count DESC;

-- Order Payments table: total orders per payment type
SELECT
	TRIM(payment_type) AS payment_type,
    COUNT(*) AS total_orders,
    CONCAT( ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(), 2), '%') AS percentage
FROM order_payments
GROUP BY TRIM(payment_type)
ORDER BY total_orders DESC;

-- Products: unique product categories
SELECT product_category_name_english, COUNT(*) AS total_products
FROM product_category_name_translation
GROUP BY product_category_name_english
ORDER BY total_products DESC;

-- Customers table: total unique customers
SELECT COUNT(DISTINCT customer_id) AS total_unique_customers FROM customers;

-- Sellers table: total unique sellers
SELECT COUNT(DISTINCT seller_id) AS total_unique_sellers FROM sellers;

-- Products table: total unique products
SELECT COUNT(DISTINCT product_id) AS total_unique_products FROM products;

-- Order Items table: total unique orders and products
SELECT COUNT(DISTINCT order_id) AS total_unique_orders,
       COUNT(DISTINCT product_id) AS total_unique_products
FROM order_items;


SELECT MIN(price) AS min_price,
	   MAX(price) AS max_price,
       ROUND(AVG(price),2) AS avg_price
FROM order_items;


SELECT MIN(order_purchase_timestamp) AS first_order,
       MAX(order_purchase_timestamp) AS last_order
FROM orders;


SELECT YEAR(MIN(order_purchase_timestamp)) AS first_analysis_year,
       YEAR(MAX(order_purchase_timestamp)) AS last_analysis_year,
       TIMESTAMPDIFF(YEAR, MIN(order_purchase_timestamp), MAX(order_purchase_timestamp)) AS accurate_years
FROM orders;
