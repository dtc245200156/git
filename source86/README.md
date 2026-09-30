# Source 86 - Fixed Header and Sidebar

## Mục tiêu

Luyện tập thiết kế giao diện trang chủ với:

- Header cố định.
- Sidebar trái.
- Khu vực nội dung chính.
- Sidebar phải.
- Flexbox.
- `z-index`.
- Responsive layout.

## Nội dung

Trang sử dụng:

- `position: fixed`, `top: 0`, `left: 0`, `width: 100%` cho header.
- `z-index: 1000` để header luôn nằm trên nội dung.
- `padding-top` cho body để nội dung không bị header che khuất.
- Flexbox cho bố cục ba cột.
- Media Query để bố cục thích ứng với tablet và mobile.

## Cấu trúc

```
source86/
├── index.html
├── style.css
└── README.md
```

## Chạy bài

Mở `index.html` bằng WebStorm hoặc trình duyệt, sau đó cuộn trang để kiểm tra header luôn cố định.
