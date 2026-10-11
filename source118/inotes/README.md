# Source 118 — iNotes (Strategy Pattern)

Ứng dụng web quản lý ghi chú cá nhân bằng Java, JSP, Servlet, JDBC và MySQL. Mẫu **Strategy Pattern** tách logic nghiệp vụ khỏi tầng lưu trữ và cho phép chuyển đổi giữa MySQL và file TXT ngay trên giao diện.

## Chức năng

- Thêm ghi chú với tiêu đề, nội dung và phân loại.
- Hiển thị danh sách ghi chú và xem chi tiết.
- Tìm kiếm theo từ khóa trong tiêu đề hoặc nội dung.
- Phân loại theo Cá nhân, Công việc và Học tập.
- Sửa và xóa ghi chú.
- Chọn nơi lưu trữ MySQL hoặc File TXT tại runtime.
- Mỗi session có thể chọn strategy riêng. Dữ liệu trong database và file là hai kho riêng biệt; ứng dụng không tự đồng bộ giữa chúng.

## Kiến trúc

- `model/Note.java`: dữ liệu ghi chú, getter/setter và thao tác lưu/xóa thông qua strategy.
- `strategy/NoteStrategy.java`: hợp đồng `save`, `delete`, `findAll`, `search`, `findById`.
- `strategy/NoteDBStrategy.java`: triển khai bằng JDBC/MySQL.
- `strategy/NoteFileStrategy.java`: triển khai bằng file UTF-8, định dạng mỗi dòng `id|title|content|typeId`. Dấu `|`, dấu gạch chéo ngược và xuống dòng được escape để không làm hỏng cấu trúc file.
- `service/NoteManagement.java`: `searchNotes`, `addNote`, `saveNote`, `deleteNote` và `setStrategy`.
- `controller/NoteServlet.java`: điều phối request theo MVC.
- `src/main/webapp/WEB-INF/views/`: dashboard, form và trang chi tiết JSP.
- `database.sql`: tạo schema và dữ liệu mẫu.

## Yêu cầu

- JDK 17+
- Maven
- MySQL 8+
- Apache Tomcat 10.1+ (Jakarta Servlet 6)

## 1. Thiết lập MySQL

Chạy toàn bộ `database.sql` trong MySQL Workbench hoặc MySQL CLI. Script tạo database `inotes_db`, bảng `note_type`, bảng `notes` với khóa ngoại và dữ liệu danh mục mẫu.

Thông tin kết nối mặc định:
- URL: `jdbc:mysql://localhost:3306/inotes_db`
- User: `root`
- Password: rỗng

Có thể ghi đè bằng biến môi trường:
- `INOTES_DB_URL`
- `INOTES_DB_USER`
- `INOTES_DB_PASSWORD`

## 2. Build và deploy

Từ thư mục `source118/inotes`, chạy:

~~~bash
mvn clean package
~~~

Deploy `target/inotes.war` lên Tomcat 10.1+ và mở:

`http://localhost:8080/inotes/notes`

## 3. Chuyển đổi strategy

Trên dashboard, chọn **MySQL Database** hoặc **File TXT** ở mục **Nơi lưu trữ**, rồi nhấn **Tìm kiếm**. Strategy được giữ trong session hiện tại.

Mặc định ứng dụng dùng MySQL. Muốn mặc định dùng file, đặt biến môi trường `INOTES_STORAGE=file` trước khi khởi động Tomcat. Giá trị mặc định của file là `data/notes.txt` tính từ working directory của server; có thể đổi bằng JVM option:

~~~text
-Dinotes.file.path=/duong/dan/toi/notes.txt
~~~

Ví dụ trên Windows có thể đặt một đường dẫn tuyệt đối như `C:\inotes-data\notes.txt`.

## 4. Kiểm thử nhanh

1. Mở dashboard và chọn **File TXT**.
2. Thêm ghi chú chứa nhiều dòng hoặc ký tự `|` để kiểm tra escaping.
3. Tìm kiếm bằng một từ có trong tiêu đề hoặc nội dung.
4. Xem, sửa và xóa ghi chú.
5. Chuyển sang **MySQL Database** sau khi đã cấu hình database và so sánh kho dữ liệu của strategy đó.

**Lưu ý:** File strategy không cần MySQL để lưu ghi chú, nhưng ứng dụng mặc định khởi tạo bằng DB strategy. Chuyển sang File TXT sẽ không tự chuyển các ghi chú từ DB qua file và ngược lại.