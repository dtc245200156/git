# AI Prompt Log - SmartFactory

## Prompt 1 - Covering Index

> Covering Index trong MySQL là gì? Vì sao SELECT có thể nhanh hơn khi toàn bộ cột cần thiết đều nằm trong secondary index?

### Ghi nhận

Covering Index là index chứa đủ các cột cần để đáp ứng một truy vấn, cho phép MySQL đọc dữ liệu từ index mà không cần truy cập thêm clustered index/table. Điều này có thể giảm I/O và lookup, đặc biệt khi điều kiện lọc chọn một phần nhỏ dữ liệu.

## Prompt 2 - Clustered và Secondary Index

> InnoDB lưu dữ liệu trong clustered index và secondary index như thế nào? Khi secondary index không chứa đủ cột SELECT thì chuyện gì xảy ra?

### Ghi nhận

Trong InnoDB, PRIMARY KEY là clustered index và chứa row data. Secondary index chứa khóa index cùng giá trị PRIMARY KEY của row. Khi secondary index không bao phủ đủ cột, MySQL có thể dùng secondary index để tìm row rồi lookup về clustered index để lấy các cột còn thiếu.

## Prompt 3 - Write Penalty

> Tại sao thêm một cột vào composite index làm INSERT/UPDATE/DELETE tốn thêm tài nguyên?

### Ghi nhận

Mỗi thay đổi dữ liệu có thể kéo theo việc duy trì entry trong index. Index rộng làm entry lớn hơn và có thể tăng số page cần ghi, page split, I/O và áp lực lên buffer pool. Vì vậy index càng nhiều hoặc càng rộng thì chi phí ghi càng cao.

## Prompt 4 - Data Length và Index Length

> Trong MySQL, làm thế nào xem DATA_LENGTH và INDEX_LENGTH của SensorLogs theo MB bằng information_schema.TABLES?

### Ghi nhận

Có thể truy vấn `information_schema.TABLES` và chia `DATA_LENGTH`, `INDEX_LENGTH` cho `1024 * 1024`. Chạy cùng một truy vấn trước và sau khi đổi index giúp so sánh storage theo cùng một đơn vị.

## Prompt 5 - EXPLAIN sau tối ưu

> Sau khi thay covering index bằng index chỉ gồm sensor_id và recorded_at, EXPLAIN của truy vấn Dashboard cần chú ý điều gì?

### Ghi nhận

Kiểm tra `key` để xác nhận MySQL chọn `idx_lean_search`. Vì index không còn chứa `temperature`, `humidity`, `status`, `Extra` dự kiến không còn `Using index`; MySQL cần lookup row từ clustered index. `type` có thể là `range` hoặc một access method phù hợp khác tùy dữ liệu và optimizer.