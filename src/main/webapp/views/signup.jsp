<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Card:Fein 회원가입</title>
  <style>
    body {
      font-family: "Arial", sans-serif;
      background-color: #3b82f6;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .logo {
      font-size: 40px;
      font-weight: bold;
      color: white;
      margin-bottom: 30px;
    }

    .signup-container {
      width: 360px;
      background-color: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    .signup-container h1 {
      font-size: 2em;
      font-weight: bold;
      text-align: center;
      color: black;
      margin-bottom: 24px;
    }

    .signup-container input[type="text"],
    .signup-container input[type="password"],
    .signup-container input[type="email"] {
      width: 100%;
      padding: 12px;
      margin-bottom: 16px;
      border: 2px solid #2563eb;
      border-radius: 6px;
      font-size: 14px;
    }

    .signup-container button {
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

    .error-message {
      color: red;
      font-size: 13px;
      margin-bottom: 12px;
    }
  </style>

  <script>
    window.addEventListener("pageshow", function (event) {
      if (event.persisted) {
        document.querySelector("form").reset();
      }
    });
  </script>
</head>
<body>
  <div class="logo">Card:Fein</div>
  <div class="signup-container">
    <h1>Sign Up</h1>

    <%-- 에러 메시지 출력 --%>
    <%
      String error = request.getParameter("error");
      String message = "";
      if ("id".equals(error)) {
        message = "이미 존재하는 ID입니다.";
      } else if ("pw".equals(error)) {
        message = "이미 존재하는 비밀번호입니다.";
      } else if ("unknown".equals(error)) {
        message = "회원가입에 실패했습니다. 다시 시도해주세요.";
      }
    %>
    <% if (!message.isEmpty()) { %>
      <p class="error-message"><%= message %></p>
    <% } %>

    <%-- ✅ 절대경로로 수정된 form 태그 --%>
    <form action="${pageContext.request.contextPath}/signup" method="post">
      <input type="text" name="username" placeholder="ID" required />
      <input type="password" name="password" placeholder="Password" required />
      <input type="email" name="email" placeholder="Email" required />
      <button type="submit">회원가입</button>
    </form>
  </div>
</body>
</html>
