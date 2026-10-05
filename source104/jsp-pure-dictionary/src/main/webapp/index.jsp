<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Từ điển Anh - Việt</title>
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
        .dictionary-container {
            width: min(100%, 420px);
            padding: 40px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,.1);
            text-align: center;
        }
        h1 {
            margin-top: 0;
            color: #1b2a7a;
        }
        .intro {
            color: #64748b;
            line-height: 1.5;
        }
        input {
            width: 100%;
            padding: 12px;
            margin: 20px 0 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        button {
            width: 100%;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            background: #1b2a7a;
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover { background: #121c54; }
    </style>
</head>
<body>
    <main class="dictionary-container">
        <h1>Từ Điển Anh - Việt</h1>
        <p class="intro">Nhập từ tiếng Anh cần tra cứu.</p>

        <form action="dictionary.jsp" method="POST">
            <label class="visually-hidden" for="search">Từ tiếng Anh</label>
            <input id="search"
                   type="text"
                   name="search"
                   placeholder="Nhập từ tiếng Anh..."
                   required
                   autofocus>
            <button type="submit">Tìm kiếm</button>
        </form>
    </main>
</body>
</html>