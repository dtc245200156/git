# Source 99 — JSP/Servlet Demo

Bài thực hành xây dựng ứng dụng Java Web đơn giản bằng JSP + Servlet, tương thích Tomcat 10.1+.

Theo đề bài, ứng dụng có một trang chính hiển thị thời gian hiện tại của máy chủ, đồng thời có Servlet để kiểm thử. 

## Cấu trúc

source99/
└── jsp-servlet-demo/
    ├── pom.xml
    ├── src/main/java/com/codegym/HelloServlet.java
    └── src/main/webapp/
        ├── index.jsp
        └── WEB-INF/web.xml

## Công nghệ

- Maven
- JSP
- Jakarta Servlet 6.0
- Java 17
- Tomcat 10.1+

## Chức năng

- index.jsp: hiển thị thời gian hiện tại bằng JSP Scriptlet.
- HelloServlet.java: xử lý GET tại /hello và hiển thị trang chào mừng.
- web.xml: cấu hình Jakarta Web Application.

## Build

Chạy tại thư mục jsp-servlet-demo:

mvn clean package

WAR tạo ra:

target/jsp-servlet-demo.war

## URL sau khi deploy

http://localhost:8080/jsp-servlet-demo/
http://localhost:8080/jsp-servlet-demo/hello
