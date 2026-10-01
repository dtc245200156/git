# AI Prompt Log

## Prompt 01 — CSS Grid areas

Câu hỏi: Làm thế nào dùng 'grid-template-areas' để tạo gallery gồm một ảnh lớn bên trái và hai ảnh nhỏ xếp chồng bên phải?

Kết quả áp dụng: Dùng template:
"main sub1"
"main sub2"

Sau đó gán 'grid-area: main/sub1/sub2' cho từng ảnh. Ở mobile đổi thành một cột:
"main"
"sub1"
"sub2"

## Prompt 02 — Bootstrap spacing

Câu hỏi: Khi refactor UI, các utility 'mt-3', 'pb-2', 'gap-3' dùng vào đâu?

Kết quả áp dụng: Các class spacing của Bootstrap được dùng để xử lý margin, padding và khoảng cách giữa flex/grid items mà không cần thêm CSS riêng. Bài này dùng các utility như 'gap-3', 'mb-5', 'pt-5', 'py-4', 'p-4'.

## Prompt 03 — Bootstrap breakpoints

Câu hỏi: Làm thế nào để 4 card thành 4 cột desktop, 2 cột tablet và 1 cột mobile?

Kết quả áp dụng: Dùng 'col-12 col-md-6 col-lg-3' trong một 'row'. Bootstrap tự thay đổi số cột theo breakpoint.

## Prompt 04 — Flexbox Author Info

Câu hỏi: Vì sao Flexbox phù hợp cho thanh tác giả một chiều?

Kết quả áp dụng: Flexbox cung cấp 'align-items: center' để căn giữa dọc và 'justify-content: space-between' để tách cụm thông tin bên trái với nhóm nút chia sẻ. 'flex-wrap' giúp nhóm tự xuống hàng trên mobile.
