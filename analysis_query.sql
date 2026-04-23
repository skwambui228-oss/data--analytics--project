SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;


SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.city,
    COUNT(DISTINCT o.order_id)        AS total_orders,
    SUM(oi.quantity * oi.unit_price)  AS total_spent
FROM customers c
JOIN orders o       ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id    = oi.order_id
GROUP BY c.customer_id, customer_name, c.city
ORDER BY total_spent DESC
LIMIT 10;


SELECT 
    p.product_name,
    p.category,
    SUM(oi.quantity)                 AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN orders o   ON oi.order_id   = o.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE EXTRACT(MONTH FROM o.order_date) IN (10, 11, 12)
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC;


SELECT 
    EXTRACT(MONTH FROM o.order_date) AS month_number,
    SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month_number
ORDER BY month_number;


SELECT 
    p.category,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;



SELECT 
    c.city,
    COUNT(DISTINCT o.order_id)       AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM customers c
JOIN orders o       ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id    = oi.order_id
GROUP BY c.city
ORDER BY total_revenue DESC;    