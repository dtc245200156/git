# Source 110 — User Management: Search by Country and Sort by Name

Bài thực hành JSP, Servlet, JDBC, MySQL. Dựa trên mô hình MVC và bổ sung:
- Tìm kiếm User theo country (tìm chuỗi con, không phân biệt hoa thường theo collation của database).
- Sắp xếp theo name tăng dần (A → Z) hoặc giảm dần (Z → A).
- Giữ chức năng thêm, sửa, xóa User.

## Cấu trúc

- `src/main/java/com/codegym/model/User.java`: model User.
- `src/main/java/com/codegym/dao/IUserDAO.java`: hợp đồng truy vấn dữ liệu.
- `src/main/java/com/codegym/dao/UserDAO.java`: JDBC CRUD, filter country, ORDER BY name.
- `src/main/java/com/codegym/controller/UserServlet.java`: xử lý request và điều hướng.
- `src/main/webapp/user/`: các view JSP.
- `database.sql`: tạo database `demo`, bảng `users` và dữ liệu mẫu.

## Yêu cầu

- JDK 17+
- Maven
- MySQL 8+
- Apache Tomcat 10.1+ (Jakarta Servlet 6)

## Cài đặt database

Chạy file `database.sql` trong MySQL Workbench hoặc MySQL CLI. Nếu đã có bảng users, hãy kiểm tra cấu trúc và dữ liệu hiện có trước khi chạy lại script.

## Cấu hình JDBC

Mặc định ứng dụng kết nối tới `jdbc:mysql://localhost:3306/demo`, user `root`, password rỗng. Tùy cấu hình máy, hãy đặt các biến môi trường sau trước khi chạy Tomcat:

- `DB_URL`: JDBC URL; mặc định trỏ tới database `demo`.
- `DB_USER`: tài khoản MySQL; mặc định là `root`.
- `DB_PASSWORD`: mật khẩu MySQL; mặc định rỗng.

Không commit thông tin đăng nhập thật vào GitHub.

## Build và chạy

Từ thư mục `source110/user-management`:

~~~bash
mvn clean package
~~~

Deploy `target/user-management.war` lên Tomcat 10.1+, sau đó truy cập:

`http://localhost:8080/user-management/users`

Trên trang danh sách, nhập country và chọn thứ tự sắp xếp name rồi bấm **Áp dụng**. Bấm **Xóa lọc** để trở về toàn bộ User.