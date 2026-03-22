/*
Total Revenue
Goal: Calculate total revenue generated from delivered orders
Tables: orders, order_items
*/
SELECT
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders AS o
JOIN order_items AS oi 
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';


/*
Top Product Categories by Revenue
Goal: Identify which product categories generate the most revenue on the platform.
Tables Used: orders, order_items, products, product_category_name_translation
Notes: Only delivered orders are considered. Underscores in category names are replaced with spaces for readability.
*/
SELECT
    REPLACE(p.product_category_name, '_', ' ') AS product_category,
    REPLACE(pcnt.product_category_name_english, '_', ' ') AS english_name,
    COUNT(*) AS units_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN products p 
    ON oi.product_id = p.product_id
JOIN product_category_name_translation pcnt 
    ON pcnt.product_category_name = p.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY
    p.product_category_name,
    pcnt.product_category_name_english 
ORDER BY total_revenue DESC
LIMIT 10;

/* 
Top 10 Products by Revenue
Goal: Identify individual products generating the highest revenue.
Tables Used: orders, order_items, products, product_category_name_translation
Notes: Only delivered orders are counted. Revenue is summed per product.
*/
SELECT
    oi.product_id,
    REPLACE(p.product_category_name, '_', ' ') AS product_category,
    REPLACE(pcn.product_category_name_english, '_', ' ') AS english_name,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation pcn
    ON pcn.product_category_name = p.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY oi.product_id, p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

/* 
Top 10 Products by Units Sold
Goal: Identify the products sold in the highest quantity.
Tables Used: orders, order_items, products, product_category_name_translation
Notes: Only delivered orders are counted. Units sold is the count of order items per product.
*/
SELECT
    oi.product_id,
    REPLACE(p.product_category_name, '_', ' ') AS product_category,
    REPLACE(pcn.product_category_name_english, '_', ' ') AS english_name,
    COUNT(*) AS total_units_sold
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation pcn
    ON pcn.product_category_name = p.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY oi.product_id, p.product_category_name
ORDER BY total_units_sold DESC
LIMIT 10;

/* 
Products Never Sold
Goal: Identify products in the catalog that were never ordered.
Tables Used: products, order_items
Notes: Left join is used to find products with no matching order items.
*/
SELECT
    p.product_id,
    REPLACE(p.product_category_name, '_', ' ') AS product_category
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;