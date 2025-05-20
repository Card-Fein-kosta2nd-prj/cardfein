<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Card:fein - 카드커버 만들기</title>
    
    <link rel="stylesheet" href="${path}/static/css/common.css">
    <link rel="stylesheet" href="${path}/static/css/popup.css">
    <!-- 공통 스크립트 -->
<script src="${path}/static/js/common.js" defer></script>
  </head>
  <body>
  
	<jsp:include page="/views/common/header.jsp" />
    <div class="popup-container">
      <h1 class="title">Create Your Own Card</h1>
      <p class="subtitle">
        내가 원하는 사진으로 자유롭게!<br />나만의 커스텀 커버를 만들어보자.
      </p>
      <button id="openPopupBtn" class="button">도안 만들기</button>
    </div>
    
    <%@ include file="popup.jsp" %>

    <jsp:include page="/views/common/footer.jsp" />
    
  </body>
</html>
