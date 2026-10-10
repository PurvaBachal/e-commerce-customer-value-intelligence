# E-Commerce Customer Value Intelligence
# 03 - Product, Profitability and Operations Analysis

USE ecommerce_customer_value_intelligence;

# 1. Product performance by quantity
SELECT
    oi.product_id,
    p.product_name,
    p.product_category,
    p.product_subcategory,
    p.brand,
    SUM(oi.quantity) AS quantity,
    COUNT(*) AS sales_lines
FROM order_items oi
JOIN product_catalog p
    ON oi.product_id = p.product_id
GROUP BY
    oi.product_id,
    p.product_name,
    p.product_category,
    p.product_subcategory,
    p.brand
ORDER BY quantity DESC;

# 2. Category performance by quantity
SELECT
    p.product_category,
    SUM(oi.quantity) AS quantity,
    COUNT(*) AS sales_lines
FROM order_items oi
JOIN product_catalog p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_category
ORDER BY quantity DESC;

# 3. Profitability by currency
SELECT
    currency,
    SUM(net_sales) AS net_sales,
    SUM(product_cost) AS product_cost,
    SUM(profit) AS profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(net_sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales
GROUP BY currency
ORDER BY currency;

# 4. Discount and profitability by currency
SELECT
    currency,
    CASE
        WHEN discount_amount / NULLIF(gross_sales, 0) <= 0.10
            THEN '0-10%'
        WHEN discount_amount / NULLIF(gross_sales, 0) <= 0.20
            THEN '>10-20%'
        WHEN discount_amount / NULLIF(gross_sales, 0) <= 0.30
            THEN '>20-30%'
        WHEN discount_amount / NULLIF(gross_sales, 0) <= 0.40
            THEN '>30-40%'
        ELSE '>40%'
    END AS discount_band,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(
        SUM(profit) / NULLIF(SUM(net_sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM sales
GROUP BY
    currency,
    discount_band
ORDER BY
    currency,
    discount_band;
    
# 5. Delivery performance
SELECT
    delivery_status,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(AVG(delivery_days), 2) AS avg_delivery_days,
    ROUND(AVG(estimated_delivery_days), 2) AS avg_estimated_delivery_days,
    ROUND(
        AVG(delivery_days - estimated_delivery_days),
        2
    ) AS avg_difference_days
FROM sales
WHERE delivery_status <> 'Cancelled'
GROUP BY delivery_status
ORDER BY delivery_status;

# 6. Return performance by sales channel
SELECT
    sales_channel,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(
        DISTINCT CASE
            WHEN return_status = 'Returned' THEN order_id
        END
    ) AS returned_orders,
    ROUND(
        COUNT(
            DISTINCT CASE
                WHEN return_status = 'Returned' THEN order_id
            END
        ) / COUNT(DISTINCT order_id) * 100,
        2
    ) AS return_rate_percentage
FROM sales
GROUP BY sales_channel
ORDER BY return_rate_percentage DESC;

# 7. Return reasons
SELECT
    return_reason,
    COUNT(DISTINCT order_id) AS returned_orders
FROM sales
WHERE return_status = 'Returned'
GROUP BY return_reason
ORDER BY returned_orders DESC;

# 8. Delivery performance by shipping method
SELECT
    shipping_method,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(
        DISTINCT CASE
            WHEN delivery_status = 'On Time' THEN order_id
        END
    ) AS on_time_orders,
    COUNT(
        DISTINCT CASE
            WHEN delivery_status = 'Delayed' THEN order_id
        END
    ) AS delayed_orders,
    ROUND(
        COUNT(
            DISTINCT CASE
                WHEN delivery_status = 'Delayed' THEN order_id
            END
        ) / COUNT(DISTINCT order_id) * 100,
        2
    ) AS delayed_rate_percentage
FROM sales
WHERE delivery_status <> 'Cancelled'
GROUP BY shipping_method
ORDER BY delayed_rate_percentage;