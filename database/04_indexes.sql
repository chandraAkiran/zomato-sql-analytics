-- =============================================
-- ZOMATO SQL ANALYTICS PROJECT
-- INDEXES & PERFORMANCE OPTIMIZATION
-- Author: Chandra Akash Kiran
-- =============================================


-- =============================================
-- 1. RESTAURANT LOCATION LOOKUP
-- =============================================

CREATE INDEX idx_restaurants_location_id
ON restaurants(location_id);


-- =============================================
-- 2. MENU ITEMS BY RESTAURANT
-- =============================================

CREATE INDEX idx_menu_items_restaurant_id
ON menu_items(restaurant_id);


-- =============================================
-- 3. ORDERS BY CUSTOMER
-- =============================================

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);


-- =============================================
-- 4. ORDERS BY RESTAURANT
-- =============================================

CREATE INDEX idx_orders_restaurant_id
ON orders(restaurant_id);


-- =============================================
-- 5. ORDERS BY DATE
-- Useful for monthly / time-series analysis
-- =============================================

CREATE INDEX idx_orders_order_date
ON orders(order_date);


-- =============================================
-- 6. ORDERS BY STATUS
-- =============================================

CREATE INDEX idx_orders_status
ON orders(order_status);


-- =============================================
-- 7. ORDER ITEMS BY ORDER
-- =============================================

CREATE INDEX idx_order_items_order_id
ON order_items(order_id);


-- =============================================
-- 8. ORDER ITEMS BY MENU ITEM
-- =============================================

CREATE INDEX idx_order_items_item_id
ON order_items(item_id);


-- =============================================
-- 9. DELIVERIES BY DELIVERY PARTNER
-- =============================================

CREATE INDEX idx_deliveries_partner_id
ON deliveries(delivery_partner_id);


-- =============================================
-- 10. REVIEWS BY CUSTOMER
-- =============================================

CREATE INDEX idx_reviews_customer_id
ON reviews(customer_id);


-- =============================================
-- 11. REVIEWS BY RESTAURANT
-- =============================================

CREATE INDEX idx_reviews_restaurant_id
ON reviews(restaurant_id);


-- =============================================
-- 12. COMPOSITE INDEX FOR RESTAURANT
-- REVENUE / STATUS ANALYSIS
-- =============================================

CREATE INDEX idx_orders_restaurant_status
ON orders(restaurant_id, order_status);
