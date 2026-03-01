/* 
===========================================================
SOLUTION TO CSV LOAD ERRORS (Error 1292 / 1366)

Problem:
- LOAD DATA INFILE failed due to:
    1. Truncated incorrect INTEGER value: ' '
    2. Incorrect integer value errors
- Root cause:
    - Hidden carriage returns (\r)
    - Spaces (' ')
    - Empty strings in numeric columns
    - MySQL strict mode rejecting invalid numeric conversions

Solution Strategy:
1. Load raw data into a staging table (all columns as VARCHAR).
2. Clean data using TRIM() and REPLACE().
3. Convert empty strings to NULL using NULLIF().
4. CAST cleaned values into proper numeric types.
===========================================================
*/


/* --------------------------------------------------------
STEP 1: Create staging table (all columns as VARCHAR)
-------------------------------------------------------- */

CREATE TABLE products_stage (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_length VARCHAR(10),
    product_description_length VARCHAR(10),
    product_photos_qty VARCHAR(10),
    product_weight_g VARCHAR(20),
    product_length_cm VARCHAR(10),
    product_height_cm VARCHAR(10),
    product_width_cm VARCHAR(10)
);


/* --------------------------------------------------------
STEP 2: Load raw CSV into staging table
- No casting here
- Prevents load failure due to bad numeric values
-------------------------------------------------------- */

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv'
INTO TABLE products_stage
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


/* --------------------------------------------------------
STEP 3: Clean and insert into final products table
- Remove carriage returns using REPLACE('\r','')
- Remove extra spaces using TRIM()
- Convert empty strings to NULL using NULLIF()
- Cast to correct numeric types
-------------------------------------------------------- */

INSERT INTO products
(
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
SELECT
    product_id,
    NULLIF(TRIM(REPLACE(product_category_name, '\r', '')), ''),
    CAST(NULLIF(TRIM(REPLACE(product_name_length, '\r', '')), '') AS SIGNED),
    CAST(NULLIF(TRIM(REPLACE(product_description_length, '\r', '')), '') AS SIGNED),
    CAST(NULLIF(TRIM(REPLACE(product_photos_qty, '\r', '')), '') AS SIGNED),
    CAST(NULLIF(TRIM(REPLACE(product_weight_g, '\r', '')), '') AS DECIMAL(10,2)),
    CAST(NULLIF(TRIM(REPLACE(product_length_cm, '\r', '')), '') AS SIGNED),
    CAST(NULLIF(TRIM(REPLACE(product_height_cm, '\r', '')), '') AS SIGNED),
    CAST(NULLIF(TRIM(REPLACE(product_width_cm, '\r', '')), '') AS SIGNED)
FROM products_stage;


/* --------------------------------------------------------
RESULT:
✔ Hidden characters removed
✔ Empty strings converted to NULL
✔ Numeric columns properly cast
✔ LOAD successful without disabling strict mode
-------------------------------------------------------- */