# Source 107 — Customer Management MVC Skeleton

Khung dự án Java Web quản lý khách hàng theo kiến trúc MVC. Bài yêu cầu các chức năng hiển thị, thêm, sửa, xóa và xem chi tiết khách hàng, nhưng phần khởi tạo AI bắt buộc chỉ tạo cấu trúc và chữ ký cơ bản, chưa sinh logic nghiệp vụ hay giao diện JSP hoàn chỉnh. 

## Cấu trúc

source107/
└── customer-management/
    ├── pom.xml
    └── src/main/
        ├── java/com/codegym/
        │   ├── model/Customer.java
        │   ├── service/CustomerService.java
        │   ├── service/CustomerServiceImpl.java
        │   └── controller/CustomerServlet.java
        └── webapp/
            ├── error-404.jsp
            ├── customer/
            │   ├── list.jsp
            │   ├── create.jsp
            │   ├── edit.jsp
            │   ├── delete.jsp
            │   └── view.jsp
            └── WEB-INF/web.xml

## Công nghệ

- Java 17
- Maven WAR
- Jakarta Servlet API 6.0
- Jakarta JSP API 3.1.1
- JSTL API 3.0.0
- JSTL implementation 3.0.1
- Tomcat 10.1+

## Trạng thái

Các file cấu hình hệ thống được hoàn thiện để dự án có thể biên dịch. Các class Java và JSP được giữ ở dạng skeleton/comment theo đúng ràng buộc của đề bài; logic MVC sẽ được học viên triển khai ở các bước thực hành tiếp theo.
