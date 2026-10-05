# Source 104 — JSP Pure Dictionary

Ứng dụng JSP tra cứu từ Anh - Việt, thực hiện toàn bộ logic trực tiếp trong `dictionary.jsp`.

## Chức năng

- `index.jsp` chứa form nhập từ tiếng Anh với input `name="search"`.
- Form sử dụng phương thức `POST` tới `dictionary.jsp`.
- `dictionary.jsp` khởi tạo `Map<String, String>` bằng JSP Scriptlet.
- Từ khóa được chuẩn hóa về chữ thường trước khi tra cứu.
- Tìm thấy: hiển thị nghĩa tiếng Việt bằng JSP Expression.
- Không tìm thấy: hiển thị thông báo tương ứng.

## Cấu trúc

source104/
└── jsp-pure-dictionary/
    ├── pom.xml
    └── src/main/webapp/
        ├── index.jsp
        ├── dictionary.jsp
        └── WEB-INF/
            └── web.xml

## Công nghệ

- Java 17
- Maven
- JSP
- Jakarta Servlet API 6.0
- Tomcat 10.1+

## Build

Chạy tại thư mục `jsp-pure-dictionary`:

mvn clean package

WAR được tạo tại:

target/jsp-pure-dictionary.war

## URL

http://localhost:8080/jsp-pure-dictionary/
