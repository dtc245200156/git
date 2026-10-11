# Source 113 — JDBC Auto-Commit Demo (Without Transaction)

Bài thực hành minh họa sự khác biệt khi nhiều lệnh SQL được chạy **không dùng transaction**. Hai dòng Employee được chèn trước, sau đó câu lệnh UPDATE cố tình bỏ trống tham số số 1 để tạo lỗi JDBC. Vì auto-commit được bật, các dòng INSERT đã hoàn thành vẫn còn trong bảng dù UPDATE thất bại.

## Tính năng và điểm cần quan sát
- Giữ ứng dụng User Management của bài trước: CRUD, tìm kiếm theo country, sắp xếp name, Stored Procedures và phân quyền theo transaction khi tạo User.
- Thêm endpoint `/users?action=test-without-tran`.
- Thêm nút **Chạy demo auto-commit** trên trang danh sách.
- Mỗi lần chạy demo, DAO **xóa và tạo lại bảng Employee**, chèn `Quynh` và `Ngan`, rồi cố tình lỗi trong câu UPDATE:
  - SQL: `UPDATE Employee SET salary=? WHERE name=?`
  - Code cố ý không gán parameter 1; đặt lại parameter 2 hai lần.
  - Kết quả mong đợi: log console báo `No value specified for parameter 1`; hai dòng INSERT vẫn còn và lương của Quynh chưa thành 999.99.

> **Cảnh báo:** Đây là mã minh họa có chủ ý tạo lỗi và xóa/tạo lại bảng Employee mỗi lần chạy endpoint. Chỉ chạy trên database thực hành, không dùng cho môi trường production hoặc bảng chứa dữ liệu thật.

## Công nghệ
- JDK 17+
- Maven WAR
- MySQL 8+
- Jakarta Servlet 6 / JSP 3.1 / JSTL 3.0
- Apache Tomcat 10.1+

## Chuẩn bị database
1. Kết nối MySQL.
2. Chạy `database.sql` trong thư mục dự án để tạo database demo, các bảng và Stored Procedures dùng bởi ứng dụng; script cũng khai báo bảng Employee.
3. Đặt biến môi trường JDBC nếu cấu hình MySQL của bạn không dùng mặc định:
   - `DB_URL` — mặc định `jdbc:mysql://localhost:3306/demo?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8`
   - `DB_USER` — mặc định `root`
   - `DB_PASSWORD` — mặc định rỗng

Không lưu mật khẩu database thật vào GitHub.

## Build và chạy
Trong thư mục `source113/user-management`, chạy:

~~~bash
mvn clean package
~~~

Deploy `target/user-management.war` lên Tomcat 10.1+, rồi truy cập:

`http://localhost:8080/user-management/users?action=test-without-tran`

Hoặc mở trang danh sách User và bấm **Chạy demo auto-commit**. Xem log của Tomcat/IDE và kiểm tra kết quả bằng SQL:

~~~sql
SELECT * FROM Employee;
~~~

Sau lần chạy thành công đến bước lỗi, bảng sẽ có Quynh (salary 10.00) và Ngan (salary 20.00). UPDATE không hoàn thành; đây là hành vi dự kiến của bài tập.

## Đường dẫn mã nguồn chính
- `src/main/java/com/codegym/dao/IUserDAO.java`
- `src/main/java/com/codegym/dao/UserDAO.java`
- `src/main/java/com/codegym/controller/UserServlet.java`
- `src/main/webapp/user/list.jsp`
- `database.sql`
