# Source 58 - Gộp ô với rowspan và colspan

## Mục tiêu

Luyện tập sử dụng `rowspan` và `colspan` để trình bày lịch họp công ty trong bảng HTML.

## Nội dung

Bảng gồm các cột:

- Ngày
- Giờ
- Nội dung cuộc họp

### rowspan

Sử dụng `rowspan="2"` để gộp ô **Ngày** khi có hai cuộc họp diễn ra trong cùng một ngày.

### colspan

Sử dụng `colspan="2"` ở hàng **Thứ Tư** để gộp hai cột **Giờ** và **Nội dung cuộc họp**, thể hiện một phiên họp kéo dài từ 09:00 đến 12:00.

## Thẻ HTML

- `<table>`: tạo bảng.
- `<tr>`: tạo hàng.
- `<th>`: tạo ô tiêu đề.
- `<td>`: tạo ô dữ liệu.
- `rowspan`: gộp nhiều hàng theo chiều dọc.
- `colspan`: gộp nhiều cột theo chiều ngang.

## Cấu trúc

```text
source58/
├── index.html
└── README.md
```
