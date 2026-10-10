# E-Commerce Customer Value Intelligence
# 02 - Sales and Customer Analysis

USE ecommerce_customer_value_intelligence;

# 1. Orders and customers by year
SELECT
    YEAR(order_date) AS order_year,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers
FROM sales
GROUP BY YEAR(order_date)
ORDER BY order_year;

# 2. Orders and customers by customer type
SELECT
    customer_type,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers
FROM sales
GROUP BY customer_type
ORDER BY orders DESC;

# 3. Orders and customers by customer segment
SELECT
    customer_segment,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers
FROM sales
GROUP BY customer_segment
ORDER BY orders DESC;

# 4. Customer order frequency
SELECT
    customer_order_count,
    COUNT(DISTINCT customer_id) AS customers
FROM sales
GROUP BY customer_order_count
ORDER BY customer_order_count;

# 5. Order status by year
SELECT
    YEAR(order_date) AS order_year,
    order_status,
    COUNT(DISTINCT order_id) AS orders
FROM sales
GROUP BY
    YEAR(order_date),
    order_status
ORDER BY
    order_year,
    order_status;
    
# 6. Orders and customers by sales channel
SELECT
    sales_channel,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers
FROM sales
GROUP BY sales_channel
ORDER BY orders DESC;

# 7. Orders and customers by marketing channel
SELECT
    marketing_channel,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers
FROM sales
GROUP BY marketing_channel
ORDER BY orders DESC;

# 8. Customer type by year
SELECT
    YEAR(order_date) AS order_year,
    customer_type,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT order_id) AS orders
FROM sales
GROUP BY
    YEAR(order_date),
    customer_type
ORDER BY
    order_year,
    customer_type;
    
