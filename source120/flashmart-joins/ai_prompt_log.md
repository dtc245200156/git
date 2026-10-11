# AI Prompt Log — FlashMart JOIN

## 1. INNER JOIN và LEFT JOIN khác nhau thế nào?
**Prompt:** Trong MySQL, `JOIN` không ghi loại cụ thể hoạt động như thế nào? Nó giữ hay bỏ bản ghi không khớp?

**Tóm tắt trả lời:** `JOIN` mặc định là `INNER JOIN`: chỉ giữ các dòng có điều kiện khớp ở cả hai bảng. `LEFT JOIN` giữ tất cả dòng của bảng bên trái; nếu không có dòng bên phải tương ứng, các cột bên phải nhận `NULL`.

## 2. COUNT khi sử dụng LEFT JOIN
**Prompt:** Nên dùng `COUNT(*)` hay `COUNT(o.order_id)` để đếm đơn khi có khách hàng chưa mua?

**Tóm tắt trả lời:** Dùng `COUNT(o.order_id)`. `COUNT(expression)` chỉ đếm giá trị khác `NULL`, nên khách không có đơn nhận 0. `COUNT(*)` đếm dòng kết quả đã ghép và có thể đếm dòng giữ lại của khách chưa có đơn thành 1.

## 3. LEFT JOIN ... IS NULL và NOT IN
**Prompt:** Phân tích hiệu năng của `LEFT JOIN ... WHERE right_table.id IS NULL` so với `NOT IN`.

**Tóm tắt trả lời:** Không có cách nào luôn nhanh hơn trong mọi tình huống. MySQL có thể tối ưu cả Anti-Join và subquery tùy phiên bản, chỉ mục, thống kê và dữ liệu. Nên có chỉ mục trên cột nối (ở đây là `Orders.product_id`) và kiểm tra bằng `EXPLAIN`. `NOT IN` dễ gây kết quả bất ngờ nếu tập con chứa `NULL`; `NOT EXISTS` thường dễ đọc và tránh bẫy này. `LEFT JOIN ... IS NULL` cũng là mẫu Anti-Join rõ ràng.

## 4. Nested-Loop Join
**Prompt:** MySQL có thể tối ưu JOIN bằng Nested-Loop Join như thế nào?

**Tóm tắt trả lời:** Với Nested-Loop Join, hệ quản trị duyệt dòng từ một bảng rồi tìm dòng phù hợp ở bảng còn lại. Chỉ mục trên cột nối có thể giảm chi phí tìm kiếm lặp lại. Hiệu năng còn phụ thuộc thứ tự bảng, số dòng, bộ lọc và chiến lược thực thi thực tế; cần xem `EXPLAIN`/ `EXPLAIN ANALYZE`, không kết luận chỉ từ cú pháp.

## 5. FULL OUTER JOIN trong MySQL
**Prompt:** Có thể mô phỏng `FULL OUTER JOIN` bằng LEFT JOIN và RIGHT JOIN không?

**Tóm tắt trả lời:** MySQL không có cú pháp `FULL OUTER JOIN` trực tiếp. Có thể ghép nhánh `LEFT JOIN` với nhánh `RIGHT JOIN` bằng `UNION` (hoặc `UNION ALL` cùng điều kiện loại phần giao bị lặp). Với dữ liệu có khóa trùng, cần định nghĩa rõ cách loại trùng để không làm sai số dòng.
