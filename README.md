# olist-ecommerce-project-SQL-Python-Power BI

# SQL Analysis

## Overview
This stage of the project focuses on data cleaning, transformation, and analysis using SQL. The goal is to explore an e-commerce dataset, ensure data quality, and generate insights related to revenue, customers, products, sellers, and delivery performance.

---

## Dataset Description
The dataset consists of 9 interconnected tables covering different aspects of the business:

- customers  
- orders  
- order_items  
- products  
- sellers  
- order_payments  
- order_reviews  
- product_category_name_translation  
- geolocation  

The data spans from 2016 to 2018.

---

## Data Cleaning Summary

- No duplicate records were found in key tables such as customers, orders, and products.  
- Missing product categories were replaced with "unknown".  
- Missing product photo counts were replaced with 0.  
- Incomplete product physical attributes were retained but excluded from logistics analysis.  
- Customer location fields were standardized for consistency.  
- Null timestamps in the orders table were linked to non-delivered orders and excluded from delivery analysis.  

---

## Key Analysis Performed

- Revenue Analysis  
- Customer Behavior Analysis  
- Product Performance Analysis  
- Seller Performance Analysis  
- Geographic Analysis  
- Delivery Performance Analysis  

---

## SQL Views

### 1. Revenue by State View

**Purpose:**  
To create a reusable dataset showing revenue contribution by state.

```sql
CREATE VIEW revenue_by_state AS
SELECT
    c.customer_state,
    SUM(oi.price) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state;