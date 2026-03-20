-- V2__users_and_roles_schema.sql
-- Users, Roles (RBAC), Customers, and Staff Fatigue Tracking

-- 1. Roles Table (RBAC)
-- පද්ධතියේ ඇති විවිධ බලතල මට්ටම්
CREATE TABLE roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE -- e.g., 'ROLE_ADMIN', 'ROLE_MANAGER', 'ROLE_CHEF', 'ROLE_CASHIER', 'ROLE_WAITER'
);

-- Insert Default Roles
INSERT INTO roles (name) VALUES
    ('ROLE_ADMIN'),
    ('ROLE_MANAGER'),
    ('ROLE_CHEF'),
    ('ROLE_CASHIER'),
    ('ROLE_WAITER'),
    ('ROLE_GUEST');

-- 2. Users Table (Staff & Management)
-- පද්ධතිය භාවිතා කරන සියලුම සේවකයින්ගේ දත්ත
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL, -- Spring Security BCrypt Hash
    full_name VARCHAR(255) NOT NULL,
    role_id BIGINT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_role FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT
);

-- 3. Customers Table (POS & Customer Management)
-- POS පද්ධතිය සඳහා පාරිභෝගික තොරතුරු (අවම සහ අත්‍යවශ්‍ය දත්ත පමණි)
CREATE TABLE customers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Staff Shifts Table (Fatigue Monitoring & Welfare)
-- සේවකයින්ගේ (විශේෂයෙන්ම Chefs ලාගේ) වැඩ මුර සටහන් කිරීම
CREATE TABLE staff_shifts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    clock_in_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    clock_out_time TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE, -- TRUE නම් තවමත් වැඩ කරනවා (on-clock)
    CONSTRAINT fk_shift_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);