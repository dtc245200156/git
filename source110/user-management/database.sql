CREATE DATABASE IF NOT EXISTS demo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE demo;

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(220) NOT NULL,
    country VARCHAR(120),
    PRIMARY KEY (id),
    UNIQUE KEY uk_users_email (email)
);

INSERT INTO users (name, email, country) VALUES
    ('Minh', 'minh@codegym.vn', 'Viet Nam'),
    ('Kante', 'kante@che.uk', 'Kenia'),
    ('Lan', 'lan@example.com', 'Viet Nam'),
    ('Alex', 'alex@example.com', 'United Kingdom')
ON DUPLICATE KEY UPDATE email = VALUES(email);
