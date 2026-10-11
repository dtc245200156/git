# Source 114 — JDBC Transaction: Commit and Rollback

Bài thực hành tiếp nối Source113, minh họa JDBC transaction theo nguyên tắc **All-or-Nothing** trên bảng `Employee`.

## Kịch bản
1. Chuẩn bị bảng `Employee` (bản demo sẽ xóa và tạo lại bảng mỗi lần chạy).
2. Tắt auto-commit bằng `Connection.setAutoCommit(false)`.
3. Chèn hai nhân viên: Quynh (salary 10) và Ngan (salary 20).
4. Chạy UPDATE với lỗi có chủ ý: gọi `psUpdate.setBigDecimal(2, ...)` trong khi tham số 1 của câu `UPDATE Employee SET salary=? WHERE name=?` chưa được gán.
5. Khi câu UPDATE thất bại, DAO gọi `rollback()`, nên hai lệnh INSERT cũng bị hủy. Nếu tất cả câu lệnh thành công, DAO gọi `commit()`.

**Lưu ý:** Đây là mã phục vụ học tập, cố tình có lỗi ở tham số. Chỉ chạy trên database thực hành. Endpoint xóa và tạo lại bảng `Employee` trước khi bắt đầu transaction.

## Hai lần kiểm thử

### Lần 1 — kiểm chứng rollback
Sau khi build và deploy, truy cập:

`http://localhost:8080/user-management/users?action=test-use-tran`

Câu UPDATE sẽ phát sinh lỗi do thiếu tham số 1. DAO rollback transaction rồi ném lỗi để Servlet container ghi log. Kiểm tra:

~~~sql
SELECT * FROM Employee;
~~~

Kết quả mong đợi: bảng rỗng.

### Lần 2 — kiểm chứng commit
Mở `src/main/java/com/codegym/dao/UserDAO.java`, tìm đoạn code UPDATE trong `insertUpdateUseTransaction()`.

Đổi dòng cố tình sai:

~~~java
psUpdate.setBigDecimal(2, new java.math.BigDecimal("999.99"));
~~~

thành dòng đúng:

~~~java
psUpdate.setBigDecimal(1, new java.math.BigDecimal("999.99"));
~~~

Giữ nguyên dòng `psUpdate.setString(2, "Quynh");`. Build và deploy lại, rồi truy cập cùng URL. Khi đó hai INSERT và UPDATE đều thành công, sau đó transaction được commit.

Chạy:

~~~sql
SELECT * FROM Employee ORDER BY id;
~~~

Kết quả mong đợi: có hai dòng; salary của Quynh là `999.99`, salary của Ngan là `20.00`.

## Build
Từ thư mục `source114/user-management`:

~~~bash
mvn clean package
~~~

Deploy `target/user-management.war` lên Tomcat 10.1+ và đảm bảo biến môi trường JDBC đúng với MySQL của bạn.

## Các file chính
- `src/main/java/com/codegym/dao/IUserDAO.java`: khai báo `insertUpdateUseTransaction()`.
- `src/main/java/com/codegym/dao/UserDAO.java`: điều khiển auto-commit, commit, rollback.
- `src/main/java/com/codegym/controller/UserServlet.java`: route `test-use-tran`.
- `src/main/webapp/user/list.jsp`: nút chạy demo transaction.
- `database.sql`: schema cho ứng dụng và bảng Employee mẫu.

## Cảnh báo dữ liệu
Demo drop/recreate bảng `Employee` trước mỗi lần chạy để bắt đầu với bảng trống. Không triển khai endpoint này lên production hoặc database chứa dữ liệu cần giữ.