-- Inspect table
SELECT * FROM order_payments LIMIT 5;


-- Payment type distribution
SELECT
	payment_type,
    COUNT(*) AS total_count,
    CONCAT(ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2), '%') AS percentage
FROM order_payments
GROUP BY payment_type
ORDER BY total_count DESC;


-- Null columns
SELECT
    COUNT(CASE WHEN order_id IS NULL THEN 1 END) AS order_id_nulls,
    COUNT(CASE WHEN payment_sequential IS NULL THEN 1 END) AS payment_sequencial_nulls,
    COUNT(CASE WHEN payment_type IS NULL THEN 1 END) AS payment_card_nulls,
    COUNT(CASE WHEN payment_installments IS NULL THEN 1 END) AS payment_installments_nulls,
    COUNT(CASE WHEN payment_value IS NULL THEN 1 END) AS payment_value_nulls
FROM order_payments;


-- installments distribution
SELECT
	payment_installments,
    COUNT(*) AS installment_count
FROM order_payments
GROUP BY payment_installments
ORDER BY installment_count DESC;


-- Negative payments
SELECT
	order_id,
	payment_value
FROM order_payments
WHERE payment_value < 0;