# Ghi chú quan sát khi thực hành

- `<!DOCTYPE html>` khai báo tài liệu HTML5; `lang="vi"` giúp trình duyệt và công cụ hỗ trợ xác định ngôn ngữ chính.
- `meta charset="UTF-8"` giúp hiển thị đúng các ký tự tiếng Việt.
- `h1` dành cho tiêu đề chính của trang; `h2` chia nội dung thành các phần dễ đọc.
- `strong` và `em` làm nổi bật nội dung quan trọng và nhấn giọng trong câu.
- `ul`/`li` phù hợp để trình bày danh sách sở thích.
- Ảnh cần có đường dẫn đúng trong thuộc tính `src` và mô tả thay thế hữu ích trong `alt`.
- Liên kết có `target="_blank"` mở trong tab mới; `rel="noopener noreferrer"` là bổ sung an toàn khi mở tab mới.
- Khi thay ảnh minh họa bằng ảnh cá nhân, cần giữ ảnh trong thư mục `images` và cập nhật lại đường dẫn trong HTML.

## Quan sát sau khi dùng Semantic HTML

- Đưa tên và ảnh vào `<header>` giúp nhận biết rõ khu vực đầu trang.
- `<main>` bao bọc nội dung chính, còn mỗi nhóm nội dung có chủ đề riêng được bao bọc bởi `<section>`.
- `<footer>` chứa thông tin bản quyền ở cuối trang.
- Sau khi thêm các thẻ ngữ nghĩa mà không thay đổi nội dung hiển thị, giao diện thông thường gần như không đổi vì các thẻ này chủ yếu mô tả ý nghĩa và cấu trúc cho trình duyệt, công cụ tìm kiếm và công nghệ hỗ trợ.
- Mã nguồn dễ đọc và dễ bảo trì hơn vì các khu vực đầu trang, nội dung chính, từng phần và chân trang được phân biệt rõ.

## Tóm tắt thực hành tạo thời khóa biểu

1. Tạo tệp `timetable.html` và khai báo cấu trúc HTML5 với `lang="vi"`, bảng mã UTF-8 và tiêu đề trang.
2. Tạo `<table>` để chứa bảng thời khóa biểu.
3. Dùng `<thead>` và một hàng `<tr>` để tạo tiêu đề các cột: thời gian và các ngày từ thứ Hai đến thứ Sáu.
4. Dùng `<tbody>` để chứa các hàng dữ liệu; `<th scope="row">` ghi tên buổi học và `<td>` ghi hoạt động trong từng ngày.
5. Lưu tệp và mở bằng Live Server để kiểm tra số hàng, số cột và nội dung.
6. Quan sát: `<thead>` và `<tbody>` giúp phân biệt phần tiêu đề với phần dữ liệu; bảng hiện chưa có đường viền hay màu sắc vì bài tập tập trung vào cấu trúc HTML, chưa áp dụng CSS.
