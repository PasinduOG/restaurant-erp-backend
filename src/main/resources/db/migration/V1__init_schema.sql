-- V1__init_schema.sql
-- Core ERP Tables: Inventory, Menu, and Bill of Materials (BOM)

-- 1. Ingredients Table (Inventory Management)
-- සියලුම අමුද්‍රව්‍ය සහ ඒවායේ දැනට පවතින තොග මෙහි ගබඩා වේ
CREATE TABLE ingredients (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    unit_of_measure VARCHAR(50) NOT NULL, -- e.g., 'g', 'ml', 'pcs'
    unit_cost DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    current_stock DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    minimum_reorder_level DECIMAL(10, 2) NOT NULL DEFAULT 0.00, -- MRL: Alert යැවීමට
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. Menu Items Table (Parent Table)
-- ප්‍රධාන කෑම වර්ග මෙහි ලියාපදිංචි වේ (උදා: 'Chicken Fried Rice')
CREATE TABLE menu_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. Menu Item Variants Table (Sizes, Prices, Prep Time)
-- කෑමක ප්‍රමාණයන් (S, M, L) සහ ඊට අදාළ මිල ගණන්
CREATE TABLE menu_item_variants (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    menu_item_id BIGINT NOT NULL,
    size_name VARCHAR(50) NOT NULL, -- 'S', 'M', 'L', 'Normal', 'Family'
    price DECIMAL(10, 2) NOT NULL,
    prep_time_mins INT NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_menu_item FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE
);

-- 4. Bill of Materials (BOM) Table
-- කෑමක් සෑදීමට අවශ්‍ය අමුද්‍රව්‍ය ප්‍රමාණයන් මෙහි ගබඩා වේ
CREATE TABLE bom_entries (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    menu_item_variant_id BIGINT NOT NULL,
    ingredient_id BIGINT NOT NULL,
    quantity_required DECIMAL(10, 2) NOT NULL, -- Exact amount deducted per order
    CONSTRAINT fk_bom_variant FOREIGN KEY (menu_item_variant_id) REFERENCES menu_item_variants(id) ON DELETE CASCADE,
    CONSTRAINT fk_bom_ingredient FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE RESTRICT
);