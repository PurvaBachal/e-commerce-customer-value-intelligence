# E-Commerce Customer Value Intelligence
   # 01 - Data Validation

USE ecommerce_customer_value_intelligence;

# Row Counts
SELECT COUNT(*) AS customer_count
FROM customer_master;

SELECT COUNT(*) AS sales_count
FROM sales;

SELECT COUNT(*) AS order_item_count
FROM order_items;

SELECT COUNT(*) AS product_count
FROM product_catalog;

# 2. Duplicate customer IDs
SELECT
    customer_id,
    COUNT(*) AS customer_count
FROM customer_master
GROUP BY customer_id
HAVING COUNT(*) > 1;

# 3. Duplicate order IDs
SELECT
    order_id,
    COUNT(*) AS order_count
FROM sales
GROUP BY order_id
HAVING COUNT(*) > 1;

# 4. Duplicate order-product combinations
SELECT
    order_id,
    product_id,
    COUNT(*) AS combination_count
FROM order_items
GROUP BY
    order_id,
    product_id
HAVING COUNT(*) > 1;

# 5. Number of duplicate order-product rows
SELECT
    SUM(combination_count - 1) AS duplicate_rows
FROM (
    SELECT
        order_id,
        product_id,
        COUNT(*) AS combination_count
    FROM order_items
    GROUP BY
        order_id,
        product_id
    HAVING COUNT(*) > 1
) AS duplicates;

# 6. Sales customers must exist in customer master
SELECT COUNT(DISTINCT s.customer_id) AS unmatched_customers
FROM sales s
LEFT JOIN customer_master c
    ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

# 7. Sales orders missing from order items
SELECT COUNT(DISTINCT s.order_id) AS unmatched_orders
FROM sales s
LEFT JOIN order_items oi
    ON s.order_id = oi.order_id
WHERE oi.order_id IS NULL;

# 8. Order items missing from sales
SELECT COUNT(DISTINCT oi.order_id) AS unmatched_orders
FROM order_items oi
LEFT JOIN sales s
    ON oi.order_id = s.order_id
WHERE s.order_id IS NULL;

# 9. Order items with products missing from product catalog
SELECT COUNT(DISTINCT oi.product_id) AS unmatched_products
FROM order_items oi
LEFT JOIN product_catalog p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

# 10. Check invalid quantities
SELECT
    COUNT(*) AS invalid_quantity_rows
FROM order_items
WHERE quantity <= 0;

# 11. Check invalid unit prices and product costs
SELECT
    COUNT(*) AS invalid_price_cost_rows
FROM order_items
WHERE unit_price < 0
   OR product_cost < 0;
   
# 12. Check invalid customer ratings
SELECT
    COUNT(*) AS invalid_rating_rows
FROM sales
WHERE customer_rating < 1
   OR customer_rating > 5;
   
# 13. Check invalid negative sales and cost values
SELECT
    COUNT(*) AS invalid_sales_cost_rows
FROM sales
WHERE gross_sales < 0
   OR discount_amount < 0
   OR tax_amount < 0
   OR shipping_cost < 0
   OR net_sales < 0
   OR product_cost < 0;
   
# 14. Check missing key fields in sales
SELECT
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(customer_id IS NULL) AS missing_customer_id
FROM sales;

# 15. Check missing key fields in order_items
SELECT
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(product_id IS NULL) AS missing_product_id
FROM order_items;

# 16. Check missing product IDs in product catalog
SELECT
    SUM(product_id IS NULL) AS missing_product_id
FROM product_catalog;

# 17. Check missing customer IDs in customer master
SELECT
    SUM(customer_id IS NULL) AS missing_customer_id
FROM customer_master;

# 18. Check sales date range
SELECT
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date
FROM sales;

# 19. Check missing order dates
SELECT
    COUNT(*) AS missing_order_dates
FROM sales
WHERE order_date IS NULL;

# 20. Check currencies in sales data
SELECT
    currency,
    COUNT(*) AS order_count
FROM sales
GROUP BY currency
ORDER BY currency;

# 21. Check order status values
SELECT
    order_status,
    COUNT(*) AS order_count
FROM sales
GROUP BY order_status
ORDER BY order_status;

# 22. Check sales channel values
SELECT
    sales_channel,
    COUNT(*) AS order_count
FROM sales
GROUP BY sales_channel
ORDER BY sales_channel;

# 23. Check customer segment values
SELECT
    customer_segment,
    COUNT(*) AS order_count
FROM sales
GROUP BY customer_segment
ORDER BY customer_segment;

# 24. Check customer type values
SELECT
    customer_type,
    COUNT(*) AS order_count
FROM sales
GROUP BY customer_type
ORDER BY customer_type;

# 25. Check payment status values
SELECT
    payment_status,
    COUNT(*) AS order_count
FROM sales
GROUP BY payment_status
ORDER BY payment_status;

# 26. Check payment method values
SELECT
    payment_method,
    COUNT(*) AS order_count
FROM sales
GROUP BY payment_method
ORDER BY payment_method;

# 27. Check delivery status values
SELECT
    delivery_status,
    COUNT(*) AS order_count
FROM sales
GROUP BY delivery_status
ORDER BY delivery_status;

# 28. Check return status values
SELECT
    return_status,
    COUNT(*) AS order_count
FROM sales
GROUP BY return_status
ORDER BY return_status;

# 29. Check marketing channel values
SELECT
    marketing_channel,
    COUNT(*) AS order_count
FROM sales
GROUP BY marketing_channel
ORDER BY marketing_channel;

# 30. Check shipping method values
SELECT
    shipping_method,
    COUNT(*) AS order_count
FROM sales
GROUP BY shipping_method
ORDER BY shipping_method;

# 31. Check invalid delivery day values
SELECT
    COUNT(*) AS invalid_delivery_day_rows
FROM sales
WHERE delivery_days < 0
   OR estimated_delivery_days < 0;
   
# 32. Check missing delivery day values
SELECT
    SUM(delivery_days IS NULL) AS missing_delivery_days,
    SUM(estimated_delivery_days IS NULL) AS missing_estimated_delivery_days
FROM sales;

# 33. Verify missing delivery days for cancelled deliveries
SELECT
    delivery_status,
    COUNT(*) AS order_count
FROM sales
WHERE delivery_days IS NULL
   OR estimated_delivery_days IS NULL
GROUP BY delivery_status
ORDER BY delivery_status;