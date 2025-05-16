<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cardfein.kro.kr.dto.LoginDto" %>
<%
  String path = request.getContextPath();
  LoginDto loginUser = (LoginDto) session.getAttribute("loginUser");
%>
<header class="logo-header">
  <div class="header-container">
    <a href="<%= path %>/main.jsp">
      <img src="<%= path %>/static/images/icons/logo.png" alt="로고" class="main-logo">
    </a>
  </div>
</header>
<div class="card-nav" id="sticky-nav">
  <div class="header-container" style="display: flex; justify-content: space-between; align-items: center;">
    <div class="card-nav-logo">
      <a href="<%= path %>/main.jsp">
        <img src="<%= path %>/static/images/icons/logo.png" alt="로고" class="nav-logo-img">
      </a>
    </div>
    <nav class="card-nav-menu">
      <ul>
        <li class="dropdown">
          <a href="#" class="dropbtn">랭킹</a>
          <div class="dropdown-content">
            <a href="#">실시간</a>
            <a href="#">카드사별</a>
            <a href="#">혜택별</a>
          </div>
        </li>
        <li class="dropdown">
          <a href="<%= path %>/views/cardMenu/fitCard.jsp" class="dropbtn">카드</a>
          <div class="dropdown-content">
            <a href="<%= path %>/views/cardMenu/fitCard.jsp">맞춤카드 검색</a>
            <a href="#">카드추천 테스트</a>
            <a href="<%= path %>/views/recommend/byBill.jsp">명세서 추천</a>
              <% if (loginUser != null) { %>
    <a href="<%= path %>/views/recommend/memberCardRecommend.jsp">누적기반 맞춤추천</a>
  <% } %>
          </div>
        </li>
        <li class="dropdown">
          <a href="<%= path %>/views/community/community.jsp" class="dropbtn">커뮤니티</a>
          <div class="dropdown-content">
            <a href="<%= path %>/views/community/community.jsp">카드리뷰</a>
            <a href="#">콘텐츠</a>
            <a href="#">공지사항</a>
          </div>
        </li>
        <li><a href="#">카드커버</a></li>
      </ul>
    </nav>
    <div class="user-actions" style="margin-left: auto; display: flex; align-items: center; gap: 12px;">
      <a href="<%= path %>/views/cart/cart.jsp" class="cart">
        <img src="<%= path %>/static/images/icons/cart.png" alt="장바구니">
        <span class="cart-count">0</span>
      </a>
      <% if (loginUser == null) { %>
        <a href="<%= path %>/views/card_login.jsp" class="login-btn">로그인</a>
      <% } else { %>
        <a href="<%= path %>/logout" class="login-btn">로그아웃</a>
        <a href="<%= path %>/views/myinfo.jsp" class="login-btn">회원정보</a>
        <a href="<%= path %>/views/myinfo.jsp" class="profile">
          <img src="<%= path %>/static/images/icons/profile.png" alt="프로필" />
        </a>
      <% } %>
    </div>
  </div>
</div>