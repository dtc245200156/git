# Source 34 — CSS → SASS chuẩn

Bài tập chuyển file CSS truyền thống sang SASS/SCSS có tổ chức.

## Mục tiêu

- Dùng variables để tránh lặp giá trị.
- Dùng mixins cho các nhóm style có thể tái sử dụng.
- Dùng nesting để cấu trúc selector rõ ràng.
- Tách code thành các partials theo kiến trúc thư mục.
- Biên dịch SCSS thành CSS để trình duyệt sử dụng.

## Cấu trúc

```
source34/
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
    │   └── _global.scss
    ├── layout/
    │   └── _container.scss
    └── components/
        ├── _buttons.scss
        └── _cards.scss
```

## Biên dịch

Cài Sass:

```bash
npm install -g sass
```

Biên dịch một lần:

```bash
sass scss/main.scss css/styles.css
```

Theo dõi thay đổi:

```bash
sass --watch scss/main.scss:css/styles.css
```

File `css/styles.css` đã được biên dịch sẵn để mở trực tiếp `index.html`.
