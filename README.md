# E-Commerce Analytics Using SQL 

## Project Overview

This project uses SQL to analyze key business metrics from an e-commerce dataset. The goal is to extract actionable insights related to revenue performance, customer behavior, and retention using analytical SQL queries.

## Dataset

- **Source**: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Table Used**:

    - customers
    - orders
    - order_payments

## Business Questions & Analysis

### 1. Total Revenue from Delivered Orders
```bash
SELECT
    SUM(op.payment_value) AS total_revenue
FROM orders o
JOIN order_payments op
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered';
```
**Insight**:
Total revenue is calculated only from delivered orders to reflect realized sales value.

### 2. Revenue Trend by Year
```bash
SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    SUM(op.payment_value) AS total_revenue
FROM orders o
JOIN order_payments op
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
GROUP BY YEAR(o.order_purchase_timestamp)
ORDER BY year;
```
**Insight**:
Revenue shows a year-over-year trend, indicating changes in business growth and transaction volume over time.

### 3. Average Order Value (AOV)
```bash
SELECT
    SUM(op.payment_value) / COUNT(DISTINCT o.order_id) AS average_order_value
FROM orders o
JOIN order_payments op
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered';
```
**Insight**:
Average order value represents the baseline customer spending per transaction and can inform pricing or upselling strategies.

### 4. Repeat Customers
```bash
SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        c.customer_unique_id
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
    HAVING COUNT(DISTINCT o.order_id) > 1
) t;
```
**Insight**:
Only a small fraction of customers place repeat orders, indicating low customer retention and a reliance on one-time buyers.

### 5. Top Customers by Revenue
```bash
SELECT
    c.customer_unique_id,
    SUM(op.payment_value) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
ORDER BY total_revenue DESC
LIMIT 10;
```
**Insight**:
Revenue is highly concentrated among a small group of high-value customers, reinforcing strong revenue concentration patterns.

## Key Takeaways

- Revenue is driven by a limited number of high-value customers.
- Customer retention is relatively low.
- Business growth relies more on customer acquisition than repeat purchases.
- There is potential to improve revenue stability through retention strategies.

## Tech Stack

- SQL
- GitHub for version control and documentation