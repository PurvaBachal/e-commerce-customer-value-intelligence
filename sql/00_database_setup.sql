# E-Commerce Customer Value Intelligence
# 00 - Database Setup

CREATE DATABASE ECommerce_Customer_Value_Intelligence;
USE ecommerce_customer_value_intelligence;

# 1. Create and Load Raw Sales Table
CREATE TABLE sales_raw (
    order_id TEXT,
    order_date TEXT,
    order_time TEXT,
    order_status TEXT,
    sales_channel TEXT,
    customer_id TEXT,
    customer_name TEXT,
    customer_age TEXT,
    gender TEXT,
    customer_segment TEXT,
    customer_type TEXT,
    customer_city TEXT,
    customer_state TEXT,
    customer_country TEXT,
    region TEXT,
    customer_postal_code TEXT,
    payment_method TEXT,
    payment_status TEXT,
    currency TEXT,
    shipping_method TEXT,
    warehouse TEXT,
    delivery_days TEXT,
    estimated_delivery_days TEXT,
    delivery_status TEXT,
    return_status TEXT,
    return_reason TEXT,
    customer_rating TEXT,
    review_sentiment TEXT,
    customer_review TEXT,
    marketing_channel TEXT,
    campaign_name TEXT,
    coupon_code TEXT,
    loyalty_points_earned TEXT,
    loyalty_points_redeemed TEXT,
    quantity TEXT,
    gross_sales TEXT,
    discount_amount TEXT,
    tax_amount TEXT,
    shipping_cost TEXT,
    net_sales TEXT,
    product_cost TEXT,
    profit TEXT,
    profit_margin_percentage TEXT,
    customer_lifetime_value TEXT,
    is_repeat_customer TEXT,
    customer_order_count TEXT
);

LOAD DATA LOCAL INFILE 'C:/Users/NARENDRA/Documents/DATA ANALYTICS/Projects/E-Commerce_Customer_Value_Intelligence/Data/Raw/ecommerce_sales_customer_analytics_150k.csv'
INTO TABLE sales_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# 2. Create Clean Sales Table
CREATE TABLE sales (
    order_id VARCHAR(20),
    order_date DATE,
    order_time TIME,
    order_status VARCHAR(20),
    sales_channel VARCHAR(30),
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    customer_age INT,
    gender VARCHAR(20),
    customer_segment VARCHAR(20),
    customer_type VARCHAR(20),
    customer_city VARCHAR(100),
    customer_state VARCHAR(100),
    customer_country VARCHAR(50),
    region VARCHAR(30),
    customer_postal_code INT,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),
    currency VARCHAR(5),
    shipping_method VARCHAR(30),
    warehouse VARCHAR(30),
    delivery_days INT,
    estimated_delivery_days INT,
    delivery_status VARCHAR(20),
    return_status VARCHAR(20),
    return_reason VARCHAR(50),
    customer_rating DECIMAL(3,1),
    review_sentiment VARCHAR(20),
    customer_review TEXT,
    marketing_channel VARCHAR(30),
    campaign_name VARCHAR(50),
    coupon_code VARCHAR(20),
    loyalty_points_earned INT,
    loyalty_points_redeemed INT,
    quantity INT,
    gross_sales DECIMAL(15,2),
    discount_amount DECIMAL(15,2),
    tax_amount DECIMAL(15,2),
    shipping_cost DECIMAL(15,2),
    net_sales DECIMAL(15,2),
    product_cost DECIMAL(15,2),
    profit DECIMAL(15,2),
    profit_margin_percentage DECIMAL(6,2),
    customer_lifetime_value DECIMAL(15,2),
    is_repeat_customer BOOLEAN,
    customer_order_count INT
);

INSERT INTO sales
SELECT
    order_id,
    STR_TO_DATE(order_date, '%d-%m-%Y'),
    STR_TO_DATE(order_time, '%H:%i:%s'),
    order_status,
    sales_channel,
    customer_id,
    customer_name,
    CAST(customer_age AS UNSIGNED),
    gender,
    customer_segment,
    customer_type,
    customer_city,
    customer_state,
    customer_country,
    region,
    CAST(customer_postal_code AS UNSIGNED),
    payment_method,
    payment_status,
    currency,
    shipping_method,
    warehouse,
    NULLIF(delivery_days, ''),
    NULLIF(estimated_delivery_days, ''),
    delivery_status,
    return_status,
    return_reason,
    NULLIF(customer_rating, ''),
    review_sentiment,
    customer_review,
    marketing_channel,
    campaign_name,
    coupon_code,
    CAST(loyalty_points_earned AS UNSIGNED),
    CAST(loyalty_points_redeemed AS UNSIGNED),
    CAST(quantity AS UNSIGNED),
    CAST(gross_sales AS DECIMAL(15,2)),
    CAST(discount_amount AS DECIMAL(15,2)),
    CAST(tax_amount AS DECIMAL(15,2)),
    CAST(shipping_cost AS DECIMAL(15,2)),
    CAST(net_sales AS DECIMAL(15,2)),
    CAST(product_cost AS DECIMAL(15,2)),
    CAST(profit AS DECIMAL(15,2)),
    CAST(profit_margin_percentage AS DECIMAL(6,2)),
    CAST(customer_lifetime_value AS DECIMAL(15,2)),
    CASE
        WHEN UPPER(is_repeat_customer) = 'TRUE' THEN TRUE
        WHEN UPPER(is_repeat_customer) = 'FALSE' THEN FALSE
        ELSE NULL
    END,
    CAST(customer_order_count AS UNSIGNED)
FROM sales_raw;

# 3. Create and Load Raw Order Items Table
CREATE TABLE order_items_raw (
    order_id TEXT,
    product_id TEXT,
    quantity TEXT,
    unit_price TEXT,
    discount_percentage TEXT,
    discount_amount TEXT,
    gross_sales TEXT,
    tax_amount TEXT,
    shipping_cost TEXT,
    net_sales TEXT,
    product_cost TEXT,
    profit TEXT
);

LOAD DATA LOCAL INFILE 'C:/Users/NARENDRA/Documents/DATA ANALYTICS/Projects/E-Commerce_Customer_Value_Intelligence/Data/Raw/order_items.csv'
INTO TABLE order_items_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# 4. Create Clean Order Items Table
CREATE TABLE order_items (
    order_id VARCHAR(20),
    product_id VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(15,2),
    discount_percentage DECIMAL(6,2),
    discount_amount DECIMAL(15,2),
    gross_sales DECIMAL(15,2),
    tax_amount DECIMAL(15,2),
    shipping_cost DECIMAL(15,2),
    net_sales DECIMAL(15,2),
    product_cost DECIMAL(15,2),
    profit DECIMAL(15,2)
);

INSERT INTO order_items
SELECT
    order_id,
    product_id,
    CAST(quantity AS UNSIGNED),
    CAST(unit_price AS DECIMAL(15,2)),
    CAST(discount_percentage AS DECIMAL(6,2)),
    CAST(discount_amount AS DECIMAL(15,2)),
    CAST(gross_sales AS DECIMAL(15,2)),
    CAST(tax_amount AS DECIMAL(15,2)),
    CAST(shipping_cost AS DECIMAL(15,2)),
    CAST(net_sales AS DECIMAL(15,2)),
    CAST(product_cost AS DECIMAL(15,2)),
    CAST(profit AS DECIMAL(15,2))
FROM order_items_raw;

# 5. Create and Load Raw Product Catalog
CREATE TABLE product_catalog_raw (
    product_id TEXT,
    product_name TEXT,
    product_category TEXT,
    product_subcategory TEXT,
    brand TEXT,
    supplier TEXT,
    unit_price TEXT,
    product_cost TEXT,
    product_rating TEXT
);

LOAD DATA LOCAL INFILE 'C:/Users/NARENDRA/Documents/DATA ANALYTICS/Projects/E-Commerce_Customer_Value_Intelligence/Data/Raw/product_catalog.csv'
INTO TABLE product_catalog_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# 6. Create Clean Product Catalog
CREATE TABLE product_catalog (
    product_id VARCHAR(20),
    product_name VARCHAR(150),
    product_category VARCHAR(50),
    product_subcategory VARCHAR(50),
    brand VARCHAR(100),
    supplier VARCHAR(100),
    unit_price DECIMAL(15,2),
    product_cost DECIMAL(15,2),
    product_rating DECIMAL(3,1)
);

INSERT INTO product_catalog
SELECT
    product_id,
    product_name,
    product_category,
    product_subcategory,
    brand,
    supplier,
    CAST(unit_price AS DECIMAL(15,2)),
    CAST(product_cost AS DECIMAL(15,2)),
    CAST(product_rating AS DECIMAL(3,1))
FROM product_catalog_raw;