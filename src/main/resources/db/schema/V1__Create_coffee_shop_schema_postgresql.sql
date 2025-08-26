-- =====================================================
-- Coffee Shop Management System - Database Schema (PostgreSQL)
-- Version: 1.0
-- Date: 2024-01-01
-- Description: Initial schema for coffee shop management
-- =====================================================

-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Drop tables if they exist (for development)
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS outbox_events CASCADE;
DROP TABLE IF EXISTS event_store CASCADE;

-- Create ENUMs
CREATE TYPE employee_status AS ENUM ('ACTIVE', 'INACTIVE', 'TERMINATED');
CREATE TYPE membership_tier AS ENUM ('BRONZE', 'SILVER', 'GOLD', 'PLATINUM');
CREATE TYPE contact_preference AS ENUM ('EMAIL', 'PHONE', 'SMS');
CREATE TYPE product_size AS ENUM ('SMALL', 'MEDIUM', 'LARGE', 'EXTRA_LARGE');
CREATE TYPE product_type AS ENUM ('BEVERAGE', 'FOOD', 'DESSERT', 'MERCHANDISE');
CREATE TYPE order_type AS ENUM ('DINE_IN', 'TAKEAWAY', 'DELIVERY');
CREATE TYPE order_status AS ENUM ('PENDING', 'CONFIRMED', 'PREPARING', 'READY', 'COMPLETED', 'CANCELLED');
CREATE TYPE payment_method AS ENUM ('CASH', 'CARD', 'MOBILE', 'LOYALTY_POINTS');
CREATE TYPE payment_status AS ENUM ('PENDING', 'PAID', 'FAILED', 'REFUNDED');
CREATE TYPE item_status AS ENUM ('PENDING', 'PREPARING', 'READY', 'SERVED');
CREATE TYPE outbox_status AS ENUM ('PENDING', 'PROCESSED', 'FAILED');

-- =====================================================
-- USERS & AUTHENTICATION
-- =====================================================

-- Users table for authentication
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by BIGINT,
    updated_by BIGINT
);

CREATE INDEX idx_users_username ON users (username);
CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_users_active ON users (is_active);

-- =====================================================
-- EMPLOYEE MANAGEMENT
-- =====================================================

-- Employees table
CREATE TABLE employees (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    employee_code VARCHAR(20) UNIQUE NOT NULL,
    position VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(12,2),
    is_manager BOOLEAN DEFAULT FALSE,
    manager_id BIGINT,
    status employee_status DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES employees(id) ON DELETE SET NULL
);

CREATE INDEX idx_employees_code ON employees (employee_code);
CREATE INDEX idx_employees_user ON employees (user_id);
CREATE INDEX idx_employees_manager ON employees (manager_id);
CREATE INDEX idx_employees_status ON employees (status);

-- =====================================================
-- CUSTOMER MANAGEMENT
-- =====================================================

-- Customers table
CREATE TABLE customers (
    id BIGSERIAL PRIMARY KEY,
    customer_code VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    date_of_birth DATE,
    loyalty_points INTEGER DEFAULT 0,
    membership_tier membership_tier DEFAULT 'BRONZE',
    preferred_contact contact_preference DEFAULT 'EMAIL',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_customers_code ON customers (customer_code);
CREATE INDEX idx_customers_email ON customers (email);
CREATE INDEX idx_customers_phone ON customers (phone);
CREATE INDEX idx_customers_tier ON customers (membership_tier);
CREATE INDEX idx_customers_active ON customers (is_active);

-- =====================================================
-- PRODUCT MANAGEMENT
-- =====================================================

-- Product categories
CREATE TABLE categories (
    id BIGSERIAL PRIMARY KEY,
    category_code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_id BIGINT,
    display_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
);

CREATE INDEX idx_categories_code ON categories (category_code);
CREATE INDEX idx_categories_parent ON categories (parent_id);
CREATE INDEX idx_categories_active ON categories (is_active);
CREATE INDEX idx_categories_order ON categories (display_order);

-- Products table
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    product_code VARCHAR(30) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    category_id BIGINT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2),
    size product_size DEFAULT 'MEDIUM',
    type product_type NOT NULL,
    calories INTEGER,
    preparation_time INTEGER, -- in minutes
    is_available BOOLEAN DEFAULT TRUE,
    is_featured BOOLEAN DEFAULT FALSE,
    stock_quantity INTEGER DEFAULT 0,
    min_stock_level INTEGER DEFAULT 5,
    image_url VARCHAR(255),
    allergen_info TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT
);

CREATE INDEX idx_products_code ON products (product_code);
CREATE INDEX idx_products_category ON products (category_id);
CREATE INDEX idx_products_type ON products (type);
CREATE INDEX idx_products_available ON products (is_available);
CREATE INDEX idx_products_featured ON products (is_featured);
CREATE INDEX idx_products_price ON products (price);

-- Full-text search index for PostgreSQL
CREATE INDEX idx_products_search ON products USING gin(to_tsvector('english', name || ' ' || COALESCE(description, '')));

-- =====================================================
-- ORDER MANAGEMENT
-- =====================================================

-- Orders table
CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    order_number VARCHAR(20) UNIQUE NOT NULL,
    customer_id BIGINT,
    employee_id BIGINT NOT NULL,
    order_type order_type NOT NULL,
    status order_status DEFAULT 'PENDING',
    table_number VARCHAR(10),
    subtotal DECIMAL(10,2) NOT NULL,
    tax_amount DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_method payment_method NOT NULL,
    payment_status payment_status DEFAULT 'PENDING',
    notes TEXT,
    estimated_ready_time TIMESTAMP,
    completed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE RESTRICT
);

CREATE INDEX idx_orders_number ON orders (order_number);
CREATE INDEX idx_orders_customer ON orders (customer_id);
CREATE INDEX idx_orders_employee ON orders (employee_id);
CREATE INDEX idx_orders_status ON orders (status);
CREATE INDEX idx_orders_type ON orders (order_type);
CREATE INDEX idx_orders_payment ON orders (payment_status);
CREATE INDEX idx_orders_date ON orders (created_at);
CREATE INDEX idx_orders_completed ON orders (completed_at);

-- Order items table
CREATE TABLE order_items (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    customizations JSONB, -- JSON format for customizations
    notes VARCHAR(255),
    status item_status DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
);

CREATE INDEX idx_order_items_order ON order_items (order_id);
CREATE INDEX idx_order_items_product ON order_items (product_id);
CREATE INDEX idx_order_items_status ON order_items (status);

-- =====================================================
-- AUDIT AND SYSTEM TABLES
-- =====================================================

-- Event store table for Event Sourcing
CREATE TABLE event_store (
    id BIGSERIAL PRIMARY KEY,
    aggregate_id VARCHAR(255) NOT NULL,
    aggregate_type VARCHAR(255) NOT NULL,
    event_type VARCHAR(255) NOT NULL,
    event_data JSONB NOT NULL,
    event_metadata JSONB,
    version BIGINT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    UNIQUE (aggregate_id, version)
);

CREATE INDEX idx_event_store_aggregate ON event_store (aggregate_id, aggregate_type);
CREATE INDEX idx_event_store_type ON event_store (event_type);
CREATE INDEX idx_event_store_timestamp ON event_store (timestamp);

-- Outbox pattern table for reliable messaging
CREATE TABLE outbox_events (
    id BIGSERIAL PRIMARY KEY,
    aggregate_id VARCHAR(255) NOT NULL,
    event_type VARCHAR(255) NOT NULL,
    event_data JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    processed_at TIMESTAMP NULL,
    status outbox_status DEFAULT 'PENDING',
    retry_count INTEGER DEFAULT 0,
    error_message TEXT
);

CREATE INDEX idx_outbox_status ON outbox_events (status);
CREATE INDEX idx_outbox_created ON outbox_events (created_at);
CREATE INDEX idx_outbox_aggregate ON outbox_events (aggregate_id);

-- =====================================================
-- FUNCTIONS AND TRIGGERS FOR UPDATED_AT
-- =====================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER users_updated_at_trigger
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER employees_updated_at_trigger
    BEFORE UPDATE ON employees
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER customers_updated_at_trigger
    BEFORE UPDATE ON customers
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER categories_updated_at_trigger
    BEFORE UPDATE ON categories
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER products_updated_at_trigger
    BEFORE UPDATE ON products
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER orders_updated_at_trigger
    BEFORE UPDATE ON orders
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER order_items_updated_at_trigger
    BEFORE UPDATE ON order_items
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- VIEWS FOR REPORTING
-- =====================================================

-- View for order summary
CREATE VIEW order_summary AS
SELECT 
    o.id,
    o.order_number,
    o.created_at,
    o.status,
    o.order_type,
    o.total_amount,
    o.payment_method,
    o.payment_status,
    c.first_name || ' ' || c.last_name AS customer_name,
    e.employee_code,
    u.first_name || ' ' || u.last_name AS employee_name,
    COUNT(oi.id) AS item_count
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.id
JOIN employees e ON o.employee_id = e.id
JOIN users u ON e.user_id = u.id
LEFT JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id, o.order_number, o.created_at, o.status, o.order_type, 
         o.total_amount, o.payment_method, o.payment_status,
         c.first_name, c.last_name, e.employee_code, u.first_name, u.last_name;

-- View for product performance
CREATE VIEW product_performance AS
SELECT 
    p.id,
    p.product_code,
    p.name,
    p.price,
    c.name AS category_name,
    COUNT(oi.id) AS order_count,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.total_price) AS total_revenue,
    AVG(oi.total_price) AS avg_order_value
FROM products p
JOIN categories c ON p.category_id = c.id
LEFT JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id, p.product_code, p.name, p.price, c.name
ORDER BY total_revenue DESC;

