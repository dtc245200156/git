# SmartFactory - Index Trade-off Report

## Chẩn đoán

`idx_fat_covering` gồm `sensor_id`, `recorded_at`, `temperature`, `humidity` và `status`. Index này có tính chất covering đối với truy vấn Dashboard vì các cột cần trả về đều nằm ngay trong index. Khi đó MySQL có thể đọc kết quả trực tiếp từ secondary index và tránh lookup bảng gốc.

Tuy nhiên SmartFactory là hệ thống ghi liên tục. Mỗi `INSERT` phải thêm entry mới vào secondary index; index càng rộng thì mỗi entry càng chứa nhiều byte, làm tăng page size, I/O, bộ nhớ cache và write amplification. Các cột `temperature`, `humidity` và `status` thay đổi theo từng bản ghi nhưng không cần thiết cho việc lọc.

Giải pháp là thay bằng `idx_lean_search(sensor_id, recorded_at)`. Index mới vẫn hỗ trợ điều kiện `WHERE sensor_id = ... AND recorded_at >= ...`, nhưng không còn covering. Vì vậy `EXPLAIN` vẫn dự kiến chọn `idx_lean_search`, trong khi `Extra` không còn `Using index` và MySQL phải đọc row từ clustered index để lấy ba cột còn thiếu.

Đây là sự đánh đổi có chủ đích: giảm lợi ích cực đại của Read để giảm Storage overhead và Write Penalty. Không gán số liệu như “INSERT nhanh 5 lần” hay “Index giảm 70%” nếu chưa đo trên dữ liệu thực tế; các con số đó phụ thuộc cardinality, số row, kiểu dữ liệu và cấu hình InnoDB.

## Log đo lường

| Chỉ số | Trước tối ưu | Sau tối ưu |
|---|---:|---:|
| Data (MB) | Điền từ `information_schema.TABLES` | Điền từ `information_schema.TABLES` |
| Index (MB) | Điền từ `information_schema.TABLES` | Điền từ `information_schema.TABLES` |
| Tổng (MB) | Điền từ `information_schema.TABLES` | Điền từ `information_schema.TABLES` |

## Kết luận

Lean Index phù hợp hơn với workload IoT có tốc độ ghi cao khi truy vấn chỉ cần lọc theo sensor và thời gian. Covering Index vẫn có thể hợp lý cho bảng ít ghi hoặc workload thiên về đọc, nhưng cần cân đối với chi phí lưu trữ và bảo trì index.