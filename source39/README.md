# Source 39 - UI/UX Registration Form

## Mục tiêu

Thực hành các nguyên tắc UI/UX cơ bản bằng một luồng đăng ký gồm 2 trang:

1. Trang 1 - Form đăng ký: Họ và tên, Email, Mật khẩu, Xác nhận mật khẩu.
2. Trang 2 - Xác nhận: Hiển thị trạng thái đăng ký thành công và bước tiếp theo.

## Nguyên tắc UI/UX đã áp dụng

- Rõ ràng: tiêu đề, nhãn trường và hướng dẫn đặt gần vùng nhập.
- Ưu tiên tác vụ chính: nút Tạo tài khoản có độ tương phản cao và nằm ngay sau form.
- Fitts' Law: nút chính có chiều cao 52px, vùng nhấn rộng và khoảng cách đủ để thao tác trên màn hình cảm ứng.
- Giảm lỗi: dùng input email, autocomplete, required và minlength; có gợi ý cho email/mật khẩu.
- Phản hồi trực quan: trạng thái focus có viền và vùng highlight; trang success xác nhận kết quả rõ ràng.
- Responsive: bố cục 2 cột trên desktop, chuyển thành 1 cột trên màn hình nhỏ.

## Wireframe

### Luồng người dùng

Trang đăng ký -> Điền thông tin -> Đồng ý điều khoản -> Tạo tài khoản -> Trang xác nhận thành công

### Phác thảo trang 1

+-------------------------------------------------------------+
| THƯƠNG HIỆU          | BƯỚC 1 / 2                         |
|                      | Tạo tài khoản                      |
| Đăng ký nhanh,       | [Họ và tên......................] |
| thoải mái sử dụng.   | [Email..........................] |
|                      | [Mật khẩu.......................] |
| ✓ 4 thông tin cơ bản | [Xác nhận mật khẩu.............] |
| ✓ Có hướng dẫn       | [x] Đồng ý điều khoản            |
| ✓ Nút lớn, dễ chạm   | [      Tạo tài khoản ->      ]   |
|                      | Đã có tài khoản? Đăng nhập       |
+-------------------------------------------------------------+

### Phác thảo trang 2

+----------------------------------------------+
|                    ✓                         |
|              BƯỚC 2 / 2                      |
|            Đăng ký thành công!               |
|                                              |
| [✉]  Kiểm tra email                          |
|      Thông tin tiếp theo sẽ được gửi...      |
|                                              |
| [Quay lại trang đăng ký] [Đi tới trang chủ] |
+----------------------------------------------+

## Chạy bài

Mở index.html bằng trình duyệt, sau đó submit form để chuyển sang success.html.

## Cấu trúc

source39/
├── index.html
├── success.html
├── README.md
└── css/
    └── style.css
