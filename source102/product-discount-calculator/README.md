# Source 102 — Product Discount Calculator

Ứng dụng Web Java nhận dữ liệu từ form và tính chiết khấu cho sản phẩm.

## Chức năng

- Trang `index.jsp` nhập:
  - Product Description
  - List Price
  - Discount Percent
- Form dùng phương thức `POST` tới endpoint `/display-discount`.
- `DiscountServlet` nhận dữ liệu và tính:
  - Discount Amount = List Price × Discount Percent × 0.01
  - Discount Price = List Price − Discount Amount
- Trang kết quả hiển thị lại các thông tin đã nhập và hai giá trị tính toán.
- Có xử lý dữ liệu số không hợp lệ.

## Cấu trúc

source102/
└── product-discount-calculator/
    ├── pom.xml
    ├── src/main/java/com/codegym/DiscountServlet.java
    └── src/main/webapp/
        ├── index.jsp
        └── WEB-INF/web.xml

## Công nghệ

- Java 17
- Maven
- JSP
- Jakarta Servlet API 6.0
- Tomcat 10.1+

## Build

Tại thư mục `product-discount-calculator`:

mvn clean package

WAR:

target/product-discount-calculator.war

## URL

http://localhost:8080/product-discount-calculator/
