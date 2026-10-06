# Source 108 — Product Management MVC

Ứng dụng quản lý sản phẩm theo kiến trúc MVC.

## Chức năng

- Hiển thị danh sách sản phẩm.
- Tạo sản phẩm mới.
- Cập nhật thông tin sản phẩm.
- Xóa sản phẩm.
- Xem chi tiết sản phẩm.
- Tìm kiếm sản phẩm theo tên.

## Thuộc tính Product

- id
- name
- price
- description
- manufacturer

## Cấu trúc

source108/
└── product-management/
    ├── pom.xml
    └── src/main/
        ├── java/com/codegym/
        │   ├── model/Product.java
        │   ├── service/ProductService.java
        │   ├── service/ProductServiceImpl.java
        │   └── controller/ProductServlet.java
        └── webapp/
            ├── error-404.jsp
            ├── product/
            │   ├── list.jsp
            │   ├── create.jsp
            │   ├── edit.jsp
            │   ├── delete.jsp
            │   ├── view.jsp
            │   └── error.jsp
            └── WEB-INF/web.xml

## MVC

- Model: Product.
- Service: ProductService và ProductServiceImpl, lưu dữ liệu giả lập bằng Map tĩnh.
- Controller: ProductServlet, ánh xạ /products và điều hướng theo action.
- View: các trang JSP, sử dụng JSTL để hiển thị dữ liệu.

## Công nghệ

- Java 17
- Maven WAR
- JSP
- JSTL 3.0
- Jakarta Servlet 6.0
- Tomcat 10.1+

## Build

Tại thư mục product-management:

mvn clean package

WAR:

target/product-management.war

## Kiểm tra

http://localhost:8080/product-management/products
