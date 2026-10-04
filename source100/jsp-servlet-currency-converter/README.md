# Source 100 — JSP/Servlet Currency Converter

Bài thực hành tạo Servlet để chuyển đổi USD sang VNĐ theo tỉ giá nhập từ form. fileciteturn535file0L9-L12

## Cấu trúc

source100/
└── jsp-servlet-currency-converter/
    ├── pom.xml
    ├── src/main/java/com/codegym/ConverterServlet.java
    └── src/main/webapp/
        ├── index.jsp
        └── WEB-INF/web.xml

## Chức năng

- index.jsp có form nhập:
  - rate: tỉ giá VND/USD
  - usd: lượng USD muốn đổi
- Form dùng POST tới endpoint convert.
- ConverterServlet nhận rate và usd, tính:
  VND = USD × Rate
- Kết quả được hiển thị trực tiếp trên trình duyệt.
- Có xử lý NumberFormatException khi nhập dữ liệu không hợp lệ.

## Công nghệ

- Java 17
- Maven
- JSP
- Jakarta Servlet API 6.0
- Tomcat 10.1+

## Build

Tại thư mục jsp-servlet-currency-converter:

mvn clean package

WAR tạo tại:

target/jsp-servlet-currency-converter.war

## URL

http://localhost:8080/jsp-servlet-currency-converter/
