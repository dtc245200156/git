# Source 35 — SASS Variables & Mixins

Bài tập tối ưu CSS bằng **variables** và **mixins** để giảm lặp code và tăng khả năng tái sử dụng.

## Mục tiêu

- Dùng variables để quản lý màu sắc, kích thước chữ, padding và box-shadow.
- Dùng mixins cho button và card.
- Tách code theo thư mục SASS chuẩn.
- Biên dịch SCSS thành CSS.

## Cấu trúc

```
source35/
├── index.html
├── README.md
├── css/
│   └── styles.css
└── scss/
    ├── main.scss
    ├── abstracts/
    │   ├── _variables.scss
    │   └── _mixins.scss
    ├── base/
    │   └── _typography.scss
    └── components/
        ├── _buttons.scss
        └── _cards.scss
```

## Biên dịch

Cài Sass:

```bash
npm install -g sass
```

Biên dịch:

```bash
sass scss/main.scss css/styles.css
```

Theo dõi thay đổi:

```bash
sass --watch scss/main.scss:css/styles.css
```

File `css/styles.css` đã được chuẩn bị sẵn để mở `index.html` trực tiếp.
