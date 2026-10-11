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
) ENGINE=InnoDB;

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
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
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
DROP PROCEDURE IF EXISTS get_all_users;
DROP PROCEDURE IF EXISTS update_user;
DROP PROCEDURE IF EXISTS delete_user;

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



-- 3. List/search users and sort by name via CallableStatement.
CREATE PROCEDURE get_all_users(
    IN country_filter VARCHAR(120),
    IN sort_order VARCHAR(4)
)
BEGIN
    SELECT id, name, email, country
    FROM users
    WHERE country_filter IS NULL
       OR country_filter = ''
       OR country LIKE CONCAT('%', country_filter, '%')
    ORDER BY
        CASE WHEN LOWER(COALESCE(sort_order, 'asc')) = 'desc' THEN name END DESC,
        CASE WHEN LOWER(COALESCE(sort_order, 'asc')) <> 'desc' THEN name END ASC,
        id ASC;
END$$

-- 4. Update user information.
CREATE PROCEDURE update_user(
    IN target_user_id INT,
    IN user_name VARCHAR(120),
    IN user_email VARCHAR(220),
    IN user_country VARCHAR(120)
)
BEGIN
    UPDATE users
    SET name = user_name,
        email = user_email,
        country = user_country
    WHERE id = target_user_id;
END$$

-- 5. Delete a user (user_permission rows cascade on delete).
CREATE PROCEDURE delete_user(IN target_user_id INT)
BEGIN
    DELETE FROM users
    WHERE id = target_user_id;
END$$

DELIMITER ;


-- Employee table for the JDBC auto-commit demonstration.
-- The demo endpoint drops and recreates this table before each run.
CREATE TABLE IF NOT EXISTS Employee (
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(15, 2) NOT NULL,
    created_Date TIMESTAMP NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB;
