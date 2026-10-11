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

## Tóm tắt thực hành tạo form liên hệ

1. Tạo tệp `contact.html` và khai báo cấu trúc HTML5, `lang="vi"`, `UTF-8` và tiêu đề trang.
2. Thêm tiêu đề `h1`, đoạn giới thiệu, rồi dùng `<form action="#" method="post">` bao bọc các trường nhập.
3. Tạo trường họ tên với `<input type="text">`, trường email với `<input type="email">` và vùng lời nhắn với `<textarea>`.
4. Liên kết mỗi `<label for="...">` với `id` tương ứng của trường nhập để người dùng có thể bấm vào nhãn và tập trung vào ô nhập.
5. Thêm nút `<button type="submit">` để gửi form.
6. Mở bằng Live Server và thử bấm nhãn, gửi form trống và nhập email sai định dạng để quan sát hành vi kiểm tra cơ bản của trình duyệt.
7. Quan sát: `type="email"` hỗ trợ kiểm tra định dạng email ở phía trình duyệt; form hiện tại chỉ là giao diện, chưa gửi dữ liệu đến dịch vụ hoặc máy chủ vì chưa có backend xử lý.

## Tóm tắt thực hành dự án công thức món ăn

1. Tạo tệp `recipe.html` với cấu trúc HTML5, `lang="vi"`, mã hóa UTF-8 và tiêu đề phù hợp.
2. Đặt toàn bộ bài công thức trong `<article>`; dùng `<header>` bên trong article để chứa tên món ăn, mô tả và hình ảnh có `alt`.
3. Tạo section “Nguyên liệu” và trình bày nguyên liệu bằng bảng `<table>`, tách tiêu đề và dữ liệu bằng `<thead>` và `<tbody>`.
4. Tạo section “Các bước thực hiện” với danh sách có thứ tự `<ol>`, mỗi bước là một `<li>`.
5. Đặt mẹo nấu ăn trong `<footer>` ở cuối article.
6. Tạo form phản hồi bên dưới article, gồm tên, nhóm radio đánh giá từ 1 đến 5 sao, bình luận và nút gửi. Mỗi input/textarea đều có label liên kết đúng qua `for` và `id`.
7. Mở bằng Live Server để kiểm tra cấu trúc bảng, thứ tự bước nấu và khả năng chọn một mức đánh giá. Form dùng `action="#"` nên chỉ minh họa giao diện, chưa lưu phản hồi lên máy chủ.

## Tóm tắt thực hành liên kết External CSS

1. Tạo tệp `style.css` nằm cùng cấp với `index.html`.
2. Viết quy tắc `body { background-color: #f0f8ff; }` để thay đổi nền trang sang màu AliceBlue.
3. Thêm `<link rel="stylesheet" href="style.css">` vào phần `<head>` của `index.html`.
4. Lưu cả hai tệp và mở `index.html` bằng Live Server để kiểm tra màu nền.
5. Nếu nền không đổi, kiểm tra tên tệp, đường dẫn `href`, vị trí của hai tệp và lưu thay đổi.
6. Quan sát: HTML giữ vai trò cấu trúc nội dung, còn CSS bên ngoài quản lý cách trình bày. Tách CSS ra tệp riêng giúp tái sử dụng và bảo trì quy tắc giao diện thuận tiện hơn.

## Tóm tắt thực hành CSS cho trang công thức

1. Liên kết stylesheet bên ngoài bằng cách thêm `<link rel="stylesheet" href="style.css">` trong phần `<head>` của `recipe.html`.
2. Thêm `id="recipe-card"` vào thẻ `<article>` để có thể chọn vùng công thức bằng bộ chọn ID `#recipe-card`.
3. Thiết lập font chữ, line-height, màu chữ và màu nền chung cho `body`.
4. Định dạng `h1` và `h2` bằng bộ chọn phần tử, bao gồm font Georgia, màu đỏ đậm, kích thước chữ và đường gạch dưới tiêu đề phụ.
5. Thêm `class="highlight"` cho tên nguyên liệu chính để thử bộ chọn class `.highlight`.
6. Dùng CSS định dạng bảng: `width: 100%`, căn trái tiêu đề cột, màu nền cho `th` và khoảng đệm cho `th`/ `td`.
7. Mở `recipe.html` bằng Live Server, kiểm tra bố cục, font, màu sắc và bảng. Phần CSS có bổ sung giới hạn chiều rộng linh hoạt để nội dung không tràn trên màn hình nhỏ.
8. Quan sát: bộ chọn phần tử áp dụng theo tên thẻ, bộ chọn ID bắt đầu bằng `#`, và bộ chọn class bắt đầu bằng `.`. Tách quy tắc vào file CSS giúp trình bày và cấu trúc HTML được quản lý riêng.

## Tóm tắt thực hành tạo phong cách Portfolio bằng CSS

1. Mở `index.html` và `style.css`, xác nhận HTML đã liên kết stylesheet bằng `<link rel="stylesheet" href="style.css">`.
2. Dùng bộ chọn `body` để thiết lập font chữ, màu chữ và màu nền chung.
3. Dùng các bộ chọn cho phần tử Semantic HTML hiện có (`body > header`, `body > main`, `body > footer`) để căn giữa và tạo vùng nội dung nền trắng, không cần thay đổi cấu trúc HTML.
4. Căn giữa phần đầu trang; đổi kích thước và màu `h1`; dùng `border-radius: 50%` để làm ảnh đại diện tròn.
5. Định dạng `h2` bằng màu nhấn và đường gạch dưới; tăng `line-height` cho đoạn văn và đổi màu chữ `strong`.
6. Định dạng các liên kết với màu riêng, bỏ gạch chân mặc định, thêm hiệu ứng `:hover`; bỏ dấu đầu dòng cho danh sách liên kết ở phần cuối của nội dung.
7. Chia CSS thành các khu vực có ghi chú: bố cục, đầu trang, nội dung, liên kết, chân trang và màn hình nhỏ.
8. Mở `index.html` bằng Live Server và quan sát: CSS có thể thay đổi đáng kể giao diện mà vẫn giữ nguyên cấu trúc HTML; các quy tắc cũ cho trang công thức vẫn được giữ lại trong cùng file stylesheet.
