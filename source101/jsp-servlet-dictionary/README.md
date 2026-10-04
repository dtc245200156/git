# Source 101 — JSP/Servlet English-Vietnamese Dictionary

Bài thực hành xây dựng ứng dụng Web tra cứu từ Anh - Việt bằng JSP + Servlet. Theo đề bài, người dùng nhập từ tiếng Anh trên `index.jsp`; Servlet tìm nghĩa trong một Map và hiển thị kết quả hoặc thông báo không tìm thấy. fileciteturn546file0L9-L12

## Cấu trúc

source101/
└── jsp-servlet-dictionary/
    ├── pom.xml
    ├── src/main/java/com/codegym/DictionaryServlet.java
    └── src/main/webapp/
        ├── index.jsp
        └── WEB-INF/web.xml

## Chức năng

- Form `POST` tới endpoint `/translate`.
- Input bắt buộc có `name="word"`.
- Dictionary dùng `Map<String, String>`.
- Có các từ mẫu như:
  - hello → Xin chào
  - book → Quyển sách
  - computer → Máy tính
  - student → Sinh viên
- Không tìm thấy → hiển thị `Không tìm thấy từ: [từ khóa]`.
- Có xử lý chuỗi rỗng và escape HTML cho kết quả hiển thị.

## Công nghệ

- Java 17
- Maven
- JSP
- Jakarta Servlet API 6.0
- Tomcat 10.1+

## Build

Chạy tại thư mục `jsp-servlet-dictionary`:

```bash
mvn clean package
```

WAR được tạo tại:

```
target/jsp-servlet-dictionary.war
```

## URL

```
http://localhost:8080/jsp-servlet-dictionary/
```
