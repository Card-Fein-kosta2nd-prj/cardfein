<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Card:Fein 로그인</title>
  <style>
    body {
      font-family: "Arial", sans-serif;
      background-color: #3b82f6;
      margin: 0;
      padding: 0;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .logo {
      font-size: 40px;
      font-weight: bold;
      color: white;
      margin-bottom: 30px;
    }
    .login-container {
      width: 360px;
      background-color: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      text-align: center;
    }
    .login-container h1 {
      font-size: 2em;
      font-weight: bold;
      color: black;
      margin-bottom: 24px;
    }
    .login-container input[type="text"],
    .login-container input[type="password"] {
      width: 100%;
      padding: 12px;
      margin-bottom: 16px;
      border: 2px solid #2563eb;
      border-radius: 6px;
      font-size: 14px;
    }
    .login-container button {
      width: 50%;
      padding: 12px;
      background-color: #2563eb;
      border: none;
      border-radius: 6px;
      color: white;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
    }
    .signup-link {
      margin-top: 14px;
      font-size: 12px;
      color: #6b7280;
      cursor: pointer;
    }
    .signup-link:hover {
      text-decoration: underline;
      color: #374151;
    }
    .message {
      color: red;
      font-size: 14px;
      margin-bottom: 16px;
    }
  </style>
  <script src="/static/js/card_login.js"></script>
</head>
<body>
  <div class="logo">Card:Fein</div>
  <div class="login-container">
    <h1>Login</h1>
    <% String signup = request.getParameter("signup");
       String error = request.getParameter("error");
       String message = "";
       if ("success".equals(signup)) message = "다시 로그인해주세요.";
       else if ("fail".equals(error)) message = "아이디 또는 비밀번호가 틀렸습니다."; %>
    <% if (!message.isEmpty()) { %><p class="message"><%= message %></p><% } %>

    <form action="login" method="post">
      <input type="text" name="username" placeholder="ID" required />
      <input type="password" name="password" placeholder="Password" required />
      <button type="submit">로그인</button>
    </form>
    <button class="signup-link" onclick="location.href='<%= request.getContextPath() %>/views/signup.jsp'">회원가입</button>
  </div>
</body>
</html>