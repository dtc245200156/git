# Source 103 — JSP Currency Converter

Ứng dụng JSP chuyển đổi USD sang VNĐ, thực hiện phép tính trực tiếp trong file `converter.jsp` bằng JSP Scriptlet và hiển thị kết quả bằng JSP Expression.

## Chức năng

- `index.jsp`: form nhập tỉ giá `rate` và lượng USD `usd`.
- Form sử dụng phương thức `POST` và gửi dữ liệu tới `converter.jsp`.
- `converter.jsp` nhận tham số từ `request`, ép kiểu số thực và tính:
  `VND = USD × Rate`.
- Kết quả hiển thị bằng JSP Expression `<%= ... %>`.
- Có xử lý dữ liệu đầu vào không hợp lệ.

## Cấu trúc

source103/
└── jsp-currency-converter/
    ├── pom.xml
    └── src/main/webapp/
        ├── index.jsp
        ├── converter.jsp
        └── WEB-INF/web.xml

## Công nghệ

- Java 17
- Maven
- JSP
- Jakarta Servlet API 6.0
- Tomcat 10.1+

## Build

Chạy tại thư mục `jsp-currency-converter`:

```bash
mvn clean package
```

WAR tạo tại:

```
target/jsp-currency-converter.war
```

## URL

```
http://localhost:8080/jsp-currency-converter/
```
