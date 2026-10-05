<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String rateParam = request.getParameter("rate");
    String usdParam = request.getParameter("usd");

    Double rate = null;
    Double usd = null;
    Double vnd = null;
    String errorMessage = null;

    try {
        if (rateParam == null || usdParam == null) {
            throw new NumberFormatException("Missing parameters");
        }

        rate = Double.parseDouble(rateParam);
        usd = Double.parseDouble(usdParam);

        if (rate < 0 || usd < 0) {
            throw new NumberFormatException("Negative values are not allowed");
        }

        vnd = rate * usd;
    } catch (NumberFormatException e) {
        errorMessage = "Dữ liệu đầu vào không hợp lệ. Vui lòng kiểm tra lại.";
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả chuyển đổi</title>
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
            color: #1f2937;
        }
        .result-container {
            width: min(100%, 500px);
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,.1);
            text-align: center;
        }
        h1 {
            color: #1b2a7a;
            margin-top: 0;
        }
        .info {
            text-align: left;
            margin-top: 24px;
        }
        .info p {
            padding: 10px 0;
            margin: 0;
            border-bottom: 1px solid #e5e7eb;
        }
        .success {
            margin-top: 20px;
            padding: 15px;
            border-radius: 8px;
            background: #e8f5e9;
        }
        .success h2 {
            margin: 0;
            color: #27ae60;
            font-size: 24px;
        }
        .error {
            margin-top: 20px;
            padding: 15px;
            border-radius: 8px;
            background: #ffebee;
        }
        .error h2 {
            margin: 0;
            color: #c0392b;
        }
        .back-btn {
            display: inline-block;
            margin-top: 24px;
            padding: 10px 20px;
            background: #1b2a7a;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .back-btn:hover { background: #121c54; }
    </style>
</head>
<body>
    <main class="result-container">
        <h1>KẾT QUẢ CHUYỂN ĐỔI</h1>

        <% if (errorMessage == null) { %>
            <div class="info">
                <p>Tỉ giá hiện tại: <b><%= rate %></b> VND/USD</p>
                <p>Lượng USD yêu cầu: <b>$<%= usd %></b></p>
            </div>

            <div class="success">
                <h2>Thành tiền: <%= vnd %> VNĐ</h2>
            </div>
        <% } else { %>
            <div class="error">
                <h2>Lỗi xử lý!</h2>
                <p><%= errorMessage %></p>
            </div>
        <% } %>

        <a href="index.jsp" class="back-btn">Quay lại trang chủ</a>
    </main>
</body>
</html>