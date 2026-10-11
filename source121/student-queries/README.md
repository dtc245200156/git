# Bài thực hành MySQL — Quản lý sinh viên

File `student_queries.sql` gồm 5 câu truy vấn theo yêu cầu:

1. Tìm sinh viên có tên bắt đầu bằng `h` (không phân biệt chữ hoa/chữ thường).
2. Lấy các lớp có `StartDate` thuộc tháng 12.
3. Lấy môn học có `Credit` từ 3 đến 5, bao gồm cả hai đầu mút.
4. Cập nhật `ClassID = 2` cho sinh viên tên `Hung`.
5. Lấy `StudentName`, `SubName`, `Mark`, sắp xếp điểm giảm dần rồi tên sinh viên tăng dần.

## Cách chạy

Mở `student_queries.sql` trong MySQL Workbench và chạy trên CSDL của bài thực hành trước.

**Lưu ý về tên CSDL/bảng/cột:** Script giả định tên database là `student_management` và schema phổ biến gồm `Student(StudentID, StudentName, ClassID)`, `Class(ClassID, ClassName, StartDate)`, `Subject(SubID, SubName, Credit)`, `Mark(MarkID, StudentID, SubID, Mark)`. Nếu bài trước dùng tên khác, điều chỉnh `USE` hoặc tên tương ứng để khớp với schema thực tế. Câu `UPDATE` sẽ cập nhật mọi bản ghi có `StudentName = 'Hung'`; nên kiểm tra trước bằng `SELECT * FROM Student WHERE StudentName = 'Hung';` nếu dữ liệu có thể có nhiều sinh viên trùng tên.
