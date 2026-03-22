/*
Top Sellers by Revenue
Goal: Identify sellers generating the highest revenue
Tables Used: sellers, order_items, orders
*/
SELECT
    s.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(*) AS total_units_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM sellers s
JOIN order_items oi 
    ON s.seller_id = oi.seller_id
JOIN orders o 
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id
ORDER BY total_revenue DESC
LIMIT 10;


/*
Top Sellers by Units Sold
Goal: Identify sellers handling the highest sales volume
*/
SELECT
    s.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(*) AS total_units_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM sellers s
JOIN order_items oi 
    ON s.seller_id = oi.seller_id
JOIN orders o 
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id
ORDER BY total_units_sold DESC
LIMIT 10;



/*
Seller Average Order Value (AOV)
Goal: Identify sellers selling high-value vs low-value orders
Tables Used: sellers, order_items, orders
*/

SELECT
    s.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(*) AS total_units_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM sellers s
JOIN order_items oi 
    ON s.seller_id = oi.seller_id
JOIN orders o 
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id
ORDER BY avg_order_value DESC
LIMIT 10;