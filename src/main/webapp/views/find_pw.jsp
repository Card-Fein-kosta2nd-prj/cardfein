<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 찾기</title>
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
    input {
      width: 90%;
      padding: 10px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
    }
    button {
      background-color: #3b82f6;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 6px;
      cursor: pointer;
      margin-top: 10px;
    }
    button:hover {
      background-color: #2563eb;
    }
    a {
      margin-top: 20px;
      display: block;
      font-size: 14px;
      color: #3b82f6;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>비밀번호 찾기</h2>

    <!-- ✅ 아이디와 이메일 입력 -->
    <form method="post" action="<%= request.getContextPath() %>/find_pw">
      <input type="text" name="userId" placeholder="아이디 입력" required />
      <input type="email" name="email" placeholder="가입된 이메일 입력" required />
      <button type="submit">비밀번호 찾기</button>
    </form>

    <!-- ✅ 로그인 페이지 이동 -->
    <a href="<%= request.getContextPath() %>/views/card_login.jsp">로그인으로 돌아가기</a>
  </div>
</body>
</html>
