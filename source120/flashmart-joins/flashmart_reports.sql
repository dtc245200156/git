-- ============================================================
-- FLASHMART - JOIN REPORTS
-- Muc tieu: INNER JOIN, LEFT JOIN, COUNT va Anti-Join
-- He quan tri: MySQL 8.x
-- ============================================================

CREATE DATABASE IF NOT EXISTS flashmart_db;
USE flashmart_db;

-- Xoa bang theo thu tu de script co the chay lai nhieu lan.
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- 1. Tao bang va du lieu mau
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    INDEX idx_orders_customer_id (customer_id),
    INDEX idx_orders_product_id (product_id)
);

INSERT INTO Customers (customer_id, name) VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie');

INSERT INTO Products (product_id, product_name) VALUES
    (101, 'Laptop'),
    (102, 'Mouse'),
    (103, 'Keyboard');

INSERT INTO Orders (order_id, customer_id, product_id) VALUES
    (1001, 1, 101),
    (1002, 1, 102),
    (1003, 2, 101);

-- ============================================================
-- BAO CAO 1 - MARKETING
-- Giu tat ca khach hang, ke ca nguoi chua co don hang.
-- COUNT(o.order_id) chi dem cac don hang thuc su khop; khi
-- khong co don hang, order_id la NULL nen COUNT tra ve 0.
-- ============================================================
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;

-- Ket qua mong doi:
-- customer_id | name    | total_orders
-- 1           | Alice   | 2
-- 2           | Bob     | 1
-- 3           | Charlie | 0

-- ============================================================
-- BAO CAO 2 - KHO VAN (ANTI-JOIN)
-- Chi lay san pham khong co dong Orders tuong ung.
-- ============================================================
SELECT
    p.product_id,
    p.product_name
FROM Products AS p
LEFT JOIN Orders AS o
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL
ORDER BY p.product_id;

-- Ket qua mong doi:
-- product_id | product_name
-- 103        | Keyboard

-- ============================================================
-- CAC TRUY VAN THAM KHAO DE TU KIEM TRA
-- INNER JOIN chi tra ve khach hang co don hang.
-- NOT EXISTS la cach viet Anti-Join thay the, thuong ro rang
-- va khong bi van de NULL nhu NOT IN.
-- ============================================================
-- SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
-- FROM Customers AS c
-- INNER JOIN Orders AS o ON o.customer_id = c.customer_id
-- GROUP BY c.customer_id, c.name;
--
-- SELECT p.product_id, p.product_name
-- FROM Products AS p
-- WHERE NOT EXISTS (
--     SELECT 1
--     FROM Orders AS o
--     WHERE o.product_id = p.product_id
-- );
