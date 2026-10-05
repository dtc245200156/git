<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Simple Calculator</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 70px 20px;
            font-family: Arial, sans-serif;
            background: #f8fafc;
            color: #1e293b;
        }
        .calculator {
            width: min(100%, 480px);
            padding: 36px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, .10);
        }
        h1 {
            margin-top: 0;
            text-align: center;
            color: #1b2a7a;
        }
        .intro {
            text-align: center;
            color: #64748b;
            margin-bottom: 28px;
        }
        .field {
            margin-bottom: 18px;
        }
        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 11px;
            border: 1px solid #cbd5e1;
            border-radius: 5px;
            font-size: 16px;
            background: #fff;
        }
        button {
            width: 100%;
            margin-top: 8px;
            padding: 12px;
            border: none;
            border-radius: 5px;
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
    <main class="calculator">
        <h1>Simple Calculator</h1>
        <p class="intro">Nhập hai toán hạng và chọn phép toán cần thực hiện.</p>

        <form method="POST" action="calculate">
            <div class="field">
                <label for="firstOperand">First operand</label>
                <input id="firstOperand" name="first-operand" type="number"
                       step="any" placeholder="Nhập số thứ nhất" required>
            </div>

            <div class="field">
                <label for="operator">Operator</label>
                <select id="operator" name="operator">
                    <option value="+">Addition (+)</option>
                    <option value="-">Subtraction (-)</option>
                    <option value="*">Multiplication (*)</option>
                    <option value="/">Division (/)</option>
                </select>
            </div>

            <div class="field">
                <label for="secondOperand">Second operand</label>
                <input id="secondOperand" name="second-operand" type="number"
                       step="any" placeholder="Nhập số thứ hai" required>
            </div>

            <button type="submit">Calculate</button>
        </form>
    </main>
</body>
</html>