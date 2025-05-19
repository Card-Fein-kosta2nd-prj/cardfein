<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="cardfein.kro.kr.dto.LoginDto" %>
<%
    LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");

    // 로그인하지 않았거나, 관리자가 아닌 경우 접근 차단
    if (loginUser == null || !"admin".equals(loginUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/views/card_login.jsp");
        return;
    }
%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>관리자 대시보드 - Card:fein</title>
  <link rel="stylesheet" href="${path}/static/css/common.css" />
  <link rel="stylesheet" href="${path}/static/css/main.css" />
  <style>
    main {
      padding: 40px 20px;
      max-width: 1200px;
      margin: 0 auto;
    }

    .admin-welcome {
      background-color: white;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
      border-radius: 12px;
      padding: 40px;
      text-align: center;
      margin-top: 40px;
    }

    .admin-welcome h2 {
      font-size: 24px;
      margin-bottom: 16px;
    }

    .admin-welcome form {
      margin-top: 20px;
    }

    .admin-welcome button {
      background-color: #3b82f6;
      color: white;
      border: none;
      padding: 10px 20px;
      font-size: 14px;
      border-radius: 6px;
      cursor: pointer;
    }

    .admin-welcome button:hover {
      background-color: #2563eb;
    }

    .banner-image {
      margin-top: 60px;
      text-align: center;
    }

    .banner-image img {
      width: 100%;
      max-width: 1000px;
      border-radius: 12px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
    }
  </style>
</head>
<body>

  <!-- ✅ 공통 Header -->
  <jsp:include page="/views/common/header.jsp" />

  <main>
    <div class="admin-welcome">
      <h2>Card:fein 관리자 페이지입니다.</h2>
    </div>
  </main>

  <!-- ✅ 공통 Footer -->
  <jsp:include page="/views/common/footer.jsp" />

</body>
</html>
