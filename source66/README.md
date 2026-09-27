# Source 66 - MySQL Stored Procedure Parameters

## Mục tiêu

Luyện tập tạo Stored Procedure trên cơ sở dữ liệu `classicmodels` và sử dụng 3 loại tham số trong MySQL:

- `IN`: tham số đầu vào.
- `OUT`: tham số đầu ra.
- `INOUT`: vừa là đầu vào vừa là đầu ra.

## Nội dung thực hành

### 1. Tham số IN

Procedure `getCusById(cusNum)` nhận mã khách hàng và trả về thông tin từ bảng `customers`.

```sql
CALL getCusById(175);
```

### 2. Tham số OUT

Procedure `GetCustomersCountByCity(in_city, total)` nhận tên thành phố và trả về số lượng khách hàng thông qua biến OUT.

```sql
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total;
```

### 3. Tham số INOUT

Procedure `SetCounter(counter, inc)` nhận giá trị hiện tại của biến đếm, cộng thêm số lượng truyền vào và cập nhật lại chính biến đó.

```sql
SET @counter = 1;

CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 1);
CALL SetCounter(@counter, 5);

SELECT @counter;
```

Kết quả cuối cùng của ví dụ `SetCounter` là `8`.

## Chạy bài

Mở file `procedure-parameter.sql` bằng MySQL Workbench hoặc MySQL client và thực thi trên database `classicmodels`.

> File có sử dụng `DROP PROCEDURE IF EXISTS` trước khi tạo để có thể chạy lại nhiều lần.
