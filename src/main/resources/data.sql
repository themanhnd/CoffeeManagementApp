-- =============================================
-- DỮ LIỆU MẪU CHO QUÁN CAFE
-- Tương thích với schema UUID hiện tại của bạn
-- =============================================

-- Note: Vì bạn đã có schema sẵn, file này chỉ chứa dữ liệu mẫu cơ bản
-- để đảm bảo ứng dụng có thể khởi động và test

-- =============================================
-- 1. DỮ LIỆU DANH MỤC SẢN PHẨM
-- =============================================

INSERT INTO categories (id, name, description, display_order, is_active) VALUES
(uuid_generate_v4(), 'Cà phê', 'Các loại cà phê nóng và lạnh', 1, true),
(uuid_generate_v4(), 'Trà', 'Các loại trà và trà sữa', 2, true),
(uuid_generate_v4(), 'Bánh ngọt', 'Bánh ngọt và dessert', 3, true),
(uuid_generate_v4(), 'Đồ ăn nhẹ', 'Sandwich, salad và các món ăn nhẹ', 4, true)
ON CONFLICT (name) DO NOTHING;

-- =============================================
-- 2. DỮ LIỆU SẢN PHẨM MẪU
-- =============================================

-- Lấy category IDs để sử dụng trong products
WITH cafe_category AS (
    SELECT id FROM categories WHERE name = 'Cà phê' LIMIT 1
),
tra_category AS (
    SELECT id FROM categories WHERE name = 'Trà' LIMIT 1
),
banh_category AS (
    SELECT id FROM categories WHERE name = 'Bánh ngọt' LIMIT 1
)

INSERT INTO products (id, category_id, product_code, name, description, base_price, cost_price, size_options, customization_options, preparation_time, is_available, is_featured) VALUES
-- Cà phê
(uuid_generate_v4(), (SELECT id FROM cafe_category), 'CF001', 'Cà phê đen', 'Cà phê đen truyền thống', 25000, 8000, '{"S": 20000, "M": 25000, "L": 30000}', '{"ice": ["ít đá", "vừa đá", "nhiều đá"], "sugar": ["không đường", "ít đường", "vừa đường", "nhiều đường"]}', 3, true, true),
(uuid_generate_v4(), (SELECT id FROM cafe_category), 'CF002', 'Cà phê sữa', 'Cà phê sữa đậm đà', 30000, 12000, '{"S": 25000, "M": 30000, "L": 35000}', '{"ice": ["ít đá", "vừa đá", "nhiều đá"], "milk": ["sữa tươi", "sữa đặc", "sữa dừa"]}', 4, true, true),
(uuid_generate_v4(), (SELECT id FROM cafe_category), 'CF003', 'Cappuccino', 'Cappuccino Ý với foam mịn', 45000, 18000, '{"S": 40000, "M": 45000, "L": 50000}', '{"milk": ["sữa tươi", "sữa yến mạch", "sữa hạnh nhân"], "foam": ["ít foam", "vừa foam", "nhiều foam"]}', 5, true, false),

-- Trà
(uuid_generate_v4(), (SELECT id FROM tra_category), 'TR001', 'Trà đào', 'Trà đào cam sả tươi mát', 35000, 15000, '{"S": 30000, "M": 35000, "L": 40000}', '{"ice": ["ít đá", "vừa đá", "nhiều đá"], "sugar": ["không đường", "ít đường", "vừa đường"]}', 3, true, true),
(uuid_generate_v4(), (SELECT id FROM tra_category), 'TR002', 'Trà sữa truyền thống', 'Trà sữa Đài Loan nguyên chất', 40000, 18000, '{"S": 35000, "M": 40000, "L": 45000}', '{"ice": ["ít đá", "vừa đá", "nhiều đá"], "topping": ["trân châu", "thạch", "không topping"]}', 4, true, true),

-- Bánh ngọt
(uuid_generate_v4(), (SELECT id FROM banh_category), 'BN001', 'Bánh croissant', 'Bánh croissant bơ thơm ngon', 25000, 12000, '{}', '{}', 0, true, false),
(uuid_generate_v4(), (SELECT id FROM banh_category), 'BN002', 'Tiramisu', 'Tiramisu Ý truyền thống', 55000, 25000, '{}', '{}', 0, true, true)
ON CONFLICT (product_code) DO NOTHING;

-- =============================================
-- 3. DỮ LIỆU NGƯỜI DÙNG MẪU
-- =============================================

-- Người dùng mẫu (giả định đã có trong Keycloak)
INSERT INTO users (id, keycloak_user_id, employee_code, full_name, phone, email, position, hire_date, salary, status) VALUES
(uuid_generate_v4(), 'admin-keycloak-uuid', 'EMP001', 'Nguyễn Văn Admin', '+84901234567', 'admin@cafe.com', 'Quản lý', '2024-01-01', 15000000, 'active'),
(uuid_generate_v4(), 'manager-keycloak-uuid', 'EMP002', 'Trần Thị Manager', '+84901234568', 'manager@cafe.com', 'Quản lý ca', '2024-01-01', 12000000, 'active'),
(uuid_generate_v4(), 'barista1-keycloak-uuid', 'EMP003', 'Lê Văn Barista', '+84901234569', 'barista1@cafe.com', 'Pha chế', '2024-01-02', 8000000, 'active'),
(uuid_generate_v4(), 'cashier1-keycloak-uuid', 'EMP004', 'Phạm Thị Thu Ngân', '+84901234570', 'cashier1@cafe.com', 'Thu ngân', '2024-01-02', 7500000, 'active')
ON CONFLICT (keycloak_user_id) DO NOTHING;

-- =============================================
-- 4. DỮ LIỆU KHÁCH HÀNG MẪU
-- =============================================

INSERT INTO customers (id, customer_code, full_name, phone, email, customer_type, points, total_spent) VALUES
(uuid_generate_v4(), 'CUST001', 'Nguyễn Văn Khách', '+84912345678', 'customer1@email.com', 'regular', 150, 500000),
(uuid_generate_v4(), 'CUST002', 'Trần Thị Hàng', '+84912345679', 'customer2@email.com', 'vip', 850, 2500000),
(uuid_generate_v4(), 'CUST003', 'Lê Minh Tùng', '+84912345680', 'customer3@email.com', 'member', 320, 1200000)
ON CONFLICT (customer_code) DO NOTHING;

-- =============================================
-- 5. DỮ LIỆU BÀN MẪU
-- =============================================

INSERT INTO tables (id, table_number, table_name, capacity, location, status) VALUES
(uuid_generate_v4(), 'T01', 'Bàn 1', 2, 'Tầng 1', 'available'),
(uuid_generate_v4(), 'T02', 'Bàn 2', 4, 'Tầng 1', 'available'),
(uuid_generate_v4(), 'T03', 'Bàn 3', 2, 'Tầng 1', 'available'),
(uuid_generate_v4(), 'T04', 'Bàn 4', 6, 'Tầng 2', 'available'),
(uuid_generate_v4(), 'T05', 'Bàn 5', 4, 'Tầng 2', 'available'),
(uuid_generate_v4(), 'T06', 'Bàn VIP 1', 8, 'Phòng VIP', 'available'),
(uuid_generate_v4(), 'OUT01', 'Bàn ngoài trời 1', 4, 'Sân thượng', 'available'),
(uuid_generate_v4(), 'OUT02', 'Bàn ngoài trời 2', 2, 'Sân thượng', 'available')
ON CONFLICT (table_number) DO NOTHING;

-- =============================================
-- 6. DỮ LIỆU CA LÀM VIỆC
-- =============================================

INSERT INTO work_shifts (id, name, start_time, end_time, is_active) VALUES
(uuid_generate_v4(), 'Ca sáng', '06:00:00', '14:00:00', true),
(uuid_generate_v4(), 'Ca chiều', '14:00:00', '22:00:00', true),
(uuid_generate_v4(), 'Ca tối', '22:00:00', '06:00:00', true),
(uuid_generate_v4(), 'Ca cuối tuần', '08:00:00', '20:00:00', true)
ON CONFLICT (name) DO NOTHING;

-- =============================================
-- 7. DỮ LIỆU NHÀ CUNG CẤP MẪU
-- =============================================

INSERT INTO suppliers (id, supplier_code, name, contact_person, phone, email, address, payment_terms, status) VALUES
(uuid_generate_v4(), 'SUP001', 'Công ty Cà phê Trung Nguyên', 'Nguyễn Văn A', '+84908111222', 'contact@trungnguyen.com', '123 Đường ABC, Quận 1, TP.HCM', 'Thanh toán trong 30 ngày', 'active'),
(uuid_generate_v4(), 'SUP002', 'Nhà cung cấp sữa TH True Milk', 'Trần Thị B', '+84908111223', 'contact@thmilk.vn', '456 Đường XYZ, Quận 3, TP.HCM', 'Thanh toán trong 15 ngày', 'active'),
(uuid_generate_v4(), 'SUP003', 'Bánh ngọt ABC Bakery', 'Lê Văn C', '+84908111224', 'contact@abcbakery.vn', '789 Đường DEF, Quận 5, TP.HCM', 'Thanh toán ngay', 'active')
ON CONFLICT (supplier_code) DO NOTHING;

-- =============================================
-- 8. DỮ LIỆU KHUYẾN MÃI MẪU
-- =============================================

INSERT INTO promotions (id, code, name, description, discount_type, discount_value, min_order_amount, max_discount_amount, usage_limit, start_date, end_date, is_active) VALUES
(uuid_generate_v4(), 'WELCOME10', 'Chào mừng khách hàng mới', 'Giảm 10% cho khách hàng mới', 'percentage', 10, 50000, 50000, 100, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '30 days', true),
(uuid_generate_v4(), 'HAPPY20', 'Giờ vàng giảm giá', 'Giảm 20K cho đơn từ 100K', 'fixed_amount', 20000, 100000, 20000, 200, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '7 days', true),
(uuid_generate_v4(), 'VIP15', 'Ưu đãi khách VIP', 'Giảm 15% cho khách VIP', 'percentage', 15, 0, 100000, null, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '90 days', true)
ON CONFLICT (code) DO NOTHING;