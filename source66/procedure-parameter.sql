USE classicmodels;

-- =========================================================
-- 1. Tham số IN: nhận dữ liệu đầu vào để tìm khách hàng
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS getCusById//

CREATE PROCEDURE getCusById(IN cusNum INT)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = cusNum;
END//

DELIMITER ;

CALL getCusById(175);

-- =========================================================
-- 2. Tham số OUT: trả dữ liệu từ procedure ra bên ngoài
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS GetCustomersCountByCity//

CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END//

DELIMITER ;

CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total AS total_customers;

-- =========================================================
-- 3. Tham số INOUT: vừa nhận dữ liệu vào vừa trả dữ liệu ra
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS SetCounter//

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END//

DELIMITER ;

SET @counter = 1;

CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 5);

SELECT @counter AS counter_result;
