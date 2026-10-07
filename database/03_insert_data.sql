-- =============================================
-- ZOMATO SQL ANALYTICS PROJECT
-- Sample Data Insertion
-- Author: Chandra Akash Kiran
-- =============================================


-- =============================================
-- 1. LOCATIONS
-- =============================================

INSERT INTO locations (city, area, state, pincode) VALUES
('Bengaluru', 'Koramangala', 'Karnataka', '560034'),
('Bengaluru', 'Indiranagar', 'Karnataka', '560038'),
('Bengaluru', 'Whitefield', 'Karnataka', '560066'),
('Hyderabad', 'Hitech City', 'Telangana', '500081'),
('Hyderabad', 'Banjara Hills', 'Telangana', '500034');


-- =============================================
-- 2. CUSTOMERS
-- =============================================

INSERT INTO customers
(name, email, phone, address, registration_date)
VALUES
('Aarav Sharma', 'aarav.sharma@example.com', '9000000001', 'Koramangala, Bengaluru', '2026-01-10'),
('Priya Reddy', 'priya.reddy@example.com', '9000000002', 'Hitech City, Hyderabad', '2026-01-15'),
('Rahul Verma', 'rahul.verma@example.com', '9000000003', 'Indiranagar, Bengaluru', '2026-02-01'),
('Sneha Patel', 'sneha.patel@example.com', '9000000004', 'Whitefield, Bengaluru', '2026-02-10'),
('Arjun Rao', 'arjun.rao@example.com', '9000000005', 'Banjara Hills, Hyderabad', '2026-03-01'),
('Neha Singh', 'neha.singh@example.com', '9000000006', 'Koramangala, Bengaluru', '2026-03-12'),
('Vikram Kumar', 'vikram.kumar@example.com', '9000000007', 'Hitech City, Hyderabad', '2026-04-05'),
('Ananya Gupta', 'ananya.gupta@example.com', '9000000008', 'Indiranagar, Bengaluru', '2026-04-15');


-- =============================================
-- 3. RESTAURANTS
-- =============================================

INSERT INTO restaurants
(restaurant_name, location_id, cuisine_type, rating, contact_number)
VALUES
('Spice Garden', 1, 'North Indian', 4.5, '8000000001'),
('Pizza Hub', 2, 'Italian', 4.2, '8000000002'),
('South Delight', 3, 'South Indian', 4.6, '8000000003'),
('Biryani House', 4, 'Hyderabadi', 4.7, '8000000004'),
('Urban Cafe', 5, 'Cafe', 4.1, '8000000005');


-- =============================================
-- 4. MENU ITEMS
-- =============================================

INSERT INTO menu_items
(restaurant_id, item_name, category, price, availability_status)
VALUES
(1, 'Paneer Butter Masala', 'Main Course', 280.00, TRUE),
(1, 'Butter Naan', 'Bread', 60.00, TRUE),
(1, 'Dal Tadka', 'Main Course', 220.00, TRUE),

(2, 'Margherita Pizza', 'Pizza', 320.00, TRUE),
(2, 'Farmhouse Pizza', 'Pizza', 450.00, TRUE),
(2, 'Garlic Bread', 'Starter', 180.00, TRUE),

(3, 'Masala Dosa', 'Breakfast', 120.00, TRUE),
(3, 'Idli Sambar', 'Breakfast', 90.00, TRUE),
(3, 'South Indian Thali', 'Main Course', 250.00, TRUE),

(4, 'Chicken Biryani', 'Biryani', 350.00, TRUE),
(4, 'Veg Biryani', 'Biryani', 280.00, TRUE),
(4, 'Chicken 65', 'Starter', 260.00, TRUE),

(5, 'Veg Sandwich', 'Snacks', 180.00, TRUE),
(5, 'Cold Coffee', 'Beverage', 150.00, TRUE),
(5, 'Pasta Alfredo', 'Pasta', 300.00, TRUE);


-- =============================================
-- 5. ORDERS
-- =============================================

INSERT INTO orders
(customer_id, restaurant_id, order_date, order_status, total_amount)
VALUES
(1, 1, '2026-05-01 12:30:00', 'Delivered', 400.00),
(2, 4, '2026-05-02 19:45:00', 'Delivered', 610.00),
(3, 2, '2026-05-03 20:15:00', 'Delivered', 500.00),
(4, 3, '2026-05-05 09:30:00', 'Delivered', 210.00),
(5, 4, '2026-05-06 21:00:00', 'Cancelled', 350.00),
(1, 2, '2026-06-01 18:30:00', 'Delivered', 450.00),
(6, 1, '2026-06-04 13:15:00', 'Delivered', 500.00),
(7, 4, '2026-06-10 20:30:00', 'Delivered', 700.00),
(8, 5, '2026-06-15 17:45:00', 'Delivered', 330.00),
(2, 3, '2026-07-01 08:45:00', 'Delivered', 250.00),
(3, 1, '2026-07-05 14:10:00', 'Preparing', 280.00),
(1, 4, '2026-07-08 21:15:00', 'Out for Delivery', 350.00);


-- =============================================
-- 6. ORDER ITEMS
-- =============================================

INSERT INTO order_items
(order_id, item_id, quantity, price)
VALUES
(1, 1, 1, 280.00),
(1, 2, 2, 60.00),

(2, 10, 1, 350.00),
(2, 12, 1, 260.00),

(3, 4, 1, 320.00),
(3, 6, 1, 180.00),

(4, 7, 1, 120.00),
(4, 8, 1, 90.00),

(5, 10, 1, 350.00),

(6, 5, 1, 450.00),

(7, 1, 1, 280.00),
(7, 3, 1, 220.00),

(8, 10, 2, 350.00),

(9, 13, 1, 180.00),
(9, 14, 1, 150.00),

(10, 9, 1, 250.00),

(11, 1, 1, 280.00),

(12, 10, 1, 350.00);


-- =============================================
-- 7. PAYMENTS
-- =============================================

INSERT INTO payments
(order_id, payment_method, payment_status, transaction_date)
VALUES
(1, 'UPI', 'Completed', '2026-05-01 12:31:00'),
(2, 'Credit Card', 'Completed', '2026-05-02 19:46:00'),
(3, 'UPI', 'Completed', '2026-05-03 20:16:00'),
(4, 'Cash on Delivery', 'Completed', '2026-05-05 10:00:00'),
(5, 'UPI', 'Refunded', '2026-05-06 21:05:00'),
(6, 'Debit Card', 'Completed', '2026-06-01 18:31:00'),
(7, 'UPI', 'Completed', '2026-06-04 13:16:00'),
(8, 'Credit Card', 'Completed', '2026-06-10 20:31:00'),
(9, 'Wallet', 'Completed', '2026-06-15 17:46:00'),
(10, 'UPI', 'Completed', '2026-07-01 08:46:00'),
(11, 'UPI', 'Completed', '2026-07-05 14:11:00'),
(12, 'Credit Card', 'Completed', '2026-07-08 21:16:00');


-- =============================================
-- 8. DELIVERY PARTNERS
-- =============================================

INSERT INTO delivery_partners
(name, phone, vehicle_type)
VALUES
('Ravi Kumar', '7000000001', 'Bike'),
('Suresh Yadav', '7000000002', 'Scooter'),
('Amit Singh', '7000000003', 'Bike'),
('Kiran Reddy', '7000000004', 'Electric Scooter');


-- =============================================
-- 9. DELIVERIES
-- =============================================

INSERT INTO deliveries
(order_id, delivery_partner_id, pickup_time, delivery_time, delivery_status)
VALUES
(1, 1, '2026-05-01 12:45:00', '2026-05-01 13:15:00', 'Delivered'),
(2, 2, '2026-05-02 20:00:00', '2026-05-02 20:40:00', 'Delivered'),
(3, 3, '2026-05-03 20:30:00', '2026-05-03 21:05:00', 'Delivered'),
(4, 4, '2026-05-05 09:45:00', '2026-05-05 10:10:00', 'Delivered'),
(6, 1, '2026-06-01 18:45:00', '2026-06-01 19:20:00', 'Delivered'),
(7, 2, '2026-06-04 13:30:00', '2026-06-04 14:00:00', 'Delivered'),
(8, 3, '2026-06-10 20:45:00', '2026-06-10 21:25:00', 'Delivered'),
(9, 4, '2026-06-15 18:00:00', '2026-06-15 18:30:00', 'Delivered'),
(10, 1, '2026-07-01 09:00:00', '2026-07-01 09:25:00', 'Delivered'),
(12, 2, '2026-07-08 21:30:00', NULL, 'Out for Delivery');


-- =============================================
-- 10. REVIEWS
-- =============================================

INSERT INTO reviews
(customer_id, restaurant_id, rating, review_text, review_date)
VALUES
(1, 1, 5, 'Excellent food and quick delivery.', '2026-05-02'),
(2, 4, 5, 'Biryani was flavorful and fresh.', '2026-05-03'),
(3, 2, 4, 'Pizza was good and delivered hot.', '2026-05-04'),
(4, 3, 5, 'Great South Indian breakfast.', '2026-05-06'),
(1, 2, 4, 'Good pizza and packaging.', '2026-06-02'),
(6, 1, 4, 'Good quality food.', '2026-06-05'),
(7, 4, 5, 'One of the best biryanis.', '2026-06-11'),
(8, 5, 4, 'Nice cafe food and coffee.', '2026-06-16'),
(2, 3, 5, 'Excellent thali.', '2026-07-02');
