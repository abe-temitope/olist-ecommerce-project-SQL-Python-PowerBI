DELIMITER //

CREATE PROCEDURE GetOrderCountByYear(IN target_year INT, IN target_month INT)
BEGIN
    SELECT COUNT(*) AS total_orders
    FROM orders
    WHERE YEAR(order_purchase_timestamp) = target_year
    AND MONTH(order_purchase_timestamp) = target_month;
END //

DELIMITER ;


CALL GetOrderCountByYear(2018, 2);