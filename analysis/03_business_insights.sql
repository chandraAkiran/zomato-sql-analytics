-- =============================================
-- ZOMATO SQL ANALYTICS PROJECT
-- BUSINESS INSIGHTS
-- Author: Chandra Akash Kiran
-- =============================================


-- =============================================
-- 1. WHICH CITY GENERATES THE MOST REVENUE?
-- =============================================

SELECT
    l.city,
    COUNT(o.order_id) AS delivered_orders,
    ROUND(SUM(o.total_amount), 2) AS total_revenue
FROM orders o
JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
JOIN locations l
    ON r.location_id = l.location_id
WHERE o.order_status = 'Delivered'
GROUP BY l.city
ORDER BY total_revenue DESC;


-- =============================================
-- 2. WHICH RESTAURANTS GENERATE THE MOST REVENUE?
-- =============================================

SELECT
    r.restaurant_name,
    r.cuisine_type,
    COUNT(o.order_id) AS delivered_orders,
    ROUND(SUM(o.total_amount), 2) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY
    r.restaurant_id,
    r.restaurant_name,
    r.cuisine_type
ORDER BY total_revenue DESC;


-- =============================================
-- 3. WHO ARE THE HIGHEST-VALUE CUSTOMERS?
-- =============================================

SELECT
    c.customer_id,
    c.name AS customer_name,
    COUNT(o.order_id) AS delivered_orders,
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
-- 4. CUSTOMER VALUE SEGMENTATION
-- =============================================

WITH customer_value AS (
    SELECT
        c.customer_id,
        c.name,
        COUNT(o.order_id) FILTER (
            WHERE o.order_status = 'Delivered'
        ) AS delivered_orders,

        COALESCE(
            SUM(o.total_amount) FILTER (
                WHERE o.order_status = 'Delivered'
            ),
            0
        ) AS total_spent

    FROM customers c

    LEFT JOIN orders o
        ON c.customer_id = o.customer_id

    GROUP BY
        c.customer_id,
        c.name
)

SELECT
    customer_id,
    name AS customer_name,
    delivered_orders,
    ROUND(total_spent, 2) AS total_spent,

    CASE
        WHEN total_spent >= 800 THEN 'High Value'
        WHEN total_spent >= 400 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment

FROM customer_value
ORDER BY total_spent DESC;


-- =============================================
-- 5. WHICH CUISINES RECEIVE THE MOST ORDERS?
-- =============================================

SELECT
    r.cuisine_type,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS order_value
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.cuisine_type
ORDER BY total_orders DESC;


-- =============================================
-- 6. WHICH MENU ITEMS SELL THE MOST?
-- =============================================

SELECT
    m.item_name,
    r.restaurant_name,
    SUM(oi.quantity) AS quantity_sold,
    ROUND(SUM(oi.quantity * oi.price), 2) AS item_revenue
FROM order_items oi
JOIN menu_items m
    ON oi.item_id = m.item_id
JOIN restaurants r
    ON m.restaurant_id = r.restaurant_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY
    m.item_id,
    m.item_name,
    r.restaurant_name
ORDER BY quantity_sold DESC, item_revenue DESC;


-- =============================================
-- 7. WHAT IS THE OVERALL ORDER CANCELLATION RATE?
-- =============================================

SELECT
    COUNT(*) AS total_orders,

    COUNT(*) FILTER (
        WHERE order_status = 'Cancelled'
    ) AS cancelled_orders,

    ROUND(
        100.0 *
        COUNT(*) FILTER (
            WHERE order_status = 'Cancelled'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS cancellation_rate_percentage

FROM orders;


-- =============================================
-- 8. WHICH RESTAURANTS HAVE THE HIGHEST
--    CANCELLATION RATE?
-- =============================================

SELECT
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders,

    COUNT(o.order_id) FILTER (
        WHERE o.order_status = 'Cancelled'
    ) AS cancelled_orders,

    ROUND(
        100.0 *
        COUNT(o.order_id) FILTER (
            WHERE o.order_status = 'Cancelled'
        ) / NULLIF(COUNT(o.order_id), 0),
        2
    ) AS cancellation_rate_percentage

FROM restaurants r

LEFT JOIN orders o
    ON r.restaurant_id = o.restaurant_id

GROUP BY
    r.restaurant_id,
    r.restaurant_name

ORDER BY
    cancellation_rate_percentage DESC;


-- =============================================
-- 9. DELIVERY PARTNER PERFORMANCE
-- =============================================

SELECT
    dp.name AS delivery_partner,
    COUNT(d.delivery_id) FILTER (
        WHERE d.delivery_status = 'Delivered'
    ) AS completed_deliveries,

    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (d.delivery_time - d.pickup_time)
            ) / 60
        ) FILTER (
            WHERE d.delivery_status = 'Delivered'
              AND d.delivery_time IS NOT NULL
              AND d.pickup_time IS NOT NULL
        ),
        2
    ) AS avg_delivery_minutes

FROM delivery_partners dp

LEFT JOIN deliveries d
    ON dp.delivery_partner_id = d.delivery_partner_id

GROUP BY
    dp.delivery_partner_id,
    dp.name

ORDER BY avg_delivery_minutes NULLS LAST;


-- =============================================
-- 10. MONTHLY REVENUE TREND
-- =============================================

SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(order_id) AS delivered_orders,
    ROUND(SUM(total_amount), 2) AS monthly_revenue
FROM orders
WHERE order_status = 'Delivered'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;


-- =============================================
-- 11. MONTH-OVER-MONTH REVENUE GROWTH
-- =============================================

WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(total_amount) AS revenue
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY DATE_TRUNC('month', order_date)
),

revenue_growth AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY month
        ) AS previous_month_revenue
    FROM monthly_revenue
)

SELECT
    TO_CHAR(month, 'YYYY-MM') AS month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_month_revenue, 2)
        AS previous_month_revenue,

    ROUND(
        100.0 *
        (revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS growth_percentage

FROM revenue_growth
ORDER BY month;


-- =============================================
-- 12. REPEAT CUSTOMER ANALYSIS
-- =============================================

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS total_orders
    FROM orders
    GROUP BY customer_id
)

SELECT
    COUNT(*) AS customers_who_ordered,

    COUNT(*) FILTER (
        WHERE total_orders > 1
    ) AS repeat_customers,

    ROUND(
        100.0 *
        COUNT(*) FILTER (
            WHERE total_orders > 1
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_customer_percentage

FROM customer_orders;


-- =============================================
-- 13. PAYMENT METHOD PERFORMANCE
-- =============================================

SELECT
    payment_method,
    COUNT(*) AS total_transactions,

    COUNT(*) FILTER (
        WHERE payment_status = 'Completed'
    ) AS completed_transactions,

    COUNT(*) FILTER (
        WHERE payment_status = 'Refunded'
    ) AS refunded_transactions,

    ROUND(
        100.0 *
        COUNT(*) FILTER (
            WHERE payment_status = 'Completed'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS payment_success_rate

FROM payments

GROUP BY payment_method
ORDER BY total_transactions DESC;

-- =============================================
-- 14. RESTAURANT RATINGS VS REVENUE
-- Uses separate CTEs to avoid duplicate revenue
-- caused by joining orders and reviews directly.
-- =============================================

WITH restaurant_revenue AS (
    SELECT
        restaurant_id,
        SUM(total_amount) AS total_revenue
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY restaurant_id
),

restaurant_reviews AS (
    SELECT
        restaurant_id,
        AVG(rating) AS avg_customer_rating,
        COUNT(review_id) AS total_reviews
    FROM reviews
    GROUP BY restaurant_id
)

SELECT
    r.restaurant_name,
    r.rating AS listed_rating,

    ROUND(
        rr.avg_customer_rating,
        2
    ) AS customer_review_rating,

    COALESCE(
        rr.total_reviews,
        0
    ) AS total_reviews,

    ROUND(
        COALESCE(rv.total_revenue, 0),
        2
    ) AS delivered_revenue

FROM restaurants r

LEFT JOIN restaurant_revenue rv
    ON r.restaurant_id = rv.restaurant_id

LEFT JOIN restaurant_reviews rr
    ON r.restaurant_id = rr.restaurant_id

ORDER BY delivered_revenue DESC;





-- =============================================
-- 15. EXECUTIVE KPI SUMMARY
-- =============================================

SELECT
    COUNT(*) AS total_orders,

    COUNT(*) FILTER (
        WHERE order_status = 'Delivered'
    ) AS delivered_orders,

    COUNT(*) FILTER (
        WHERE order_status = 'Cancelled'
    ) AS cancelled_orders,

    ROUND(
        SUM(total_amount) FILTER (
            WHERE order_status = 'Delivered'
        ),
        2
    ) AS total_revenue,

    ROUND(
        AVG(total_amount) FILTER (
            WHERE order_status = 'Delivered'
        ),
        2
    ) AS average_order_value,

    ROUND(
        100.0 *
        COUNT(*) FILTER (
            WHERE order_status = 'Delivered'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS delivery_success_rate

FROM orders;
