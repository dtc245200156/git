# Source 106 — Servlet Calculator

Ứng dụng Java Web thực hiện bốn phép toán cơ bản: Cộng, Trừ, Nhân và Chia. Form gửi hai toán hạng và toán tử tới `CalculatorServlet`; lớp `Calculator` thực hiện phép tính và tung Exception khi chia cho 0.

## Cấu trúc

source106/
└── servlet-calculator/
    ├── pom.xml
    └── src/main/
        ├── java/com/codegym/model/Calculator.java
        ├── java/com/codegym/servlet/CalculatorServlet.java
        └── webapp/
            ├── index.jsp
            └── WEB-INF/web.xml

## Chức năng

- Form `POST /calculate`.
- Hỗ trợ `+`, `-`, `*`, `/`.
- Lớp `Calculator` có phương thức `calculate()`.
- Chia cho 0 → `ArithmeticException`.
- `CalculatorServlet` dùng try/catch để hiển thị thông báo lỗi.
- Thêm kiểm tra dữ liệu số và định dạng kết quả.

## Công nghệ

- Java 17
- Maven
- JSP
- Jakarta Servlet API 6.0
- Tomcat 10.1+

## Tham khảo

Mã nguồn tham khảo: https://github.com/codegym-vn/jwbd-servlet-calculator/tree/develop

## Build

mvn clean package

WAR: target/servlet-calculator.war

## URL

http://localhost:8080/servlet-calculator/
