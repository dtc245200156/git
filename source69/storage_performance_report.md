# Storage & Performance Report - QuickFeed

## Bắt bệnh

Bảng `Posts` ban đầu có 5 index gồm: `idx_user_id`, `idx_content`, `idx_post_type`, `idx_is_visible` và `idx_created_at`. Mỗi lần `INSERT`, MySQL không chỉ ghi một dòng dữ liệu mà còn phải cập nhật các secondary index liên quan, duy trì cấu trúc B-Tree. Vì vậy càng nhiều index không cần thiết thì chi phí ghi và I/O càng lớn.

`idx_content` bị loại vì đây là B-Tree prefix index trên `TEXT(255)`, tạo thêm overhead lưu trữ và không phù hợp cho nhu cầu tìm kiếm nội dung tự do. `idx_post_type` chỉ có khoảng 3 giá trị và `idx_is_visible` chỉ có 2 giá trị nên cardinality thấp; khi một giá trị xuất hiện trên phần lớn bảng, optimizer có thể thấy full table scan rẻ hơn việc đi qua index rồi đọc lại nhiều row.

`idx_user_id` được giữ để hỗ trợ truy xuất bài viết theo người dùng. `idx_created_at` được giữ để hỗ trợ các truy vấn newsfeed theo thời gian.

## Đánh đổi Read / Write

Index tốt có thể giảm số trang dữ liệu phải đọc và tăng tốc các truy vấn có điều kiện phù hợp. Đổi lại, mỗi `INSERT`, `UPDATE` hoặc `DELETE` có thể phải cập nhật thêm index, làm tăng CPU, I/O và bộ nhớ cache. Tối ưu index vì thế không phải là xóa càng nhiều càng tốt mà là giữ các index phục vụ workload thực tế.

## Log dung lượng

| Chỉ số | Trước tối ưu | Sau tối ưu |
|---|---:|---:|
| Data (MB) | Ghi từ `information_schema.TABLES` | Ghi từ `information_schema.TABLES` |
| Index (MB) | Ghi từ `information_schema.TABLES` | Ghi từ `information_schema.TABLES` |
| Tổng (MB) | Ghi từ `information_schema.TABLES` | Ghi từ `information_schema.TABLES` |

> Số liệu thực tế phụ thuộc lượng dữ liệu của hệ thống khi chạy bài. `INDEX_LENGTH` dùng để so sánh phần dung lượng index; kích thước file vật lý trên hệ điều hành còn phụ thuộc cấu hình InnoDB/tablespace.

## Kết luận

Việc loại bỏ 3 index ít giá trị giúp giảm số cấu trúc B-Tree phải duy trì cho thao tác ghi, đồng thời giảm storage overhead. Sau khi chạy script, dùng hai kết quả `INDEX_LENGTH` trước và sau để ghi nhận mức thay đổi thực tế.