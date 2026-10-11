# Source 112 — User Management with JDBC Transactions

Bài thực hành JSP, Servlet, JDBC, MySQL: khi tạo mới User, lưu thông tin User và gán các quyền được chọn trong **cùng một transaction**. Nếu có lỗi khi ghi User hoặc bất kỳ dòng nào trong bảng `user_permission`, DAO rollback toàn bộ thay đổi.

## Chức năng
- Tìm kiếm User theo country.
- Sắp xếp User theo name tăng dần hoặc giảm dần.
- Tạo mới User cùng các quyền add/edit/delete/view đã chọn.
- Giữ chức năng xem/sửa/xóa từ bài trước.
- Tiếp tục dùng Stored Procedure `get_user_by_id` khi tải thông tin User theo ID.

## Thành phần chính
- `database.sql`: tạo/chuẩn hóa bảng `users`, thêm bảng `permission`, bảng liên kết `user_permission`, dữ liệu quyền mẫu và Stored Procedures từ bài trước.
- `IUserDAO.java`: thêm khai báo `addUserTransaction(User user, int[] permissionIds)`.
- `UserDAO.java`: dùng `Connection.setAutoCommit(false)`, `PreparedStatement.RETURN_GENERATED_KEYS`, `commit()` và `rollback()`.
- `UserServlet.java`: đọc checkbox `permissions` và gọi `addUserTransaction` khi tạo user.
- `user/create.jsp`: checkbox chọn các quyền Add, Edit, Delete, View.

## Database
Chạy file `database.sql` từ MySQL Workbench hoặc MySQL CLI. Script tạo các permission sau:
- `1 = add`
- `2 = edit`
- `3 = delete`
- `4 = view`

Bảng `user_permission` có khóa chính ghép `(user_id, permission_id)` và khóa ngoại đến `users` và `permission`. Bảng sử dụng InnoDB để hỗ trợ transaction.

## Cấu hình JDBC
Mặc định URL là `jdbc:mysql://localhost:3306/demo`, user `root`, password rỗng. Có thể cấu hình bằng biến môi trường `DB_URL`, `DB_USER` và `DB_PASSWORD`. Không commit mật khẩu thật lên GitHub.

## Build và chạy
Từ thư mục `source112/user-management`:

~~~bash
mvn clean package
~~~

Deploy `target/user-management.war` lên Apache Tomcat 10.1+ và mở:

`http://localhost:8080/user-management/users?action=create`

Nhập Name, Email, Country, chọn một hoặc nhiều quyền rồi lưu. Kiểm tra kết quả với:

~~~sql
SELECT * FROM users ORDER BY id DESC LIMIT 1;
SELECT * FROM user_permission ORDER BY user_id DESC, permission_id;
~~~

Để thử rollback, có thể gửi một `permission_id` không tồn tại trong database qua request/test DAO; thao tác thêm quyền sẽ vi phạm khóa ngoại và transaction phải rollback cả user vừa tạo. Controller giao diện bình thường chỉ cho phép các ID quyền từ 1 đến 4.

## Cách DAO đảm bảo tính toàn vẹn
1. Tắt auto-commit.
2. Chèn User và đọc ID tự tăng từ generated keys.
3. Chèn các quan hệ User–Permission trong cùng connection.
4. Commit nếu mọi thao tác thành công; nếu có `SQLException`, rollback và ném lỗi về Controller.
5. Đóng tài nguyên JDBC sau khi kết thúc giao dịch.