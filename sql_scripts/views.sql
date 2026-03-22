CREATE VIEW vw_revenue_by_state AS
SELECT
    c.customer_state,
    SUM(oi.price) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state;


CREATE VIEW vw_customer_summary AS
SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue,
    IF(COUNT(o.order_id) = 1, 'One Time', 'Repeat') AS customer_status
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id;



SELECT * FROM vw_revenue_by_state;
SELECT * FROM vw_revenue_by_state;


-- Check all views in database
SHOW FULL TABLES WHERE table_type = 'VIEW';