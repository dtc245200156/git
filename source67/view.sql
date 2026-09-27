USE classicmodels;

-- Xóa view cũ nếu đã tồn tại để có thể chạy lại script
DROP VIEW IF EXISTS customer_views;

-- 1. Tạo view từ bảng customers
CREATE VIEW customer_views AS
SELECT customerNumber, customerName, phone
FROM customers;

-- Kiểm tra dữ liệu trong view
SELECT * FROM customer_views;

-- 2. Cập nhật view: bổ sung thông tin liên hệ và lọc theo thành phố
CREATE OR REPLACE VIEW customer_views AS
SELECT customerNumber, customerName, contactFirstName, contactLastName, phone
FROM customers
WHERE city = 'Nantes';

-- Kiểm tra view sau khi cập nhật
SELECT * FROM customer_views;

-- 3. Xóa view khi không còn sử dụng
DROP VIEW customer_views;
