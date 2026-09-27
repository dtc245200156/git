# Sass CLI Practice

## Kiểm tra Node.js và npm

~~~bash
node -v
npm -v
~~~

## Cài đặt dependency

Trong thư mục source33:

~~~bash
npm install
~~~

## Biên dịch SCSS sang CSS

~~~bash
npm run sass
~~~

Tương đương với:

~~~bash
sass scss/main.scss css/styles.css
~~~

## Watch mode

~~~bash
npm run watch
~~~

Mỗi khi file trong scss/ thay đổi, Sass sẽ biên dịch lại css/styles.css.

## Cấu trúc

~~~text
source33/
├── index.html
├── package.json
├── README.md
├── css/
│   └── styles.css
└── scss/
    ├── main.scss
    └── abstracts/
        ├── _variables.scss
        └── _mixins.scss
~~~

File css/styles.css đã được biên dịch sẵn để mở trang ngay cả trước khi chạy Sass CLI.

Lưu ý: trên Windows, nếu PowerShell chặn script của npm, nên xử lý đúng theo thông báo lỗi cụ thể thay vì thay đổi Execution Policy một cách rộng rãi.