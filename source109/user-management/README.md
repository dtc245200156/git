# Source 109 — User Management (JDBC + MVC)

Khung dự án Java Web quản lý User với MySQL/JDBC theo mô hình MVC. Theo yêu cầu bài tập, Maven và web.xml được cấu hình đầy đủ, còn các lớp Java/JSP giữ ở dạng skeleton để học viên tự triển khai logic CRUD.

## Cấu trúc

source109/
└── user-management/
    ├── pom.xml
    ├── database.sql
    └── src/main/
        ├── java/com/codegym/
        │   ├── model/User.java
        │   ├── dao/IUserDAO.java
        │   ├── dao/UserDAO.java
        │   └── controller/UserServlet.java
        └── webapp/
            ├── user/
            │   ├── list.jsp
            │   ├── create.jsp
            │   ├── edit.jsp
            │   └── delete.jsp
            └── WEB-INF/web.xml

## Công nghệ

- Java 17, Maven WAR
- Jakarta Servlet API 6.0 và JSP API 3.1.1
- Jakarta JSTL 3.0
- MySQL Connector/J 8.3.0
- Tomcat 10.1+

## Bước 1 — Khởi tạo database

Mở MySQL Workbench/DBeaver hoặc terminal và chạy nội dung file `database.sql`. Script tạo database `demo`, bảng `users` và thêm hai bản ghi mẫu nếu chưa có.

## Bước 2 — Cấu hình JDBC

Khi tự triển khai `UserDAO`, thay JDBC URL, username và password theo MySQL trên máy của bạn. Không commit mật khẩu thật vào repository công khai.

## Bước 3 — Hoàn thiện bài thực hành

Triển khai Model User, chữ ký CRUD trong `IUserDAO`, kết nối JDBC trong `UserDAO`, điều hướng `/users` trong `UserServlet`, sau đó hoàn thiện 4 trang JSP bằng JSTL.

## Build

Từ thư mục `user-management`:

```bash
mvn clean package
```

WAR được tạo tại `target/user-management.war`.

URL sau khi deploy Tomcat:

`http://localhost:8080/user-management/users`
