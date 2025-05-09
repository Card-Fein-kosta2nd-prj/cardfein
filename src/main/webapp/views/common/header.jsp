<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로고 헤더 (중앙 배치) -->
<header class="logo-header">
    <div class="container">
        <img src="${pageContext.request.contextPath}/static/images/icons/logo.png" alt="로고" class="main-logo">
    </div>
</header>

<!-- 네비게이션 헤더 (스크롤 시 보이는 헤더) -->
<div class="card-nav" id="sticky-nav">
    <div class="container">
        <div class="card-nav-logo">
            <img src="${pageContext.request.contextPath}/static/images/icons/logo.png" alt="로고" class="nav-logo-img">
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
                    <a href="#" class="dropbtn">카드</a>
                    <div class="dropdown-content">
                        <a href="#">맞춤카드 검색</a>
                        <a href="#">카드추천 테스트</a>
                        <a href="#">명세서 맞춤추천</a>
                    </div>
                </li>
                <li><a href="#">커뮤니티</a></li>
                <li><a href="#">카드커버</a></li>
            </ul>
        </nav>
        
        <div class="user-actions">
            <a href="#" class="cart">
                <img src="${pageContext.request.contextPath}/static/images/icons/cart.png" alt="장바구니">
                <span class="cart-count">0</span>
            </a>
            <a href="#" class="profile">
                <img src="${pageContext.request.contextPath}/static/images/icons/profile.png" alt="프로필">
            </a>
        </div>
    </div>
</div>