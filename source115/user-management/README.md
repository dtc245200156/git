# Source 115 — User Management with Stored Procedures (CRUD)

Bài thực hành JSP, Servlet, JDBC và MySQL: dùng `CallableStatement` để gọi Stored Procedures cho ba chức năng:
- Hiển thị/tìm kiếm danh sách User.
- Cập nhật thông tin User.
- Xóa User.

Các thủ tục `get_user_by_id` và `insert_user` từ các bài trước vẫn được giữ lại. Chức năng tạo User cùng quyền permission vẫn minh họa JDBC transaction.

## Stored Procedures mới

- `get_all_users(country_filter, sort_order)`: trả danh sách User, lọc theo country (nếu có) và sắp xếp name tăng dần hoặc giảm dần.
- `update_user(target_user_id, user_name, user_email, user_country)`: cập nhật các thông tin của User theo ID.
- `delete_user(target_user_id)`: xóa User theo ID. Các liên kết ở `user_permission` được cascade bởi khóa ngoại khi xóa User.

## Mã Java sử dụng CallableStatement

- `UserDAO.selectUsers(country, sortOrder)` gọi `{CALL get_all_users(?, ?)}`.
- `UserDAO.updateUser(user)` gọi `{CALL update_user(?, ?, ?, ?)}`.
- `UserDAO.deleteUser(id)` gọi `{CALL delete_user(?)}`.
- Controller tiếp tục gọi các phương thức DAO này trong luồng hiển thị danh sách, sửa và xóa User.

## Cấu trúc quan trọng

- `src/main/java/com/codegym/dao/IUserDAO.java`
- `src/main/java/com/codegym/dao/UserDAO.java`
- `src/main/java/com/codegym/controller/UserServlet.java`
- `src/main/webapp/user/list.jsp`
- `src/main/webapp/user/edit.jsp`
- `src/main/webapp/user/delete.jsp`
- `database.sql`

## Cài đặt database

1. Mở MySQL Workbench hoặc MySQL CLI.
2. Chạy toàn bộ `database.sql` trong dự án này. Script tạo/cập nhật schema dùng trong bài và xóa-tạo lại các Stored Procedures có cùng tên để tránh lỗi trùng tên.
3. Kiểm tra cấu hình kết nối trong các biến môi trường `DB_URL`, `DB_USER`, `DB_PASSWORD`. Mặc định URL là `jdbc:mysql://localhost:3306/demo`, user `root`, password rỗng.

Không commit mật khẩu database thật vào GitHub.

## Build và chạy

Từ thư mục `source115/user-management`:

~~~bash
mvn clean package
~~~

Deploy `target/user-management.war` lên Apache Tomcat 10.1+ và mở:

`http://localhost:8080/user-management/users`

Thử thao tác:
1. Quan sát danh sách User và dùng bộ lọc country / lựa chọn sắp xếp name.
2. Bấm **Sửa** để cập nhật User; Controller dùng DAO với Stored Procedure `update_user`.
3. Bấm **Xóa** và xác nhận; DAO gọi Stored Procedure `delete_user`.

## Lưu ý về demo Transaction

Dự án kế thừa các endpoint minh họa transaction của source114. Các endpoint test Employee sẽ xóa và tạo lại bảng `Employee` khi được chạy. Chỉ dùng endpoint demo trên database thực hành, không dùng trên dữ liệu thật.