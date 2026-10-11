# Bài thực hành MySQL — Quản lý bán hàng

File `quan_ly_ban_hang.sql` tạo database `QuanLyBanHang`, bốn bảng `Customer`, `Order`, `Product`, `OrderDetail`, chèn dữ liệu mẫu và chạy đủ bốn yêu cầu truy vấn.

## Cách chạy

1. Mở `quan_ly_ban_hang.sql` trong MySQL Workbench.
2. Chạy toàn bộ script.
3. Đối chiếu bốn kết quả SELECT ở cuối script.

## Lưu ý về dữ liệu đề bài

Bảng `OrderDetail` trong nội dung đề bị lệch định dạng. Script diễn giải các giá trị theo từng bộ ba `(oID, pID, odQTY)` như sau: `(1,1,3)`, `(1,3,7)`, `(1,4,2)`, `(2,1,1)`, `(3,1,8)`, `(2,5,4)`, `(2,3,3)`. Nếu bảng từ buổi thực hành trước có dữ liệu khác, hãy điều chỉnh phần `INSERT INTO OrderDetail` theo dữ liệu gốc.

Cột trong bảng hóa đơn theo đề là `oTotalPrice` và các giá trị ban đầu đều `NULL`; ở truy vấn đầu, cột được đặt bí danh `oPrice`. Truy vấn cuối tự tính giá bằng `SUM(odQTY * pPrice)`.

**Cảnh báo:** Script xóa rồi tạo lại bốn bảng trong database `QuanLyBanHang` để có thể chạy lặp lại. Sao lưu dữ liệu trước khi chạy nếu database đã có dữ liệu cần giữ.
