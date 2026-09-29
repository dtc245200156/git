# Source 78 - CSS Horizontal Dropdown Menu

## Mục tiêu

Luyện tập sử dụng CSS để tạo menu ngang cơ bản có dropdown.

## Nội dung

Trang thực hành gồm:

- Menu ngang với các mục `Sem 1`, `Sem 2`, `Sem 3`, `Sem 4`.
- `Sem 1` và `Sem 2` có menu con.
- Các mục menu chính được xếp ngang bằng Flexbox.
- Menu con sử dụng `position: absolute` và được ẩn bằng `visibility: hidden`.
- Khi rê chuột vào mục cha, menu con hiển thị bằng selector `#menu ul li:hover > ul`.
- Hiệu ứng đổi màu nền khi hover.
- Có responsive cơ bản cho màn hình nhỏ.

## Cấu trúc

```
source78/
├── index.html
├── styles.css
└── README.md
```

## Chạy bài

Mở `index.html` bằng WebStorm hoặc trình duyệt. Di chuyển chuột vào **Sem 1** hoặc **Sem 2** để xem dropdown.
