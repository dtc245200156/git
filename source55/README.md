# Source 55 - Form đăng ký người dùng

## Mục tiêu

Tạo form đăng ký và cấu hình đúng để gửi dữ liệu lên server đã được chuẩn bị sẵn.

## Cấu hình form

- `action="http://demo.codegym.vn/6/registration_form/register.php"`
- `method="POST"`

## Tên các trường bắt buộc

| Trường | name |
|---|---|
| Họ và tên | `name` |
| Email | `email` |
| Số điện thoại | `phone` |
| Giới tính | `gender` |

## Cách hoạt động

Khi người dùng nhấn **Đăng ký**, trình duyệt gửi dữ liệu bằng HTTP POST tới địa chỉ server trong thuộc tính `action`.

Ví dụ dữ liệu form có dạng:

```text
name=Nguyen+Van+A
email=example%40email.com
phone=0123456789
gender=male
```

## Cấu trúc

```text
source55/
├── index.html
└── README.md
```
