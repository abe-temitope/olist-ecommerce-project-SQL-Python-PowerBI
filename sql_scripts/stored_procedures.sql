DELIMITER //

CREATE PROCEDURE top_products(IN limit_number INT)
BEGIN
    SELECT
        oi.product_id,
        SUM(oi.price) AS total_revenue
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY oi.product_id
    ORDER BY total_revenue DESC
    LIMIT limit_number;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE delivery_by_state()
BEGIN
    SELECT
        c.customer_state,
        ROUND(AVG(TIMESTAMPDIFF(DAY, o.order_approved_at, o.order_delivered_customer_date)), 0) AS avg_delivery_days
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    AND o.order_approved_at IS NOT NULL
    AND o.order_delivered_customer_date IS NOT NULL
    GROUP BY c.customer_state
    ORDER BY avg_delivery_days DESC;
END //

DELIMITER ;


CALL top_products(10);
CALL delivery_by_state;