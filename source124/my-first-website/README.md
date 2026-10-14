# My First Website — Bài tập HTML và CSS

Dự án thực hành HTML/CSS gồm trang giới thiệu bản thân, Semantic HTML, thời khóa biểu, form liên hệ, công thức món ăn, portfolio CSS và thí nghiệm Box Model.

## Cấu trúc

- `index.html`: trang About Me dùng Semantic HTML và các quy tắc portfolio trong `style.css`.
- `style.css`: stylesheet chung, có CSS riêng cho About Me, trang công thức và lớp Box Model.
- `timetable.html`: thời khóa biểu tuần.
- `contact.html`: form liên hệ.
- `recipe.html`: công thức phở gà, bảng nguyên liệu và form đánh giá.
- `box-model.html`: trang thí nghiệm hai khối `div`, liên kết tới `style.css`.
- `images/profile-avatar.svg`: ảnh đại diện minh họa.
- `images/pho-ga.svg`: hình minh họa phở gà.
- `observations.md`: ghi chú quá trình thực hành.

## Mở trang

Mở thư mục trong VS Code rồi chạy tệp HTML cần xem bằng Live Server. Để làm thí nghiệm Box Model, mở `box-model.html` và thay đổi lần lượt `padding`, `border`, `margin` trong quy tắc `.box`.

## Lưu ý

- Trang About Me sử dụng tên và ảnh minh họa; hãy thay bằng thông tin cá nhân thật trước khi chia sẻ.
- Các form là giao diện HTML mẫu; chúng chưa gửi hoặc lưu dữ liệu do chưa có backend xử lý.
- Hình phở gà là ảnh minh họa SVG tự tạo trong thư mục `images`.
- Các quy tắc Box Model được bổ sung vào stylesheet chung, không xóa các quy tắc cũ của các trang khác.

## Xuất bản portfolio bằng Netlify Drop

1. Tải và giải nén file `Portfolio_Netlify_Drop.zip`.
2. Mở [Netlify Drop](https://app.netlify.com/drop).
3. Kéo thư mục `portfolio-project` đã giải nén (bên trong có `index.html`, `style.css` và `images/`) vào vùng thả.
4. Sau khi deploy thành công, sao chép URL có đuôi `.netlify.app` mà Netlify cấp để chia sẻ hoặc nộp bài.
5. Trước khi xuất bản, hãy thay tên minh họa, ảnh đại diện và liên kết mạng xã hội mẫu bằng thông tin thật của bạn.

Ghi chú: `Portfolio_Netlify_Drop.zip` là gói xuất bản tĩnh đã chuẩn bị; cần giải nén trước khi thả thư mục theo hướng dẫn của Netlify. URL công khai chỉ được tạo sau khi chính bạn hoàn tất thao tác deploy trong Netlify.
