# Source 36 — Responsive Grid chuyển sang SASS

Bài tập tái cấu trúc mã HTML/CSS của repository
`https://github.com/codegym-vn/responsive-grid` thành SCSS có tổ chức.

## Đã áp dụng

- Variables để quản lý số cột, kích thước, màu sắc và khoảng cách.
- Mixins để tái sử dụng style cho grid column, border và block.
- Nesting trong các component.
- Function Sass để tính độ rộng theo số cột.
- Partial theo cấu trúc `abstracts / base / layout / components`.
- Loại bỏ phần lớn inline style khỏi HTML và chuyển sang class.
- CSS được biên dịch sẵn trong `css/styles.css`.

## Cấu trúc

```
source36/
├── index.html
├── README.md
├── css/
│   └── styles.css
└── scss/
    ├── main.scss
    ├── abstracts/
    │   ├── _variables.scss
    │   ├── _functions.scss
    │   └── _mixins.scss
    ├── base/
    │   └── _global.scss
    ├── layout/
    │   └── _grid.scss
    └── components/
        ├── _blocks.scss
        └── _instruction.scss
```

## Biên dịch

```bash
npm install -g sass
sass scss/main.scss css/styles.css
```

Theo dõi thay đổi:

```bash
sass --watch scss/main.scss:css/styles.css
```

## Nguồn tham khảo

Mã nguồn HTML/CSS ban đầu được tham khảo từ repository CodeGym:
`codegym-vn/responsive-grid`.
