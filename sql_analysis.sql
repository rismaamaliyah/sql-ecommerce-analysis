-- Q1: Total revenue from delivered orders

SELECT
    SUM(op.payment_value) AS total_revenue
FROM orders o
JOIN order_payments op
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered';

-- Q2: How does total revenue trend over time (yearly)?

SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    SUM(op.payment_value) AS total_revenue
FROM orders o
JOIN order_payments op
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
GROUP BY YEAR(o.order_purchase_timestamp)
ORDER BY year;

-- Q3: What is the Average Order Value (AOV)?

SELECT
    SUM(op.payment_value) / COUNT(DISTINCT o.order_id) AS average_order_value
FROM orders o
JOIN order_payments op
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered';

-- Q4: How many customers are repeat buyers?

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

-- Q5: Who are the top customers by total revenue?

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