# Source 116 — JDBC Transaction: Force SQL Error and Verify Rollback

Bài thực hành tiếp nối ứng dụng quản lý User. Phương thức `addUserTransaction(User user, int[] permissionIds)` cố tình có một lỗi SQL khi ghi các quyền của User, nhằm quan sát transaction rollback.

## Mục tiêu thử nghiệm

Khi tạo User kèm một hoặc nhiều quyền:
1. DAO bắt đầu transaction với `connection.setAutoCommit(false)`.
2. Dữ liệu User được insert vào bảng `users`.
3. DAO cố gắng insert vào `user_permission`, nhưng câu lệnh SQL cố tình dùng tên cột sai `permission_id_typo`.
4. MySQL ném `SQLException`; DAO gọi `connection.rollback()` và ném lỗi về tầng Controller.
5. Do rollback, bản ghi User vừa insert và quan hệ User–Permission chưa được commit đều bị hủy.

**Quan trọng:** Để kích hoạt lỗi, hãy chọn ít nhất một checkbox quyền trong form tạo User. Nếu không chọn quyền nào thì nhánh insert quyền không chạy và lỗi cố tình sẽ không được kích hoạt.

## File quan trọng

- `src/main/java/com/codegym/dao/UserDAO.java`: triển khai transaction và dòng SQL gây lỗi có chủ đích.
- `src/main/java/com/codegym/dao/IUserDAO.java`: khai báo `addUserTransaction`.
- `src/main/java/com/codegym/controller/UserServlet.java`: xử lý request tạo User.
- `src/main/webapp/user/create.jsp`: form tạo User và các checkbox phân quyền.
- `database.sql`: schema cho User, Permission và Stored Procedures từ các bài trước.

## Chạy và kiểm tra

1. Chạy `database.sql` trong MySQL Workbench hoặc MySQL CLI. Điều chỉnh `DB_URL`, `DB_USER`, `DB_PASSWORD` theo MySQL của bạn nếu cần.
2. Từ thư mục `source116/user-management` chạy:

~~~bash
mvn clean package
~~~

3. Deploy `target/user-management.war` vào Apache Tomcat 10.1+.
4. Mở `http://localhost:8080/user-management/users?action=create`.
5. Nhập Name, Email, Country và chọn ít nhất một permission, sau đó bấm Lưu.
6. Mở log Tomcat/IDE để xem lỗi SQL về cột `permission_id_typo`.
7. Kiểm tra database:

~~~sql
SELECT * FROM users ORDER BY id DESC;
SELECT * FROM user_permission ORDER BY user_id, permission_id;
~~~

Vì transaction rollback, không có User mới hoặc liên kết quyền mới do lần thử lỗi này tạo ra. Các bản ghi tồn tại từ trước không bị ảnh hưởng.

## Thử nghiệm commit thành công

Sau khi đã quan sát rollback, mở `UserDAO.java` và sửa câu lệnh:

~~~java
String insertPermissionSql =
        "INSERT INTO user_permission (user_id, permission_id_typo) VALUES (?, ?)";
~~~

thành:

~~~java
String insertPermissionSql =
        "INSERT INTO user_permission (user_id, permission_id) VALUES (?, ?)";
~~~

Build lại bằng `mvn clean package`, redeploy WAR, rồi tạo User kèm quyền lần nữa. Nếu thao tác thành công, DAO sẽ gọi `connection.commit()`, và User cùng các quyền sẽ được ghi nhận.

## Cảnh báo

Đây là lỗi có chủ ý phục vụ học tập; không dùng phiên bản đang gây lỗi trong môi trường production.