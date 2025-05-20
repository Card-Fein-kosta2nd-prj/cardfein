<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Card:Fein 로그인</title>
  <style>
body {
  font-family: 'Noto Sans KR', sans-serif;
  margin: 0;
  padding: 0;
  height: 100vh;
  background: linear-gradient(135deg, #3b82f6, #60a5fa); /* ✅ 세련된 파란 그라데이션 */
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

/* ✅ 로고 - 정확히 중앙 정렬 */
.logo {
  font-size: 36px;
  font-weight: 800;
  color: white;
  margin-bottom: 24px;
  text-align: center;
}

/* ✅ 로그인 카드 */
.login-container {
  width: 340px;
  background: white;
  border-radius: 20px;
  padding: 40px 30px 60px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
  text-align: center; /* 내부 요소 가운데 정렬 */
  position: relative;
    box-shadow: 0 16px 40px rgba(0, 0, 0, 0.12); /* ✅ 그림자 강조 */
}

/* ✅ 제목 */
.login-container h1 {
  font-size: 1.7rem;
  font-weight: bold;
  color: #1f2937;
  margin-bottom: 24px;
}

/* ✅ 입력창: 가운데 배치, 내부 글자는 왼쪽 정렬 */
.login-container input[type="text"],
.login-container input[type="password"] {
  width: 100%;
  padding: 12px 14px;
  margin-bottom: 18px;
  border: 1.5px solid #60a5fa;
  border-radius: 12px;
  font-size: 14px;
  background-color: #f9fafb;
  text-align: left;

  box-sizing: border-box;  /* ✅ 내부 padding 포함 계산 */
}


.login-container input:focus {
  outline: none;
  border-color: #2563eb;
  box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.2);
  background-color: #fff;
}

/* ✅ 버튼 */
.login-container button[type="submit"] {
  width: 100%;
  padding: 12px;
  background: linear-gradient(90deg, #2563eb, #3b82f6);
  border: none;
  border-radius: 12px;
  color: white;
  font-size: 15px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.25s ease;
}

.login-container button[type="submit"]:hover {
  background: #1d4ed8;
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

/* ✅ 회원가입 버튼 */
.signup-link {
  margin-top: 20px;
  font-size: 13px;
  color: #6b7280;
  background: none;
  border: none;
  cursor: pointer;
}

.signup-link:hover {
  color: #374151;
  text-decoration: underline;
}

/* ✅ 메시지 (예: 로그인 실패 안내) */
.message {
  color: #ef4444;
  font-size: 13px;
  margin-bottom: 16px;
  text-align: center;
}

/* ✅ 하단 링크들 */
.find-links {
  position: absolute;
  bottom: 16px;
  left: 0;
  width: 100%;
  text-align: center;
  font-size: 13px;
  color: #9ca3af;
}

.find-links a {
  color: #6b7280;
  text-decoration: none;
  margin: 0 6px;
}

.find-links a:hover {
  text-decoration: underline;
  color: #ffffff;
}

  </style>
</head>
<body>
  <div class="logo">Card:Fein</div>

  <div class="login-container">
    <h1>Login</h1>

    <%
      String signup = request.getParameter("signup");
      String error = request.getParameter("error");
      String message = "";
      if ("success".equals(signup)) message = "회원가입이 완료되었습니다. 로그인 해주세요.";
      else if ("fail".equals(error)) message = "아이디 또는 비밀번호가 틀렸습니다."; 
    %>
    <% if (!message.isEmpty()) { %>
      <p class="message"><%= message %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/login" method="post">
      <input type="text" name="username" placeholder="ID" required />
      <input type="password" name="password" placeholder="Password" required />
      <button type="submit">로그인</button>
    </form>

    <button class="signup-link" onclick="location.href='<%= request.getContextPath() %>/views/signup.jsp'">회원가입</button>

    <!-- ✅ 카드 하단 고정: 아이디/비밀번호 찾기 -->
    <div class="find-links">
      <a href="<%= request.getContextPath() %>/views/find_id.jsp">아이디 찾기</a>
      <span class="divider">/</span>
      <a href="<%= request.getContextPath() %>/views/find_pw.jsp">비밀번호 찾기</a>
    </div>
  </div>

</body>
  
  
</body>
</html>
