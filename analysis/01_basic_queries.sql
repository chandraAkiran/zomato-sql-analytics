-- =============================================
-- ZOMATO SQL ANALYTICS PROJECT
-- BASIC SQL ANALYSIS
-- Author: Chandra Akash Kiran
-- =============================================


-- =============================================
-- 1. VIEW ALL CUSTOMERS
-- =============================================

SELECT *
FROM customers;


-- =============================================
-- 2. TOTAL NUMBER OF CUSTOMERS
-- =============================================

SELECT COUNT(*) AS total_customers
FROM customers;


-- =============================================
-- 3. TOTAL NUMBER OF RESTAURANTS
-- =============================================

SELECT COUNT(*) AS total_restaurants
FROM restaurants;


-- =============================================
-- 4. TOTAL NUMBER OF ORDERS
-- =============================================

SELECT COUNT(*) AS total_orders
FROM orders;


-- =============================================
-- 5. TOTAL REVENUE FROM DELIVERED ORDERS
-- =============================================

SELECT
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM orders
WHERE order_status = 'Delivered';


-- =============================================
-- 6. AVERAGE ORDER VALUE
-- =============================================

SELECT
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE order_status = 'Delivered';


-- =============================================
-- 7. ORDER STATUS DISTRIBUTION
-- =============================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- =============================================
-- 8. PAYMENT METHOD USAGE
-- =============================================

SELECT
    payment_method,
    COUNT(*) AS total_transactions
FROM payments
GROUP BY payment_method
ORDER BY total_transactions DESC;


-- =============================================
-- 9. REVENUE BY RESTAURANT
-- =============================================

SELECT
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY
    r.restaurant_id,
    r.restaurant_name
ORDER BY total_revenue DESC;


-- =============================================
-- 10. TOP 3 RESTAURANTS BY REVENUE
-- =============================================

SELECT
    r.restaurant_name,
    ROUND(SUM(o.total_amount), 2) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY
    r.restaurant_id,
    r.restaurant_name
ORDER BY total_revenue DESC
LIMIT 3;


-- =============================================
-- 11. ORDERS BY CUISINE
-- =============================================

SELECT
    r.cuisine_type,
    COUNT(o.order_id) AS total_orders
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.cuisine_type
ORDER BY total_orders DESC;


-- =============================================
-- 12. CUSTOMER SPENDING
-- =============================================

SELECT
    c.customer_id,
    c.name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.customer_id,
    c.name
ORDER BY total_spent DESC;


-- =============================================
-- 13. TOP 5 CUSTOMERS BY SPENDING
-- =============================================

SELECT
    c.name AS customer_name,
    ROUND(SUM(o.total_amount), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY
    c.customer_id,
    c.name
ORDER BY total_spent DESC
LIMIT 5;


-- =============================================
-- 14. AVERAGE RESTAURANT RATING
-- =============================================

SELECT
    r.restaurant_name,
    ROUND(AVG(rv.rating), 2) AS average_rating,
    COUNT(rv.review_id) AS total_reviews
FROM restaurants r
LEFT JOIN reviews rv
    ON r.restaurant_id = rv.restaurant_id
GROUP BY
    r.restaurant_id,
    r.restaurant_name
ORDER BY average_rating DESC NULLS LAST;


-- =============================================
-- 15. MOST POPULAR MENU ITEMS
-- =============================================

SELECT
    m.item_name,
    SUM(oi.quantity) AS quantity_sold
FROM order_items oi
JOIN menu_items m
    ON oi.item_id = m.item_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY
    m.item_id,
    m.item_name
ORDER BY quantity_sold DESC;


-- =============================================
-- 16. REVENUE BY MONTH
-- =============================================

SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    ROUND(SUM(total_amount), 2) AS monthly_revenue
FROM orders
WHERE order_status = 'Delivered'
GROUP BY
    TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;


-- =============================================
-- 17. ORDERS BY CITY
-- =============================================

SELECT
    l.city,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
JOIN locations l
    ON r.location_id = l.location_id
GROUP BY l.city
ORDER BY total_orders DESC;


-- =============================================
-- 18. REVENUE BY CITY
-- =============================================

SELECT
    l.city,
    ROUND(SUM(o.total_amount), 2) AS total_revenue
FROM orders o
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
JOIN locations l
    ON r.location_id = l.location_id
WHERE o.order_status = 'Delivered'
GROUP BY l.city
ORDER BY total_revenue DESC;
