CREATE DATABASE IF NOT EXISTS product_demo;
USE product_demo;

-- ========================================================
-- BƯỚC 2: TẠO BẢNG PRODUCTS VÀ DỮ LIỆU MẪU
-- ========================================================
DROP VIEW IF EXISTS product_views;
DROP PROCEDURE IF EXISTS getAllProducts;
DROP PROCEDURE IF EXISTS addProduct;
DROP PROCEDURE IF EXISTS updateProduct;
DROP PROCEDURE IF EXISTS deleteProduct;

DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(20) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(12,2) NOT NULL,
    productAmount INT NOT NULL DEFAULT 0,
    productDescription VARCHAR(255),
    productStatus VARCHAR(20) NOT NULL DEFAULT 'Active'
);

INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
    ('P001', 'Laptop Dell Inspiron', 1599.00, 10, 'Laptop văn phòng', 'Active'),
    ('P002', 'Laptop Lenovo IdeaPad', 1299.00, 15, 'Laptop học tập', 'Active'),
    ('P003', 'iPhone 15', 999.00, 20, 'Điện thoại thông minh', 'Active'),
    ('P004', 'Samsung Galaxy S24', 899.00, 18, 'Điện thoại Android', 'Active'),
    ('P005', 'Tai nghe Bluetooth', 79.00, 50, 'Tai nghe không dây', 'Active'),
    ('P006', 'Chuột Logitech', 35.00, 100, 'Chuột máy tính', 'Active'),
    ('P007', 'Bàn phím cơ Keychron', 109.00, 40, 'Bàn phím cơ', 'Active'),
    ('P008', 'Màn hình LG 27 inch', 329.00, 12, 'Màn hình máy tính', 'Inactive');

SELECT * FROM Products;

-- ========================================================
-- BƯỚC 3: SO SÁNH TRUY VẤN TRƯỚC VÀ SAU KHI TẠO INDEX
-- ========================================================
-- Trước khi tạo index, kiểm tra kế hoạch thực thi.
EXPLAIN SELECT * FROM Products WHERE productCode = 'P003';
EXPLAIN SELECT * FROM Products WHERE productName = 'iPhone 15' AND productPrice = 999.00;

-- Tạo Unique Index cho productCode.
CREATE UNIQUE INDEX idx_product_code ON Products(productCode);

-- Tạo Composite Index cho productName và productPrice.
CREATE INDEX idx_product_name_price ON Products(productName, productPrice);

-- Sau khi tạo index, chạy lại EXPLAIN để so sánh.
EXPLAIN SELECT * FROM Products WHERE productCode = 'P003';
EXPLAIN SELECT * FROM Products WHERE productName = 'iPhone 15' AND productPrice = 999.00;

SHOW INDEX FROM Products;

-- ========================================================
-- BƯỚC 4: VIEW
-- ========================================================
-- Tạo view lấy các thông tin yêu cầu.
CREATE VIEW product_views AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

SELECT * FROM product_views;

-- Sửa đổi view.
CREATE OR REPLACE VIEW product_views AS
SELECT productCode, productName, productPrice, productAmount, productStatus
FROM Products
WHERE productStatus = 'Active';

SELECT * FROM product_views;

-- Xóa view.
DROP VIEW product_views;

-- ========================================================
-- BƯỚC 5: STORED PROCEDURE
-- ========================================================
DELIMITER //

CREATE PROCEDURE getAllProducts()
BEGIN
    SELECT * FROM Products;
END//

CREATE PROCEDURE addProduct(
    IN p_productCode VARCHAR(20),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(12,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(20)
)
BEGIN
    INSERT INTO Products (
        productCode, productName, productPrice, productAmount, productDescription, productStatus
    )
    VALUES (
        p_productCode, p_productName, p_productPrice, p_productAmount, p_productDescription, p_productStatus
    );
END//

CREATE PROCEDURE updateProduct(
    IN p_Id INT,
    IN p_productCode VARCHAR(20),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(12,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(20)
)
BEGIN
    UPDATE Products
    SET productCode = p_productCode,
        productName = p_productName,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
    WHERE Id = p_Id;
END//

CREATE PROCEDURE deleteProduct(IN p_Id INT)
BEGIN
    DELETE FROM Products
    WHERE Id = p_Id;
END//

DELIMITER ;

-- Demo Stored Procedure.
CALL getAllProducts();

CALL addProduct(
    'P009',
    'Webcam Full HD',
    59.00,
    25,
    'Webcam cho học tập và làm việc online',
    'Active'
);

CALL updateProduct(
    9,
    'P009',
    'Webcam Full HD Pro',
    69.00,
    30,
    'Webcam Full HD nâng cấp',
    'Active'
);

CALL deleteProduct(9);

CALL getAllProducts();
