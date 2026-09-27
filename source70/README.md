# Source 70 - MySQL View, Index và Stored Procedure

## Mục tiêu

Luyện tập sử dụng `VIEW`, `INDEX` và `STORED PROCEDURE` trên bảng `Products`.

## Nội dung

### 1. Database và bảng Products

Tạo database `product_demo`, bảng `Products` với các trường:

- `Id`
- `productCode`
- `productName`
- `productPrice`
- `productAmount`
- `productDescription`
- `productStatus`

Script có sẵn dữ liệu mẫu để thực hành.

### 2. Index và EXPLAIN

Tạo:

- Unique Index `idx_product_code` trên `productCode`.
- Composite Index `idx_product_name_price` trên `productName` và `productPrice`.

Chạy `EXPLAIN` trước và sau khi tạo index để quan sát kế hoạch thực thi.

### 3. View

Tạo `product_views` gồm `productCode`, `productName`, `productPrice`, `productStatus`; sau đó cập nhật View bằng `CREATE OR REPLACE VIEW` để bổ sung `productAmount` và lọc sản phẩm `Active`, cuối cùng xóa View.

### 4. Stored Procedure

- `getAllProducts()` - lấy toàn bộ sản phẩm.
- `addProduct(...)` - thêm sản phẩm mới.
- `updateProduct(...)` - sửa sản phẩm theo `Id`.
- `deleteProduct(p_Id)` - xóa sản phẩm theo `Id`.

## Chạy bài

Mở `product_view_index_procedure.sql` bằng MySQL Workbench hoặc MySQL client và chạy trên MySQL.

Script được thiết kế có thể chạy lại bằng cách xóa các View, Procedure và bảng cũ trước khi tạo lại.