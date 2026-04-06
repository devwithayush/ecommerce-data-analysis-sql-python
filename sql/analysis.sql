USE ecommerce;

-- KPI VIEW
CREATE OR REPLACE VIEW kpi_summary AS
SELECT 
    ROUND(SUM(payment_value), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(payment_value) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM final_dataset;


-- MONTHLY ORDERS TREND
CREATE OR REPLACE VIEW monthly_orders AS
SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(DISTINCT order_id) AS total_orders
FROM final_dataset
GROUP BY month
ORDER BY month;


-- DELIVERY PERFORMANCE
CREATE OR REPLACE VIEW delivery_performance AS
SELECT 
    AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS avg_delivery_days,
    
    ROUND(
        SUM(CASE 
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 
            ELSE 0 
        END) * 100.0 / COUNT(*), 2
    ) AS late_delivery_percentage
FROM final_dataset;


-- CUSTOMER RETENTION
CREATE OR REPLACE VIEW customer_orders AS
SELECT 
    customer_id,
    COUNT(DISTINCT order_id) AS total_orders
FROM final_dataset
GROUP BY customer_id;


-- TOP PRODUCTS
CREATE OR REPLACE VIEW top_products AS
SELECT 
    product_id,
    COUNT(*) AS total_orders
FROM final_dataset
GROUP BY product_id
ORDER BY total_orders DESC;


-- TOP STATES
CREATE OR REPLACE VIEW top_states AS
SELECT 
    customer_state,
    COUNT(DISTINCT customer_id) AS total_customers
FROM final_dataset
GROUP BY customer_state
ORDER BY total_customers DESC;


-- SAMPLE SELECTS (FOR USE
-- KPI
SELECT * FROM kpi_summary;

-- Monthly Orders
SELECT * FROM monthly_orders;

-- Delivery
SELECT * FROM delivery_performance;

-- Top Products (limit 10)
SELECT * FROM top_products LIMIT 10;

-- Top States
SELECT * FROM top_states LIMIT 10;