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
    