CREATE VIEW vw_delivered_orders_summary AS
SELECT 
    o.order_id, 
    o.customer_id, 
    o.order_status,
    SUM(oi.price) AS total_revenue,
    SUM(oi.freight_value) AS total_freight
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY o.order_id, o.customer_id, o.order_status;


