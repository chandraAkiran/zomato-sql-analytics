-- =============================================
-- ZOMATO SQL ANALYTICS PROJECT
-- DATABASE VALIDATION
-- Author: Chandra Akash Kiran
-- =============================================


-- 1. CHECK ALL TABLES
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;


-- 2. CHECK NUMBER OF LOCATIONS
SELECT COUNT(*) AS total_locations
FROM locations;


-- 3. CHECK NUMBER OF CUSTOMERS
SELECT COUNT(*) AS total_customers
FROM customers;


-- 4. CHECK NUMBER OF RESTAURANTS
SELECT COUNT(*) AS total_restaurants
FROM restaurants;


-- 5. CHECK NUMBER OF MENU ITEMS
SELECT COUNT(*) AS total_menu_items
FROM menu_items;


-- 6. CHECK NUMBER OF ORDERS
SELECT COUNT(*) AS total_orders
FROM orders;


-- 7. CHECK NUMBER OF ORDER ITEMS
SELECT COUNT(*) AS total_order_items
FROM order_items;


-- 8. CHECK NUMBER OF PAYMENTS
SELECT COUNT(*) AS total_payments
FROM payments;


-- 9. CHECK NUMBER OF DELIVERY PARTNERS
SELECT COUNT(*) AS total_delivery_partners
FROM delivery_partners;


-- 10. CHECK NUMBER OF DELIVERIES
SELECT COUNT(*) AS total_deliveries
FROM deliveries;


-- 11. CHECK NUMBER OF REVIEWS
SELECT COUNT(*) AS total_reviews
FROM reviews;


-- =============================================
-- 12. VERIFY ORDER-CUSTOMER-RESTAURANT RELATIONSHIP
-- =============================================

SELECT
    o.order_id,
    c.name AS customer_name,
    r.restaurant_name,
    o.order_date,
    o.order_status,
    o.total_amount
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
ORDER BY o.order_id;


-- =============================================
-- 13. CHECK FOR ORPHAN ORDER ITEMS
-- Expected result: 0
-- =============================================

SELECT COUNT(*) AS orphan_order_items
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


-- =============================================
-- 14. CHECK FOR ORPHAN PAYMENTS
-- Expected result: 0
-- =============================================

SELECT COUNT(*) AS orphan_payments
FROM payments p
LEFT JOIN orders o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL;


-- =============================================
-- 15. CHECK ORDER TOTAL VS ITEM TOTAL
-- =============================================

SELECT
    o.order_id,
    o.total_amount AS order_total,
    SUM(oi.quantity * oi.price) AS calculated_item_total,
    o.total_amount -
        SUM(oi.quantity * oi.price) AS difference
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    o.total_amount
ORDER BY o.order_id;
