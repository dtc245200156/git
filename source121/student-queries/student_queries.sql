-- BAI THUC HANH: CAC CAU TRUY VAN MYSQL - QUAN LY SINH VIEN
-- Gia dinh schema theo mo hinh thong dung:
-- Student(StudentID, StudentName, ClassID, ...)
-- Class(ClassID, ClassName, StartDate, ...)
-- Subject(SubID, SubName, Credit, ...)
-- Mark(MarkID, StudentID, SubID, Mark, ...)
-- Chay tren CSDL quan ly sinh vien da tao tu bai truoc.

USE student_management;

-- 1. Hien thi sinh vien co ten bat dau bang ky tu 'h'.
-- LOWER() de tim khong phan biet chu hoa/chu thuong.
SELECT *
FROM Student
WHERE LOWER(StudentName) LIKE 'h%';

-- 2. Hien thi thong tin lop hoc co thoi gian bat dau trong thang 12.
SELECT *
FROM Class
WHERE MONTH(StartDate) = 12;

-- 3. Hien thi thong tin mon hoc co Credit tu 3 den 5 (bao gom ca 3 va 5).
SELECT *
FROM Subject
WHERE Credit BETWEEN 3 AND 5;

-- 4. Cap nhat ClassID thanh 2 cho sinh vien co ten 'Hung'.
-- Kiem tra so dong bi anh huong sau khi chay lenh UPDATE.
UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';

-- 5. Hien thi ten sinh vien, ten mon hoc va diem;
-- sap xep diem giam dan, neu bang diem thi ten sinh vien tang dan.
SELECT
    s.StudentName,
    sub.SubName,
    m.Mark
FROM Student AS s
INNER JOIN Mark AS m ON m.StudentID = s.StudentID
INNER JOIN Subject AS sub ON sub.SubID = m.SubID
ORDER BY m.Mark DESC, s.StudentName ASC;
