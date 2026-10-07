-- =============================================
-- ZOMATO SQL ANALYTICS PROJECT
-- ADVANCED SQL ANALYSIS
-- Author: Chandra Akash Kiran
-- =============================================


-- =============================================
-- 1. RANK RESTAURANTS BY REVENUE
-- Window Function: DENSE_RANK()
-- =============================================

WITH restaurant_revenue AS (
    SELECT
        r.restaurant_id,
        r.restaurant_name,
        SUM(o.total_amount) AS total_revenue
    FROM restaurants r
    JOIN orders o
        ON r.restaurant_id = o.restaurant_id
    WHERE o.order_status = 'Delivered'
    GROUP BY r.restaurant_id, r.restaurant_name
)
SELECT
    restaurant_name,
    ROUND(total_revenue, 2) AS total_revenue,
    DENSE_RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM restaurant_revenue
ORDER BY revenue_rank;


-- =============================================
-- 2. RANK CUSTOMERS BY TOTAL SPENDING
-- Window Function: RANK()
-- =============================================

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Delivered'
    GROUP BY c.customer_id, c.name
)
SELECT
    name AS customer_name,
    ROUND(total_spent, 2) AS total_spent,
    RANK() OVER (
        ORDER BY total_spent DESC
    ) AS spending_rank
FROM customer_spending
ORDER BY spending_rank;


-- =============================================
-- 3. CUSTOMER SEGMENTATION
-- CASE Statement
-- =============================================

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.name,
        COALESCE(SUM(o.total_amount), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
        AND o.order_status = 'Delivered'
    GROUP BY c.customer_id, c.name
)
SELECT
    customer_id,
    name AS customer_name,
    ROUND(total_spent, 2) AS total_spent,

    CASE
        WHEN total_spent >= 800 THEN 'High Value'
        WHEN total_spent >= 400 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment

FROM customer_spending
ORDER BY total_spent DESC;


-- =============================================
-- 4. REPEAT CUSTOMERS
-- HAVING
-- =============================================

SELECT
    c.customer_id,
    c.name AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;


-- =============================================
-- 5. RESTAURANTS WITH ABOVE-AVERAGE REVENUE
-- CTE + Subquery
-- =============================================

WITH restaurant_revenue AS (
    SELECT
        r.restaurant_id,
        r.restaurant_name,
        SUM(o.total_amount) AS total_revenue
    FROM restaurants r
    JOIN orders o
        ON r.restaurant_id = o.restaurant_id
    WHERE o.order_status = 'Delivered'
    GROUP BY r.restaurant_id, r.restaurant_name
)

SELECT
    restaurant_name,
    ROUND(total_revenue, 2) AS total_revenue
FROM restaurant_revenue
WHERE total_revenue > (
    SELECT AVG(total_revenue)
    FROM restaurant_revenue
)
ORDER BY total_revenue DESC;


-- =============================================
-- 6. MONTHLY REVENUE
-- CTE
-- =============================================

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(total_amount) AS revenue
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    TO_CHAR(month, 'YYYY-MM') AS month,
    ROUND(revenue, 2) AS revenue
FROM monthly_sales
ORDER BY month;


-- =============================================
-- 7. MONTH-OVER-MONTH REVENUE GROWTH
-- Window Function: LAG()
-- =============================================

WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(total_amount) AS revenue
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY DATE_TRUNC('month', order_date)
),

revenue_comparison AS (
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
        ((revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0)) * 100,
        2
    ) AS growth_percentage

FROM revenue_comparison
ORDER BY month;


-- =============================================
-- 8. AVERAGE DELIVERY TIME BY DELIVERY PARTNER
-- =============================================

SELECT
    dp.name AS delivery_partner,
    COUNT(d.delivery_id) AS completed_deliveries,

    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (d.delivery_time - d.pickup_time)
            ) / 60
        ),
        2
    ) AS avg_delivery_minutes

FROM delivery_partners dp
JOIN deliveries d
    ON dp.delivery_partner_id = d.delivery_partner_id

WHERE d.delivery_status = 'Delivered'
AND d.delivery_time IS NOT NULL
AND d.pickup_time IS NOT NULL

GROUP BY
    dp.delivery_partner_id,
    dp.name

ORDER BY avg_delivery_minutes;


-- =============================================
-- 9. FASTEST DELIVERY PARTNER
-- ROW_NUMBER()
-- =============================================

WITH delivery_performance AS (
    SELECT
        dp.delivery_partner_id,
        dp.name,

        AVG(
            EXTRACT(
                EPOCH FROM (d.delivery_time - d.pickup_time)
            ) / 60
        ) AS avg_delivery_minutes

    FROM delivery_partners dp
    JOIN deliveries d
        ON dp.delivery_partner_id = d.delivery_partner_id

    WHERE d.delivery_status = 'Delivered'
    AND d.delivery_time IS NOT NULL
    AND d.pickup_time IS NOT NULL

    GROUP BY
        dp.delivery_partner_id,
        dp.name
),

ranked_partners AS (
    SELECT
        name,
        avg_delivery_minutes,

        ROW_NUMBER() OVER (
            ORDER BY avg_delivery_minutes
        ) AS delivery_rank

    FROM delivery_performance
)

SELECT
    name AS delivery_partner,
    ROUND(avg_delivery_minutes, 2)
        AS avg_delivery_minutes,
    delivery_rank

FROM ranked_partners
ORDER BY delivery_rank;


-- =============================================
-- 10. MOST POPULAR ITEM PER RESTAURANT
-- CTE + DENSE_RANK()
-- =============================================

WITH item_sales AS (
    SELECT
        r.restaurant_name,
        m.item_name,
        SUM(oi.quantity) AS quantity_sold

    FROM order_items oi

    JOIN menu_items m
        ON oi.item_id = m.item_id

    JOIN restaurants r
        ON m.restaurant_id = r.restaurant_id

    JOIN orders o
        ON oi.order_id = o.order_id

    WHERE o.order_status = 'Delivered'

    GROUP BY
        r.restaurant_name,
        m.item_name
),

ranked_items AS (
    SELECT
        restaurant_name,
        item_name,
        quantity_sold,

        DENSE_RANK() OVER (
            PARTITION BY restaurant_name
            ORDER BY quantity_sold DESC
        ) AS item_rank

    FROM item_sales
)

SELECT
    restaurant_name,
    item_name,
    quantity_sold

FROM ranked_items
WHERE item_rank = 1
ORDER BY restaurant_name;


-- =============================================
-- 11. CUSTOMER ORDER HISTORY
-- ROW_NUMBER()
-- =============================================

SELECT
    c.name AS customer_name,
    o.order_id,
    o.order_date,
    o.total_amount,

    ROW_NUMBER() OVER (
        PARTITION BY c.customer_id
        ORDER BY o.order_date
    ) AS customer_order_number

FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id

ORDER BY
    c.customer_id,
    o.order_date;


-- =============================================
-- 12. RESTAURANT REVENUE CONTRIBUTION %
-- =============================================

WITH restaurant_revenue AS (
    SELECT
        r.restaurant_name,
        SUM(o.total_amount) AS revenue

    FROM restaurants r
    JOIN orders o
        ON r.restaurant_id = o.restaurant_id

    WHERE o.order_status = 'Delivered'

    GROUP BY r.restaurant_name
)

SELECT
    restaurant_name,
    ROUND(revenue, 2) AS revenue,

    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER (),
        2
    ) AS revenue_percentage

FROM restaurant_revenue
ORDER BY revenue DESC;


-- =============================================
-- 13. CANCELLATION RATE
-- =============================================

SELECT
    COUNT(*) AS total_orders,

    COUNT(*) FILTER (
        WHERE order_status = 'Cancelled'
    ) AS cancelled_orders,

    ROUND(
        COUNT(*) FILTER (
            WHERE order_status = 'Cancelled'
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_percentage

FROM orders;


-- =============================================
-- 14. RESTAURANT PERFORMANCE BY CITY
-- =============================================

SELECT
    l.city,
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders,

    ROUND(
        SUM(
            CASE
                WHEN o.order_status = 'Delivered'
                THEN o.total_amount
                ELSE 0
            END
        ),
        2
    ) AS delivered_revenue

FROM locations l

JOIN restaurants r
    ON l.location_id = r.location_id

LEFT JOIN orders o
    ON r.restaurant_id = o.restaurant_id

GROUP BY
    l.city,
    r.restaurant_id,
    r.restaurant_name

ORDER BY
    l.city,
    delivered_revenue DESC;


-- =============================================
-- 15. PAYMENT SUCCESS RATE BY METHOD
-- =============================================

SELECT
    payment_method,
    COUNT(*) AS total_transactions,

    COUNT(*) FILTER (
        WHERE payment_status = 'Completed'
    ) AS successful_transactions,

    ROUND(
        COUNT(*) FILTER (
            WHERE payment_status = 'Completed'
        ) * 100.0 / COUNT(*),
        2
    ) AS success_rate_percentage

FROM payments

GROUP BY payment_method
ORDER BY success_rate_percentage DESC;
