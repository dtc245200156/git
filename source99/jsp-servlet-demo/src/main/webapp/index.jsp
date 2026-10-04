<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    java.util.Date currentTime = new java.util.Date();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CodeGym JSP Demo</title>
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f8fafc;
            color: #1e293b;
        }
        .container {
            width: min(92%, 720px);
            background: #fff;
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 10px 28px rgba(15, 23, 42, 0.10);
            text-align: center;
        }
        h1 { color: #1b2a7a; margin-top: 0; }
        .time {
            display: inline-block;
            margin: 18px 0 26px;
            padding: 14px 20px;
            border-radius: 8px;
            background: #fff7ed;
            color: #f15a24;
            font-size: 1.15rem;
        }
        a {
            display: inline-block;
            background: #1b2a7a;
            color: #fff;
            padding: 11px 20px;
            text-decoration: none;
            border-radius: 6px;
        }
        a:hover { background: #14205d; }
    </style>
</head>
<body>
    <main class="container">
        <h1>Chào mừng tới lớp học Java Web!</h1>
        <p>Đây là trang JSP động được biên dịch trực tiếp từ Tomcat Server.</p>

        <div class="time">
            Thời gian hệ thống hiện tại:
            <strong><%= currentTime %></strong>
        </div>

        <br>
        <a href="hello">Đi tới HelloServlet</a>
    </main>
</body>
</html>
