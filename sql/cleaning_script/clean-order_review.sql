-- Inspect table
SELECT * FROM order_reviews LIMIT 5;


-- Review greater than 5 or less than 1
SELECT review_score FROM order_reviews where review_score > 5 or review_score < 1 LIMIT 5;


-- Check for duplicate
SELECT
COUNT(DISTINCT review_id) AS unique_review,
COUNT(review_id) AS total_review,
COUNT(review_id) - COUNT(DISTINCT review_id) AS duplicate_orders
FROM order_reviews;


-- Duplicate review_id
SELECT
	review_id,
	COUNT(*) AS review_count
FROM order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1;


-- Order status distribution
SELECT
	order_status,
    COUNT(*) AS total_count,
    CONCAT(ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2), '%') AS percentage
FROM orders
GROUP BY order_status
ORDER BY total_count DESC;


-- Null columns
SELECT
    COUNT(CASE WHEN review_id IS NULL THEN 1 END) AS review_id_nulls,
    COUNT(CASE WHEN order_id IS NULL THEN 1 END) AS order_id_nulls,
    COUNT(CASE WHEN review_score IS NULL THEN 1 END) AS review_score_nulls,
    COUNT(CASE WHEN review_comment_title IS NULL OR review_comment_title = "" THEN 1 END) AS review_comment_title_nulls,
    COUNT(CASE WHEN review_comment_message IS NULL OR review_comment_message = "" THEN 1 END) AS review_comment_massage_nulls,
    COUNT(CASE WHEN review_creation_date IS NULL THEN 1 END) AS review_creation_date_nulls,
    COUNT(CASE WHEN review_answer_timestamp IS NULL THEN 1 END) AS review_answer_timestamp_nulls
FROM order_reviews;


-- Review response time
SELECT
	CONCAT( ROUND( AVG (timestampdiff(HOUR, review_creation_date, review_answer_timestamp)))," ", "hours") AS avg_response_time
FROM order_reviews;