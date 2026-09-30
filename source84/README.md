# Source 84 - Vertical Dropdown Menu

## Mục tiêu

Luyện tập tạo menu dropdown dọc bằng HTML và CSS.

## Nội dung

- Menu được xây dựng bằng `div`, `ul`, `li` và `a`.
- Các mục `Menu 1` và `Menu 2` có menu con.
- Menu con được ẩn mặc định bằng `visibility: hidden`.
- Menu con sử dụng `position: absolute` để hiển thị bên cạnh menu cha.
- Khi di chuột vào mục cha, menu con được hiển thị bằng selector `#menu ul li:hover > ul`.
- Hiệu ứng đổi màu nền khi hover.
- Có responsive cơ bản cho màn hình nhỏ.

## Cấu trúc

```
source84/
├── index.html
├── styles.css
└── README.md
```

## Chạy bài

Mở `index.html` bằng WebStorm hoặc trình duyệt, sau đó đưa chuột vào **Menu 1** hoặc **Menu 2** để kiểm tra dropdown.
