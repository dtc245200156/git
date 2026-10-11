CREATE DATABASE IF NOT EXISTS demo
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE demo;

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(220) NOT NULL,
    country VARCHAR(120),
    PRIMARY KEY (id),
    UNIQUE KEY uk_users_email (email)
);

INSERT INTO users (name, email, country)
SELECT 'Minh', 'minh@codegym.vn', 'Viet Nam'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'minh@codegym.vn');

INSERT INTO users (name, email, country)
SELECT 'Kante', 'kante@che.uk', 'Kenia'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'kante@che.uk');

INSERT INTO users (name, email, country)
SELECT 'Lan', 'lan@example.com', 'Viet Nam'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'lan@example.com');

INSERT INTO users (name, email, country)
SELECT 'Alex', 'alex@example.com', 'United Kingdom'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'alex@example.com');

-- MySQL 8 uses InnoDB by default; all related tables should use a transactional engine.

-- Permission master table.
CREATE TABLE IF NOT EXISTS permission (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- Join table: a user can have multiple permissions.
CREATE TABLE IF NOT EXISTS user_permission (
    user_id INT NOT NULL,
    permission_id INT NOT NULL,
    PRIMARY KEY (user_id, permission_id),
    CONSTRAINT fk_user_permission_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_user_permission_permission
        FOREIGN KEY (permission_id) REFERENCES permission(id)
) ENGINE=InnoDB;

INSERT INTO permission (id, name) VALUES
    (1, 'add'),
    (2, 'edit'),
    (3, 'delete'),
    (4, 'view')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Stored procedures for finding a user and inserting a new user.
DROP PROCEDURE IF EXISTS get_user_by_id;
DROP PROCEDURE IF EXISTS insert_user;

DELIMITER $$

CREATE PROCEDURE get_user_by_id(IN user_id INT)
BEGIN
    SELECT users.name, users.email, users.country
    FROM users
    WHERE users.id = user_id;
END$$

CREATE PROCEDURE insert_user(
    IN user_name VARCHAR(120),
    IN user_email VARCHAR(220),
    IN user_country VARCHAR(120)
)
BEGIN
    INSERT INTO users(name, email, country)
    VALUES(user_name, user_email, user_country);
END$$

DELIMITER ;
