# Giải trình lựa chọn COUNT()

Với `LEFT JOIN`, mọi khách hàng ở bảng `Customers` đều được giữ lại. Nếu một khách hàng chưa có đơn, các cột của `Orders` được điền `NULL` ở dòng kết quả ghép. `COUNT(o.order_id)` chỉ đếm giá trị không `NULL`, vì vậy khách chưa mua hàng có `total_orders = 0`. Ngược lại, `COUNT(*)` đếm cả dòng được giữ lại bởi `LEFT JOIN`; dòng giả lập của khách chưa có đơn vẫn được tính là một dòng, khiến kết quả sai thành 1. Do đó, cần đếm cột khóa của bảng phụ có thể `NULL` khi không khớp, chẳng hạn `o.order_id`, thay vì đếm toàn bộ dòng.
