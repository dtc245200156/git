# Final Exam — Product Management (Source119)

Ứng dụng web quản lý sản phẩm sử dụng Java Servlet, JSP, JDBC, MySQL và Maven.

## Chức năng
- Hiển thị danh sách sản phẩm với ID, tên, giá và số lượng.
- Thêm sản phẩm mới.
- Sửa thông tin sản phẩm với dữ liệu hiện có được điền sẵn.
- Xóa sản phẩm với hộp thoại xác nhận.
- Dùng JDBC `PreparedStatement`, kiểm tra dữ liệu đầu vào và áp dụng POST-Redirect-GET sau khi ghi dữ liệu.

## Công nghệ
- JDK 17+
- Maven
- MySQL 8+
- Apache Tomcat 10.1+ (Jakarta Servlet 6)
- JSP + JSTL + Bootstrap 5.3

## 1. Tạo cơ sở dữ liệu
Mở MySQL Workbench hoặc MySQL CLI và chạy toàn bộ file `database.sql`. File tạo database `product_management_db`, bảng `products` và ba sản phẩm mẫu nếu chưa tồn tại.

## 2. Cấu hình JDBC
Mặc định:
- URL: `jdbc:mysql://localhost:3306/product_management_db`
- User: `root`
- Password: rỗng

Có thể cấu hình bằng biến môi trường:
- `PRODUCT_DB_URL`
- `PRODUCT_DB_USER`
- `PRODUCT_DB_PASSWORD`

Không lưu mật khẩu MySQL thật vào repository công khai.

## 3. Build
Tại thư mục dự án, chạy:

~~~bash
mvn clean package
~~~

WAR được tạo tại `target/product-management.war`.

## 4. Deploy lên Tomcat
Sao chép `target/product-management.war` vào thư mục `webapps` của Tomcat 10.1+, khởi động Tomcat và truy cập:

`http://localhost:8080/product-management/products`

## Cấu trúc
- `src/main/java/com/codegym/model/Product.java` — model sản phẩm.
- `src/main/java/com/codegym/dao/ProductDAO.java` — truy vấn JDBC CRUD.
- `src/main/java/com/codegym/controller/ProductServlet.java` — controller xử lý request.
- `src/main/webapp/WEB-INF/views/product-list.jsp` — danh sách.
- `src/main/webapp/WEB-INF/views/product-form.jsp` — form thêm/sửa.
- `database.sql` — schema và dữ liệu mẫu.

## Đóng gói bài nộp
Nén thư mục dự án cùng file SQL thành ZIP. Đổi tên file thành `<MaSoSinhVien>_FinalExam.zip` trước khi nộp, ví dụ `123456_FinalExam.zip`.
