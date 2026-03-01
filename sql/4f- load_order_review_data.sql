/******************************************************************************************
-- SQL Documentation: Order Reviews ETL Process
-- Objective: Load, clean, validate, and insert order reviews into production table
-- Dataset: olist_order_reviews_final.csv
-- Author: Abe Temitope Moses
-- Date: 2026-03-01
******************************************************************************************/

/******************************************************************************************
-- Step 1: Create Staging Table
-- Purpose: 
--   1. Temporarily store CSV data without constraints.
--   2. Allow validation and cleaning before inserting into production table.
--   3. Prevent primary key or foreign key errors during initial load.
******************************************************************************************/
CREATE TABLE order_reviews_stage (
    review_id VARCHAR(100),
    order_id VARCHAR(100),
    review_score VARCHAR(10),
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date VARCHAR(50),
    review_answer_timestamp VARCHAR(50)
);

/******************************************************************************************
-- Step 2: Load CSV into Staging Table
-- Notes:
--   - Fields are comma-separated.
--   - Text fields are enclosed in double quotes.
--   - Ignore first row (header).
--   - Using cleaned CSV (olist_order_reviews_final.csv) to avoid malformed rows.
******************************************************************************************/
LOAD DATA INFILE 
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_ecommerce_data/olist_order_reviews_final.csv'
INTO TABLE order_reviews_stage
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

/******************************************************************************************
-- Step 3: Validate Production Table
-- Purpose:
--   - Check how many rows already exist in production table.
******************************************************************************************/
SELECT COUNT(*) AS production_row_count
FROM order_reviews;

/******************************************************************************************
-- Step 4: Check for Duplicate Review IDs in Staging
-- Purpose:
--   - Identify duplicate review_id values before inserting into production.
--   - Ensures PRIMARY KEY constraint will not fail.
******************************************************************************************/
SELECT review_id, COUNT(*) AS duplicate_count
FROM order_reviews_stage
GROUP BY review_id
HAVING COUNT(*) > 1;

/******************************************************************************************
-- Step 5: Insert Clean Data into Production Table
-- Notes:
--   - Assumes staging table is clean and duplicate review_ids have been handled.
--   - Mapping columns explicitly to avoid errors and maintain clarity.
******************************************************************************************/
INSERT INTO order_reviews (
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
)
SELECT
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM order_reviews_stage;

/******************************************************************************************
-- Step 6: Optional Post-Insert Validation
-- Purpose:
--   - Confirm all rows were inserted successfully.
--   - Check for any remaining duplicates (should be zero if cleaned properly).
******************************************************************************************/
SELECT COUNT(*) AS production_total_rows
FROM order_reviews;

SELECT review_id, COUNT(*) AS duplicate_count
FROM order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1;


/******************************************************************************************
import pandas as pd

# Step 1: Load raw CSV safely using flexible parser
df = pd.read_csv(
    r"C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\olist_ecommerce_data\olist_order_reviews_dataset.csv",
    sep=",",
    quotechar='"',
    engine="python"   # Handles malformed/multiline rows better
)

print("Total rows loaded:", len(df))

# Step 2: Detect duplicate review_id values
duplicates_id = df[df.duplicated(subset="review_id", keep=False)]
print("Duplicate review_id records:")
print(duplicates_id.sort_values("review_id"))

# Step 3: Detect fully duplicated rows (entire row identical)
duplicates_full = df[df.duplicated(keep=False)]
print("Fully duplicated rows:")
print(duplicates_full)

# Step 4: Remove duplicate review_id (keep first occurrence)
df_clean = df.drop_duplicates(subset="review_id", keep="first")

print("Rows before cleaning:", len(df))
print("Rows after cleaning:", len(df_clean))

# Step 5: Export cleaned file for MySQL loading
df_clean.to_csv(
    r"C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\olist_ecommerce_data\olist_order_reviews_final.csv",
    index=False
)

print("Clean CSV exported successfully.")
******************************************************************************************/