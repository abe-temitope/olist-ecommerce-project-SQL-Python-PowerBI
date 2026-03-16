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
Total Revenue by State
Goal: Calculate revenue per state and percentage of total revenue
Tables: orders, order_items, customers
*/
SELECT
    c.customer_state AS customer_state,
    ROUND(SUM(oi.price), 2) AS total_revenue_per_state,
    concat( ROUND(SUM(oi.price) * 100.0 / SUM(SUM(oi.price)) OVER (), 2), ' ', '%') AS revenue_percentage
FROM orders AS o
JOIN order_items AS oi 
    ON o.order_id = oi.order_id
JOIN customers AS c 
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_revenue_per_state DESC;


/*
Monthly Revenue Trend
Goal: Analyze how revenue changes month by month
Tables: orders, order_items
*/

SELECT
    YEAR(o.order_purchase_timestamp) AS order_year,
    MONTHNAME(o.order_purchase_timestamp) AS order_month,
    ROUND(SUM(oi.price),2) AS revenue_by_month
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp),
    MONTHNAME(o.order_purchase_timestamp)
ORDER BY
    order_year,
    MONTH(o.order_purchase_timestamp);
    

/*
Top Product Categories by Revenue
Goal: Identify which product categories generate the most revenue
Tables: orders, order_items, products, product_category_name_translation
*/
SELECT
    replace(p.product_category_name, '_', ' ') AS product_category,
	replace(pcnt.product_category_name_english, '_', ' ') AS english_name,
    ROUND(SUM(oi.price),2) AS total_revenue
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


SELECT
p.product_id,
p.product_category_name
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;


-- Top 10 Products by Revenue
-- Goal: Identify the products that generate the highest revenue from delivered orders
SELECT
    oi.product_id,
    p.product_category_name,
    COUNT(*) AS total_units_sold,
    SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
GROUP BY oi.product_id, p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;






SELECT * FROM customers LIMIT 3;   
SELECT * FROM orders LIMIT 3;
SELECT * FROM order_items LIMIT 3; 
SELECT * FROM products LIMIT 3;
    