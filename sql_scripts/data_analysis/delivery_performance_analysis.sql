/*
Delivery Performance Analysis
Goal: Evaluate delivery efficiency, delays, and overall logistics performance
Tables Used: orders
Notes:
- Only delivered orders are considered
- NULL values are excluded to ensure accurate calculations
*/


/*
1. Average Delivery Time
Goal: Measure average time taken from approval to delivery and compare with estimated timelines
*/
SELECT
    ROUND(AVG(TIMESTAMPDIFF(DAY, order_approved_at, order_delivered_customer_date)), 0) AS avg_delivery_days,
    ROUND(AVG(TIMESTAMPDIFF(DAY, order_approved_at, order_delivered_carrier_date)), 0) AS avg_carrier_days,
    ROUND(AVG(TIMESTAMPDIFF(DAY, order_approved_at, order_estimated_delivery_date)), 0) AS avg_estimated_days
FROM orders
WHERE order_status = 'delivered'
AND order_approved_at IS NOT NULL
AND order_delivered_customer_date IS NOT NULL
AND order_estimated_delivery_date IS NOT NULL
AND order_delivered_customer_date >= order_approved_at
AND order_delivered_carrier_date >= order_approved_at;


/*
2. On-Time vs Late Delivery
Goal: Classify deliveries based on whether they met the estimated delivery date
*/
SELECT
    CASE 
        WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status,
    COUNT(*) AS total_orders,
    CONCAT(ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()), '%') AS delivery_percentage
FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
AND order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_status;


/*
3. Late Delivery Rate (%)
Goal: Measure percentage of delayed deliveries (Key Performance Indicator)
*/
SELECT
    ROUND(
        SUM(CASE 
                WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 
                ELSE 0 
            END) * 100.0 / COUNT(*), 
    2) AS late_delivery_percentage
FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
AND order_estimated_delivery_date IS NOT NULL;


/*
4. Average Delay Duration
Goal: Measure how late delayed orders are (in days)
*/
SELECT
    ROUND(AVG(TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)), 0) AS avg_delay_days
FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date > order_estimated_delivery_date;


/*
5. Delivery Performance by State
Goal: Identify regions with faster or slower delivery performance
Tables Used: orders, customers
*/
SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(TIMESTAMPDIFF(DAY, o.order_approved_at, o.order_delivered_customer_date)), 0) AS avg_delivery_days
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
AND o.order_approved_at IS NOT NULL
AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;


/*
6. Delivery Speed Distribution
Goal: Categorize deliveries based on speed to understand customer experience
*/
SELECT
    CASE
        WHEN TIMESTAMPDIFF(DAY, order_approved_at, order_delivered_customer_date) = 0 THEN 'Same Day'
        WHEN TIMESTAMPDIFF(DAY, order_approved_at, order_delivered_customer_date) BETWEEN 1 AND 3 THEN '1-3 Days'
        WHEN TIMESTAMPDIFF(DAY, order_approved_at, order_delivered_customer_date) BETWEEN 4 AND 7 THEN '4-7 Days'
        ELSE '8+ Days'
    END AS delivery_speed,
    COUNT(*) AS total_orders
FROM orders
WHERE order_status = 'delivered'
AND order_approved_at IS NOT NULL
AND order_delivered_customer_date IS NOT NULL
GROUP BY delivery_speed
ORDER BY total_orders DESC;