# Source 65 - MySQL Stored Procedure

## Mục tiêu

Luyện tập tạo, gọi và xóa Stored Procedure trong MySQL trên cơ sở dữ liệu `classicmodels`.

## Nội dung đã thực hiện

### 1. Procedure không có tham số

```sql
DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT * FROM customers;
END//

DELIMITER ;
```

Gọi procedure:

```sql
CALL findAllCustomers();
```

Procedure trả về toàn bộ dữ liệu trong bảng `customers`.

### 2. Procedure có tham số

```sql
CREATE PROCEDURE findCustomerById(IN p_customerNumber INT)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = p_customerNumber;
END
```

Gọi với mã khách hàng mẫu:

```sql
CALL findCustomerById(175);
```

### 3. Xóa và tạo lại Procedure

MySQL có thể xóa procedure cũ trước khi tạo lại bằng:

```sql
DROP PROCEDURE IF EXISTS findAllCustomers;
```

## Giải thích DELIMITER

`DELIMITER //` tạm thời thay đổi ký tự kết thúc câu lệnh để MySQL có thể đọc toàn bộ phần `BEGIN ... END` của Stored Procedure.

Sau khi tạo xong, dùng `DELIMITER ;` để đưa delimiter về mặc định.

## Các lệnh chính

| Lệnh | Ý nghĩa |
|---|---|
| `CREATE PROCEDURE` | Tạo Stored Procedure |
| `CALL` | Gọi Stored Procedure |
| `DROP PROCEDURE IF EXISTS` | Xóa procedure nếu đã tồn tại |
| `DELIMITER` | Thay đổi ký tự kết thúc câu lệnh |

## Cách chạy

1. Import database `classicmodels`.
2. Mở file `procedure.sql` trong MySQL Workbench hoặc MySQL client.
3. Chạy script.
4. Kiểm tra kết quả bằng các câu lệnh `CALL`.

## Tham khảo

Repository mẫu theo đề bài:

https://github.com/codegym-vn/jwbd-2023-using-stored-procedure

Nhánh tham khảo: `dev`.

## Cấu trúc

```text
source65/
├── procedure.sql
└── README.md
```
