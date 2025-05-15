<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- contextPath 변수 설정 --%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Card:fein - 내 손안의 카드비서</title>

    <!-- 공통 스타일 -->
    <link rel="stylesheet" href="${path}/static/css/common.css" />

    <!-- 공통 스크립트 -->
    <script src="${path}/static/js/common.js" defer></script>
    <!-- 페이지 전용 스크립트 -->
    <script src="${path}/static/js/main.js" defer></script>
    
    <style>
      main {
        padding: 40px 20px;
        max-width: 960px;
        margin: 0 auto;
      }
    </style>
</head>
<body>

    <!-- ✅ 공통 header 포함 -->
    <jsp:include page="/views/common/header.jsp" />

    <!-- ✅ 메인 콘텐츠 -->
    <main>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
        <h1>메인</h1>
    </main>

    <!-- ✅ 공통 footer 포함 -->
    <jsp:include page="/views/common/footer.jsp" />

</body>
</html>
