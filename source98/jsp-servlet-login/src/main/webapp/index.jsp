<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login Page</title>
  <style>
    * { box-sizing: border-box; }
    body {
      font-family: Arial, sans-serif;
      display: flex;
      justify-content: center;
      margin: 0;
      padding: 100px 20px;
      background-color: #f8fafc;
      min-height: 100vh;
    }
    .login-container {
      width: min(100%, 380px);
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      text-align: center;
    }
    .login-container h1 {
      color: #1b2a7a;
      margin-top: 0;
    }
    input {
      padding: 10px;
      margin: 10px 0;
      width: 100%;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    button {
      background-color: #1b2a7a;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      width: 100%;
    }
    button:hover { background-color: #14205d; }
  </style>
</head>
<body>
  <main class="login-container">
    <h1>System Login</h1>
    <form action="login" method="POST">
      <label class="visually-hidden" for="username">Username</label>
      <input id="username" type="text" name="username" placeholder="Enter username" required>
      <label class="visually-hidden" for="password">Password</label>
      <input id="password" type="password" name="password" placeholder="Enter password" required>
      <button type="submit">Login</button>
    </form>
  </main>
</body>
</html>
