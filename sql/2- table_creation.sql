
CREATE TABLE customers (
	customer_id VARCHAR(32) NOT NULL,
	customer_unique_id VARCHAR(32),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state CHAR(2),
    
    PRIMARY KEY (customer_id),
    UNIQUE (customer_unique_id)
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4;


CREATE TABLE order_items (
	order_id VARCHAR(32) NOT NULL,
    order_item_id SMALLINT UNSIGNED NOT NULL,
    product_id VARCHAR(32) NOT NULL,
    seller_id VARCHAR(32) NOT NULL,
    shipping_limit_date DATETIME NOT NULL,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    
    PRIMARY KEY (order_id, order_item_id),
    
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4;


CREATE TABLE orders(
	order_id VARCHAR(32) NOT NULL,
    customer_id VARCHAR(32) NOT NULL,
    order_status ENUM('processing','approved','shipped','delivered','canceled', 'invoiced'),
    order_purchase_timestamp DATETIME NOT NULL,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME NOT NULL,
    
    PRIMARY KEY (order_id),
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON DELETE RESTRICT
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4;


CREATE TABLE products(
	product_id VARCHAR(32) NOT NULL,
    product_category_name VARCHAR(100),
    product_name_length SMALLINT UNSIGNED,
    product_description_length SMALLINT UNSIGNED,
    product_photos_qty TINYINT UNSIGNED,
    product_weight_g SMALLINT UNSIGNED NOT NULL,
    product_length_cm SMALLINT UNSIGNED NOT NULL,
	product_height_cm SMALLINT UNSIGNED NOT NULL,
    product_width_cm SMALLINT UNSIGNED NOT NULL,
    
    PRIMARY KEY (product_id)
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4;


CREATE TABLE sellers (
	seller_id VARCHAR(32) NOT NULL,
    seller_zip_code_prefix CHAR(5),
    seller_city VARCHAR(50) NOT NULL,
    seller_state CHAR(2) NOT NULL,
    
	PRIMARY KEY (seller_id)
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4;



CREATE TABLE order_payments (
	order_id VARCHAR(32) NOT NULL,
    payment_sequential TINYINT NOT NULL,
    payment_type VARCHAR(20) NOT NULL,
    payment_installments TINYINT NOT NULL,
    payment_value DECIMAL(10,2) NOT NULL,
    
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4;



CREATE TABLE order_reviews (
	review_id VARCHAR(32) NOT NULL,
    order_id VARCHAR(32) NOT NULL,
    review_score TINYINT NOT NULL CHECK ( review_score BETWEEN 1 AND 5),
    review_comment_title VARCHAR(50),
    review_comment_message TEXT,
    review_creation_date DATETIME NOT NULL,
    review_answer_timestamp DATETIME NOT NULL,
    
    PRIMARY KEY (review_id),
     UNIQUE (order_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4;



CREATE TABLE product_category_name_translation (
	product_category_name VARCHAR (50) NOT NULL,
    product_category_name_english VARCHAR(50),
    
	PRIMARY KEY (product_category_name)
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4;



CREATE TABLE geolocation(
    geolocation_zip_code_prefix CHAR(5),
    geolocation_lat DECIMAL(10,8),
    geolocation_lng DECIMAL(11,8),
    geolocation_city VARCHAR(50),
    geolocation_state CHAR(2)
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4;



