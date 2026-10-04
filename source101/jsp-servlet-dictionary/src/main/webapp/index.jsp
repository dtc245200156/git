<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Từ điển Anh - Việt</title>
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            min-height: 100vh;
            margin: 0;
            padding: 80px 20px;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            background: #f8fafc;
            color: #1e293b;
        }
        .dictionary-container {
            width: min(100%, 420px);
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,.1);
            text-align: center;
        }
        h1 { color: #1b2a7a; margin-top: 0; }
        .description { color: #64748b; line-height: 1.6; }
        input {
            width: 100%;
            padding: 12px;
            margin: 20px 0 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            width: 100%;
            padding: 12px 20px;
            background: #1b2a7a;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover { background: #121c54; }
        .examples {
            margin-top: 20px;
            font-size: 14px;
            color: #64748b;
        }
        .examples code {
            color: #1b2a7a;
            background: #eef2ff;
            padding: 3px 6px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <main class="dictionary-container">
        <h1>Từ Điển Anh - Việt</h1>
        <p class="description">Nhập một từ tiếng Anh để tra nghĩa tiếng Việt.</p>

        <form action="translate" method="POST">
            <label class="visually-hidden" for="word">Từ tiếng Anh</label>
            <input id="word" type="text" name="word"
                   placeholder="Nhập từ tiếng Anh..."
                   required autofocus>
            <button type="submit">Tìm kiếm</button>
        </form>

        <p class="examples">
            Ví dụ: <code>hello</code> · <code>book</code> · <code>computer</code>
        </p>
    </main>
</body>
</html>