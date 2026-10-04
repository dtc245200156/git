<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Discount Calculator</title>
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
            background: #f4f7fb;
            color: #1f2937;
        }
        .calculator {
            width: min(100%, 500px);
            background: #fff;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,.10);
        }
        h1 { margin-top: 0; color: #1b2a7a; text-align: center; }
        .description { color: #64748b; text-align: center; margin-bottom: 28px; }
        .field { margin-bottom: 18px; }
        label { display: block; font-weight: bold; margin-bottom: 7px; }
        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 16px;
        }
        input:focus {
            outline: 2px solid #bfdbfe;
            border-color: #2563eb;
        }
        button {
            width: 100%;
            padding: 12px 18px;
            border: 0;
            border-radius: 6px;
            background: #1b2a7a;
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover { background: #14205d; }
    </style>
</head>
<body>
    <main class="calculator">
        <h1>Product Discount Calculator</h1>
        <p class="description">Enter product information to calculate the discount.</p>

        <form action="display-discount" method="POST">
            <div class="field">
                <label for="productDescription">Product Description</label>
                <input id="productDescription" type="text" name="productDescription"
                       placeholder="Enter product description" required>
            </div>

            <div class="field">
                <label for="listPrice">List Price</label>
                <input id="listPrice" type="number" name="listPrice"
                       placeholder="Enter list price" min="0" step="0.01" required>
            </div>

            <div class="field">
                <label for="discountPercent">Discount Percent</label>
                <input id="discountPercent" type="number" name="discountPercent"
                       placeholder="Enter discount percent" min="0" step="0.01" required>
            </div>

            <button type="submit">Calculate Discount</button>
        </form>
    </main>
</body>
</html>