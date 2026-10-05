<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>USD to VND Converter</title>
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
        .converter-container {
            width: min(100%, 420px);
            background: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,.1);
        }
        h1 {
            margin-top: 0;
            margin-bottom: 10px;
            text-align: center;
            color: #1b2a7a;
        }
        .intro {
            text-align: center;
            color: #64748b;
            line-height: 1.5;
            margin-bottom: 28px;
        }
        .field {
            margin-bottom: 18px;
        }
        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            color: #333;
        }
        input {
            width: 100%;
            padding: 11px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        button {
            width: 100%;
            margin-top: 8px;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            background-color: #1b2a7a;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover { background-color: #121c54; }
    </style>
</head>
<body>
    <main class="converter-container">
        <h1>USD to VND Converter</h1>
        <p class="intro">Nhập tỉ giá và lượng USD muốn chuyển đổi.</p>

        <form action="converter.jsp" method="POST">
            <div class="field">
                <label for="rate">Tỉ giá (VND/USD)</label>
                <input id="rate" type="number" name="rate"
                       placeholder="Ví dụ: 25000"
                       value="25000"
                       min="0"
                       step="any"
                       required>
            </div>

            <div class="field">
                <label for="usd">Lượng USD cần đổi</label>
                <input id="usd" type="number" name="usd"
                       placeholder="Nhập số lượng USD"
                       min="0"
                       step="any"
                       required>
            </div>

            <button type="submit">Tính toán</button>
        </form>
    </main>
</body>
</html>