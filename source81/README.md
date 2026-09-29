# Source 81 - DIV + CSS Responsive Layout

## Mục tiêu

Luyện tập sử dụng `div` và CSS để xây dựng bố cục cơ bản cho trang web và làm bố cục responsive.

## Bố cục

Trang được chia thành các khu vực bằng `div`:

- `#head`: logo và banner.
- `#head-link`: menu điều hướng.
- `#left`: menu bên trái.
- `#content`: nội dung chính.
- `#right`: lịch, bản đồ và liên kết nhanh.
- `#footer`: chân trang.

## Responsive

CSS Grid được dùng để chia 3 cột trên màn hình lớn. Khi màn hình nhỏ hơn:

- Sidebar phải chuyển xuống dưới nội dung.
- Trên màn hình mobile, toàn bộ layout chuyển thành một cột.
- Menu điều hướng tự động chia lại các mục.
- Header chuyển sang bố cục dọc.

## Cấu trúc

```
source81/
├── index.html
├── styles.css
└── README.md
```

## Chạy bài

Mở `index.html` bằng WebStorm hoặc trình duyệt để kiểm tra bố cục trên nhiều kích thước màn hình.
