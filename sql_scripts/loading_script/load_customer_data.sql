/*================================================================================
BULK DATA LOADING IN MYSQL – CONCEPT OVERVIEW
================================================================================
This script uses MySQL's bulk loading feature to import CSV data efficiently.

KEY CONCEPTS:
1) LOAD DATA INFILE
   - Loads a file that exists on the MySQL SERVER machine.
   - File must be inside the directory allowed by secure-file-priv.
   - Used mostly in production environments.
2) secure-file-priv
   - MySQL security setting that restricts where files can be read/written.
   - Check with:
       SHOW VARIABLES LIKE 'secure_file_priv';
   - If file is outside this directory → Error 1290.
3) LOAD DATA LOCAL INFILE
   - Loads a file from the CLIENT machine (e.g., your laptop).
   - Client reads file and sends data to MySQL server.
   - Useful for development environments.
4) local_infile
   - MySQL setting that enables/disables LOCAL file loading.
   - Check with:
       SHOW VARIABLES LIKE 'local_infile';
   - Enable with:
       SET GLOBAL local_infile = 1;
BEST PRACTICE WORKFLOW:
   1. Confirm file location (server vs client)
   2. Check secure-file-priv (if using INFILE)
   3. Check local_infile (if using LOCAL)
   4. Validate import:
        SELECT COUNT(*) FROM table_name;
This approach ensures secure, efficient, and production-ready data loading.
================================================================================*/

SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_ecommerce_data/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;