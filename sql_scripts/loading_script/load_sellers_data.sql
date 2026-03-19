LOAD DATA INFILE 
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_ecommerce_data/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;