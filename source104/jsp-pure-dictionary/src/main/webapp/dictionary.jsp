<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    String searchWord = request.getParameter("search");

    Map<String, String> dic = new HashMap<>();
    dic.put("hello", "Xin chào");
    dic.put("how", "Thế nào");
    dic.put("book", "Quyển sách");
    dic.put("computer", "Máy tính");
    dic.put("student", "Sinh viên");
    dic.put("school", "Trường học");
    dic.put("teacher", "Giáo viên");
    dic.put("friend", "Bạn bè");

    String result = null;
    String normalizedSearch = "";

    if (searchWord != null) {
        normalizedSearch = searchWord.trim().toLowerCase();
        if (!normalizedSearch.isEmpty()) {
            result = dic.get(normalizedSearch);
        }
    }

    String displayWord = escapeHtml(searchWord);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả tra cứu</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 80px 20px;
            font-family: Arial, sans-serif;
            background: #f8fafc;
            color: #1e293b;
        }
        .result-container {
            width: min(100%, 500px);
            padding: 40px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,.1);
            text-align: center;
        }
        h1 { color: #1b2a7a; margin-top: 0; }
        .word {
            font-size: 18px;
            color: #555;
        }
        .meaning {
            margin-top: 20px;
            padding: 15px;
            border-radius: 8px;
            background: #e8f5e9;
        }
        .meaning h2 {
            margin: 0;
            color: #27ae60;
            font-size: 24px;
        }
        .not-found {
            margin-top: 20px;
            padding: 15px;
            border-radius: 8px;
            background: #ffebee;
        }
        .not-found h2 {
            margin: 0;
            color: #c0392b;
        }
        .back-btn {
            display: inline-block;
            margin-top: 24px;
            padding: 10px 20px;
            border-radius: 4px;
            background: #1b2a7a;
            color: #fff;
            text-decoration: none;
        }
        .back-btn:hover { background: #121c54; }
    </style>
</head>
<body>
    <main class="result-container">
        <h1>KẾT QUẢ TRA CỨU</h1>

        <% if (result != null) { %>
            <p class="word">
                Từ cần tra:
                <b style="color:#1b2a7a;"><%= displayWord %></b>
            </p>

            <div class="meaning">
                <h2>Nghĩa là: <%= escapeHtml(result) %></h2>
            </div>
        <% } else { %>
            <div class="not-found">
                <h2>Không tìm thấy!</h2>
                <p>
                    Từ khóa
                    <b style="color:#c0392b;"><%= displayWord %></b>
                    không có trong từ điển.
                </p>
            </div>
        <% } %>

        <a href="index.jsp" class="back-btn">Quay lại trang chủ</a>
    </main>
</body>
</html>

<%!
    private String escapeHtml(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace(""", "&quot;")
                .replace("'", "&#39;");
    }
%>