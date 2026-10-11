CREATE DATABASE IF NOT EXISTS product_management_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE product_management_db;

CREATE TABLE IF NOT EXISTS products (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    price DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    quantity INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT chk_products_price CHECK (price >= 0),
    CONSTRAINT chk_products_quantity CHECK (quantity >= 0)
) ENGINE=InnoDB;

INSERT INTO products (name, price, quantity)
SELECT 'Laptop', 15990000.00, 12
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Laptop');

INSERT INTO products (name, price, quantity)
SELECT 'Wireless Mouse', 259000.00, 35
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Wireless Mouse');

INSERT INTO products (name, price, quantity)
SELECT 'Mechanical Keyboard', 1290000.00, 18
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Mechanical Keyboard');
