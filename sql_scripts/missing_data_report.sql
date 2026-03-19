SET @table_name = 'order_items';

-- Build a single query dynamically
SELECT 
    CONCAT('SELECT ', GROUP_CONCAT( CONCAT('COUNT(IF(`', COLUMN_NAME, '` IS NULL, 1, NULL)) AS `', COLUMN_NAME, '_nulls`')
        ),
        ' FROM ', @table_name, ';'
    ) INTO @sql
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = @table_name;

-- Execute the query
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;