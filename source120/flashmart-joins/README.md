# FlashMart JOIN Reports

Bộ nộp bài thực hành SQL về `INNER JOIN`, `LEFT JOIN`, `COUNT()` và Anti-Join trên MySQL.

## Thành phần
- `flashmart_reports.sql`: tạo database/bảng, thêm dữ liệu mẫu, truy vấn báo cáo và ghi chú kết quả mong đợi.
- `join_analysis.md`: giải trình về `COUNT(o.order_id)` (dưới 150 từ).
- `ai_prompt_log.md`: nhật ký hỏi đáp lý thuyết JOIN, Anti-Join, Nested-Loop Join và FULL OUTER JOIN.

## Cách chạy
1. Mở MySQL Workbench hoặc công cụ chạy script MySQL.
2. Mở và chạy toàn bộ `flashmart_reports.sql`.
3. Kiểm tra báo cáo Marketing có 3 dòng (Alice 2, Bob 1, Charlie 0).
4. Kiểm tra báo cáo Kho vận có 1 dòng (103, Keyboard).

Lưu ý: Script drop các bảng `Orders`, `Products`, `Customers` trong `flashmart_db` trước khi tạo lại để có thể chạy lặp lại; không dùng database này để lưu dữ liệu thật.
