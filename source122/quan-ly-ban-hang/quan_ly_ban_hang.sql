-- BAI THUC HANH MYSQL: QUAN LY BAN HANG (QuanLyBanHang)
-- MySQL 8.x
-- Du lieu OrderDetail duoc dien giai theo cac bo 3 gia tri trong de:
-- (oID, pID, odQTY): (1,1,3), (1,3,7), (1,4,2),
-- (2,1,1), (3,1,8), (2,5,4), (2,3,3).
-- Luu y: script DROP cac bang de co the chay lai tu dau; sao luu du lieu truoc khi chay neu can.

CREATE DATABASE IF NOT EXISTS QuanLyBanHang;
USE QuanLyBanHang;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS OrderDetail;
DROP TABLE IF EXISTS `Order`;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Tao bang
CREATE TABLE Customer (
    cID INT PRIMARY KEY,
    Name VARCHAR(25) NOT NULL,
    cAge TINYINT
) ENGINE=InnoDB;

CREATE TABLE Product (
    pID INT PRIMARY KEY,
    pName VARCHAR(25) NOT NULL,
    pPrice INT NOT NULL
) ENGINE=InnoDB;

-- Order la tu khoa/identifier can trich dan bang dau ` trong MySQL.
CREATE TABLE `Order` (
    oID INT PRIMARY KEY,
    cID INT NOT NULL,
    oDate DATETIME NOT NULL,
    oTotalPrice INT NULL,
    CONSTRAINT fk_order_customer FOREIGN KEY (cID) REFERENCES Customer(cID)
) ENGINE=InnoDB;

CREATE TABLE OrderDetail (
    oID INT NOT NULL,
    pID INT NOT NULL,
    odQTY INT NOT NULL,
    PRIMARY KEY (oID, pID),
    CONSTRAINT fk_orderdetail_order FOREIGN KEY (oID) REFERENCES `Order`(oID),
    CONSTRAINT fk_orderdetail_product FOREIGN KEY (pID) REFERENCES Product(pID),
    CONSTRAINT chk_orderdetail_qty CHECK (odQTY > 0)
) ENGINE=InnoDB;

-- 2. Chen du lieu mau
INSERT INTO Customer (cID, Name, cAge) VALUES
    (1, 'Minh Quan', 10),
    (2, 'Ngoc Oanh', 20),
    (3, 'Hong Ha', 50);

INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES
    (1, 1, '2006-03-21 00:00:00', NULL),
    (2, 2, '2006-03-23 00:00:00', NULL),
    (3, 1, '2006-03-16 00:00:00', NULL);

INSERT INTO Product (pID, pName, pPrice) VALUES
    (1, 'May Giat', 3),
    (2, 'Tu Lanh', 5),
    (3, 'Dieu Hoa', 7),
    (4, 'Quat', 1),
    (5, 'Bep Dien', 2);

INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
    (1, 1, 3),
    (1, 3, 7),
    (1, 4, 2),
    (2, 1, 1),
    (3, 1, 8),
    (2, 5, 4),
    (2, 3, 3);

-- ============================================================
-- YEU CAU 1: Hien thi oID, oDate, oPrice cua tat ca hoa don.
-- Trong bang du lieu goc cot luu tru la oTotalPrice, dang NULL;
-- alias oPrice de dung dung ten cot trong de bai.
-- ============================================================
SELECT
    oID,
    oDate,
    oTotalPrice AS oPrice
FROM `Order`
ORDER BY oID;

-- ============================================================
-- YEU CAU 2: Danh sach khach hang da mua hang va san pham da mua.
-- DISTINCT de tranh lap dong neu cung mot khach mua cung san pham
-- o nhieu hoa don/chi tiet khac nhau.
-- ============================================================
SELECT DISTINCT
    c.cID,
    c.Name AS CustomerName,
    p.pID,
    p.pName AS ProductName
FROM Customer AS c
INNER JOIN `Order` AS o ON o.cID = c.cID
INNER JOIN OrderDetail AS od ON od.oID = o.oID
INNER JOIN Product AS p ON p.pID = od.pID
ORDER BY c.cID, p.pID;

-- ============================================================
-- YEU CAU 3: Khach hang chua mua bat ky san pham nao.
-- ============================================================
SELECT
    c.cID,
    c.Name,
    c.cAge
FROM Customer AS c
LEFT JOIN `Order` AS o ON o.cID = c.cID
WHERE o.oID IS NULL
ORDER BY c.cID;

-- ============================================================
-- YEU CAU 4: Gia tien tinh theo chi tiet hoa don:
-- SUM(odQTY * pPrice). LEFT JOIN giu tat ca hoa don; COALESCE
-- tra 0 neu hoa don khong co chi tiet.
-- ============================================================
SELECT
    o.oID,
    o.oDate,
    COALESCE(SUM(od.odQTY * p.pPrice), 0) AS oPrice
FROM `Order` AS o
LEFT JOIN OrderDetail AS od ON od.oID = o.oID
LEFT JOIN Product AS p ON p.pID = od.pID
GROUP BY o.oID, o.oDate
ORDER BY o.oID;

-- Voi cac chi tiet da dien giai o tren, gia tien tinh duoc:
-- Hoa don 1: 3*3 + 7*7 + 2*1 = 60
-- Hoa don 2: 1*3 + 4*2 + 3*7 = 32
-- Hoa don 3: 8*3 = 24
