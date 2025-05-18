<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>아이디 찾기 결과</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f3f4f6;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .container {
      background-color: white;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      width: 400px;
      text-align: center;
    }
    h2 {
      margin-bottom: 20px;
    }
    p {
      font-size: 18px;
      margin: 20px 0;
    }
    strong {
      color: #1f2937;
    }
    a {
      color: #3b82f6;
      text-decoration: none;
      margin-top: 20px;
      display: inline-block;
      font-size: 14px;
    }
    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>아이디 찾기 결과</h2>

    <%
      String userId = (String) request.getAttribute("userId");
      if (userId != null && !userId.trim().isEmpty()) {
    %>
        <p>회원님의 아이디는 <strong><%= userId %></strong> 입니다.</p>
    <%
      } else {
    %>
        <p>입력하신 이메일로 가입된 아이디가 없습니다.</p>
    <%
      }
    %>

    <a href="<%= request.getContextPath() %>/views/card_login.jsp">로그인 페이지로 돌아가기</a>
  </div>
</body>
</html>
