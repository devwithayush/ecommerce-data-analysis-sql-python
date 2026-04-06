-- Create Database
CREATE DATABASE IF NOT EXISTS ecommerce;

-- Use database
USE ecommerce;

-- Create Final Dataset Table
CREATE TABLE IF NOT EXISTS final_dataset (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    product_id VARCHAR(100),
    seller_id VARCHAR(100),

    order_purchase_timestamp DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,

    price FLOAT,
    freight_value FLOAT,
    payment_value FLOAT,

    customer_state VARCHAR(10)
);
