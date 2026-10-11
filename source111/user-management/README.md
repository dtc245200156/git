# Source 111 — User Management with MySQL Stored Procedures

Bài thực hành JSP, Servlet, JDBC, MySQL: cập nhật ứng dụng quản lý User để sử dụng Stored Procedures và JDBC `CallableStatement` cho hai thao tác:

1. Lấy thông tin User theo ID bằng `get_user_by_id`.
2. Thêm User bằng `insert_user`.

Các chức năng của source110 như tìm kiếm theo country, sắp xếp theo name và CRUD còn lại được giữ lại.

## Công nghệ
- JDK 17+
- Maven WAR
- MySQL 8+
- Jakarta Servlet 6, JSP 3.1, JSTL 3.0
- Apache Tomcat 10.1+

## Cấu trúc quan trọng
- `database.sql`: tạo database/table mẫu và hai stored procedures.
- `src/main/java/com/codegym/dao/IUserDAO.java`: khai báo `getUserById` và `insertUserStore`.
- `src/main/java/com/codegym/dao/UserDAO.java`: gọi procedures bằng `CallableStatement`.
- `src/main/java/com/codegym/controller/UserServlet.java`: sử dụng `getUserById` khi tải form sửa/xóa và `insertUserStore` khi thêm mới.
- `src/main/webapp/user/`: JSP list/create/edit/delete.

## Thiết lập database
Chạy toàn bộ file `database.sql` bằng MySQL Workbench hoặc MySQL CLI. Script sử dụng `DROP PROCEDURE IF EXISTS` trước khi tạo lại thủ tục để có thể chạy lại phần stored procedure.

## Cấu hình JDBC
Mặc định DAO dùng URL `jdbc:mysql://localhost:3306/demo`, user `root`, password rỗng. Có thể tùy chỉnh bằng biến môi trường:
- `DB_URL`
- `DB_USER`
- `DB_PASSWORD`

Không commit mật khẩu database thật vào repository.

## Build và chạy
Từ thư mục `source111/user-management` chạy:

~~~bash
mvn clean package
~~~

Deploy `target/user-management.war` vào Tomcat 10.1+ rồi truy cập:

`http://localhost:8080/user-management/users`

Tại form thêm User, dữ liệu được thêm qua `{CALL insert_user(?, ?, ?)}`. Khi mở form sửa hoặc xóa User, dữ liệu được lấy qua `{CALL get_user_by_id(?)}`.

## Triển khai lên Tomcat
Hãy kiểm tra đường dẫn Tomcat trên máy của bạn trước khi copy WAR. Trên Windows, ví dụ:

~~~powershell
mvn clean package
Copy-Item .\target\user-management.war "C:\Tomcat 10.1\webapps\user-management.war"
& "C:\Tomcat 10.1\bin\startup.bat"
~~~

Thay `C:\Tomcat 10.1` bằng đường dẫn cài đặt thực tế. Các lệnh trên chỉ là ví dụ hướng dẫn; việc build/deploy cần thực hiện trên máy đang có JDK, Maven, MySQL và Tomcat cài đặt.