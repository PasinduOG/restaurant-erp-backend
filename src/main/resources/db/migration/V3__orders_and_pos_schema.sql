-- V3__orders_and_pos_schema.sql
-- Orders, KDS Assignments, and POS Billing Systems

-- 1. Orders Table
-- සම්පූර්ණ ඇණවුමේ ප්‍රධාන තොරතුරු මෙහි ගබඩා වේ
CREATE TABLE orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    customer_id BIGINT NULL, -- Takeaway/Delivery සඳහා පාරිභෝගිකයා
    waiter_id BIGINT NOT NULL, -- ඇණවුම ලබාගත් Waiter ගේ ID එක
    table_number INT NULL, -- Dine-in නම් මේස අංකය
    order_type VARCHAR(50) NOT NULL, -- 'DINE_IN', 'TAKEAWAY', 'DELIVERY'
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING', -- 'PENDING', 'KITCHEN', 'READY', 'COMPLETED', 'CANCELLED'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    CONSTRAINT fk_order_waiter FOREIGN KEY (waiter_id) REFERENCES users(id) ON DELETE RESTRICT
);

-- 2. Order Items Table
-- ඇණවුමට අදාළ කෑම වර්ග සහ ප්‍රමාණයන් (මෙහි status එක 'COMPLETED' වූ වහාම BOM depletion සිදුවේ)
CREATE TABLE order_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    menu_item_variant_id BIGINT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL, -- මිල වෙනස් වුවහොත් පරණ බිල් වලට බලපෑමක් නොවීම සඳහා
    subtotal DECIMAL(10, 2) NOT NULL,
    notes VARCHAR(255) NULL, -- පාරිභෝගිකයාගේ විශේෂ ඉල්ලීම් (උදා: "අඩු මිරිස්")
    CONSTRAINT fk_item_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_item_variant FOREIGN KEY (menu_item_variant_id) REFERENCES menu_item_variants(id) ON DELETE RESTRICT
);

-- 3. KDS Assignments Table (Kitchen Workflow & Throttling)
-- කුමන Chef කුමන ඇණවුම හදනවාද යන්න සහ ඔවුන්ගේ කාර්යබහුලත්වය මැනීමට
CREATE TABLE kds_assignments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    chef_id BIGINT NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'QUEUED', -- 'QUEUED', 'PREPARING', 'DONE'
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    CONSTRAINT fk_kds_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_kds_chef FOREIGN KEY (chef_id) REFERENCES users(id) ON DELETE RESTRICT
);

-- 4. POS Bills Table
-- Cashier විසින් නිකුත් කරන අවසන් බිල්පත සහ ගෙවීම් විස්තර
CREATE TABLE pos_bills (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL UNIQUE,
    cashier_id BIGINT NOT NULL,
    sub_total DECIMAL(10, 2) NOT NULL,
    tax_amount DECIMAL(10, 2) DEFAULT 0.00,
    discount_amount DECIMAL(10, 2) DEFAULT 0.00,
    net_total DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL, -- 'CASH', 'CARD', 'ONLINE'
    payment_status VARCHAR(50) NOT NULL DEFAULT 'PENDING', -- 'PENDING', 'PAID'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_bill_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_bill_cashier FOREIGN KEY (cashier_id) REFERENCES users(id) ON DELETE RESTRICT
);