# Source 68 - MySQL Trigger

## Mục tiêu

Luyện tập sử dụng Trigger trong MySQL để tự động xử lý dữ liệu khi thực hiện `INSERT` vào bảng.

## Nội dung

### 1. Tạo cơ sở dữ liệu và bảng

Tạo database `company` và bảng `employees` gồm các cột:

- `id`: khóa chính tự tăng.
- `name`: tên nhân viên.
- `department`: phòng ban.
- `salary`: mức lương.

### 2. Tạo Trigger

Trigger `update_department` chạy `BEFORE INSERT` trên bảng `employees`.

Quy tắc xử lý phòng ban:

- Lương từ `5000` trở lên → `Management`.
- Lương từ `3000` đến dưới `5000` → `Sales`.
- Lương dưới `3000` → `Support`.

### 3. Demo

Khi thêm:

- `John Doe` có lương `3500` → `Sales`.
- `Jane Smith` có lương `2000` → `Support`.
- `David Johnson` có lương `6000` → `Management`.

Giá trị `department` được truyền vào lúc `INSERT` chỉ là giá trị ban đầu; Trigger sẽ tự động thiết lập lại theo mức lương.

## Chạy bài

Mở file `trigger.sql` bằng MySQL Workbench hoặc MySQL client và thực thi. Script có `DROP TRIGGER IF EXISTS` để có thể tạo lại Trigger khi chạy lại.