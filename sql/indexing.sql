-- ============================
-- Indexes for Olist Project
-- Purpose: Improve query performance on JOINs and frequent filters
-- ============================

-- Orders table
CREATE INDEX idx_orders_customer
ON orders(customer_id);  -- Index foreign key for joins with customers

CREATE INDEX idx_orders_purchase_date
ON orders(order_purchase_timestamp);  -- Index for filtering and aggregation by order date

-- Order Items table
CREATE INDEX idx_order_items_order
ON order_items(order_id);  -- Index foreign key for joins with orders

CREATE INDEX idx_order_items_product
ON order_items(product_id);  -- Index foreign key for joins with products

CREATE INDEX idx_order_items_seller
ON order_items(seller_id);  -- Index foreign key for joins with sellers

-- Order Payments table
CREATE INDEX idx_order_payments_order
ON order_payments(order_id);  -- Index foreign key for joins with orders

-- Order Reviews table
CREATE INDEX idx_order_reviews_order
ON order_reviews(order_id);  -- Index foreign key for joins with orders