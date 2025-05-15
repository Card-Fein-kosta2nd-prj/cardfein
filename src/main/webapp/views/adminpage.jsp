<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String loginUser = (String) session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect("card_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>관리자 대시보드</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f3f4f6;
      margin: 0;
      padding: 0;
    }
    header {
      background-color: #3b82f6;
      color: white;
      padding: 20px;
      text-align: center;
      font-size: 24px;
      font-weight: bold;
    }
    .content {
      padding: 40px;
      text-align: center;
    }
    .logout {
      margin-top: 20px;
    }
  </style>
</head>
<body>
  <header>Card:Fein 관리자 대시보드</header>
  <div class="content">
    <h2>환영합니다, <%= loginUser %>님</h2>
    <form action="logout" method="post" class="logout">
      <button type="submit">로그아웃</button>
    </form>
  </div>
</body>
</html>
