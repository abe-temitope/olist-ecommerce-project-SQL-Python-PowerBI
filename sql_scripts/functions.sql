DELIMITER //

CREATE FUNCTION delivery_status(delivered_date DATETIME, estimated_date DATETIME)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN (
        CASE
            WHEN delivered_date <= estimated_date THEN 'On Time'
            ELSE 'Late'
        END
    );
END //

DELIMITER ;


DELIMITER //

CREATE FUNCTION order_value_category(total_amount DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN (
        CASE
            WHEN total_amount < 100 THEN 'Low Value'
            WHEN total_amount BETWEEN 100 AND 500 THEN 'Medium Value'
            ELSE 'High Value'
        END
    );
END //

DELIMITER ;