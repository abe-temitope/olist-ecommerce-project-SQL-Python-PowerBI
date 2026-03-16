-- Inspect table
SELECT * FROM order_items LIMIT 5;

SELECT
	*,
    price + freight_value AS total_payment
FROM order_items LIMIT 5;


-- Null columns
SELECT
    COUNT(CASE WHEN order_id IS NULL THEN 1 END) AS order_id_nulls,
    COUNT(CASE WHEN order_item_id IS NULL THEN 1 END) AS order_item_id_nulls,
    COUNT(CASE WHEN product_id IS NULL THEN 1 END) AS product_id_nulls,
    COUNT(CASE WHEN seller_id IS NULL THEN 1 END) AS seller_id_nulls,
    COUNT(CASE WHEN shipping_limit_date IS NULL THEN 1 END) AS shippong_limit_date_nulls,
    COUNT(CASE WHEN price IS NULL THEN 1 END) AS price_nulls,
    COUNT(CASE WHEN freight_value IS NULL THEN 1 END) AS freight_value_nulls
FROM order_items;


-- Negative prices
SELECT
	order_id,
	price,
    freight_value
FROM order_items
WHERE price < 0
OR freight_value < 0;
