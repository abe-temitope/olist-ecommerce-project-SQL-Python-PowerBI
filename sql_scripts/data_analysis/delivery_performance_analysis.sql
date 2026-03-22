-- Average timestamps
SELECT
	CONCAT( ROUND( AVG( timestampdiff( DAY, order_approved_at, order_delivered_customer_date)), 0)," ", "Days") AS avg_delivery_date,
    CONCAT( ROUND( AVG( timestampdiff( DAY, order_approved_at, order_delivered_carrier_date)), 0)," ", "Days") AS avg_carrier_delivery_date,
    CONCAT( ROUND( AVG( timestampdiff( DAY, order_approved_at, order_estimated_delivery_date)), 0)," ", "Days") AS avg_estimate_delivery_date
FROM orders
WHERE order_approved_at IS NOT NULL
AND order_delivered_customer_date IS NOT NULL
AND order_estimated_delivery_date IS NOT NULL
AND order_delivered_customer_date >= order_approved_at
AND order_delivered_carrier_date >= order_approved_at;