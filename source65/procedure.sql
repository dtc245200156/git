USE classicmodels;

DELIMITER //

DROP PROCEDURE IF EXISTS findAllCustomers//

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers;
END//

DELIMITER ;

CALL findAllCustomers();

DELIMITER //

DROP PROCEDURE IF EXISTS findCustomerById//

CREATE PROCEDURE findCustomerById(IN p_customerNumber INT)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = p_customerNumber;
END//

DELIMITER ;

CALL findCustomerById(175);
