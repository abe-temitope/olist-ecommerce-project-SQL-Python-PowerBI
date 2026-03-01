LOAD DATA INFILE 
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_ecommerce_data/olist_order_payments_dataset.csv'
INTO TABLE order_payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

