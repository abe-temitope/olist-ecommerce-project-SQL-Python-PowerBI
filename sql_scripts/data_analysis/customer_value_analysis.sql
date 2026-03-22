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
Analysis: Average Order Value (AOV)
Goal: Calculate total orders, total revenue, and average order value
Tables Used: orders, order_items
*/
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';


/*
Analysis: Customer Lifetime Value (Basic)
Goal: Identify top customers based on total revenue and order count
Tables Used: orders, order_items, customers
*/
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN customers c 
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
ORDER BY total_revenue DESC
LIMIT 10;


/*
Analysis: Repeat vs One-Time Customers
Goal: Identify customer retention by classifying customers based on order frequency
*/
SELECT
    customer_status,
    COUNT(*) AS total_customers
FROM (
    SELECT
        c.customer_unique_id AS customer_id,
        COUNT(o.order_id) AS total_orders,
        IF(COUNT(o.order_id) = 1, 'One Time', 'Repeat') AS customer_status
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
) AS customer_summary
GROUP BY customer_status;


/*
Analysis: Customers Status Distribution
Goal: Identify customer revnue distribution by classifying customers based on order frequency
*/
SELECT
	customer_status,
    COUNT(*) AS total_orders,
    SUM(total_revenue)
FROM
	(SELECT
		c.customer_unique_id,
		COUNT(o.order_id) AS total_orders,
		SUM(oi.price) total_revenue,
		IF(COUNT(o.order_id) = 1, 'One Time', 'Repeat') AS customer_status
	FROM customers c
	JOIN orders o 
		ON c.customer_id = o.customer_id
	JOIN order_items oi
		ON o.order_id = oi.order_id
	WHERE o.order_status = 'delivered'
	GROUP BY c.customer_unique_id
    ) AS customer_summary
GROUP BY customer_status;
