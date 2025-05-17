<%@page import="cardfein.kro.kr.dto.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <link rel="stylesheet" href="${path}/static/css/common.css" />
    <link rel="stylesheet" href="${path}/static/css/cardranking.css" />
  </head>
  <body>
    <jsp:include page="/views/common/header.jsp" />
    <div class="container">
      <!-- 로고 및 상단 네비게이션 -->
      <div class="top-bar">
        <div class="logo">카드커버</div>
        <div class="nav">
          <a href="#">베스트</a>
          <a href="#">카드커버</a>
          <a href="#">DIY카드</a>
          <a href="#">스티커제작소</a>
          <a href="#">스티커샵</a>
          <a href="#">쇼룸</a>
          <a href="#">뉴스룸</a>
        </div>
      </div>

      <!-- TOP100 랭킹 -->
      <div class="ranking-section">
        <h2>카드커버 TOP100 <span class="powered">Powered by @gif</span></h2>
        <div class="ranking-list">
          
        </div>
      </div>

      <!-- 카드 목록 -->
      <div class="card-grid">
        <div class="card-item">
          <img src="" alt="Card6" />
          <div class="title">고른 선택, 댕기</div>
        </div>
        
      </div>
    </div>

    <jsp:include page="/views/common/footer.jsp" />
    <%
    	LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");
    	int userNo = (loginUser != null) ? loginUser.getUserNo() : -1;
    %>
    <script type="text/javascript">
    	const userNo = <%= userNo %>;
    	const path = "${path}";
    </script>
    <script src="${path}/static/js/cardCover/cardranking.js"></script>
  </body>
</html>
