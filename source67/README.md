# Source 67 - MySQL View

## Mục tiêu

Luyện tập tạo, cập nhật và xóa View trên cơ sở dữ liệu `classicmodels`.

## Nội dung

File `view.sql` thực hiện lần lượt:

1. Xóa `customer_views` nếu đã tồn tại.
2. Tạo View `customer_views` từ bảng `customers` với các cột `customerNumber`, `customerName`, `phone`.
3. Truy vấn dữ liệu từ View bằng `SELECT * FROM customer_views`.
4. Cập nhật View bằng `CREATE OR REPLACE VIEW`, bổ sung `contactFirstName`, `contactLastName` và lọc các khách hàng ở `Nantes`.
5. Truy vấn lại View sau khi cập nhật.
6. Xóa View bằng `DROP VIEW customer_views`.

## Chạy bài

Mở file `view.sql` bằng MySQL Workbench hoặc MySQL client và chạy trên database `classicmodels`.