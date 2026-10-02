# Source 98 — JSP/Servlet Login

Bài thực hành xây dựng ứng dụng Java Web bằng JSP + Servlet, tương thích Tomcat 10.1+ và Jakarta Servlet API.

## Chức năng

- `index.jsp`: form đăng nhập gửi POST tới endpoint `/login`.
- `LoginServlet.java`: nhận username/password và kiểm tra tài khoản cố định:
  - `admin / admin` → `Welcome admin to website`
  - Sai thông tin → `Login Error`
- `web.xml`: cấu hình web application theo Jakarta Servlet 6.0.
- Maven đóng gói ứng dụng thành file WAR với tên `jsp-servlet-login.war`.

## Cấu trúc

```
source98/
└── jsp-servlet-login/
    ├── pom.xml
    └── src/
        └── main/
            ├── java/
            │   └── com/
            │       └── codegym/
            │           └── LoginServlet.java
            └── webapp/
                ├── index.jsp
                └── WEB-INF/
                    └── web.xml
```

## Build

Tại thư mục `jsp-servlet-login`:

```
mvn clean package
```

Sau khi build thành công, WAR được tạo tại:

```
target/jsp-servlet-login.war
```

## Deploy

Triển khai WAR vào thư mục `webapps` của Tomcat 10.1+ rồi khởi động server.

URL kiểm tra:

```
http://localhost:8080/jsp-servlet-login/
```
