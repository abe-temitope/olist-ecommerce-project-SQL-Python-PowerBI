-- Inspect table
SELECT * FROM orders LIMIT 5;


-- Check for duplicate
SELECT
COUNT(DISTINCT order_id) AS unique_orders,
COUNT(order_id) AS total_orders,
COUNT(order_id) - COUNT(DISTINCT order_id) AS duplicate_orders
FROM orders;


-- Duplicate order_id
SELECT
	order_id,
	COUNT(*) AS order_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Order status distribution
SELECT
	order_status,
    COUNT(*) AS total_count,
    CONCAT(ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2), '%') AS percentage
FROM orders
GROUP BY order_status
ORDER BY total_count DESC;


-- Null columns
SELECT
    COUNT(CASE WHEN order_id IS NULL THEN 1 END) AS order_id_nulls,
    COUNT(CASE WHEN customer_id IS NULL THEN 1 END) AS customer_id_nulls,
    COUNT(CASE WHEN order_status IS NULL THEN 1 END) AS order_status_nulls,
    COUNT(CASE WHEN order_purchase_timestamp IS NULL THEN 1 END) AS order_purchase_timestamp_nulls,
    COUNT(CASE WHEN order_approved_at IS NULL THEN 1 END) AS order_approved_at_nulls,
    COUNT(CASE WHEN order_delivered_carrier_date IS NULL THEN 1 END) AS order_delivered_carrier_date_nulls,
    COUNT(CASE WHEN order_delivered_customer_date IS NULL THEN 1 END) AS order_delivered_customer_date_nulls,
    COUNT(CASE WHEN order_estimated_delivery_date IS NULL THEN 1 END) AS order_estimate_delivery_date_nulls
FROM orders;


-- Analysis years
SELECT YEAR(MIN(order_purchase_timestamp)) AS first_analysis_year,
       YEAR(MAX(order_purchase_timestamp)) AS last_analysis_year,
       TIMESTAMPDIFF(YEAR, MIN(order_purchase_timestamp), MAX(order_purchase_timestamp)) AS total_years
FROM orders;


-- Average timestamps
SELECT
	CONCAT( ROUND( AVG( timestampdiff( DAY, order_approved_at, order_delivered_customer_date)), 0)," ", "Days") AS avg_delivery_date,
    CONCAT( ROUND( AVG( timestampdiff( DAY, order_approved_at, order_delivered_carrier_date)), 0)," ", "Days") AS avg_carrier_delivery_date,
    CONCAT( ROUND( AVG( timestampdiff( DAY, order_approved_at, order_estimated_delivery_date)), 0)," ", "Days") AS avg_estimate_delivery_date
FROM orders
WHERE order_approved_at IS NOT NULL
AND order_delivered_customer_date IS NOT NULL
AND order_estimated_delivery_date IS NOT NULL
AND order_delivered_customer_date >= order_approved_at
AND order_delivered_carrier_date >= order_approved_at;