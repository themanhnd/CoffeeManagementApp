-- =====================================================
-- Coffee Shop Management System - Master Data
-- Version: 2.0
-- Date: 2024-01-01
-- Description: Insert master data for coffee shop
-- =====================================================

-- =====================================================
-- CATEGORIES DATA
-- =====================================================

INSERT INTO categories (category_code, name, description, parent_id, display_order, is_active) VALUES
('CAT001', 'Beverages', 'All types of drinks', NULL, 1, TRUE),
('CAT002', 'Hot Coffee', 'Hot coffee beverages', 1, 1, TRUE),
('CAT003', 'Cold Coffee', 'Iced and cold coffee drinks', 1, 2, TRUE),
('CAT004', 'Tea', 'Hot and cold tea varieties', 1, 3, TRUE),
('CAT005', 'Non-Coffee', 'Non-coffee beverages', 1, 4, TRUE),
('CAT006', 'Food', 'Food items', NULL, 2, TRUE),
('CAT007', 'Breakfast', 'Breakfast items', 6, 1, TRUE),
('CAT008', 'Lunch', 'Lunch items', 6, 2, TRUE),
('CAT009', 'Snacks', 'Light snacks and appetizers', 6, 3, TRUE),
('CAT010', 'Desserts', 'Sweet desserts and pastries', NULL, 3, TRUE),
('CAT011', 'Cakes', 'Various cakes', 10, 1, TRUE),
('CAT012', 'Pastries', 'Pastries and baked goods', 10, 2, TRUE),
('CAT013', 'Merchandise', 'Coffee shop merchandise', NULL, 4, TRUE);

-- =====================================================
-- PRODUCTS DATA
-- =====================================================

-- Hot Coffee Products
INSERT INTO products (product_code, name, description, category_id, price, cost, size, type, calories, preparation_time, is_available, is_featured, stock_quantity, min_stock_level, allergen_info) VALUES
('PRD001', 'Espresso', 'Rich and intense single shot of espresso', 2, 2.50, 0.80, 'SMALL', 'BEVERAGE', 5, 2, TRUE, TRUE, 100, 10, NULL),
('PRD002', 'Americano', 'Espresso with hot water', 2, 3.00, 0.90, 'MEDIUM', 'BEVERAGE', 10, 3, TRUE, FALSE, 100, 10, NULL),
('PRD003', 'Cappuccino', 'Espresso with steamed milk and foam', 2, 4.50, 1.20, 'MEDIUM', 'BEVERAGE', 120, 4, TRUE, TRUE, 100, 10, 'Contains dairy'),
('PRD004', 'Latte', 'Espresso with steamed milk', 2, 4.75, 1.30, 'LARGE', 'BEVERAGE', 150, 4, TRUE, TRUE, 100, 10, 'Contains dairy'),
('PRD005', 'Macchiato', 'Espresso with a dollop of foamed milk', 2, 4.25, 1.15, 'MEDIUM', 'BEVERAGE', 80, 3, TRUE, FALSE, 100, 10, 'Contains dairy'),
('PRD006', 'Mocha', 'Espresso with chocolate and steamed milk', 2, 5.25, 1.50, 'LARGE', 'BEVERAGE', 280, 5, TRUE, TRUE, 100, 10, 'Contains dairy, chocolate'),

-- Cold Coffee Products
('PRD007', 'Iced Coffee', 'Cold brewed coffee over ice', 3, 3.50, 1.00, 'LARGE', 'BEVERAGE', 15, 2, TRUE, FALSE, 100, 10, NULL),
('PRD008', 'Iced Latte', 'Espresso with cold milk over ice', 3, 4.95, 1.40, 'LARGE', 'BEVERAGE', 160, 3, TRUE, TRUE, 100, 10, 'Contains dairy'),
('PRD009', 'Frappuccino', 'Blended coffee drink with ice', 3, 5.75, 1.70, 'LARGE', 'BEVERAGE', 320, 4, TRUE, TRUE, 100, 10, 'Contains dairy'),
('PRD010', 'Cold Brew', 'Slow-steeped cold coffee', 3, 4.25, 1.25, 'LARGE', 'BEVERAGE', 20, 1, TRUE, FALSE, 50, 5, NULL),

-- Tea Products
('PRD011', 'Green Tea', 'Premium green tea', 4, 2.75, 0.70, 'MEDIUM', 'BEVERAGE', 2, 3, TRUE, FALSE, 100, 10, NULL),
('PRD012', 'Earl Grey', 'Classic Earl Grey black tea', 4, 2.75, 0.70, 'MEDIUM', 'BEVERAGE', 2, 3, TRUE, FALSE, 100, 10, NULL),
('PRD013', 'Chai Latte', 'Spiced tea with steamed milk', 4, 4.25, 1.15, 'LARGE', 'BEVERAGE', 140, 4, TRUE, TRUE, 100, 10, 'Contains dairy, spices'),
('PRD014', 'Iced Tea', 'Refreshing iced tea', 4, 2.95, 0.80, 'LARGE', 'BEVERAGE', 5, 2, TRUE, FALSE, 100, 10, NULL),

-- Non-Coffee Beverages
('PRD015', 'Hot Chocolate', 'Rich hot chocolate drink', 5, 3.75, 1.05, 'MEDIUM', 'BEVERAGE', 240, 3, TRUE, TRUE, 100, 10, 'Contains dairy, chocolate'),
('PRD016', 'Smoothie', 'Fresh fruit smoothie', 5, 5.50, 1.80, 'LARGE', 'BEVERAGE', 180, 3, TRUE, FALSE, 50, 5, 'Contains fruit, dairy'),
('PRD017', 'Fresh Orange Juice', 'Freshly squeezed orange juice', 5, 3.95, 1.20, 'MEDIUM', 'BEVERAGE', 110, 2, TRUE, FALSE, 30, 5, NULL),

-- Breakfast Items
('PRD018', 'Croissant', 'Buttery, flaky croissant', 7, 3.25, 1.00, 'MEDIUM', 'FOOD', 231, 0, TRUE, FALSE, 20, 5, 'Contains gluten, dairy'),
('PRD019', 'Breakfast Sandwich', 'Egg, cheese, and bacon on English muffin', 7, 6.50, 2.50, 'MEDIUM', 'FOOD', 450, 5, TRUE, TRUE, 15, 3, 'Contains gluten, dairy, eggs'),
('PRD020', 'Avocado Toast', 'Toasted bread with fresh avocado', 7, 5.75, 2.00, 'MEDIUM', 'FOOD', 320, 3, TRUE, TRUE, 10, 2, 'Contains gluten'),
('PRD021', 'Oatmeal', 'Warm oatmeal with toppings', 7, 4.95, 1.50, 'MEDIUM', 'FOOD', 280, 3, TRUE, FALSE, 25, 5, 'Contains oats'),

-- Lunch Items
('PRD022', 'Grilled Chicken Salad', 'Fresh salad with grilled chicken', 8, 8.95, 3.50, 'LARGE', 'FOOD', 380, 8, TRUE, TRUE, 12, 3, NULL),
('PRD023', 'Turkey Sandwich', 'Turkey sandwich with fresh vegetables', 8, 7.50, 2.80, 'MEDIUM', 'FOOD', 420, 5, TRUE, FALSE, 15, 3, 'Contains gluten, dairy'),
('PRD024', 'Soup of the Day', 'Daily featured soup', 8, 5.25, 1.80, 'MEDIUM', 'FOOD', 200, 2, TRUE, FALSE, 20, 5, 'Varies by day'),
('PRD025', 'Quinoa Bowl', 'Healthy quinoa bowl with vegetables', 8, 9.25, 3.20, 'LARGE', 'FOOD', 450, 6, TRUE, TRUE, 10, 2, NULL),

-- Snacks
('PRD026', 'Blueberry Muffin', 'Fresh blueberry muffin', 9, 3.50, 1.20, 'MEDIUM', 'FOOD', 340, 0, TRUE, FALSE, 25, 5, 'Contains gluten, dairy, eggs'),
('PRD027', 'Chocolate Chip Cookie', 'Homemade chocolate chip cookie', 9, 2.75, 0.90, 'SMALL', 'FOOD', 160, 0, TRUE, TRUE, 30, 10, 'Contains gluten, dairy, chocolate'),
('PRD028', 'Granola Bar', 'Healthy granola bar', 9, 3.25, 1.10, 'SMALL', 'FOOD', 140, 0, TRUE, FALSE, 40, 10, 'Contains nuts, oats'),

-- Desserts
('PRD029', 'Cheesecake', 'New York style cheesecake', 11, 5.95, 2.20, 'MEDIUM', 'DESSERT', 410, 0, TRUE, TRUE, 8, 2, 'Contains dairy, eggs, gluten'),
('PRD030', 'Chocolate Cake', 'Rich chocolate layer cake', 11, 4.95, 1.80, 'MEDIUM', 'DESSERT', 380, 0, TRUE, FALSE, 6, 1, 'Contains dairy, eggs, gluten, chocolate'),
('PRD031', 'Tiramisu', 'Classic Italian tiramisu', 11, 6.25, 2.50, 'MEDIUM', 'DESSERT', 450, 0, TRUE, TRUE, 5, 1, 'Contains dairy, eggs, coffee, alcohol'),
('PRD032', 'Danish Pastry', 'Flaky pastry with fruit filling', 12, 3.75, 1.30, 'MEDIUM', 'DESSERT', 290, 0, TRUE, FALSE, 15, 3, 'Contains gluten, dairy'),

-- Merchandise
('PRD033', 'Coffee Mug', 'Coffee shop branded ceramic mug', 13, 12.99, 5.00, 'MEDIUM', 'MERCHANDISE', 0, 0, TRUE, FALSE, 50, 10, NULL),
('PRD034', 'Coffee Beans (1lb)', 'Premium coffee beans for home brewing', 13, 15.99, 8.00, 'MEDIUM', 'MERCHANDISE', 0, 0, TRUE, TRUE, 25, 5, NULL),
('PRD035', 'Travel Tumbler', 'Insulated travel tumbler', 13, 18.99, 9.00, 'LARGE', 'MERCHANDISE', 0, 0, TRUE, FALSE, 30, 5, NULL);

-- =====================================================
-- USERS DATA (Admin and Initial Employees)
-- =====================================================

INSERT INTO users (username, email, password_hash, first_name, last_name, phone, is_active) VALUES
('admin', 'admin@coffeeshop.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'System', 'Administrator', '+1234567890', TRUE),
('manager1', 'manager1@coffeeshop.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'John', 'Smith', '+1234567891', TRUE),
('barista1', 'barista1@coffeeshop.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Emma', 'Johnson', '+1234567892', TRUE),
('barista2', 'barista2@coffeeshop.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Michael', 'Davis', '+1234567893', TRUE),
('cashier1', 'cashier1@coffeeshop.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Sarah', 'Wilson', '+1234567894', TRUE);

-- =====================================================
-- EMPLOYEES DATA
-- =====================================================

INSERT INTO employees (user_id, employee_code, position, department, hire_date, salary, is_manager, manager_id, status) VALUES
(1, 'EMP001', 'System Administrator', 'IT', '2024-01-01', 75000.00, TRUE, NULL, 'ACTIVE'),
(2, 'EMP002', 'Store Manager', 'Operations', '2024-01-01', 55000.00, TRUE, 1, 'ACTIVE'),
(3, 'EMP003', 'Senior Barista', 'Operations', '2024-01-01', 35000.00, FALSE, 2, 'ACTIVE'),
(4, 'EMP004', 'Barista', 'Operations', '2024-01-02', 32000.00, FALSE, 2, 'ACTIVE'),
(5, 'EMP005', 'Cashier', 'Operations', '2024-01-02', 30000.00, FALSE, 2, 'ACTIVE');

-- =====================================================
-- SAMPLE CUSTOMERS DATA
-- =====================================================

INSERT INTO customers (customer_code, first_name, last_name, email, phone, date_of_birth, loyalty_points, membership_tier, preferred_contact, is_active) VALUES
('CUST001', 'Alice', 'Brown', 'alice.brown@email.com', '+1555000001', '1990-05-15', 150, 'BRONZE', 'EMAIL', TRUE),
('CUST002', 'Bob', 'Taylor', 'bob.taylor@email.com', '+1555000002', '1985-08-22', 750, 'SILVER', 'PHONE', TRUE),
('CUST003', 'Carol', 'Martinez', 'carol.martinez@email.com', '+1555000003', '1992-12-03', 1250, 'GOLD', 'EMAIL', TRUE),
('CUST004', 'David', 'Anderson', 'david.anderson@email.com', '+1555000004', '1988-03-18', 2100, 'PLATINUM', 'EMAIL', TRUE),
('CUST005', 'Eva', 'Garcia', 'eva.garcia@email.com', '+1555000005', '1995-07-11', 320, 'BRONZE', 'SMS', TRUE),
('CUST006', 'Frank', 'Lee', 'frank.lee@email.com', '+1555000006', '1983-11-27', 880, 'SILVER', 'EMAIL', TRUE),
('CUST007', 'Grace', 'White', 'grace.white@email.com', '+1555000007', '1991-09-14', 45, 'BRONZE', 'PHONE', TRUE),
('CUST008', 'Henry', 'Clark', 'henry.clark@email.com', '+1555000008', '1987-06-30', 1650, 'GOLD', 'EMAIL', TRUE),
('CUST009', 'Iris', 'Rodriguez', 'iris.rodriguez@email.com', '+1555000009', '1993-04-25', 95, 'BRONZE', 'EMAIL', TRUE),
('CUST010', 'Jack', 'Lewis', 'jack.lewis@email.com', '+1555000010', '1986-01-08', 2850, 'PLATINUM', 'EMAIL', TRUE);

-- =====================================================
-- SAMPLE ORDERS DATA
-- =====================================================

-- Insert some sample orders
INSERT INTO orders (order_number, customer_id, employee_id, order_type, status, table_number, subtotal, tax_amount, discount_amount, total_amount, payment_method, payment_status, notes, estimated_ready_time, completed_at) VALUES
('ORD20240101001', 1, 3, 'DINE_IN', 'COMPLETED', 'T05', 12.25, 0.98, 0.00, 13.23, 'CARD', 'PAID', 'Extra hot cappuccino', '2024-01-01 09:15:00', '2024-01-01 09:12:00'),
('ORD20240101002', 2, 4, 'TAKEAWAY', 'COMPLETED', NULL, 8.50, 0.68, 1.00, 8.18, 'CASH', 'PAID', 'No sugar in latte', '2024-01-01 10:30:00', '2024-01-01 10:28:00'),
('ORD20240101003', NULL, 5, 'DINE_IN', 'COMPLETED', 'T12', 15.75, 1.26, 0.00, 17.01, 'MOBILE', 'PAID', '', '2024-01-01 11:45:00', '2024-01-01 11:42:00'),
('ORD20240101004', 3, 3, 'TAKEAWAY', 'READY', NULL, 22.50, 1.80, 2.25, 22.05, 'LOYALTY_POINTS', 'PAID', 'Birthday order', '2024-01-01 14:15:00', NULL),
('ORD20240101005', 4, 4, 'DELIVERY', 'PREPARING', NULL, 31.25, 2.50, 0.00, 33.75, 'CARD', 'PAID', 'Office delivery', '2024-01-01 15:30:00', NULL);

-- Insert order items for the sample orders
INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price, customizations, notes, status) VALUES
-- Order 1 items
(1, 3, 2, 4.50, 9.00, '{"milk": "oat", "size": "large"}', 'Extra hot', 'SERVED'),
(1, 27, 1, 2.75, 2.75, NULL, NULL, 'SERVED'),
(1, 11, 1, 2.75, 2.75, NULL, NULL, 'SERVED'),

-- Order 2 items  
(2, 4, 1, 4.75, 4.75, '{"sugar": "none", "milk": "almond"}', 'No sugar', 'SERVED'),
(2, 26, 1, 3.50, 3.50, NULL, NULL, 'SERVED'),

-- Order 3 items
(3, 6, 2, 5.25, 10.50, '{"whipped_cream": "extra"}', NULL, 'SERVED'),
(3, 19, 1, 6.50, 6.50, NULL, NULL, 'SERVED'),

-- Order 4 items
(4, 9, 2, 5.75, 11.50, '{"flavor": "caramel"}', NULL, 'READY'),
(4, 29, 1, 5.95, 5.95, NULL, 'Birthday cake', 'READY'),
(4, 31, 1, 6.25, 6.25, NULL, NULL, 'READY'),

-- Order 5 items
(5, 22, 2, 8.95, 17.90, '{"dressing": "ranch"}', NULL, 'PREPARING'),
(5, 8, 2, 4.95, 9.90, '{"ice": "light"}', NULL, 'PREPARING'),
(5, 28, 3, 3.25, 9.75, NULL, NULL, 'PREPARING');

