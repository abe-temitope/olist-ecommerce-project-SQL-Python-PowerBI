/*
Geographic Revenue Analysis by State
Goal: Identify which states contribute the most revenue and order volume
Tables Used: orders, order_items, customers
*/

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    CONCAT(ROUND(SUM(oi.price) * 100.0 / SUM(SUM(oi.price)) OVER (), 2), '%') AS revenue_percentage
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN customers c 
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;