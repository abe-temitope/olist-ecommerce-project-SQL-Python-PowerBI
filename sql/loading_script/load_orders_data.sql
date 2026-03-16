/*
================================================================================
OLIST E-COMMERCE PROJECT
TABLE: orders
BULK LOAD DOCUMENTATION – LOAD DATA INFILE
================================================================================

OBJECTIVE:
Load olist_orders_dataset.csv into the orders table using LOAD DATA INFILE.

-------------------------------------------------------------------------------
PROBLEM 1 – Error 1292 (Incorrect Datetime Value)
-------------------------------------------------------------------------------
Error:
    Incorrect datetime value: '' for column 'order_delivered_carrier_date'

Cause:
    The CSV file contains empty strings ("") for some datetime columns.
    MySQL strict mode does not allow '' to be inserted into DATETIME columns.
    Empty string is NOT the same as NULL.

Affected Columns:
    - order_approved_at
    - order_delivered_carrier_date
    - order_delivered_customer_date

Resolution:
1. Allow NULL in optional datetime columns:
       ALTER TABLE orders
       MODIFY order_delivered_carrier_date DATETIME NULL;

2. Convert empty strings to NULL during load using NULLIF():

       LOAD DATA INFILE 'file_path'
       INTO TABLE orders
       FIELDS TERMINATED BY ','
       ENCLOSED BY '"'
       LINES TERMINATED BY '\n'
       IGNORE 1 ROWS
       (order_id,
        customer_id,
        order_status,
        @order_purchase_timestamp,
        @order_approved_at,
        @order_delivered_carrier_date,
        @order_delivered_customer_date,
        @order_estimated_delivery_date)
       SET
       order_purchase_timestamp = NULLIF(@order_purchase_timestamp, ''),
       order_approved_at = NULLIF(@order_approved_at, ''),
       order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
       order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),
       order_estimated_delivery_date = NULLIF(@order_estimated_delivery_date, '');

-------------------------------------------------------------------------------
PROBLEM 2 – Error 1265 (Data Truncated for order_status)
-------------------------------------------------------------------------------
Error:
    Data truncated for column 'order_status'

Cause:
    Column was defined too small (e.g., VARCHAR(10)).
    Dataset contains values like 'unavailable' (11 characters).
    Strict mode prevents silent truncation.

Resolution:
    Increase column size:

       ALTER TABLE orders
       MODIFY order_status VARCHAR(20);

-------------------------------------------------------------------------------
PROBLEM 3 – Foreign Key Constraint During Reset (Error 1701)
-------------------------------------------------------------------------------
Error:
    Cannot truncate a table referenced in a foreign key constraint

Cause:
    orders.customer_id references customers.customer_id.
    TRUNCATE is blocked when foreign keys exist.

Resolution:
       (development only):
       SET FOREIGN_KEY_CHECKS = 0;
       TRUNCATE TABLE orders;
       TRUNCATE TABLE customers;
       SET FOREIGN_KEY_CHECKS = 1;

-------------------------------------------------------------------------------
KEY LESSONS LEARNED
-------------------------------------------------------------------------------
1. Empty string ('') is not NULL.
2. Optional datetime fields must allow NULL.
3. Use NULLIF() during LOAD DATA for clean ETL handling.
4. Column sizes must reflect actual dataset values.
5. Foreign keys enforce correct table load order.
6. Strict mode protects data integrity and should remain enabled.

This documentation captures all data-loading challenges encountered
while importing the orders dataset and the professional resolutions applied.
================================================================================
*/

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_ecommerce_data/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id,
 customer_id,
 order_status,
 @order_purchase_timestamp,
 @order_approved_at,
 @order_delivered_carrier_date,
 @order_delivered_customer_date,
 @order_estimated_delivery_date)
SET
order_purchase_timestamp = NULLIF(@order_purchase_timestamp, ''),
order_approved_at = NULLIF(@order_approved_at, ''),
order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),
order_estimated_delivery_date = NULLIF(@order_estimated_delivery_date, '');

