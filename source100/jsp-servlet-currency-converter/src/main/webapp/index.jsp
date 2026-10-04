<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Currency Converter</title>
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            margin: 0;
            padding: 80px 20px;
            background: #f8fafc;
        }
        .converter-container {
            width: min(100%, 380px);
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 { color: #1b2a7a; margin-top: 0; }
        .field { text-align: left; margin-top: 18px; }
        label { display: block; font-weight: bold; color: #333; margin-bottom: 7px; }
        input {
            padding: 11px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            background: #1b2a7a;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-weight: bold;
            margin-top: 24px;
            font-size: 16px;
        }
        button:hover { background: #121c54; }
    </style>
</head>
<body>
    <main class="converter-container">
        <h1>Chuyển đổi USD sang VNĐ</h1>
        <p>Nhập tỉ giá và số USD cần chuyển đổi.</p>

        <form action="convert" method="POST">
            <div class="field">
                <label for="rate">Tỉ giá (VND/USD)</label>
                <input id="rate" type="number" name="rate" placeholder="Ví dụ: 25000"
                       value="25000" required step="any" min="0">
            </div>

            <div class="field">
                <label for="usd">Lượng USD cần đổi</label>
                <input id="usd" type="number" name="usd" placeholder="Nhập số USD"
                       required step="any" min="0">
            </div>

            <button type="submit">Chuyển đổi</button>
        </form>
    </main>
</body>
</html>
