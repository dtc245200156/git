# Source 77 - CSS Dropdown Vertical Menu

## Mục tiêu

Luyện tập sử dụng CSS để tạo hiệu ứng dropdown cho menu dọc.

## Nội dung

Trang thực hành gồm:

- Menu chính với các mục `Sem 1`, `Sem 2`, `Sem 3`, `Sem 4`.
- `Sem 1` và `Sem 2` có menu con.
- Menu con được ẩn bằng `visibility: hidden`.
- Menu con được hiển thị khi rê chuột vào mục cha bằng selector `#menu ul li:hover > ul`.
- Sử dụng `position: relative` cho phần tử cha và `position: absolute` cho menu con.
- Hiệu ứng đổi màu nền khi hover.

## Cấu trúc

```
source77/
├── index.html
├── styles.css
└── README.md
```

## Chạy bài

Mở `index.html` bằng WebStorm hoặc trình duyệt. Di chuyển chuột vào **Sem 1** hoặc **Sem 2** để xem menu dropdown.
