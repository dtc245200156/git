# Source 105 — JSTL Customer List

Bài thực hành luyện tập sử dụng JSTL trong JSP để hiển thị danh sách khách hàng có sẵn. Yêu cầu bài tập là danh sách gồm tên, ngày sinh, địa chỉ và ảnh, sau đó kết hợp HTML với JSTL để hiển thị. 

## Chức năng

- Tạo danh sách Customer trong JSP.
- Truyền danh sách vào request với thuộc tính `customers`.
- Dùng JSTL Core với:
  - `c:forEach` để lặp danh sách.
  - `c:choose`, `c:when`, `c:otherwise` để xử lý danh sách rỗng.
  - `c:out` để xuất dữ liệu an toàn.
- Giao diện responsive, hiển thị ảnh, tên, ngày sinh và địa chỉ.

## Cấu trúc

source105/
└── jstl-customer-list/
    ├── pom.xml
    ├── src/main/java/com/codegym/Customer.java
    └── src/main/webapp/
        ├── index.jsp
        └── WEB-INF/web.xml

## JSTL

Dự án dùng JSTL 3.0.1 phù hợp với Jakarta/Tomcat 10.1+ và khai báo:

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

## Build

Tại thư mục `jstl-customer-list`:

mvn clean package

WAR:

target/jstl-customer-list.war

## URL

http://localhost:8080/jstl-customer-list/
