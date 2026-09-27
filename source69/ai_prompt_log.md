# AI Prompt Log - QuickFeed Index Optimization

## Prompt 1 - Storage

> Trong MySQL, làm thế nào truy vấn `information_schema.TABLES` để xem `DATA_LENGTH` và `INDEX_LENGTH` của bảng `Posts` theo đơn vị MB? Giải thích ý nghĩa của từng trường.

### Ghi nhận

`DATA_LENGTH` và `INDEX_LENGTH` là các chỉ số dung lượng được MySQL cung cấp qua `information_schema.TABLES`. Có thể chia cho `1024 * 1024` để hiển thị theo MB. Dùng cùng một truy vấn trước và sau tối ưu để so sánh nhất quán.

## Prompt 2 - Cardinality

> Cardinality là gì? Vì sao index B-Tree trên cột BOOLEAN hoặc cột chỉ có vài giá trị thường khó mang lại lợi ích khi phần lớn các hàng có cùng giá trị?

### Ghi nhận

Cardinality mô tả số lượng giá trị khác nhau ước tính trong một cột/index. Cardinality càng thấp thì một điều kiện lọc thường trả về càng nhiều hàng. Khi phải đọc phần lớn bảng, optimizer có thể chọn full table scan thay vì dùng index vì chi phí truy cập index và quay lại các row dữ liệu không còn có lợi.

## Prompt 3 - TEXT và tìm kiếm

> Vì sao B-Tree index prefix trên cột TEXT có thể tốn storage, và nếu cần tìm kiếm từ khóa trong nội dung thì cơ chế nào của MySQL phù hợp hơn?

### Ghi nhận

Prefix index trên `TEXT` vẫn tạo dữ liệu index cho phần prefix được chọn, nên sẽ tăng storage và chi phí bảo trì khi ghi. Với nhu cầu tìm kiếm từ khóa trong văn bản, `FULLTEXT` là cơ chế phù hợp hơn cho các truy vấn full-text.

## Prompt 4 - Trade-off Read / Write

> Nếu một bảng có 5 index, điều gì xảy ra khi INSERT một row? Giải thích trade-off giữa tốc độ đọc và tốc độ ghi.

### Ghi nhận

Dữ liệu mới phải được thêm vào cấu trúc index phù hợp, có thể phát sinh page modification, I/O và cập nhật cache. Index có thể giúp SELECT nhanh hơn nhưng càng nhiều index càng làm INSERT/UPDATE/DELETE tốn thêm tài nguyên. Vì vậy index cần được thiết kế theo workload thực tế.

## Prompt 5 - Đánh giá kết quả

> Sau khi DROP 3 secondary index, cần kiểm tra gì để chứng minh tối ưu có tác động?

### Ghi nhận

Chạy lại `SHOW TABLE STATUS LIKE 'Posts'`, truy vấn `information_schema.TABLES` và `SHOW INDEX FROM Posts`. So sánh `INDEX_LENGTH` trước/sau và xác nhận chỉ còn `idx_user_id`, `idx_created_at` cùng PRIMARY KEY.